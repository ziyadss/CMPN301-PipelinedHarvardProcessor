library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity bufferFetchDecode is
	port(
		clk			: in	std_logic;
		addOutputIN		: in    std_logic_vector (15 downto 0);
		instructionOutIN        : in    std_logic_vector (31 downto 0);

		addOutputOUT		: out    std_logic_vector (15 downto 0);
		instructionOutOUT        : out   std_logic_vector (31 downto 0)
		);
end bufferFetchDecode;



architecture arch_bufferFetchDecode of bufferFetchDecode is

	
	
	component registerDD is 
		generic(n: integer :=32);
		port(
			d				:	in	std_logic_vector(n-1 downto 0);
			q				:	out	std_logic_vector(n-1 downto 0);
			en, clk, rst	:	in	std_logic
			);
	end component;

begin

	ADDOUTPUTBUF:		registerDD generic map (16)	port map (addOutputIN,addOutputOUT,'1',clk,'0');
	INSTRUCTIONOUTBUFF:		registerDD generic map (32)	port map (instructionOutIN,instructionOutOUT,'1',clk,'0');
	
end  arch_bufferFetchDecode;