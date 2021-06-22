library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity mux2x4 is 
Port (
Input0: IN std_logic_vector (15 downto 0);
Input1: IN std_logic_vector (15 downto 0);
Input2: IN std_logic_vector (15 downto 0);
Input3: IN std_logic_vector (15 downto 0);
S: IN std_logic_vector (1 downto 0);
Output: Out std_logic_vector (15 downto 0)
);
end entity;

Architecture  arch_mux2x4 of mux2x4 is 
begin 
Output <= Input0 when s="00"
else Input1 when s="01"
else Input2 when s="10"
else Input3 when s="11";
end Architecture;