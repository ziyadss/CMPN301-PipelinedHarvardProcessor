library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bufferExMemControl is
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
end bufferExMemControl;

architecture archBufferExMemControl of bufferExMemControl is

	component registerDD is 
		generic(n: integer :=32);
		port(
			d				:	in	std_logic_vector(n-1 downto 0);
			q				:	out	std_logic_vector(n-1 downto 0);
			en, clk, rst	:	in	std_logic
			);
	end component;

begin

		memWriteBuf:	registerDD generic map (1) port map (d(0)=>memWriteIn,	q(0)=>memWriteOut,en=>'1',clk=>clk,rst=>'0');
		memReadBuf:		registerDD generic map (1) port map (d(0)=>memReadIn,	q(0)=>memReadOut,en=>'1',clk=>clk,rst=>'0');
		stackEnBuf:		registerDD generic map (1) port map (d(0)=>stackEnIn,	q(0)=>stackEnOut,en=>'1',clk=>clk,rst=>'0');
		DataSrcBuf:		registerDD generic map (1) port map (d(0)=>DataSrcIn,	q(0)=>DataSrcOut,en=>'1',clk=>clk,rst=>'0');
		CallRetEnBuf:	registerDD generic map (1) port map (d(0)=>CallRetEnIn, q(0)=>CallRetEnOut,en=>'1',clk=>clk,rst=>'0');

end archBufferExMemControl;
