library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity writeBackStage is
	port(
		outPortEn	: in	std_logic;
		outPortIn	: in	std_logic_vector(31 downto 0);
		MemoryIn	: in	std_logic_vector(31 downto 0);
		resALU		: in	std_logic_vector(31 downto 0);
		dstRegIn	: in	std_logic_vector(2 downto 0);
		Mem2Reg		: in	std_logic;
		RegWriteIn	: in	std_logic;
		outPortOut	: out	std_logic_vector(31 downto 0);
		RegWriteOut	: out	std_logic;
		writeData	: out	std_logic_vector(31 downto 0);
		dstRegOut	: out	std_logic_vector(2 downto 0)
		);
end writeBackStage;

architecture archWriteBackStage of writeBackStage is
	
begin
	writeData <= MemoryIn when Mem2Reg='1' else resALU;
	RegWriteOut <= RegWriteIn;
	outPortOut <= outPortIn when outPortEn='1' else (others=>'Z');
	dstRegOut <= dstRegIn;
	
end archWriteBackStage;

