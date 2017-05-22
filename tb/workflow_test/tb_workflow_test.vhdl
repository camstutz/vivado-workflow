-- Testbench for workflow_test
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
  -- empty
end testbench;

architecture tb of testbench is

-- DUT component
component top_workflow is
  port (
    sys_clk: in std_logic;
    a_in:    in std_logic;
    b_in:    in std_logic;
    p_out:  out std_logic_vector(3 downto 0);
    q_out:  out std_logic;
    r_out:  out std_logic_vector(3 downto 0)
  );
end component top_workflow;

signal clk : std_logic := '0';
signal a_in, b_in, q_out : std_logic;
signal p_out : std_logic_vector(3 downto 0);
signal r_out : std_logic_vector(3 downto 0);

begin

  -- Connect design with testbench
  DUT : top_workflow port map
  (
    sys_clk => clk,
    a_in    => a_in,
    b_in    => b_in,
    p_out   => p_out,
    q_out   => q_out,
    r_out   => r_out
  );

  --CLOCK:
  clk <= not clk after 0.5 ns;

  process
  begin
    a_in <= '0';
    b_in <= '0';
    wait for 1 ns;
    assert(q_out='0') report "Fail 0/0" severity error;

    a_in <= '0';
    b_in <= '1';
    wait for 1 ns;
    assert(q_out='1') report "Fail 0/1" severity error;

    a_in <= '1';
    b_in <= 'X';
    wait for 1 ns;
    assert(q_out='1') report "Fail 1/X" severity error;

    a_in <= '1';
    b_in <= '1';
    wait for 1 ns;
    assert(q_out='1') report "Fail 1/1" severity error;

    -- Clear inputs
    a_in <= '0';
    b_in <= '0';

    assert false report "Test done." severity note;
    wait;
  end process;
end tb;
