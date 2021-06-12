library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoryStage is
	port(
		clk			: in	std_logic;
		memWrite	: in	std_logic;
		memRead		: in	std_logic;
		stackEn		: in	std_logic;
		DataSrc		: in	std_logic;
		CallRetEn	: in	std_logic;
		stackPointer: in	std_logic_vector(31 downto 0);
		stackUpdated: out	std_logic_vector(31 downto 0);
		outPortIn	: in	std_logic_vector(31 downto 0);
		PC			: in	std_logic_vector(15 downto 0);
		resALU		: in	std_logic_vector(31 downto 0);
		dataStore	: in	std_logic_vector(31 downto 0);
		outPortOut	: out	std_logic_vector(31 downto 0);
		MemoryOut	: out	std_logic_vector(31 downto 0);
		resALUout	: out	std_logic_vector(31 downto 0);
		addCallRet	: out	std_logic_vector(31 downto 0);
		useRetAdd	: out	std_logic
		);
end memoryStage;

architecture archMemoryStage of memoryStage is

	component RAM is
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
	end component;

	signal MemAdd: std_logic_vector(31 downto 0);
	signal dataIn: std_logic_vector(31 downto 0);
	signal dataOut: std_logic_vector(31 downto 0);
	signal stackIncr: integer;
	
begin
	
	MemAdd <= stackPointer when stackEn='1' else resALU;
	
	dataIn <= "0000000000000000" & PC when DataSrc='1' and CallRetEn='0'
	else dataStore when DataSrc='1' and CallRetEn='1'
	else resALU;
	
	addCallRet <= dataOut;
	useRetAdd <= (not DataSrc) and CallRetEn;
	
	stackUpdated <= std_logic_vector(to_unsigned(to_integer(unsigned(stackPointer)) + stackIncr,32));
	
	stackIncr <= -2 when MemWrite='1' and stackEn='1' else 2 when MemRead='1' and stackEn='1';
	
	Memory: RAM generic map(32, 32) port map(MemAdd, dataIn,dataOut, memWrite, clk, '0');
	
	outPortOut <= outPortIn;
	resALUout <= resALU;
	MemoryOut <= dataOut;

end archMemoryStage;
