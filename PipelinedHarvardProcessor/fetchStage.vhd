library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity fetchStage is 

port ( clk                   : in std_logic ;
       branch0		     : in  std_logic_vector (15 downTO 0);
       branch1		     : in  std_logic_vector (15 downTO 0);
       addOutput       	     : out std_logic_vector (15 downTO 0);
       instructionOut        : out std_logic_vector (31 downTO 0)
);                                                

end fetchStage ;



architecture arch_fetchStage of fetchStage is

component  InstrMem is
generic(
	AddWid: integer ;
	unit: integer 
);
port(
	clk, rst, we: in std_logic;
	address: in std_logic_vector ( AddWid-1 downto 0 );
	dataIn: in std_logic_vector ( unit-1 downto 0 );
	dataOut: out std_logic_vector ( unit-1 downto 0 )
);
end component ;


 
component  programCounter is 

port ( CLK            : in  std_logic ;
       input		: in  std_logic_vector (15 downTO 0);  
       output		: out std_logic_vector (15 downTO 0) );
end component;


component mux2x4 is 
Port (
Input0: IN std_logic_vector (15 downto 0);
Input1: IN std_logic_vector (15 downto 0);
Input2: IN std_logic_vector (15 downto 0);
Input3: IN std_logic_vector (15 downto 0);
S: IN std_logic_vector (1 downto 0);
Output: Out std_logic_vector (15 downto 0)
);
end component;

component mux2x1 is 
Port (
       sel   : IN std_logic   ;
       Output: Out std_logic_vector (1 downto 0)
);
end component;

signal mux2x4Out , pcOut,addOut,RST,zeroo : std_logic_vector (15 downto 0);
signal ramOut:std_logic_vector (31 downto 0);
signal mux2x1Out:std_logic_vector (1 downto 0);
signal selOf2x1 : std_logic;

signal unknown  : std_logic_vector (1 downto 0):="10";

begin

RST <=(others=>'0');
zeroo<=(others=>'0');

process(clk)
begin
if (falling_edge(clk)) then
selOf2x1<= ramOut(31) and ramOut(30) and ramOut(29) ;

end if;
end process;
addOut <= std_logic_vector(to_unsigned(to_integer(unsigned(mux2x1Out))+to_integer(unsigned(pcOut)),16));

muxadder :  mux2x1         port map ( selOf2x1 ,mux2x1Out);
RAM1   : InstrMem generic map(16,16) port map (clk ,'0','0', pcOut,zeroo,ramOut);
muxPC :        mux2x4      port map (  branch0,branch1,addOut,RST, unknown ,mux2x4Out);
pc    :   programCounter   port map (clk,mux2x4Out,pcOut);

addOutput<=addOut;
instructionOut <= ramOut;
end architecture ;

