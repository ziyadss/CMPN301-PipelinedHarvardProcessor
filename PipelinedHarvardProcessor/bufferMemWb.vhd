library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bufferMemWb is
	port(
		clk			: in	std_logic;
		
		outPortEnIn	: in	std_logic;
		Mem2RegIn	: in	std_logic;
		RegWriteIn	: in	std_logic;
		outPortIn	: in	std_logic_vector(31 downto 0);
		MemoryIn	: in	std_logic_vector(31 downto 0);
		resALUIn	: in	std_logic_vector(31 downto 0);
		dstRegIn	: in	std_logic_vector(2 downto 0);
		
		outPortEnOut: out	std_logic;
		Mem2RegOut	: out	std_logic;
		RegWriteOut	: out	std_logic;
		outPortOut	: out	std_logic_vector(31 downto 0);
		MemoryOut	: out	std_logic_vector(31 downto 0);
		resALUOut	: out	std_logic_vector(31 downto 0);
		dstRegOut	: out	std_logic_vector(2 downto 0)

		
		);
end bufferMemWb;

architecture archBufferMemWb of bufferMemWb is

	component bufferMemWbControl is
		port(
			clk			: in	std_logic;
			
			outPortEnIn	: in	std_logic;
			Mem2RegIn	: in	std_logic;
			RegWriteIn	: in	std_logic;
	
			outPortEnOut: out	std_logic;
			Mem2RegOut	: out	std_logic;
			RegWriteOut	: out	std_logic
			
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

begin

	outPortBuf:		registerDD generic map (32)	port map (outPortIn,outPortOut,'1',clk,'0');
	MemoryBuf:		registerDD generic map (32)	port map (MemoryIn,MemoryOut,'1',clk,'0');
	resALUBuf:		registerDD generic map (32)	port map (resALUIn,resALUOut,'1',clk,'0');
	dstRegBuf:		registerDD generic map (2) 	port map (dstRegIn,dstRegOut,'1',clk,'0');
	
	CtrlBufMemWb:	bufferMemWbControl port map(clk,outPortEnIn,Mem2RegIn,RegWriteIn,outPortEnOut,Mem2RegOut,RegWriteOut);

end archBufferMemWb;
