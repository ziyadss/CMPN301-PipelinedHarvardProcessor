library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity decodeStage is 

port ( clk                   : in std_logic ;
       addOutputFetch	     : in  std_logic_vector (15 downTO 0);
	instructionIn	     : in  std_logic_vector (31 downTO 0);
	datain	     	     : in  std_logic_vector(31 downTO 0) ;
	dst		     : in std_logic_vector(2 downto 0);
	wEn			: in std_logic;
      data1, data2	: out std_logic_vector(31 downto 0);
	immdVal		: out std_logic_vector (31 downto 0);
	shiftImmdVal		: out std_logic_vector (31 downto 0);
       addOutput       	     : out std_logic_vector (15 downTO 0);
       instructionOut        : out std_logic_vector (31 downTO 0);
	regWrite : OUT std_logic;
	ALUSrc :   OUT std_logic_vector (1 downto 0);
	ALUControl : OUT std_logic_vector (3 downto 0);
	RegDst : OUT std_logic;
	MemWrite : OUT std_logic;
	MemRead : OUT std_logic ;
	StackEn : OUT std_logic;
	Mem2Reg : OUT std_logic;
	CallRetEn : OUT std_logic;
	FlagOp : OUT std_logic;
	JmpOpEn :OUT std_logic;
	JmpOP : OUT std_logic_vector (1 downto 0);
	ImmVal : OUT std_logic_vector (1 downto 0)
);                                                

end decodeStage ;


architecture decodeStage_arch of decodeStage is

Component controlUnit is
Port( opCode : IN std_logic_vector (4 downto 0);
	clk : IN std_logic;
	regWrite : OUT std_logic;
	ALUSrc :   OUT std_logic_vector (1 downto 0);
	ALUControl : OUT std_logic_vector (3 downto 0);
	RegDst : OUT std_logic;
	MemWrite : OUT std_logic;
	MemRead : OUT std_logic ;
	StackEn : OUT std_logic;
	Mem2Reg : OUT std_logic;
	CallRetEn : OUT std_logic;
	FlagOp : OUT std_logic;
	JmpOpEn :OUT std_logic;
	JmpOP : OUT std_logic_vector (1 downto 0);
	ImmVal : OUT std_logic_vector (1 downto 0)
);
End component;

component registerFile is
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
end component;

--signal RegWrite,RegDst, MemWrite,MemRead,StackEn,Mem2Reg,CallRetEn,FlagOp,JmpOpEn : std_logic;

	begin
	controlUnitU : controlUnit port map(instructionIn(31 downto 27),clk,regWrite,ALUSrc,ALUControl,RegDst,MemWrite,MemRead,StackEn,Mem2Reg,CallRetEn,FlagOp,JmpOpEn,JmpOP,ImmVal);
	registerFileU : registerFile generic map(3,32) port map(instructionIn(26 downto 24),dst,datain,data1,data2,wEn,clk,'0');
end decodeStage

