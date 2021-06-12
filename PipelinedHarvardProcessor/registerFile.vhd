library ieee;
use ieee.std_logic_1164.all;

entity registerFile is
	generic(
		addWid: integer :=3;
		dataWid: integer :=32
		);
	port(
		src1, src2, dst	:	in	std_logic_vector(addWid-1 downto 0);
		dataIn			:	in	std_logic_vector(dataWid-1 downto 0);
		wEn, clk, rst	:	in	std_logic
		);
end registerFile;

architecture archRegisterFile of registerFile is
	
	component registerDD is 
		generic(n: integer :=32);
		port(
			d				:	in	std_logic_vector(n-1 downto 0);
			q				:	out	std_logic_vector(n-1 downto 0);
			en, clk, rst	:	in	std_logic;
			);
	end component;
	
	component triBuffer is 
		generic(n: integer :=1);
		port(
			input	:	in	std_logic_vector(n-1 downto 0);
			output	:	out	std_logic_vector(n-1 downto 0);
			en		:	in	std_logic
			);
	end component;
	
	
type regOut_type is array(0 to 2**n - 1) of std_logic_vector(unit-1 downto 0);
signal ram: ram_type;

--	signal outReg0: std_logic_vector (wid-1 downto 0);
--	signal outReg1: std_logic_vector (wid-1 downto 0);
--	signal outReg2: std_logic_vector (wid-1 downto 0);
--	signal outReg3: std_logic_vector (wid-1 downto 0);
	
begin
	
--	wDec: decoder_2x4 port map (wAdd,wReg,wEn);
--	rDec: decoder_2x4 port map (rAdd,rReg,rEn);
--	
--	reg0: registerDD generic map(wid) port map (clk,rst,wReg(0),data,outReg0);
--	reg1: registerDD generic map(wid) port map (clk,rst,wReg(1),data,outReg1);
--	reg2: registerDD generic map(wid) port map (clk,rst,wReg(2),data,outReg2);
--	reg3: registerDD generic map(wid) port map (clk,rst,wReg(3),data,outReg3);
--	reg4: registerDD generic map(wid) port map (clk,rst,wReg(4),data,outReg4);
--	reg5: registerDD generic map(wid) port map (clk,rst,wReg(5),data,outReg5);
--	reg6: registerDD generic map(wid) port map (clk,rst,wReg(6),data,outReg6);
--	reg7: registerDD generic map(wid) port map (clk,rst,wReg(7),data,outReg7);
--	
--	tri0: triBuffer generic map(wid) port map (outReg0,data,rReg(0));
--	tri1: triBuffer generic map(wid) port map (outReg1,data,rReg(1));
--	tri2: triBuffer generic map(wid) port map (outReg2,data,rReg(2));
--	tri3: triBuffer generic map(wid) port map (outReg3,data,rReg(3));
		
end archRegisterFile;