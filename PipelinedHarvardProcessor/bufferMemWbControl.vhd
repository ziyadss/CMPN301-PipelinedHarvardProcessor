library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bufferMemWbControl is
	port(
		clk			: in	std_logic;
		
		outPortEnIn	: in	std_logic;
		Mem2RegIn	: in	std_logic;
		RegWriteIn	: in	std_logic;

		outPortEnOut: out	std_logic;
		Mem2RegOut	: out	std_logic;
		RegWriteOut	: out	std_logic
		
		);
end bufferMemWbControl;

architecture archBufferMemWbControl of bufferMemWbControl is

	component registerDD is 
		generic(n: integer :=32);
		port(
			d				:	in	std_logic_vector(n-1 downto 0);
			q				:	out	std_logic_vector(n-1 downto 0);
			en, clk, rst	:	in	std_logic
			);
	end component;

begin

	outPortEnBuf:	registerDD generic map (1) 	port map (d(0)=>outPortEnIn,q(0)=>outPortEnOut,en=>'1',clk=>clk,rst=>'0');
	Mem2RegBuf:		registerDD generic map (1) 	port map (d(0)=>Mem2RegIn,q(0)=>Mem2RegOut,en=>'1',clk=>clk,rst=>'0');
	RegWriteBuf:	registerDD generic map (1) 	port map (d(0)=>RegWriteIn,q(0)=>RegWriteOut,en=>'1',clk=>clk,rst=>'0');

end archBufferMemWbControl;
