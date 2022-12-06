library ieee;
use ieee.std_logic_1164.all;

entity GSMRegister is
port(
WB_ADDR_IN: in std_logic_vector( 15 downto 0 );
WB_ACK_OUT: out std_logic;
CLK_IN: in std_logic;
WB_DATA_IN: in std_logic_vector( 15 downto 0 );
WB_DATA_OUT: out std_logic_vector( 15 downto 0 );
NRST_IN: in std_logic;
WB_SEL_IN: in std_logic_vector( 1 downto 0 );
WB_STB_IN: in std_logic;
WB_WE_IN: in std_logic;

PRT_O: out std_logic_vector( 15 downto 0 )
 );
end entity GSMRegister;
architecture Behavior of GSMRegister is
 signal QH: std_logic_vector( 7 downto 0 );
 signal QL: std_logic_vector( 7 downto 0 );
begin
 REG: process( CLK_I )
 begin
 if(WB_ADDR_IN = '0000000000000000') then
	if( rising_edge( CLK_IN ) ) then
		if( NRST_IN = '1' ) then
		QH <= B"00000000";
		elsif( (WB_STB_IN and WB_WE_IN and WB_SEL_IN(1)) = '1' ) then
		QH <= WB_DATA_IN( 15 downto 8 );
		else
		QH <= QH;
		end if;
	end if;
	if( rising_edge( CLK_IN ) ) then
		if( NRST_IN = '1' ) then
			QL <= B"00000000";
		elsif( (WB_STB_IN and WB_WE_IN and WB_SEL_IN(0)) = '1' ) then
			QL <= WB_DATA_IN( 7 downto 0 );
		else
			QL <= QL;
		end if;
	end if;
end if;
end process REG;
 WB_ACK_OUT <= WB_STB_IN;
 WB_DATA_OUT( 15 downto 8 ) <= QH;
 WB_DATA_OUT( 7 downto 0 ) <= QL;
 PRT_O( 15 downto 8 ) <= QH;
 PRT_O( 7 downto 0 ) <= QL;
end architecture Behavior;
