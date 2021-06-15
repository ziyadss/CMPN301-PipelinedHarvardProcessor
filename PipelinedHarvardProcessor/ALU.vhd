LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;



entity ALU is 

port ( ALUControl            : in  std_logic_vector (3 downTO 0);
       OP1		     : in  std_logic_vector (31 downTO 0);
       OP2		     : in  std_logic_vector (31 downTO 0);
       Result      	     : out std_logic_vector (31 downTO 0);
       FLAGControl           : inout std_logic_vector (2 downTO 0) --2=carry 1=NEG 0=ZERO
);                                                

end ALU ;



architecture arch_alu of ALU is

signal Temp      :std_logic_vector (32 downto 0);
signal ZERO,Temp0,FULL:std_logic_vector (31 downto 0);
signal tempFlag  :std_logic_vector (2 downto 0);--2=carry 1=NEG 0=ZERO
 


BEGIN

ZERO<=(others=>'0');
FULL<=(others=>'1');

with ALUControl select Temp <=
'0' & not OP1 when "0110",
std_logic_vector(to_signed(to_integer(signed(OP1))+1,33)) when "1010",
std_logic_vector(to_signed(to_integer(signed(OP1))-1,33)) when "1011",
'0' & ZERO when others;

tempFlag(0) <= not ALUControl(0) when ALUControl(3 downto 1)="000" else '1' when Temp0=ZERO else '0' ;
tempFlag(1) <= FLAGCONTROL(1) when ALUControl(3 downto 1)="000" else Temp(31);
tempFlag(2) <= FLAGCONTROL(2) when ALUControl(3 downto 1)="000" or ALUControl="0110"
			else '1' when ALUControl="1011" and OP1=ZERO
			else '1' when ALUControl="1010" and OP1=FULL
			else '0';

FLAGControl <=tempFlag;
Result      <=Temp(31 downto 0);

end arch_alu;