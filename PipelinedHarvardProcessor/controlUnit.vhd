USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

Entity controlUnit is
Port( opCode : IN std_logic_vector (4 downto 0);
	clk : IN std_logic;
	regWrite : OUT std_logic;
	ALUSrc :   OUT std_logic_vector (2 downto 0);
	ALUControl : OUT std_logic_vector (4 downto 0);
	RegDst : OUT std_logic;
	MemWrite : OUT std_logic;
	MemRead : OUT std_logic ;
	StackEn : OUT std_logic;
	DataSrc :
	Mem2Reg : OUT std_logic;
	CallRetEn : OUT std_logic;
	FlagOp : OUT std_logic;
	JmpOpEn :OUT std_logic;
	JmpOP : OUT std_logic_vector (1 downto 0);
	ImmVal : OUT std_logic_vector (1 downto 0);
);
End Entity controlUnit;

Architecture controlUnit_arch of controlUnit is
