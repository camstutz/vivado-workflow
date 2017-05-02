# Coding Guidelines and Style #

* Only 80 characters on each line.
* Indention shall be made by spaces. Number: 2
* For declarations, instantiations, and mappings use one line for each signal
  or generic.
* Everything should be written by small letters.
* Exception: CAPITAL LETTERS are used for constants.
* Underscores \'\_\' should be used to separate words in identifiers, i.e.
  camel\_casing. This facilitates read identifiers easily even when the
  identifier gets converted to small letters only, e.g. some simulation tools.
* This suffixes shall be used for identifiers:
  + (<code>\_i</code>: input port)
  + (<code>\_o</code>: output port)
  + <code>\_int</code>: internal signals that are used to allow the output port
    to be read
  + <code>\_n</code>: signals that are active low. Avoid them inside the design!
  + <code>\_r</code>: signals that are a registered version.
  + <code>\_lt</code>: signals that comes from latches.
  + <code>\_t</code>: for new type and subtype definitions.
  + <code>\_v</code>: for variables
  + (<code>\_gc</code>: objects that are global ?)
  + (<code>\_g</code>: generics ?)
* Some common names/abbreviations are used throughout the design:
  + <code>en</code> : enable signal
  + <code>reset</code> : reset signal
  + <code>areset</code> : asynchronous reset signal
  + <code>\_addr</code> : a signal/variable that carries an address
  + <code>\_div2</code> : e.g. for a clock divided by two
  + <code>\_x2</code> : e.g. for a clock with a doubled rate
* no new type definitions except for enumerates, subtypes are ok
* keep the same signal name through hierarchies

* vertically align separation characters of:
  + interface declarations
  + signal declarations
  + signal assignments
  + constant declarations
  + named associations: port or generics associations
* Never create latches, combinatorial feedback or asynchronous sequential logic,
  whether intended or unintended!
* If the signal is a vector, the range is defined as: MSB <code>downto</code> LSB
* In arrays increasing indexes are ok
* avoid hard values, use constants instead for limits, parameters and table
  lookups
* also use attributes whenever possible
* always use named associations
* use <code>others</code> for the initialization of signals
* Enumerates shall be used to represent non-arithmetic discrete values.
* Use more parentheses than necessary if it clarifies things
* Use relative paths
* Both ports and generics should be commented
* Only use <code>in</code>, <code>out</code> ports and *no* <code>buffer</code>
  ports
* <code>inout</code> ports should only be used at the very top level
* Do not leave ports unconnected by omission : use <code>open</code>
* Each process has to be labeled and should be closed with the same label.
* Entities and architectures go into the same file
* All configurations of a design go into the same file.
* The file extension used for VHDL files is <code>.vhdl</code>
* The file name corresponds to the entity name
* For testbenches the suffix <code>\_tb</code> should be added to the file name
* (All configurations for the design should be listed in a single file)
* file containing packages get the suffix '\_pkg' at the end of the file name
* Example names for architectures:
  + <code>rtl</code> :
  + <code>structural</code> :
  + <code>behavioral</code> :
  + <code>test</code> :
  + <code>\_xilinx</code> : could be added when the architecture uses
    Xilinx-specific features.
* try to keep behavioral and structural separated
* sequential processes:
  + use <code>rising_edge(clk)</code> instead of
    <code>(clk'event and clk='1')</code>
  + initialize every signal, preferably with 0, in the reset part
* All signals that are read in a process have to be listed in the sensitivity
  list, except for the clocked processes, that are used for implementing
  registers.
* use unsized vectors for passing signals, attributes like <code>range</code>
  can be used to determine the size of the vector
* Uses aliases when it makes things clearer, e.g. to define the meaning of a
  slice of an array

## File Header ##

* File name
* Date of creation
* Author, including full address
* Name of the design units in the file
* simple Description
* List of known model limitations and errors, if any
* Version
* Change list,  containing date, author and a description of all changes made
* Disclaimer
* Copyright
* tools names and versions
* HDL standard followed

* Comment each process, function, procedure

ESS example:

    -- Project :
    -------------------------------------------------------------------------------
    -- File    : Clk_Divider.vhd
    -- Author  : Angel Monera
    -- Created : 2014-12-22
    -- Last update: 2014-12-22
    -- Platform   :
    -- Standard   : VHDL'93/02
    -------------------------------------------------------------------------------
    -- Description: Generate a output pulse of a determined length. Through the     generics
    --              one can decide if extend to a determined length the positive     (EXTEND_HIGH_US)
    --              or if to extend a low pulse (EXTEND_LOW_US). Both can not be     set up at the
    --              same time. Only one active, the other value must be 0.
    --              The program will look for a rising/falling edge and then use a
    --              pre-charged counter to extend/limit the pulse length.
    --          Pulse extender High 10 us
    --          ________|------|_________|---------------|_____
    --          _________|--10--|_________|--10--|_____
    -------------------------------------------------------------------------------
    -- Copyright (c) 2015 ESS AB
    -------------------------------------------------------------------------------
    -- Revisions  :
    -- Date     Version    Author    Description
    -- 2014-12-22  1.0   a. moneram     Created
    -------------------------------------------------------------------------------


## Dont's: ##


## Ideas: ##
* Make processes visible by placing dummy comments
* Naming convention for instances
* Use exclusively std_logic and std_logic_vector types in ports (why not records?)
* use constants instead of generics --> allows bottom-up design flow

## Sources: ##

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
