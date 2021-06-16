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
		ImmVal : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		DataSrc : OUT STD_LOGIC;
		outPortEn : OUT STD_LOGIC
	);
END ENTITY controlUnit;

ARCHITECTURE controlUnit_arch OF controlUnit IS
BEGIN
	PROCESS (clk) IS
	BEGIN
		--IF rising_edge (clk) THEN
			IF (opCode = "XXXXX") THEN --NOP
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
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "00000") THEN --NOP
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
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "00010") THEN --SETC
				regWrite <= '0';
				ALUSrc <= "00";
				ALUControl <= "0001";
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
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "00011") THEN --CLRC
				regWrite <= '0';
				ALUSrc <= "00";
				ALUControl <= "0010";
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
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "00100") THEN --RET
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
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "01110") THEN --MOV
				regWrite <= '1';
				ALUSrc <= "00";
				ALUControl <= "1110";
				RegDst <= '1';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "01000") THEN --ADD
				regWrite <= '1';
				ALUSrc <= "01";
				ALUControl <= "1101";
				RegDst <= '1';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "01001") THEN --SUB
				regWrite <= '1';
				ALUSrc <= "01";
				ALUControl <= "1100";
				RegDst <= '1';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "01010") THEN --AND
				regWrite <= '1';
				ALUSrc <= "01";
				ALUControl <= "0100";
				RegDst <= '1';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "01011") THEN --OR
				regWrite <= '1';
				ALUSrc <= "01";
				ALUControl <= "0101";
				RegDst <= '1';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "01100") THEN --SHL
				regWrite <= '1';
				ALUSrc <= "10";
				ALUControl <= "1000";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "10";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "01101") THEN --SHR
				regWrite <= '1';
				ALUSrc <= "10";
				ALUControl <= "1001";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "10";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "10000") THEN --CALL
				regWrite <= '0';
				ALUSrc <= "00";
				ALUControl <= "0000";
				RegDst <= '0';
				MemWrite <= '1';
				MemRead <= '0';
				StackEn <= '1';
				Mem2Reg <= '0';
				CallRetEn <= '1';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "10";
				outPortEn <= '0';
				DataSrc <= '1';
			END IF;
			IF (opCode = "10001") THEN --NOT
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
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "10010") THEN --INC
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
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "10011") THEN --DEC
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
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "10100") THEN --OUT
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
				outPortEn <= '1';
				DataSrc <= '0';
			END IF;
			IF (opCode = "10101") THEN --IN
				regWrite <= '1';
				ALUSrc <= "00";
				ALUControl <= "0011";
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
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "10110") THEN --PUSH
				regWrite <= '0';
				ALUSrc <= "00";
				ALUControl <= "1110";
				RegDst <= '0';
				MemWrite <= '1';
				MemRead <= '0';
				StackEn <= '1';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
				outPortEn <= '0';
				DataSrc <= '1';
			END IF;
			IF (opCode = "10111") THEN --POP
				regWrite <= '1';
				ALUSrc <= "00";
				ALUControl <= "0000";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '1';
				StackEn <= '1';
				Mem2Reg <= '1';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "00";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "11000") THEN --JZ
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
				JmpOpEn <= '1';
				JmpOp <= "00";
				ImmVal <= "00";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "11001") THEN --JN
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
				JmpOpEn <= '1';
				JmpOp <= "01";
				ImmVal <= "00";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "11010") THEN --JC
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
				JmpOpEn <= '1';
				JmpOp <= "10";
				ImmVal <= "00";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "11011") THEN --JMP
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
				JmpOpEn <= '1';
				JmpOp <= "11";
				ImmVal <= "00";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "11100") THEN --LDD
				regWrite <= '1';
				ALUSrc <= "11";
				ALUControl <= "0111";
				RegDst <= '1';
				MemWrite <= '0';
				MemRead <= '1';
				StackEn <= '0';
				Mem2Reg <= '1';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "01";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "11101") THEN --STD
				regWrite <= '0';
				ALUSrc <= "11";
				ALUControl <= "0111";
				RegDst <= '0';
				MemWrite <= '1';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "01";
				outPortEn <= '0';
				DataSrc <= '1';
			END IF;
			IF (opCode = "11110") THEN --IADD
				regWrite <= '1';
				ALUSrc <= "11";
				ALUControl <= "1111";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "01";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
			IF (opCode = "11111") THEN --LDM
				regWrite <= '1';
				ALUSrc <= "11";
				ALUControl <= "0011";
				RegDst <= '0';
				MemWrite <= '0';
				MemRead <= '0';
				StackEn <= '0';
				Mem2Reg <= '0';
				CallRetEn <= '0';
				FlagOp <= '0';
				JmpOpEn <= '0';
				JmpOp <= "00";
				ImmVal <= "01";
				outPortEn <= '0';
				DataSrc <= '0';
			END IF;
		--END IF;
	END PROCESS;
END controlUnit_arch;