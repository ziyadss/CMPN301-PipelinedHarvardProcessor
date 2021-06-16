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
'0' & not OP1 when "0110", --NOT
std_logic_vector(to_signed(to_integer(signed(OP1))+1,33)) when "1010", --INC
std_logic_vector(to_signed(to_integer(signed(OP1))-1,33)) when "1011", --DEC
'0' & OP2 when "1110", --MOV
std_logic_vector((unsigned('0' & OP1)) + (unsigned('0' &OP2))) when "1101", --ADD
std_logic_vector((unsigned('0' & OP1)) - (unsigned('0' &OP2))) when "1100", --SUB
'0' & (OP1 and OP2) when "0100", --AND
'0' & (OP1 or OP2) when "0101", --OR
--OP1()& OP1(31-to_integer(unsigned(OP2)) downTO 0) & others=>'0' when
OP1(to_integer(32 - unsigned(OP2)))& std_logic_vector(shift_Left(unsigned(OP1),to_integer(unsigned(OP2)))) when "1000",  --SHL
std_logic_vector(shift_Right(unsigned(OP1),to_integer(unsigned(OP2)))) when "1001", --SHR
std_logic_vector((unsigned('0' & OP1)) + (unsigned('0' &OP2))) when "1111", --IADD
'0' & ZERO when others; -- ELSE

tempFlag(0) <= not ALUControl(0) when ALUControl(3 downto 1)="000" 
              else '1' when Temp0=ZERO else '0' ; 
tempFlag(1) <= FLAGCONTROL(1) when ALUControl(3 downto 1)="000" else Temp(31);
tempFlag(2) <= FLAGCONTROL(2) when ALUControl(3 downto 1)="000" or ALUControl="0110"
			else '1' when ALUControl="1011" and OP1=ZERO
			else '1' when ALUControl="1010" and OP1=FULL
			else '0';

FLAGControl <=tempFlag;
Result      <=Temp(31 downto 0);

end arch_alu;