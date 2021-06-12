Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

Entity controlUnit is
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
End Entity controlUnit;

Architecture controlUnit_arch of controlUnit is
	begin
	process(clk) is 
	begin 
	if rising_edge (clk) then
		if (opCode="00000") then 
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
		end if;
		if (opCode="00010") then 
			regWrite <= '0';
			ALUSrc<="00";
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
		end if;
		if (opCode="00011") then 
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
		end if;
		if (opCode="00100") then 
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
		end if;
		if (opCode="00010") then 
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
		end if;
	end if;
	end process;			
end controlUnit_arch;
