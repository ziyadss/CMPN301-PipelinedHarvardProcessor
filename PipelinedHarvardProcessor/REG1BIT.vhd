library ieee;
use ieee.std_logic_1164.all;

entity REG1BIT is 
	
	port(
		d				:	in	std_logic;
		q				:	out	std_logic;
		en, clk, rst	:	in	std_logic
		);
end REG1BIT ;

architecture archREG1BIT  of REG1BIT  is
begin

	--process (clk,rst,en)
	--begin
	--	if rst='1' then q<= '0';
	--	elsif rising_edge(clk) and en='1' then q <= d;
	--	end if;
	--end process;
	--
	q <= '0' when rst='1' else d when en='1';

end archREG1BIT ;
