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
		outPortIn	: in	std_logic_vector(31 downto 0);
		PC			: in	std_logic_vector(15 downto 0);
		resALU		: in	std_logic_vector(31 downto 0);
		dataStore	: in	std_logic_vector(31 downto 0);
		outPortOut	: out	std_logic_vector(31 downto 0);
		MemoryOut	: out	std_logic_vector(31 downto 0);
		resALUout	: out	std_logic_vector(31 downto 0);
		addCallRet	: out	std_logic_vector(31 downto 0);
		useRetAdd	: out	std_logic;
		
		dstRegIn	: in	std_logic_vector(2 downto 0);
		dstRegOut	: out	std_logic_vector(2 downto 0)
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
	
	component registerDD is 
		generic(n: integer :=32);
		port(
			d				:	in	std_logic_vector(n-1 downto 0);
			q				:	out	std_logic_vector(n-1 downto 0);
			en, clk, rst	:	in	std_logic
			);
	end component;

	signal MemAdd: std_logic_vector(19 downto 0);
	signal dataIn, dataOut: std_logic_vector(31 downto 0);
	signal stackIn: std_logic_vector(31 downto 0) :=std_logic_vector(to_unsigned(2**20 - 2,32));
	signal stackOut: std_logic_vector(31 downto 0);
	signal stackIncr: integer;
	
begin
	
	MemAdd <= stackIn(19 downto 0) when stackEn='1' else resALU(19 downto 0);
	
	dataIn <= "0000000000000000" & PC when DataSrc='1' and CallRetEn='0'
	else dataStore when DataSrc='1' and CallRetEn='1'
	else resALU;
	
	addCallRet <= dataOut;
	useRetAdd <= (not DataSrc) and CallRetEn;
	
	stackOut <= std_logic_vector(to_unsigned(to_integer(unsigned(stackIn)) + stackIncr,32));
	
	stackIncr <= -2 when MemWrite='1' and stackEn='1' else 2 when MemRead='1' and stackEn='1';
	
	Memory: RAM generic map(20, 16) port map(MemAdd, dataIn,dataOut, memWrite, clk, '0');
	SP: registerDD generic map(32) port map(stackIn, stackOut, stackEn, clk, '0');
	
	outPortOut <= outPortIn;
	resALUout <= resALU;
	MemoryOut <= dataOut;
	dstRegOut <= dstRegIn;

end archMemoryStage;
