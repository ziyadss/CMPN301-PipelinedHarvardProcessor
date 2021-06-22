library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bufferExMem is
	port(
		clk			: in	std_logic;
		
		memWriteIn	: in	std_logic;
		memReadIn	: in	std_logic;
		stackEnIn	: in	std_logic;
		DataSrcIn	: in	std_logic;
		CallRetEnIn	: in	std_logic;
		memWriteOut	: out	std_logic;
		memReadOut	: out	std_logic;
		stackEnOut	: out	std_logic;
		DataSrcOut	: out	std_logic;
		CallRetEnOut: out	std_logic;
		outPortEnIn	: in	std_logic;
		Mem2RegIn	: in	std_logic;
		RegWriteIn	: in	std_logic;
		outPortEnOut: out	std_logic;
		Mem2RegOut	: out	std_logic;
		RegWriteOut	: out	std_logic;
		
		outPortIn	: in	std_logic_vector(31 downto 0);
		PCIn		: in	std_logic_vector(15 downto 0);
		resALUIn	: in	std_logic_vector(31 downto 0);
		dataStoreIn	: in	std_logic_vector(31 downto 0);
		dstRegIn	: in	std_logic_vector(2 downto 0);
		
		outPortOut	: out	std_logic_vector(31 downto 0);
		PCOut		: out	std_logic_vector(15 downto 0);
		resALUOut	: out	std_logic_vector(31 downto 0);
		dataStoreOut: out	std_logic_vector(31 downto 0);
		dstRegOut	: out	std_logic_vector(2 downto 0)
		);
end bufferExMem;

architecture archBufferExMem of bufferExMem is

	component bufferExMemControl is
		port(
			clk			: in	std_logic;
			
			memWriteIn	: in	std_logic;
			memReadIn	: in	std_logic;
			stackEnIn	: in	std_logic;
			DataSrcIn	: in	std_logic;
			CallRetEnIn	: in	std_logic;
			
			memWriteOut	: out	std_logic;
			memReadOut	: out	std_logic;
			stackEnOut	: out	std_logic;
			DataSrcOut	: out	std_logic;
			CallRetEnOut: out	std_logic
			
			);
	end component;

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

	outPortBuf:		registerDD generic map (32) port map (outPortIn,outPortOut,'1',clk,'0');
	PCBuf:			registerDD generic map (16) port map (PCIn,PCOut,'1',clk,'0');
	resALUBuf:		registerDD generic map (32) port map (resALUIn,resALUOut,'1',clk,'0');
	dataStoreBuf:	registerDD generic map (32) port map (dataStoreIn,dataStoreOut,'1',clk,'0');
	dstRegBuf:		registerDD generic map (3) port map (dstRegIn,dstRegOut,'1',clk,'0');

	CtrlBufExMem:	bufferExMemControl port map(clk,memWriteIn,memReadIn,stackEnIn,DataSrcIn,CallRetEnIn,memWriteOut,memReadOut,stackEnOut,DataSrcOut,CallRetEnOut);
		
	CtrlBufMemWb:	bufferMemWbControl port map(clk,outPortEnIn,Mem2RegIn,RegWriteIn,outPortEnOut,Mem2RegOut,RegWriteOut);

end archBufferExMem;

