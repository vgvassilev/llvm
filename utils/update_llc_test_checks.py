#!/usr/bin/env python2.7

"""A test case update script.

This script is a utility to update LLVM X86 'llc' based test cases with new
FileCheck patterns. It can either update all of the tests in the file or
a single test function.
"""

import argparse
import os         # Used to advertise this file's name ("autogenerated_note").
import string
import subprocess
import sys
import re

# Invoke the tool that is being tested.
def llc(args, cmd_args, ir):
  with open(ir) as ir_file:
    stdout = subprocess.check_output(args.llc_binary + ' ' + cmd_args,
                                     shell=True, stdin=ir_file)
  # Fix line endings to unix CR style.
  stdout = stdout.replace('\r\n', '\n')
  return stdout


# RegEx: this is where the magic happens.

ASM_FUNCTION_X86_RE = re.compile(
    r'^_?(?P<func>[^:]+):[ \t]*#+[ \t]*@(?P=func)\n[^:]*?'
    r'(?P<body>^##?[ \t]+[^:]+:.*?)\s*'
    r'^\s*(?:[^:\n]+?:\s*\n\s*\.size|\.cfi_endproc|\.globl|\.comm|\.(?:sub)?section|#+ -- End function)',
    flags=(re.M | re.S))

ASM_FUNCTION_ARM_RE = re.compile(
        r'^(?P<func>[0-9a-zA-Z_]+):\n' # f: (name of function)
        r'\s+\.fnstart\n' # .fnstart
        r'(?P<body>.*?)\n' # (body of the function)
        r'.Lfunc_end[0-9]+:', # .Lfunc_end0: or # -- End function
        flags=(re.M | re.S))

ASM_FUNCTION_AARCH64_RE = re.compile(
     r'^_?(?P<func>[^:]+):[ \t]*\/\/[ \t]*@(?P=func)\n'
     r'[ \t]+.cfi_startproc\n'
     r'(?P<body>.*?)\n'
     # This list is incomplete
     r'.Lfunc_end[0-9]+:\n',
     flags=(re.M | re.S))

ASM_FUNCTION_MIPS_RE = re.compile(
    r'^_?(?P<func>[^:]+):[ \t]*#+[ \t]*@(?P=func)\n[^:]*?' # f: (name of func)
    r'(?:^[ \t]+\.(frame|f?mask|set).*?\n)+'  # Mips+LLVM standard asm prologue
    r'(?P<body>.*?)\n'                        # (body of the function)
    r'(?:^[ \t]+\.(set|end).*?\n)+'           # Mips+LLVM standard asm epilogue
    r'(\$|\.L)func_end[0-9]+:\n',             # $func_end0: (mips32 - O32) or
                                              # .Lfunc_end0: (mips64 - NewABI)
    flags=(re.M | re.S))

ASM_FUNCTION_PPC_RE = re.compile(
    r'^_?(?P<func>[^:]+):[ \t]*#+[ \t]*@(?P=func)\n'
    r'\.Lfunc_begin[0-9]+:\n'
    r'(?:[ \t]+.cfi_startproc\n)?'
    r'(?:\.Lfunc_[gl]ep[0-9]+:\n(?:[ \t]+.*?\n)*)*'
    r'(?P<body>.*?)\n'
    # This list is incomplete
    r'(?:^[ \t]*(?:\.long[ \t]+[^\n]+|\.quad[ \t]+[^\n]+)\n)*'
    r'.Lfunc_end[0-9]+:\n',
    flags=(re.M | re.S))

ASM_FUNCTION_RISCV_RE = re.compile(
    r'^_?(?P<func>[^:]+):[ \t]*#+[ \t]*@(?P=func)\n[^:]*?'
    r'(?P<body>^##?[ \t]+[^:]+:.*?)\s*'
    r'.Lfunc_end[0-9]+:\n',
    flags=(re.M | re.S))

ASM_FUNCTION_SYSTEMZ_RE = re.compile(
    r'^_?(?P<func>[^:]+):[ \t]*#+[ \t]*@(?P=func)\n'
    r'[ \t]+.cfi_startproc\n'
    r'(?P<body>.*?)\n'
    r'.Lfunc_end[0-9]+:\n',
    flags=(re.M | re.S))


SCRUB_WHITESPACE_RE = re.compile(r'(?!^(|  \w))[ \t]+', flags=re.M)
SCRUB_TRAILING_WHITESPACE_RE = re.compile(r'[ \t]+$', flags=re.M)
SCRUB_KILL_COMMENT_RE = re.compile(r'^ *#+ +kill:.*\n')
SCRUB_LOOP_COMMENT_RE = re.compile(
    r'# =>This Inner Loop Header:.*|# in Loop:.*', flags=re.M)

SCRUB_X86_SHUFFLES_RE = (
    re.compile(
        r'^(\s*\w+) [^#\n]+#+ ((?:[xyz]mm\d+|mem)( \{%k\d+\}( \{z\})?)? = .*)$',
        flags=re.M))
SCRUB_X86_SP_RE = re.compile(r'\d+\(%(esp|rsp)\)')
SCRUB_X86_RIP_RE = re.compile(r'[.\w]+\(%rip\)')
SCRUB_X86_LCP_RE = re.compile(r'\.LCPI[0-9]+_[0-9]+')
SCRUB_X86_RET_RE = re.compile(r'ret[l|q]')

RUN_LINE_RE = re.compile('^\s*;\s*RUN:\s*(.*)$')
TRIPLE_ARG_RE = re.compile(r'-mtriple=([^ ]+)')
TRIPLE_IR_RE = re.compile(r'^target\s+triple\s*=\s*"([^"]+)"$')
IR_FUNCTION_RE = re.compile('^\s*define\s+(?:internal\s+)?[^@]*@(\w+)\s*\(')
CHECK_PREFIX_RE = re.compile('--?check-prefix(?:es)?=(\S+)')
CHECK_RE = re.compile(r'^\s*;\s*([^:]+?)(?:-NEXT|-NOT|-DAG|-LABEL)?:')

def scrub_asm_x86(asm, args):
  # Scrub runs of whitespace out of the assembly, but leave the leading
  # whitespace in place.
  asm = SCRUB_WHITESPACE_RE.sub(r' ', asm)
  # Expand the tabs used for indentation.
  asm = string.expandtabs(asm, 2)
  # Detect shuffle asm comments and hide the operands in favor of the comments.
  asm = SCRUB_X86_SHUFFLES_RE.sub(r'\1 {{.*#+}} \2', asm)
  # Generically match the stack offset of a memory operand.
  asm = SCRUB_X86_SP_RE.sub(r'{{[0-9]+}}(%\1)', asm)
  # Generically match a RIP-relative memory operand.
  asm = SCRUB_X86_RIP_RE.sub(r'{{.*}}(%rip)', asm)
  # Generically match a LCP symbol.
  asm = SCRUB_X86_LCP_RE.sub(r'{{\.LCPI.*}}', asm)
  if args.x86_extra_scrub:
    # Avoid generating different checks for 32- and 64-bit because of 'retl' vs 'retq'.
    asm = SCRUB_X86_RET_RE.sub(r'ret{{[l|q]}}', asm)
  # Strip kill operands inserted into the asm.
  asm = SCRUB_KILL_COMMENT_RE.sub('', asm)
  # Strip trailing whitespace.
  asm = SCRUB_TRAILING_WHITESPACE_RE.sub(r'', asm)
  return asm

def scrub_asm_arm_eabi(asm, args):
  # Scrub runs of whitespace out of the assembly, but leave the leading
  # whitespace in place.
  asm = SCRUB_WHITESPACE_RE.sub(r' ', asm)
  # Expand the tabs used for indentation.
  asm = string.expandtabs(asm, 2)
  # Strip kill operands inserted into the asm.
  asm = SCRUB_KILL_COMMENT_RE.sub('', asm)
  # Strip trailing whitespace.
  asm = SCRUB_TRAILING_WHITESPACE_RE.sub(r'', asm)
  return asm

def scrub_asm_powerpc64(asm, args):
  # Scrub runs of whitespace out of the assembly, but leave the leading
  # whitespace in place.
  asm = SCRUB_WHITESPACE_RE.sub(r' ', asm)
  # Expand the tabs used for indentation.
  asm = string.expandtabs(asm, 2)
  # Stripe unimportant comments
  asm = SCRUB_LOOP_COMMENT_RE.sub(r'', asm)
  # Strip trailing whitespace.
  asm = SCRUB_TRAILING_WHITESPACE_RE.sub(r'', asm)
  return asm

def scrub_asm_mips(asm, args):
  # Scrub runs of whitespace out of the assembly, but leave the leading
  # whitespace in place.
  asm = SCRUB_WHITESPACE_RE.sub(r' ', asm)
  # Expand the tabs used for indentation.
  asm = string.expandtabs(asm, 2)
  # Strip trailing whitespace.
  asm = SCRUB_TRAILING_WHITESPACE_RE.sub(r'', asm)
  return asm

def scrub_asm_riscv(asm, args):
  # Scrub runs of whitespace out of the assembly, but leave the leading
  # whitespace in place.
  asm = SCRUB_WHITESPACE_RE.sub(r' ', asm)
  # Expand the tabs used for indentation.
  asm = string.expandtabs(asm, 2)
  # Strip trailing whitespace.
  asm = SCRUB_TRAILING_WHITESPACE_RE.sub(r'', asm)
  return asm

def scrub_asm_systemz(asm, args):
  # Scrub runs of whitespace out of the assembly, but leave the leading
  # whitespace in place.
  asm = SCRUB_WHITESPACE_RE.sub(r' ', asm)
  # Expand the tabs used for indentation.
  asm = string.expandtabs(asm, 2)
  # Strip trailing whitespace.
  asm = SCRUB_TRAILING_WHITESPACE_RE.sub(r'', asm)
  return asm


# Build up a dictionary of all the function bodies.
def build_function_body_dictionary(raw_tool_output, triple, prefixes, func_dict,
                                   args):
  target_handlers = {
      'x86_64': (scrub_asm_x86, ASM_FUNCTION_X86_RE),
      'i686': (scrub_asm_x86, ASM_FUNCTION_X86_RE),
      'x86': (scrub_asm_x86, ASM_FUNCTION_X86_RE),
      'i386': (scrub_asm_x86, ASM_FUNCTION_X86_RE),
      'aarch64': (scrub_asm_arm_eabi, ASM_FUNCTION_AARCH64_RE),
      'arm-eabi': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumb-eabi': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumbv6': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumbv6-eabi': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumbv6t2': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumbv6t2-eabi': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumbv6m': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumbv6m-eabi': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumbv7': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumbv7-eabi': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumbv7m': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumbv7m-eabi': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumbv8-eabi': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumbv8m.base': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'thumbv8m.main': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'armv6': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'armv7': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'armv7-eabi': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'armeb-eabi': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'armv7eb-eabi': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'armv7eb': (scrub_asm_arm_eabi, ASM_FUNCTION_ARM_RE),
      'mips': (scrub_asm_mips, ASM_FUNCTION_MIPS_RE),
      'powerpc64': (scrub_asm_powerpc64, ASM_FUNCTION_PPC_RE),
      'powerpc64le': (scrub_asm_powerpc64, ASM_FUNCTION_PPC_RE),
      'riscv32': (scrub_asm_riscv, ASM_FUNCTION_RISCV_RE),
      'riscv64': (scrub_asm_riscv, ASM_FUNCTION_RISCV_RE),
      's390x': (scrub_asm_systemz, ASM_FUNCTION_SYSTEMZ_RE),
  }
  handlers = None
  for prefix, s in target_handlers.items():
    if triple.startswith(prefix):
      handlers = s
      break
  else:
    raise KeyError('Triple %r is not supported' % (triple))

  scrubber, function_re = handlers
  for m in function_re.finditer(raw_tool_output):
    if not m:
      continue
    func = m.group('func')
    scrubbed_body = scrubber(m.group('body'), args)
    if func.startswith('stress'):
      # We only use the last line of the function body for stress tests.
      scrubbed_body = '\n'.join(scrubbed_body.splitlines()[-1:])
    if args.verbose:
      print >>sys.stderr, 'Processing function: ' + func
      for l in scrubbed_body.splitlines():
        print >>sys.stderr, '  ' + l
    for prefix in prefixes:
      if func in func_dict[prefix] and func_dict[prefix][func] != scrubbed_body:
        if prefix == prefixes[-1]:
          print >>sys.stderr, ('WARNING: Found conflicting asm under the '
                               'same prefix: %r!' % (prefix,))
        else:
          func_dict[prefix][func] = None
          continue

      func_dict[prefix][func] = scrubbed_body


def add_checks(output_lines, run_list, func_dict, func_name):
  printed_prefixes = []
  for p in run_list:
    checkprefixes = p[0]
    for checkprefix in checkprefixes:
      if checkprefix in printed_prefixes:
        break
      if not func_dict[checkprefix][func_name]:
        continue
      # Add some space between different check prefixes.
      if len(printed_prefixes) != 0:
        output_lines.append(';')
      printed_prefixes.append(checkprefix)
      output_lines.append('; %s-LABEL: %s:' % (checkprefix, func_name))
      func_body = func_dict[checkprefix][func_name].splitlines()
      output_lines.append('; %s:       %s' % (checkprefix, func_body[0]))
      for func_line in func_body[1:]:
        output_lines.append('; %s-NEXT:  %s' % (checkprefix, func_line))
      # Add space between different check prefixes and the first line of code.
      # output_lines.append(';')
      break
  return output_lines


def should_add_line_to_output(input_line, prefix_set):
  # Skip any blank comment lines in the IR.
  if input_line.strip() == ';':
    return False
  # Skip any blank lines in the IR.
  #if input_line.strip() == '':
  #  return False
  # And skip any CHECK lines. We're building our own.
  m = CHECK_RE.match(input_line)
  if m and m.group(1) in prefix_set:
    return False

  return True


def main():
  parser = argparse.ArgumentParser(description=__doc__)
  parser.add_argument('-v', '--verbose', action='store_true',
                      help='Show verbose output')
  parser.add_argument('--llc-binary', default='llc',
                      help='The "llc" binary to use to generate the test case')
  parser.add_argument(
      '--function', help='The function in the test file to update')
  parser.add_argument(
      '--x86_extra_scrub', action='store_true',
      help='Use more regex for x86 matching to reduce diffs between various subtargets')
  parser.add_argument('tests', nargs='+')
  args = parser.parse_args()

  autogenerated_note = ('; NOTE: Assertions have been autogenerated by '
                        'utils/' + os.path.basename(__file__))

  for test in args.tests:
    if args.verbose:
      print >>sys.stderr, 'Scanning for RUN lines in test file: %s' % (test,)
    with open(test) as f:
      input_lines = [l.rstrip() for l in f]

    triple_in_ir = None
    for l in input_lines:
      m = TRIPLE_IR_RE.match(l)
      if m:
        triple_in_ir = m.groups()[0]
        break

    raw_lines = [m.group(1)
                 for m in [RUN_LINE_RE.match(l) for l in input_lines] if m]
    run_lines = [raw_lines[0]] if len(raw_lines) > 0 else []
    for l in raw_lines[1:]:
      if run_lines[-1].endswith("\\"):
        run_lines[-1] = run_lines[-1].rstrip("\\") + " " + l
      else:
        run_lines.append(l)

    if args.verbose:
      print >>sys.stderr, 'Found %d RUN lines:' % (len(run_lines),)
      for l in run_lines:
        print >>sys.stderr, '  RUN: ' + l

    run_list = []
    for l in run_lines:
      commands = [cmd.strip() for cmd in l.split('|', 1)]
      llc_cmd = commands[0]

      triple_in_cmd = None
      m = TRIPLE_ARG_RE.search(llc_cmd)
      if m:
        triple_in_cmd = m.groups()[0]

      filecheck_cmd = ''
      if len(commands) > 1:
        filecheck_cmd = commands[1]
      if not llc_cmd.startswith('llc '):
        print >>sys.stderr, 'WARNING: Skipping non-llc RUN line: ' + l
        continue

      if not filecheck_cmd.startswith('FileCheck '):
        print >>sys.stderr, 'WARNING: Skipping non-FileChecked RUN line: ' + l
        continue

      llc_cmd_args = llc_cmd[len('llc'):].strip()
      llc_cmd_args = llc_cmd_args.replace('< %s', '').replace('%s', '').strip()

      check_prefixes = [item for m in CHECK_PREFIX_RE.finditer(filecheck_cmd)
                               for item in m.group(1).split(',')]
      if not check_prefixes:
        check_prefixes = ['CHECK']

      # FIXME: We should use multiple check prefixes to common check lines. For
      # now, we just ignore all but the last.
      run_list.append((check_prefixes, llc_cmd_args, triple_in_cmd))

    func_dict = {}
    for p in run_list:
      prefixes = p[0]
      for prefix in prefixes:
        func_dict.update({prefix: dict()})
    for prefixes, llc_args, triple_in_cmd in run_list:
      if args.verbose:
        print >>sys.stderr, 'Extracted LLC cmd: llc ' + llc_args
        print >>sys.stderr, 'Extracted FileCheck prefixes: ' + str(prefixes)

      raw_tool_output = llc(args, llc_args, test)
      if not (triple_in_cmd or triple_in_ir):
        print >>sys.stderr, "Cannot find a triple. Assume 'x86'"

      build_function_body_dictionary(raw_tool_output,
          triple_in_cmd or triple_in_ir or 'x86', prefixes, func_dict, args)

    is_in_function = False
    is_in_function_start = False
    func_name = None
    prefix_set = set([prefix for p in run_list for prefix in p[0]])
    if args.verbose:
      print >>sys.stderr, 'Rewriting FileCheck prefixes: %s' % (prefix_set,)
    output_lines = []
    output_lines.append(autogenerated_note)

    for input_line in input_lines:
      if is_in_function_start:
        if input_line == '':
          continue
        if input_line.lstrip().startswith(';'):
          m = CHECK_RE.match(input_line)
          if not m or m.group(1) not in prefix_set:
            output_lines.append(input_line)
            continue

        # Print out the various check lines here.
        output_lines = add_checks(output_lines, run_list, func_dict, func_name)
        is_in_function_start = False

      if is_in_function:
        if should_add_line_to_output(input_line, prefix_set) == True:
          # This input line of the function body will go as-is into the output.
          output_lines.append(input_line)
        else:
          continue
        if input_line.strip() == '}':
          is_in_function = False
        continue

      if input_line == autogenerated_note:
        continue

      # If it's outside a function, it just gets copied to the output.
      output_lines.append(input_line)

      m = IR_FUNCTION_RE.match(input_line)
      if not m:
        continue
      func_name = m.group(1)
      if args.function is not None and func_name != args.function:
        # When filtering on a specific function, skip all others.
        continue
      is_in_function = is_in_function_start = True

    if args.verbose:
      print>>sys.stderr, 'Writing %d lines to %s...' % (len(output_lines), test)

    with open(test, 'wb') as f:
      f.writelines([l + '\n' for l in output_lines])


if __name__ == '__main__':
  main()
