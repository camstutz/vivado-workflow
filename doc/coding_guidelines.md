# Coding Guidelines and Style for VHDL

## Formating

* Avoid too long lines. 80 characters is a good indication, but sometimes this is
  not applicable, e.g. file formats that do not allow multi-line commands.
* Use SPACE for indention. Number of spaces: 2
* Everything should be written by small letters, i.e. signals, variables, keywords, etc.
* Exception: CAPITAL LETTERS are used for constants and generics.
* Underscores \'\_\' should be used to separate words in identifiers, i.e.
  camel\_casing. This facilitates read identifiers easily even when the
  identifier gets converted to small letters, e.g. simulation tools.
* For declarations, instantiations, and mappings use one line for each signal
  or generic.
* Vertically align separation characters of:
  + interface declarations
  + signal declarations
  + signal assignments
  + constant declarations
  + named associations: port or generics associations

## Naming conventions

* Each process should be labeled and closed with the same label.
* Names should indicate the purpose (e.g. address_counter), not the type
  (e.g. up_counter8) of an object.
* (Naming convention for module instances ?)
* keep the same signal name through hierarchies

This suffixes shall be used for identifiers:
  + `\_n`: signals that are active low. Should be avoided inside a
    design!
  + `\_r`: signals that are a registered version of another signal.
  + `\_lt`: signals that come from latches.
  + `\_v`: for variables
  + `\_i`: input port
  + `\_o`: output port
  + `\_b`: bi-directional port (inout)
  + `\_int`: internal signals that are used to allow the output port
    to be read. Apart from that the same name as for the output should be used.
  + `\_t`: for new type and subtype definitions.

Some common names/abbreviations are used throughout the design:
  + `clk` : reset signal
  + `reset` : reset signal
  + `areset` : asynchronous reset signal
  + `en` : enable signal
  + `addr` : a signal/variable that carries an address
  + `div2` : e.g. for a clock divided by two
  + `x2` : e.g. for a clock with a doubled rate

Example names for architectures:
  + `rtl` : synthesizable RTL descriptions.
  + `structural` : architectures that only put together components.
  + `behavioral` : non-synthesizable code that describes the
    functionality of a block.
  + `test` : the architecture of a test bench.

## VHDL constructs
* try to keep behavioral and structural separated, i.e. in separate
  architectures.
* If the signal is a vector, the range is defined as:
  `MSB downto LSB `
* Increasing indexes are ok for arrays.
* Avoid hard values, use constants instead for limits, parameters and table
  lookups.
* Uses aliases when it makes things clearer, e.g. to define the meaning of a
  slice of an array.
* Enumerates shall be used to represent non-arithmetic discrete values.
* Always use named associations for port maps and generic maps
* Only use `in`, `out` ports and *no* `buffer` within a design.
* `inout` ports should only be used at the very top level.
* Do not leave ports unconnected by omission, use: `open`.
* Use unsized vectors for passing signals, attributes like `'range`
  can be used to determine the size of the vector.
* Also, use VHDL attributes (e.g. `'left` for the leftmost bit)
  whenever possible.
* All signals that are read in a process have to be listed in the sensitivity
  list, except for the clocked processes that are used for implementing
  registers.
* Sequential processes:
  + use `rising_edge(clk)` instead of
    `(clk'event and clk='1')`
  + initialize every signal, preferably with 0, in the reset part
* use `others` for the initialization of signals:<br>
  `… := (others => '0')` instead of<br>
  `… := "000000"`
* Avoid creating latches, combinatorial feedback or asynchronous sequential
  logic. Take care that it does not happen unintended.
* Choosing constants instead of generics allows bottom-up design flow.
* Use more parentheses than necessary if it clarifies the functionality.

## Documentation
* Comment each process, function, procedure.
* Both ports and generics should be commented.
* Add a dummy comment<br>
  `--********************************`<br>
   after each process, function, component, etc. to make it visually clear where
   a block ends. Can be left out if followed by another block starting with a
   comment.

#### File Header
```
-- Project     :
-------------------------------------------------------------------------------
-- File        : Clk_Divider.vhd
-- Authors     : Sven Svensson
-- Created     : 2017-05-01
-- Last update : 2017-05-01
-- Platform    : Xilinx Ultrascale
-- Standard    : VHDL'93/02
-------------------------------------------------------------------------------
-- Description :
-- Problems    :
-------------------------------------------------------------------------------
-- Copyright (c) 2017 Company
-------------------------------------------------------------------------------
-- Revisions  :
--
-- 1.0 : 2014-12-22  Sven Svensson     Created
-------------------------------------------------------------------------------
```

## Project & File Organization
* Use always relative paths!
* The file name corresponds to the entity name within the file.
* The file extension used for VHDL files is `.vhdl`
* Files containing packages get the suffix '\_pkg' to the file name
* Entities and architectures go into the same file.
* All configurations of a design go into the same file.
* For test benches the suffix `\_tb` should be added to the file name.

## Sources:

[1] vhdlguru.blogspot.se  - 10 Tips On Writing A Well Formatted VHDL Code
(http://vhdlguru.blogspot.se/2016/08/10-tips-on-writing-well-formatted-vhdl.html)

[2] C. W. Scherjon - VHDL Style Guide (Ver. 1.2)
(https://www.ims-chips.de/content/pdftext/VHDL_Style_Guide.pdf)

[3] Xilinx - Coding Style Guidelines
(https://wiki.electroniciens.cnrs.fr/images/Xilinx_HDL_Coding_style.pdf)

[4] ALSE - ALSE's VHDL Design Rules & Coding Style
(https://wiki.electroniciens.cnrs.fr/images/VHDL_Coding_eng.pdf)

[5] M. Fohler and M. Gordić - VHDL Style Guide
(https://www.so-logic.net/en/knowledgebase/fpga_universe/tutorials/vhdl_style_guide)
