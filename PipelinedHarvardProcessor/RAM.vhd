library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity RAM is
	generic(
		AddWid: integer :=6;
		unit: integer :=8
			);
	port(
		address: in std_logic_vector (AddWid-1 downto 0);
		dataIn: in std_logic_vector (unit-1 downto 0);
		dataOut: out std_logic_vector (unit-1 downto 0);
		wEn, clk, rst: in std_logic
		);
end RAM;

architecture archRAM of RAM is
	
	type ram_type is array(0 to 2**AddWid - 1) of std_logic_vector(unit-1 downto 0);
	signal ram: ram_type;
	
begin
	process(clk) is
	begin
		if rising_edge(clk) and wEn='1' then
			ram( to_integer(unsigned(address)) ) <= dataIn;
		end if;
	end process;
	
	dataOut <= ram( to_integer(unsigned(address)) );
	
end archRAM;

