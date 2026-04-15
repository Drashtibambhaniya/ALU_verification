# ALU Verification — SystemVerilog Layered Testbench

A complete functional verification environment for an 8-bit parameterized ALU using a custom SystemVerilog layered testbench.
The testbench follows industry-standard verification architecture with clear separation of concerns across all components.

## DUT Overview

| Parameter | Value |
|---|---|
| Design | 8-bit Parameterized ALU |
| RTL File | `alu.sv` |
| Supported Operations | 25 opcodes (arithmetic, logical, shift, comparison, multiply) |
| Simulator | QuestaSim 10.6c |

---

## Testbench Architecture

The testbench follows a **layered architecture** that separates stimulus generation, driving, monitoring, checking, and coverage into independent components — closely mirroring the UVM methodology without the UVM base class library.

## Component Descriptions

| File | Role |
|---|---|
| `alu_packet.sv` | Transaction data object — holds operands, opcode, and result fields |
| `alu_txn.sv` | Transaction class with `rand` fields and constraints for stimulus generation |
| `alu_interface.sv` | SystemVerilog interface with clocking blocks for synchronous drive/sample |
| `alu_generator.sv` | Produces constrained-random and directed transactions via mailbox |
| `alu_driver.sv` | Consumes transactions from mailbox and drives DUT signals via interface |
| `alu_monitor_ip.sv` | Observes DUT **input** signals and forwards transactions to scoreboard |
| `alu_monitor_op.sv` | Observes DUT **output** signals and forwards to scoreboard for checking |
| `alu_ref.sv` | Golden reference model — computes expected result for every opcode |
| `alu_scoreboard.sv` | Compares DUT output vs reference model; logs pass/fail per transaction |
| `alu_cov.sv` | Functional coverage — covergroups for opcodes, operand corners, transitions |
| `alu_base_test.sv` | Base test class — environment setup and simulation control |
| `alu_test.sv` | Extended test — defines directed and constrained-random test scenarios |
| `alu_top.sv` | Top-level module — DUT instantiation, clock gen, interface binding |
| `pkg.sv` | Package file — imports and includes all TB classes in correct order |

---

## Inter-Component Communication

- **Generator → Driver**: `mailbox` (blocking `put` / `get`)
- **Monitors → Scoreboard**: `mailbox` (separate mailboxes for input and output)
- **Simulation control**: `event`-based termination triggered after last transaction

---

## Test Plan Coverage

| Test Category | Description |
|---|---|
| Directed Tests | 25+ directed test cases, one per opcode |
| Corner Cases | Zero operands, max values (0xFF), overflow conditions |
| Constrained Random | Mode-aware random stimulus across all opcodes |
| Regression Suite | Full automated regression across all test cases |

---

## Results

| Metric | Result |
|---|---|
| Functional Coverage | ~92% |
| RTL Bugs Found | 8 |
| Opcodes Verified | 25 / 25 |

---

## Repository Structure

```
ALU_verification/
├── rtl/
│   └── alu.sv                    # DUT
├── testbench/
│   ├── pkg.sv
│   ├── alu_interface.sv
│   ├── alu_packet.sv
│   ├── alu_txn.sv
│   ├── alu_generator.sv
│   ├── alu_driver.sv
│   ├── alu_monitor_ip.sv
│   ├── alu_monitor_op.sv
│   ├── alu_ref.sv
│   ├── alu_scoreboard.sv
│   ├── alu_cov.sv
│   ├── alu_base_test.sv
│   ├── alu_test.sv
│   └── alu_top.sv
├── sim/
│   └── run.do
├── docs/
│   └── verification_report.pdf
└── README.md


## How to Run

```bash
vsim -do sim/run.do
```

## Skills Demonstrated

- SystemVerilog layered testbench architecture 
- Constrained-random stimulus generation with `rand` / `constraint`
- SystemVerilog Assertions (SVA)
- Functional coverage with `covergroup` / `coverpoint` / `cross`
- Mailbox and event-based inter-component communication
- Dual monitor architecture (separate input and output monitors)
- Scoreboard-based self-checking with golden reference model
- RTL bug detection and waveform analysis in QuestaSim
