LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--Notes: stage runs at the very end of the first clk cycle 
ENTITY decodeStage IS

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

END decodeStage;
ARCHITECTURE decodeStage_arch OF decodeStage IS

	COMPONENT controlUnit IS
		PORT (
			opCode : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			clk : IN STD_LOGIC;
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
	END COMPONENT;

	COMPONENT registerFile IS
		GENERIC (
			addWid : INTEGER := 3;
			dataWid : INTEGER := 32
		);
		PORT (
			src1, src2, dst : IN STD_LOGIC_VECTOR(addWid - 1 DOWNTO 0);
			dataIn : IN STD_LOGIC_VECTOR(dataWid - 1 DOWNTO 0);
			data1, data2 : OUT STD_LOGIC_VECTOR(dataWid - 1 DOWNTO 0);
			wEn, clk, rst : IN STD_LOGIC
		);
	END COMPONENT;

	--signal RegWrite,RegDst, MemWrite,MemRead,StackEn,Mem2Reg,CallRetEn,FlagOp,JmpOpEn : std_logic;

BEGIN
	controlUnitU : controlUnit PORT MAP(instructionIn(31 DOWNTO 27), clk, regWrite, ALUSrc, ALUControl, RegDst, MemWrite, MemRead, StackEn, Mem2Reg, CallRetEn, FlagOp, JmpOpEn, JmpOP, ImmVal);
	registerFileU : registerFile GENERIC MAP(3, 32) PORT MAP(instructionIn(26 DOWNTO 24), instructionIn(23 DOWNTO 21), dst, datain, data1, data2, wEn, clk, '0');
	shiftImmdVal <= (31 DOWNTO 5 => '0') & instructionIn(20 DOWNTO 16);
	immdVal <= (31 DOWNTO 16 => '0') & instructionIn(15 DOWNTO 0);
	addOutput <= addOutputFetch;
	instructionOut <= instructionIn;

END decodeStage_arch;