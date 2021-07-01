# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# Verify that we create proper JSON for the MCA views TimelineView, ResourcePressureview,
# InstructionInfoView and SummaryView.

# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=haswell --json --timeline-max-iterations=1 --timeline --all-stats --all-views < %s | FileCheck %s
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=haswell --json --timeline-max-iterations=1 --timeline --all-stats --all-views -o %t.json < %s
# RUN: cat %t.json \
# RUN:  | %python -c 'import json, sys; json.dump(json.loads(sys.stdin.read()), sys.stdout, sort_keys=True, indent=2)' \
# RUN:  | FileCheck %s

add %eax, %eax
add %ebx, %ebx
add %ecx, %ecx
add %edx, %edx

# CHECK:      {
# CHECK-NEXT:   "DispatchStatistics": {
# CHECK-NEXT:     "GROUP": 0,
# CHECK-NEXT:     "LQ": 0,
# CHECK-NEXT:     "RAT": 0,
# CHECK-NEXT:     "RCU": 0,
# CHECK-NEXT:     "SCHEDQ": 0,
# CHECK-NEXT:     "SQ": 0,
# CHECK-NEXT:     "USH": 0
# CHECK-NEXT:   },
# CHECK-NEXT:   "InstructionInfoView": {
# CHECK-NEXT:     "InstructionList": [
# CHECK-NEXT:       {
# CHECK-NEXT:         "Instruction": 0,
# CHECK-NEXT:         "Latency": 1,
# CHECK-NEXT:         "NumMicroOpcodes": 1,
# CHECK-NEXT:         "RThroughput": 0.25,
# CHECK-NEXT:         "hasUnmodeledSideEffects": false,
# CHECK-NEXT:         "mayLoad": false,
# CHECK-NEXT:         "mayStore": false
# CHECK-NEXT:       },
# CHECK-NEXT:       {
# CHECK-NEXT:         "Instruction": 1,
# CHECK-NEXT:         "Latency": 1,
# CHECK-NEXT:         "NumMicroOpcodes": 1,
# CHECK-NEXT:         "RThroughput": 0.25,
# CHECK-NEXT:         "hasUnmodeledSideEffects": false,
# CHECK-NEXT:         "mayLoad": false,
# CHECK-NEXT:         "mayStore": false
# CHECK-NEXT:       },
# CHECK-NEXT:       {
# CHECK-NEXT:         "Instruction": 2,
# CHECK-NEXT:         "Latency": 1,
# CHECK-NEXT:         "NumMicroOpcodes": 1,
# CHECK-NEXT:         "RThroughput": 0.25,
# CHECK-NEXT:         "hasUnmodeledSideEffects": false,
# CHECK-NEXT:         "mayLoad": false,
# CHECK-NEXT:         "mayStore": false
# CHECK-NEXT:       },
# CHECK-NEXT:       {
# CHECK-NEXT:         "Instruction": 3,
# CHECK-NEXT:         "Latency": 1,
# CHECK-NEXT:         "NumMicroOpcodes": 1,
# CHECK-NEXT:         "RThroughput": 0.25,
# CHECK-NEXT:         "hasUnmodeledSideEffects": false,
# CHECK-NEXT:         "mayLoad": false,
# CHECK-NEXT:         "mayStore": false
# CHECK-NEXT:       }
# CHECK-NEXT:     ]
# CHECK-NEXT:   },
# CHECK-NEXT:   "Instructions and CPU resources": {
# CHECK-NEXT:     "Instructions": [
# CHECK-NEXT:       "addl\t%eax, %eax",
# CHECK-NEXT:       "addl\t%ebx, %ebx",
# CHECK-NEXT:       "addl\t%ecx, %ecx",
# CHECK-NEXT:       "addl\t%edx, %edx"
# CHECK-NEXT:     ],
# CHECK-NEXT:     "Resources": {
# CHECK-NEXT:       "CPUName": "haswell",
# CHECK-NEXT:       "Resources": [
# CHECK-NEXT:         "HWDivider",
# CHECK-NEXT:         "HWFPDivider",
# CHECK-NEXT:         "HWPort0",
# CHECK-NEXT:         "HWPort1",
# CHECK-NEXT:         "HWPort2",
# CHECK-NEXT:         "HWPort3",
# CHECK-NEXT:         "HWPort4",
# CHECK-NEXT:         "HWPort5",
# CHECK-NEXT:         "HWPort6",
# CHECK-NEXT:         "HWPort7"
# CHECK-NEXT:       ]
# CHECK-NEXT:     }
# CHECK-NEXT:   },
# CHECK-NEXT:   "ResourcePressureView": {
# CHECK-NEXT:     "ResourcePressureInfo": [
# CHECK-NEXT:       {
# CHECK-NEXT:         "InstructionIndex": 0,
# CHECK-NEXT:         "ResourceIndex": 8,
# CHECK-NEXT:         "ResourceUsage": 1
# CHECK-NEXT:       },
# CHECK-NEXT:       {
# CHECK-NEXT:         "InstructionIndex": 1,
# CHECK-NEXT:         "ResourceIndex": 7,
# CHECK-NEXT:         "ResourceUsage": 1
# CHECK-NEXT:       },
# CHECK-NEXT:       {
# CHECK-NEXT:         "InstructionIndex": 2,
# CHECK-NEXT:         "ResourceIndex": 3,
# CHECK-NEXT:         "ResourceUsage": 1
# CHECK-NEXT:       },
# CHECK-NEXT:       {
# CHECK-NEXT:         "InstructionIndex": 3,
# CHECK-NEXT:         "ResourceIndex": 2,
# CHECK-NEXT:         "ResourceUsage": 1
# CHECK-NEXT:       },
# CHECK-NEXT:       {
# CHECK-NEXT:         "InstructionIndex": 4,
# CHECK-NEXT:         "ResourceIndex": 2,
# CHECK-NEXT:         "ResourceUsage": 1
# CHECK-NEXT:       },
# CHECK-NEXT:       {
# CHECK-NEXT:         "InstructionIndex": 4,
# CHECK-NEXT:         "ResourceIndex": 3,
# CHECK-NEXT:         "ResourceUsage": 1
# CHECK-NEXT:       },
# CHECK-NEXT:       {
# CHECK-NEXT:         "InstructionIndex": 4,
# CHECK-NEXT:         "ResourceIndex": 7,
# CHECK-NEXT:         "ResourceUsage": 1
# CHECK-NEXT:       },
# CHECK-NEXT:       {
# CHECK-NEXT:         "InstructionIndex": 4,
# CHECK-NEXT:         "ResourceIndex": 8,
# CHECK-NEXT:         "ResourceUsage": 1
# CHECK-NEXT:       }
# CHECK-NEXT:     ]
# CHECK-NEXT:   },
# CHECK-NEXT:   "SummaryView": {
# CHECK-NEXT:     "BlockRThroughput": 1,
# CHECK-NEXT:     "DispatchWidth": 4,
# CHECK-NEXT:     "IPC": 3.883495145631068,
# CHECK-NEXT:     "Instructions": 400,
# CHECK-NEXT:     "Iterations": 100,
# CHECK-NEXT:     "TotalCycles": 103,
# CHECK-NEXT:     "TotaluOps": 400,
# CHECK-NEXT:     "uOpsPerCycle": 3.883495145631068
# CHECK-NEXT:   },
# CHECK-NEXT:   "TimelineView": {
# CHECK-NEXT:     "TimelineInfo": [
# CHECK-NEXT:       {
# CHECK-NEXT:         "CycleDispatched": 0,
# CHECK-NEXT:         "CycleExecuted": 2,
# CHECK-NEXT:         "CycleIssued": 1,
# CHECK-NEXT:         "CycleReady": 0,
# CHECK-NEXT:         "CycleRetired": 3
# CHECK-NEXT:       },
# CHECK-NEXT:       {
# CHECK-NEXT:         "CycleDispatched": 0,
# CHECK-NEXT:         "CycleExecuted": 2,
# CHECK-NEXT:         "CycleIssued": 1,
# CHECK-NEXT:         "CycleReady": 0,
# CHECK-NEXT:         "CycleRetired": 3
# CHECK-NEXT:       },
# CHECK-NEXT:       {
# CHECK-NEXT:         "CycleDispatched": 0,
# CHECK-NEXT:         "CycleExecuted": 2,
# CHECK-NEXT:         "CycleIssued": 1,
# CHECK-NEXT:         "CycleReady": 0,
# CHECK-NEXT:         "CycleRetired": 3
# CHECK-NEXT:       },
# CHECK-NEXT:       {
# CHECK-NEXT:         "CycleDispatched": 0,
# CHECK-NEXT:         "CycleExecuted": 2,
# CHECK-NEXT:         "CycleIssued": 1,
# CHECK-NEXT:         "CycleReady": 0,
# CHECK-NEXT:         "CycleRetired": 3
# CHECK-NEXT:       }
# CHECK-NEXT:     ]
# CHECK-NEXT:   }
# CHECK-NEXT: }
