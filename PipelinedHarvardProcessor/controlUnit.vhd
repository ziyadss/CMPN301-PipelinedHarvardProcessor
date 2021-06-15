LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY controlUnit IS
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
END ENTITY controlUnit;

ARCHITECTURE controlUnit_arch OF controlUnit IS
BEGIN
	PROCESS (clk) IS
	BEGIN
		IF rising_edge (clk) THEN
			IF (opCode = "00000") THEN
				regWrite <= '0';
				ALUSrc <= "00";
				ALUControl <= "0000";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
			END IF;
			IF (opCode = "00010") THEN
				regWrite <= '0';
				ALUSrc <= "00";
				ALUControl <= "0000";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '1';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
			END IF;
			IF (opCode = "00011") THEN
				regWrite <= '0';
				ALUSrc <= "00";
				ALUControl <= "0000";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '1';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
			END IF;
			IF (opCode = "00100") THEN
				regWrite <= '0';
				ALUSrc <= "00";
				ALUControl <= "0000";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '1';
				StackEn <= '1';
				Mem2Reg <= '0';
				CallRetEn <= '1';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
			END IF;
			IF (opCode = "10001") THEN
				regWrite <= '1';
				ALUSrc <= "00";
				ALUControl <= "0110";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
			END IF;
			IF (opCode = "10010") THEN
				regWrite <= '1';
				ALUSrc <= "00";
				ALUControl <= "1010";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
			END IF;
			IF (opCode = "10011") THEN
				regWrite <= '1';
				ALUSrc <= "00";
				ALUControl <= "1011";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
			END IF;
			IF (opCode = "10100") THEN
				regWrite <= '0';
				ALUSrc <= "00";
				ALUControl <= "0000";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
			END IF;
			IF (opCode = "10101") THEN
				regWrite <= '1';
				ALUSrc <= "00";
				ALUControl <= "0000";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
			ELSE
				regWrite <= '0';
				ALUSrc <= "00";
				ALUControl <= "0000";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
			END IF;
		END IF;
	END PROCESS;
END controlUnit_arch;