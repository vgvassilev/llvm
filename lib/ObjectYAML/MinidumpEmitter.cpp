//===- yaml2minidump.cpp - Convert a YAML file to a minidump file ---------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "llvm/ObjectYAML/MinidumpYAML.h"
#include "llvm/ObjectYAML/yaml2obj.h"
#include "llvm/Support/ConvertUTF.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;
using namespace llvm::minidump;
using namespace llvm::MinidumpYAML;

namespace {
/// A helper class to manage the placement of various structures into the final
/// minidump binary. Space for objects can be allocated via various allocate***
/// methods, while the final minidump file is written by calling the writeTo
/// method. The plain versions of allocation functions take a reference to the
/// data which is to be written (and hence the data must be available until
/// writeTo is called), while the "New" versions allocate the data in an
/// allocator-managed buffer, which is available until the allocator object is
/// destroyed. For both kinds of functions, it is possible to modify the
/// data for which the space has been "allocated" until the final writeTo call.
/// This is useful for "linking" the allocated structures via their offsets.
class BlobAllocator {
public:
  size_t tell() const { return NextOffset; }

  size_t allocateCallback(size_t Size,
                          std::function<void(raw_ostream &)> Callback) {
    size_t Offset = NextOffset;
    NextOffset += Size;
    Callbacks.push_back(std::move(Callback));
    return Offset;
  }

  size_t allocateBytes(ArrayRef<uint8_t> Data) {
    return allocateCallback(
        Data.size(), [Data](raw_ostream &OS) { OS << toStringRef(Data); });
  }

  size_t allocateBytes(yaml::BinaryRef Data) {
    return allocateCallback(Data.binary_size(), [Data](raw_ostream &OS) {
      Data.writeAsBinary(OS);
    });
  }

  template <typename T> size_t allocateArray(ArrayRef<T> Data) {
    return allocateBytes({reinterpret_cast<const uint8_t *>(Data.data()),
                          sizeof(T) * Data.size()});
  }

  template <typename T, typename RangeType>
  std::pair<size_t, MutableArrayRef<T>>
  allocateNewArray(const iterator_range<RangeType> &Range);

  template <typename T> size_t allocateObject(const T &Data) {
    return allocateArray(makeArrayRef(Data));
  }

  template <typename T, typename... Types>
  std::pair<size_t, T *> allocateNewObject(Types &&... Args) {
    T *Object = new (Temporaries.Allocate<T>()) T(std::forward<Types>(Args)...);
    return {allocateObject(*Object), Object};
  }

  size_t allocateString(StringRef Str);

  void writeTo(raw_ostream &OS) const;

private:
  size_t NextOffset = 0;

  BumpPtrAllocator Temporaries;
  std::vector<std::function<void(raw_ostream &)>> Callbacks;
};
} // namespace

template <typename T, typename RangeType>
std::pair<size_t, MutableArrayRef<T>>
BlobAllocator::allocateNewArray(const iterator_range<RangeType> &Range) {
  size_t Num = std::distance(Range.begin(), Range.end());
  MutableArrayRef<T> Array(Temporaries.Allocate<T>(Num), Num);
  std::uninitialized_copy(Range.begin(), Range.end(), Array.begin());
  return {allocateArray(Array), Array};
}

size_t BlobAllocator::allocateString(StringRef Str) {
  SmallVector<UTF16, 32> WStr;
  bool OK = convertUTF8ToUTF16String(Str, WStr);
  assert(OK && "Invalid UTF8 in Str?");
  (void)OK;

  // The utf16 string is null-terminated, but the terminator is not counted in
  // the string size.
  WStr.push_back(0);
  size_t Result =
      allocateNewObject<support::ulittle32_t>(2 * (WStr.size() - 1)).first;
  allocateNewArray<support::ulittle16_t>(make_range(WStr.begin(), WStr.end()));
  return Result;
}

void BlobAllocator::writeTo(raw_ostream &OS) const {
  size_t BeginOffset = OS.tell();
  for (const auto &Callback : Callbacks)
    Callback(OS);
  assert(OS.tell() == BeginOffset + NextOffset &&
         "Callbacks wrote an unexpected number of bytes.");
  (void)BeginOffset;
}

static LocationDescriptor layout(BlobAllocator &File, yaml::BinaryRef Data) {
  return {support::ulittle32_t(Data.binary_size()),
          support::ulittle32_t(File.allocateBytes(Data))};
}

static void layout(BlobAllocator &File, MemoryListStream::entry_type &Range) {
  Range.Entry.Memory = layout(File, Range.Content);
}

static void layout(BlobAllocator &File, ModuleListStream::entry_type &M) {
  M.Entry.ModuleNameRVA = File.allocateString(M.Name);

  M.Entry.CvRecord = layout(File, M.CvRecord);
  M.Entry.MiscRecord = layout(File, M.MiscRecord);
}

static void layout(BlobAllocator &File, ThreadListStream::entry_type &T) {
  T.Entry.Stack.Memory = layout(File, T.Stack);
  T.Entry.Context = layout(File, T.Context);
}

template <typename EntryT>
static size_t layout(BlobAllocator &File,
                     MinidumpYAML::detail::ListStream<EntryT> &S) {

  File.allocateNewObject<support::ulittle32_t>(S.Entries.size());
  for (auto &E : S.Entries)
    File.allocateObject(E.Entry);

  size_t DataEnd = File.tell();

  // Lay out the auxiliary data, (which is not a part of the stream).
  DataEnd = File.tell();
  for (auto &E : S.Entries)
    layout(File, E);

  return DataEnd;
}

static Directory layout(BlobAllocator &File, Stream &S) {
  Directory Result;
  Result.Type = S.Type;
  Result.Location.RVA = File.tell();
  Optional<size_t> DataEnd;
  switch (S.Kind) {
  case Stream::StreamKind::MemoryList:
    DataEnd = layout(File, cast<MemoryListStream>(S));
    break;
  case Stream::StreamKind::ModuleList:
    DataEnd = layout(File, cast<ModuleListStream>(S));
    break;
  case Stream::StreamKind::RawContent: {
    RawContentStream &Raw = cast<RawContentStream>(S);
    File.allocateCallback(Raw.Size, [&Raw](raw_ostream &OS) {
      Raw.Content.writeAsBinary(OS);
      assert(Raw.Content.binary_size() <= Raw.Size);
      OS << std::string(Raw.Size - Raw.Content.binary_size(), '\0');
    });
    break;
  }
  case Stream::StreamKind::SystemInfo: {
    SystemInfoStream &SystemInfo = cast<SystemInfoStream>(S);
    File.allocateObject(SystemInfo.Info);
    // The CSD string is not a part of the stream.
    DataEnd = File.tell();
    SystemInfo.Info.CSDVersionRVA = File.allocateString(SystemInfo.CSDVersion);
    break;
  }
  case Stream::StreamKind::TextContent:
    File.allocateArray(arrayRefFromStringRef(cast<TextContentStream>(S).Text));
    break;
  case Stream::StreamKind::ThreadList:
    DataEnd = layout(File, cast<ThreadListStream>(S));
    break;
  }
  // If DataEnd is not set, we assume everything we generated is a part of the
  // stream.
  Result.Location.DataSize =
      DataEnd.getValueOr(File.tell()) - Result.Location.RVA;
  return Result;
}

namespace llvm {
namespace yaml {

bool yaml2minidump(MinidumpYAML::Object &Obj, raw_ostream &Out) {
  BlobAllocator File;
  File.allocateObject(Obj.Header);

  std::vector<Directory> StreamDirectory(Obj.Streams.size());
  Obj.Header.StreamDirectoryRVA =
      File.allocateArray(makeArrayRef(StreamDirectory));
  Obj.Header.NumberOfStreams = StreamDirectory.size();

  for (auto &Stream : enumerate(Obj.Streams))
    StreamDirectory[Stream.index()] = layout(File, *Stream.value());

  File.writeTo(Out);
  return true;
}

} // namespace yaml
} // namespace llvm
