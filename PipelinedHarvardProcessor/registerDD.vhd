library ieee;
use ieee.std_logic_1164.all;

entity registerDD is 
	generic(n: integer :=32);
	port(
		d				:	in	std_logic_vector(n-1 downto 0);
		q				:	out	std_logic_vector(n-1 downto 0);
		en, clk, rst	:	in	std_logic
		);
end registerDD;

architecture archRegister of registerDD is
begin

	process (clk,rst,en)
	begin
		if rst='1' then q<= (others=>'0');
		elsif rising_edge(clk) and en='1' then q <= d;
		end if;
	end process;

end archRegister;
