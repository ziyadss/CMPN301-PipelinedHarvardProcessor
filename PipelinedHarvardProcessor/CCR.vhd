LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


entity CCR is 

port ( clk                           : in  std_logic;
       FLAGControl                   : in std_logic_vector (2 downTO 0); --2=carry 1=NEG 0=ZERO
       CarryFlagOUT                  : OUT  std_logic;
       NegtiveFlagOUT     	     : OUT std_logic;
       ZeroFlagOUT		     : OUT  std_logic

       
);                                                

end CCR ;

architecture arch_CCR of CCR is


component REG1BIT is 
	
	port(
		d				:	in	std_logic;
		q				:	out	std_logic;
		en, clk, rst	:	in	std_logic
		);
end component REG1BIT ;

begin 



ZEROFLAG :   REG1BIT 	port map (FLAGControl(0),ZeroFlagOUT,'1',clk,'0');
NEGTIVEFLAG : REG1BIT	port map (FLAGControl(1), NegtiveFlagOUT ,'1',clk,'0');
CARRYFLAG :   REG1BIT	port map (FLAGControl(2), CarryFlagOUT ,'1',clk,'0');


















end arch_CCR;