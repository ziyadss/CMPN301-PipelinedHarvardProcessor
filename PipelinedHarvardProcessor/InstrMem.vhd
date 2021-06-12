library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity InstrMem is
generic(
	AddWid: integer :=6;
	unit: integer :=8
);
port(
	clk, rst, we: in std_logic;
	address: in std_logic_vector ( AddWid-1 downto 0 );
	dataIn: in std_logic_vector ( unit-1 downto 0 );
	dataOut: out std_logic_vector ( 2*unit-1 downto 0 )
);
end InstrMem;

architecture archInstrMem of InstrMem is

type InstrMem_type is array(0 to 2**AddWid - 1) of std_logic_vector(unit-1 downto 0);
signal InstrMem: InstrMem_type;

begin
process(clk) is
begin
	if rising_edge(clk) and we='1' then
		InstrMem( to_integer(unsigned(address)) ) <= dataIn;
	end if;
end process;

dataOut <= InstrMem( to_integer(unsigned(address)) ) & InstrMem( to_integer(unsigned(address))+1 );
end archInstrMem;

