--! Simple OR gate design
--
--! \file or_gate.vhdl
--! \todo Finalize proper documentation

library IEEE;
use IEEE.std_logic_1164.all;

--------------------------------------------------------------------------------
--! Entity for a single bit OR gate
--------------------------------------------------------------------------------
entity or_gate is
port(
  a: in std_logic;       --! first input to OR gate
  b: in std_logic;       --! second input to OR gate
  q: out std_logic);     --! result of the OR gate
end or_gate;

--------------------------------------------------------------------------------
--! RTL description of a simple OR gate
--------------------------------------------------------------------------------
architecture rtl of or_gate is
begin
  process(a, b) is
  begin
    q <= a or b;
  end process;
end rtl;
