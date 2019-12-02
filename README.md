## About
- A collection of functions and algorithms I've implemented using limited RISC-V instructions. 
- Calling conventions follow those of CS 3410. Frame pointer, thread pointer are ignored.
- Testing was done with the [Cornell University RISC-V Interpreter](https://www.cs.cornell.edu/courses/cs3410/2019sp/riscv/interpreter/index.html).

## Calling Conventions
| Register  | Name     | Use                                |
|-----------|----------|------------------------------------|
| x0        | zero     | constant value 0                   |
| x1        | ra       | return address                     |
| x2        | sp       | stack pointer                      |
| x3        | gp       | global data pointer                |
| x5 - x7   | t0 - t2  | temporary registers                |
| x8 - x9   | s0 - s1  | saved registers                    |
| x10 - x11 | a0 - a1  | return values / function arguments |
| x12 - x17 | a2 - a7  | function arguments                 |
| x18 - x27 | s2 - s11 | saved registers                    |
| x28 - x31 | t3 - t6  | temporary registers                |

## Supported Instruction Set of the Interpreter*
| RISC-V Instructions | Code                            |
|---------------------|---------------------------------|
| Arithmetic          | AND, ANDI, OR, ORI, XOR, XORI   |
| Logical             | AND, ANDI, OR, ORI, XOR, XORI   |
| Sets                | SLT, SLTI, SLTU, SLTIU          |
| Shifts              | SRA, SRAI, SRL, SRLI, SLL, SLLI |
| Memory              | LW, SW, LB, SB                  |
| PC                  | LUI, AUIPC                      |
| Jumps               | JAL, JALR                       |
| Branches            | BEQ, BNE, BLT, BGE, BLTU, BGEU  |

\* as of December 2019
