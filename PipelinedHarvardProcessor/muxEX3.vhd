
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity muxEX3 is 
Port ( 

Input0: IN std_logic_vector (2 downto 0);
Input1: IN std_logic_vector (2 downto 0);
S: IN std_logic;
Output: Out std_logic_vector (2 downto 0)
);
end entity;

Architecture  arch_muxEX3 of muxEX3 is 
begin 
Output <= Input0 when S='0'
else Input1 when S='1';

end Architecture;