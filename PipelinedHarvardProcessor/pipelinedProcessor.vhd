library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipelinedProcessor is
	port(
		clk		: in	std_logic;
		reset	: in	std_logic;
		inPort	: in	std_logic_vector(31 downto 0);
		outPort	: out	std_logic_vector(31 downto 0)
		);
end pipelinedProcessor;

architecture archPipelinedProcessor of pipelinedProcessor is
	
	component fetchStage is 
	port ( clk                   : in std_logic ;
		branch0		     : in  std_logic_vector (15 downTO 0);
		branch1		     : in  std_logic_vector (15 downTO 0);
		addOutput       	     : out std_logic_vector (15 downTO 0);
		instructionOut        : out std_logic_vector (31 downTO 0);
	   reset	:	in	std_logic;
	   DoCallRet : in std_logic
	);                                                
	end component;
	
	component bufferFetchDecode is
	port(
		clk			: in	std_logic;
		addOutputIN		: in    std_logic_vector (15 downto 0);
		instructionOutIN        : in    std_logic_vector (31 downto 0);

		addOutputOUT		: out    std_logic_vector (15 downto 0);
		instructionOutOUT        : out   std_logic_vector (31 downto 0)
		);
	end component;
	
	component decodeStage IS
		PORT (
			clk : IN STD_LOGIC;
			addOutputFetch : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			instructionIn : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			datain : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			dst : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			wEn : IN STD_LOGIC;
			data1, data2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			immdVal : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			shiftImmdVal : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			addOutput : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			instructionOut : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			regWrite : OUT STD_LOGIC;
			ALUSrc : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
			ALUControl : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			RegDst : OUT STD_LOGIC;
			MemWrite : OUT STD_LOGIC;
			MemRead : OUT STD_LOGIC;
			StackEn : OUT STD_LOGIC;
			Mem2Reg : OUT STD_LOGIC;
			CallRetEn : OUT STD_LOGIC;
			FlagOp : OUT STD_LOGIC;
			JmpOpEn : OUT STD_LOGIC;
			JmpOP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
			ImmVal : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
		);
	END component;
	
	component bufferExMem is
		port(
			clk			: in	std_logic;
			
			memWriteIn	: in	std_logic;
			memReadIn	: in	std_logic;
			stackEnIn	: in	std_logic;
			DataSrcIn	: in	std_logic;
			CallRetEnIn	: in	std_logic;
			memWriteOut	: out	std_logic;
			memReadOut	: out	std_logic;
			stackEnOut	: out	std_logic;
			DataSrcOut	: out	std_logic;
			CallRetEnOut: out	std_logic;
			outPortEnIn	: in	std_logic;
			Mem2RegIn	: in	std_logic;
			RegWriteIn	: in	std_logic;
			outPortEnOut: out	std_logic;
			Mem2RegOut	: out	std_logic;
			RegWriteOut	: out	std_logic;
			
			outPortIn	: in	std_logic_vector(31 downto 0);
			PCIn		: in	std_logic_vector(15 downto 0);
			resALUIn	: in	std_logic_vector(31 downto 0);
			dataStoreIn	: in	std_logic_vector(31 downto 0);
			dstRegIn	: in	std_logic_vector(2 downto 0);
			
			outPortOut	: out	std_logic_vector(31 downto 0);
			PCOut		: out	std_logic_vector(15 downto 0);
			resALUOut	: out	std_logic_vector(31 downto 0);
			dataStoreOut: out	std_logic_vector(31 downto 0);
			dstRegOut	: out	std_logic_vector(2 downto 0)
			);
	end component;

	component memoryStage is
		port(
			clk			: in	std_logic;
			memWrite	: in	std_logic;
			memRead		: in	std_logic;
			stackEn		: in	std_logic;
			DataSrc		: in	std_logic;
			CallRetEn	: in	std_logic;
			outPortIn	: in	std_logic_vector(31 downto 0);
			PC			: in	std_logic_vector(15 downto 0);
			resALUin	: in	std_logic_vector(31 downto 0);
			dataStore	: in	std_logic_vector(31 downto 0);
			outPortEnIn	: in	std_logic;
			Mem2RegIn	: in	std_logic;
			RegWriteIn	: in	std_logic;
			dstRegIn	: in	std_logic_vector(2 downto 0);
			
			addCallRet	: out	std_logic_vector(15 downto 0);	-- to PC
			useRetAdd	: out	std_logic;						
			
			dstRegOut	: out	std_logic_vector(2 downto 0);	--to buffer
			outPortOut	: out	std_logic_vector(31 downto 0);
			MemoryOut	: out	std_logic_vector(31 downto 0);
			resALUout	: out	std_logic_vector(31 downto 0);
			outPortEnOut: out	std_logic;
			Mem2RegOut	: out	std_logic;
			RegWriteOut	: out	std_logic
			);
	end component;

	component bufferMemWb is
		port(
			clk			: in	std_logic;
			
			outPortEnIn	: in	std_logic;
			Mem2RegIn	: in	std_logic;
			RegWriteIn	: in	std_logic;
			outPortIn	: in	std_logic_vector(31 downto 0);
			MemoryIn	: in	std_logic_vector(31 downto 0);
			resALUIn	: in	std_logic_vector(31 downto 0);
			dstRegIn	: in	std_logic_vector(2 downto 0);
			
			outPortEnOut: out	std_logic;
			Mem2RegOut	: out	std_logic;
			RegWriteOut	: out	std_logic;
			outPortOut	: out	std_logic_vector(31 downto 0);
			MemoryOut	: out	std_logic_vector(31 downto 0);
			resALUOut	: out	std_logic_vector(31 downto 0);
			dstRegOut	: out	std_logic_vector(2 downto 0)
	
			
			);
	end component;

	component writeBackStage is
		port(
			outPortEn	: in	std_logic;
			outPortIn	: in	std_logic_vector(31 downto 0);
			MemoryIn	: in	std_logic_vector(31 downto 0);
			resALU		: in	std_logic_vector(31 downto 0);
			dstRegIn	: in	std_logic_vector(2 downto 0);
			Mem2Reg		: in	std_logic;
			RegWriteIn	: in	std_logic;
			outPortOut	: out	std_logic_vector(31 downto 0);
			RegWriteOut	: out	std_logic;
			writeData	: out	std_logic_vector(31 downto 0);
			dstRegOut	: out	std_logic_vector(2 downto 0)
			);
	end component;
	
	signal branchJump, branchCR : std_logic_vector(15 downto 0);
	signal nextPC_FD, nextPC_D, nextPC_DE : std_logic_vector(15 downto 0);
	signal instruction_FD, instruction_D, instruction_DE : std_logic_vector(31 downto 0);
	signal WB_Dst	:	std_logic_vector(2 downto 0);
	signal WB_Data	:	std_logic_vector(31 downto 0);
	signal WB_En	:	std_logic;
	signal Reg1_DE, Reg2_DE, shImm_DE, Imm_DE, Reg1_E, Reg2_E, shImm_E, Imm_E : std_logic_vector(31 downto 0);
	
	signal DoCallRet : std_logic;
	
	signal ALUControl_DE: std_logic_vector (3 downto 0);
	signal regWrite_DE,RegDst_DE,MemWrite_DE,MemRead_DE,StackEn_DE,Mem2Reg_DE,CallRetEn_DE,FlagOp_DE,JmpOpEn_DE	: std_logic;
	signal ALUSrc_DE,JmpOP_DE,ImmVal_DE		: std_logic_vector (1 downto 0);
		
	signal memWrite_EM,memRead_EM,stackEn_EM,DataSrc_EM,CallRetEn_EM,outPortEn_EM,Mem2Reg_EM,RegWrite_EM	: std_logic;
	signal memWrite_M,memRead_M,stackEn_M,DataSrc_M,CallRetEn_M,outPortEn_M,Mem2Reg_M,RegWrite_M	: std_logic;
	signal outPort_EM,resALU_EM,dataStore_EM	: std_logic_vector(31 downto 0);
	signal PC_EM		: std_logic_vector(15 downto 0);
	signal dstReg_EM	: std_logic_vector(2 downto 0);
	signal PC_M		: std_logic_vector(15 downto 0);
	signal outPort_M,resALU_M,dataStore_M	: std_logic_vector(31 downto 0);
	signal dstReg_M	: std_logic_vector(2 downto 0);
	
	signal dstReg_MW	: std_logic_vector(2 downto 0);
	signal outPort_MW,Memory_MW,resALU_MW	: std_logic_vector(31 downto 0);
	signal outPortEn_MW,Mem2Reg_MW,RegWrite_MW: std_logic;
	
	signal outPortEn_W,Mem2Reg_W,RegWrite_W: std_logic;
	signal outPort_W,Memory_W,resALU_W	: std_logic_vector(31 downto 0);
	signal dstReg_W	: std_logic_vector(2 downto 0);

begin
	
	Fetch: fetchStage port map(clk,branchJump,branchCR,nextPC_FD,instruction_FD,reset,DoCallRet);		--need to input branch conditions
	
	IF_ID_Buffer:  bufferFetchDecode port map(clk,nextPC_FD,instruction_FD,nextPC_D,instruction_D);
	
	Decode: decodeStage port map(clk,nextPC_D,instruction_D,WB_Data,WB_Dst,WB_En,Reg1_DE, Reg2_DE,Imm_DE,shImm_DE,nextPC_DE,instruction_DE,regWrite_DE,ALUSrc_DE,ALUControl_DE,RegDst_DE,MemWrite_DE,MemRead_DE,StackEn_DE,Mem2Reg_DE,CallRetEn_DE,FlagOp_DE,JmpOpEn_DE,JmpOP_DE,ImmVal_DE);
	--input port here
	
	--ID_EX_Buffer
	--Execute
	
	EX_MEM_Buffer: bufferExMem port map(clk,memWrite_EM,memRead_EM,stackEn_EM,DataSrc_EM,CallRetEn_EM,memWrite_M,memRead_M,stackEn_M,DataSrc_M,CallRetEn_M,outPortEn_EM,Mem2Reg_EM,RegWrite_EM,outPortEn_M,Mem2Reg_M,RegWrite_M,outPort_EM,PC_EM,resALU_EM,dataStore_EM,dstReg_EM,outPort_M,PC_M,resALU_M,dataStore_M,dstReg_M);
	
	Memory: memoryStage port map(clk,memWrite_M,memRead_M,stackEn_M,DataSrc_M,CallRetEn_M,outPort_M,PC_M,resALU_M,dataStore_M,outPortEn_M,Mem2Reg_M,RegWrite_M,dstReg_M,branchCR,DoCallRet,dstReg_MW,outPort_MW,Memory_MW,resALU_MW,outPortEn_MW,Mem2Reg_MW,RegWrite_MW);
	
	MEM_WB_Buffer: bufferMemWb port map(clk,outPortEn_MW,Mem2Reg_MW,RegWrite_MW,outPort_MW,Memory_MW,resALU_MW,dstReg_MW,outPortEn_W,Mem2Reg_W,RegWrite_W,outPort_W,Memory_W,resALU_W,dstReg_W);
	
	WriteBack: writeBackStage port map(outPortEn_W,outPort_W,Memory_W,resALU_W,dstReg_W,Mem2Reg_W,RegWrite_W,outPort,WB_En,WB_Data,WB_Dst);
	
end archPipelinedProcessor;

