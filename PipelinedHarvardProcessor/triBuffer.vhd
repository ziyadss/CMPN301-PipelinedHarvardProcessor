library ieee;
use ieee.std_logic_1164.all;

entity triBuffer is 
generic(n: integer :=1);
port(
	input: in std_logic_vector ( n-1 downto 0 );
	output: out std_logic_vector ( n-1 downto 0 );
	en: in std_logic
);
end triBuffer;

architecture archTriBuffer of triBuffer is
begin

output <= input when en='1' else (others=>'Z');

end archTriBuffer;

