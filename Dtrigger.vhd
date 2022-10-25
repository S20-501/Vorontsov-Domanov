library ieee;
use ieee.std_logic_1164.all;

entity dtrigger is
	port(
		clock, reset, D : in std_logic;
		Q : out std_logic := '0'
	);
end dtrigger;

architecture Work of dtrigger is
	signal FF : std_logic;
begin
	process(clock, reset)
	begin
		if (reset='1') then
			FF <= '0';
		elsif (clock='0' and clock'event) then
			FF<=D;
		end if;
	end process;
	Q<=FF;
end Work;