<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This design implements a simple 8-bit cryptographic engine.

The input data is processed through multiple rounds of transformation:
- XOR with a key
- Bit rotation
- Substitution

Each round modifies the data further, producing a scrambled output.

A start signal begins the process, and after 4 rounds, the encrypted output is available.

## How to test

1. Provide an 8-bit input through `ui_in`
2. Set `ui_in[0] = 1` to start the encryption
3. Wait a few clock cycles
4. Read the encrypted result from `uo_out`

## External hardware

List external hardware used in your project (e.g. PMOD, LED display, etc), if any
