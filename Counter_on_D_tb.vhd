library ieee;
use ieee.std_logic_1164.all;

entity tb_counter_d is
end tb_counter_d;

architecture test_counter of tb_counter_d is

	component counter_d
		port (clock: in std_logic;
		      reset: in std_logic;
		      Q: out std_logic_vector(3 downto 0));
	end component;
	
	signal reset, clock: std_logic;
	signal Q: std_logic_vector(3 downto 0);

	begin
	CNT: counter_d
		port map(
			clock => clock,
			reset => reset,
			Q => Q);
	process
	begin
	clock <= '0';
	wait for 10 ns;
	clock <= '1';
	wait for 10 ns;
	end process;

	process
	begin
	reset <= '1';
	wait for 20 ns;
	reset <= '0';
	wait;
	end process;
end test_counter;		