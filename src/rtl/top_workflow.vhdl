library IEEE;
use IEEE.std_logic_1164.all;

entity top_workflow is
  port(
    sys_clk: in std_logic;
    a_in:    in std_logic;
    b_in:    in std_logic;
    p_out:  out std_logic_vector(3 downto 0);
    q_out:  out std_logic;
    r_out:  out std_logic_vector(3 downto 0)
  );
end top_workflow;

architecture struct of top_workflow is

  component or_gate
    port(
      a:  in std_logic;
      b:  in std_logic;
      q: out std_logic
    );
  end component;

  component multiplier
    port (
      clk :  in std_logic;
      a   :  in std_logic_vector(1 downto 0);
      b   :  in std_logic_vector(1 downto 0);
      p   : out std_logic_vector(3 downto 0)
    );
  end component;

  component multiply_bd
    port (
      clk :  in std_logic;
      a   :  in std_logic_vector(1 downto 0);
      b   :  in std_logic_vector(1 downto 0);
      p   : out std_logic_vector(3 downto 0)
    );
  end component;

begin

    my_or : or_gate
      port map (
        a => a_in,
        b => b_in,
        q => q_out
      );

    my_multiplier : multiplier
      port map (
        clk  => sys_clk,
        a(0) => a_in,
        a(1) => a_in,
        b(0) => b_in,
        b(1) => b_in,
        p    => p_out
      );

    my_bd : multiply_bd
      port map (
        clk  => sys_clk,
        a(0) => a_in,
        a(1) => a_in,
        b(0) => b_in,
        b(1) => b_in,
        p    => r_out
      );

end struct;
