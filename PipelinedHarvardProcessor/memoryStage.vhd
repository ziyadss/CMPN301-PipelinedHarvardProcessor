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
		resALUin	: in	std_logic_vector(31 downto 0);
		dataStore	: in	std_logic_vector(31 downto 0);
		outPortEnIn	: in	std_logic;
		Mem2RegIn	: in	std_logic;
		RegWriteIn	: in	std_logic;
		dstRegIn	: in	std_logic_vector(2 downto 0);
		
		addCallRet	: out	std_logic_vector(15 downto 0);	-- to PC								size?
		useRetAdd	: out	std_logic;						
		
		dstRegOut	: out	std_logic_vector(2 downto 0);	--to buffer
		outPortOut	: out	std_logic_vector(31 downto 0);
		MemoryOut	: out	std_logic_vector(31 downto 0);
		resALUout	: out	std_logic_vector(31 downto 0);
		outPortEnOut: out	std_logic;
		Mem2RegOut	: out	std_logic;
		RegWriteOut	: out	std_logic
		);
end memoryStage;

architecture archMemoryStage of memoryStage is

	component RAM is
		generic(
			AddWid: integer :=20;
			unit: integer :=16
				);
		port(
			address: in std_logic_vector (AddWid-1 downto 0);
			dataIn: in std_logic_vector (2*unit-1 downto 0);
			dataOut: out std_logic_vector (2*unit-1 downto 0);
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
	signal stackOut: std_logic_vector(31 downto 0):=std_logic_vector(to_unsigned(2**20 - 2,32));
	signal stackIncr: integer;
	
begin
	
	MemAdd <= stackOut(19 downto 0) when stackEn='1' else resALUin(19 downto 0);
	
	dataIn <= "0000000000000000" & PC when DataSrc='1' and CallRetEn='1'
	else dataStore when DataSrc='1' and MemWrite='1'
	else resALUin;
	
	addCallRet <= dataOut(15 downto 0);
	useRetAdd <= (not DataSrc) and CallRetEn;
	
	stackIn <= std_logic_vector(to_unsigned(to_integer(unsigned(stackOut))-2,32)) when MemWrite='1' and stackEn='1' else std_logic_vector(to_unsigned(to_integer(unsigned(stackOut))+2,32)) when MemRead='1' and stackEn='1' else stackOut;
	
	--stackIncr <= -2 when MemWrite='1' and stackEn='1' else 2 when MemRead='1' and stackEn='1' else 0;
	
	Memory: RAM generic map(20, 16) port map(MemAdd, dataIn,dataOut, memWrite, clk, '0');
	SP: registerDD generic map(32) port map(stackIn, stackOut, stackEn, clk, '0');
	
	outPortOut <= outPortIn;
	resALUout <= resALUin;
	MemoryOut <= dataOut;
	dstRegOut <= dstRegIn;
	
	outPortEnOut <= outPortEnIn;
	Mem2RegOut	 <= Mem2RegIn;
	RegWriteOut	 <= RegWriteIn;

end archMemoryStage;
