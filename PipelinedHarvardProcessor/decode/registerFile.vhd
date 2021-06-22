library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registerFile is
	generic(
		addWid: integer :=3;
		dataWid: integer :=32
		);
	port(
		src1, src2, dst	:	in	std_logic_vector(addWid-1 downto 0);
		dataIn			:	in	std_logic_vector(dataWid-1 downto 0);
		data1, data2	: out std_logic_vector(dataWid-1 downto 0);
		wEn, clk, rst	:	in	std_logic
		);
end registerFile;

architecture archRegisterFile of registerFile is
	
	component registerDD is 
		generic(n: integer :=32);
		port(
			d				:	in	std_logic_vector(n-1 downto 0);
			q				:	out	std_logic_vector(n-1 downto 0);
			en, clk, rst	:	in	std_logic
			);
	end component;
	
	type regOut_type is array(0 to 2**addWid - 1) of std_logic_vector(dataWid-1 downto 0);
	signal regOut: regOut_type;
	
	signal wReg: std_logic_vector(2**addWid - 1 downto 0);
	signal writeClk: std_logic;
	
begin
	
	writeClk <= not clk;
	process (clk)
	begin
		wReg <= (others => '0');
		wReg(to_integer(unsigned(dst))) <= wEn;
	end process;

	loop1: for i in 0 to 2**addWid-1 generate
		regX: registerDD generic map(dataWid) port map(dataIn, regOut(i), wReg(i), writeClk, rst);
	end generate;

	data1 <= regOut(to_integer(unsigned(src1)));
	data2 <= regOut(to_integer(unsigned(src2)));

end archRegisterFile;