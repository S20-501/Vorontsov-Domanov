library ieee;
use ieee.std_logic_1164.all;

entity counter_d is
	port(clock: in std_logic;
	     reset: in std_logic;
	     Q: out std_logic_vector(3 downto 0));
end counter_d;

architecture arch_counter of counter_d is

signal DQ: std_logic_vector(3 downto 0);
signal Q_in: std_logic_vector(3 downto 0);

component dtrigger
    port (clock, reset, D : in std_logic;
          Q : out std_logic);
end component;

begin
	process(clock,reset)
	begin
	if (reset = '1') then
	    DQ(0)<='1';
	    DQ(1)<='1';
	    DQ(2)<='1';
	    DQ(3)<='1';
	elsif(clock='1' and clock'event) then
		for i in 0 to 3 loop
			DQ(i)<= not Q_in(i);
		end loop;
	end if;
	end process;
	DFF0: dtrigger
	port map(
		clock => clock,
		reset => reset,
		D => DQ(0),
		Q => Q_in(0));
	DFF1: dtrigger
	port map(
		clock => Q_in(0),
		reset => reset,
		D => DQ(1),
		Q => Q_in(1));
	DFF2: dtrigger
	port map(
		clock => Q_in(1),
		reset => reset,
		D => DQ(2),
		Q => Q_in(2));
	DFF3: dtrigger
	port map(
		clock => Q_in(2),
		reset => reset,
		D => DQ(3),
		Q => Q_in(3));
	Q <= Q_in;
end arch_counter;
