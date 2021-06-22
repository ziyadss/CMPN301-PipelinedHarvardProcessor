library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux2x1 is 
Port (

sel         : IN std_logic   ;
Output: Out std_logic_vector (1 downto 0)
);
end entity;

Architecture  arch_mux2x1 of mux2x1 is 
begin 


Output <= "10" when sel = '1'
else "01"   when sel = '0';

end Architecture ;
