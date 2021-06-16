library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ExecuteStage is 

port ( clk                   : in std_logic ;
        SELDATA1            : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        SELDATA2            : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
aluResultWB,aluResultMEM,INport   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        data1In, data2In : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        immdValIn : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        shiftImmdValIn : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        addOutputIn : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        instructionIn : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        regWriteIn : IN STD_LOGIC;
        ALUSrcIn : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        ALUControlIn : IN STD_LOGIC_VECTOR (3 DOWNTO 0); ------
        RegDstIn : IN STD_LOGIC;
        MemWriteIn : IN STD_LOGIC;
        MemReadIn : IN STD_LOGIC;
        StackEnIn : IN STD_LOGIC;
        Mem2RegIn : IN STD_LOGIC;
        CallRetEnIn : IN STD_LOGIC;
        FlagOpIn : IN STD_LOGIC;
        JmpOpEnIn : IN STD_LOGIC;
        JmpOPIn : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        ImmValIn : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        data1SrcIn, data2SrcIn : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
       -- outPortEnIn : IN STD_LOGIC;
        DataSrcIn,outPortEnIn : IN STD_LOGIC;
              memWriteOut	: out	std_logic;
		memReadOut	: out	std_logic;
		stackEnOut	: out	std_logic;
		DataSrcOut	: out	std_logic;
                   CallRetEnOut: out	std_logic;
                    outPortEnOut: out	std_logic;
		Mem2RegOut	: out	std_logic;
		RegWriteOut	: out	std_logic;
                outPortOut1,OP2OUTMEM	: out	std_logic_vector(31 downto 0);
		PCOut		: out	std_logic_vector(15 downto 0);
		resALUOut	: out	std_logic_vector(31 downto 0);
		dstRegOut	: out	std_logic_vector(2 downto 0)
);                                                

end ExecuteStage ;




architecture archExecuteStage of ExecuteStage is


 component  muxEX3 is 
Port ( 

Input0: IN std_logic_vector (2 downto 0);
Input1: IN std_logic_vector (2 downto 0);
S: IN std_logic;
Output: Out std_logic_vector (2 downto 0)
);
end component;

component muxEX4 is 
Port ( 

Input0: IN std_logic_vector (31 downto 0);
Input1: IN std_logic_vector (31 downto 0);
Input2: IN std_logic_vector (31 downto 0);
Input3: IN std_logic_vector (31 downto 0);
S: IN std_logic_vector (1 downto 0);
Output: Out std_logic_vector (31 downto 0)
);
end component;


 component CCR is 

port ( clk                           : in  std_logic;
       FLAGControl                   : in std_logic_vector (2 downTO 0); --2=carry 1=NEG 0=ZERO
       CarryFlagOUT                  : OUT  std_logic;
       NegtiveFlagOUT     	     : OUT std_logic;
       ZeroFlagOUT		     : OUT  std_logic

       
);                                                

end  component CCR ;



component ALU is 

port ( ALUControl            : in  std_logic_vector (3 downTO 0);
       OP1		     : in  std_logic_vector (31 downTO 0);
       OP2		     : in  std_logic_vector (31 downTO 0);
       Result      	     : out std_logic_vector (31 downTO 0);
       FLAGControl           : inout std_logic_vector (2 downTO 0) --2=carry 1=NEG 0=ZERO
);                                                

end  component ALU ;

signal OP1OUT,OP2OUT,OP2OUTtemp,Result,ZERO : std_logic_vector (31 downto 0);
signal ZEROFLAG,NEGTIVEFLAG,CARRYFLAG :std_logic ;
signal FlagCont,OUTDEST : std_logic_vector (2 downto 0);


begin 

ZERO<=(others=>'0');



ALUEX : ALU port map(  ALUControlIn,OP1OUT,OP2OUT,Result,FlagCont); 

CCREX : CCR port map( clk ,FlagCont,CARRYFLAG,NEGTIVEFLAG,ZEROFLAG);



MUXOP1 : muxEX4 port map( data1In,aluResultMEM,aluResultWB,ZERO,SELDATA1 ,OP1OUT);


MUXOP2temp : muxEX4 port map(data2In,aluResultMEM,aluResultWB,ZERO,SELDATA2 ,OP2OUTtemp);


MUXOP2 : muxEX4 port map(INport ,OP2OUTtemp,shiftImmdValIn,immdValIn,ALUSrcIn ,OP2OUT);


MUXDEST : muxEX3 port map( data1SrcIn , data2SrcIn , RegDstIn,OUTDEST);


resALUOut<=Result;
outPortOut1<=OP1OUT;
OP2OUTMEM<=OP2OUTtemp;
dstRegOut<=OUTDEST;

memWriteOut<=memWriteIn;
memReadOut<=memReadIn;
stackEnOut<=stackEnIn;
DataSrcOut<=DataSrcIn;
CallRetEnOut<=CallRetEnIn;
outPortEnOut<=outPortEnIn;
Mem2RegOut<=Mem2RegIn;
RegWriteOut<=RegWriteIn;       	
PCOut<=addOutputIn;
			








end archExecuteStage;





