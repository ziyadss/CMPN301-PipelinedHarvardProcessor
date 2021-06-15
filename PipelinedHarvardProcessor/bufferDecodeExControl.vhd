LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY bufferDecodeExControl IS
	PORT (
		clk : IN STD_LOGIC;

		ALUSrcIn : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		ALUControlIn : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		ImmValIn : IN STD_LOGIC_VECTOR (1 DOWNTO 0);

		ALUSrcOut : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		ALUControlOut : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		ImmValOut : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)

	);
END bufferDecodeExControl;

ARCHITECTURE bufferDecodeExControl_arch OF bufferDecodeExControl IS

	COMPONENT registerDD IS
		GENERIC (n : INTEGER := 32);
		PORT (
			d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
			q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
			en, clk, rst : IN STD_LOGIC
		);
	END COMPONENT;

BEGIN

	ALUSrcBuf : registerDD GENERIC MAP(2) PORT MAP(ALUSrcIn, ALUSrcOut, en => '1', clk => clk, rst => '0');
	ALUControlBuf : registerDD GENERIC MAP(4) PORT MAP(ALUControlIn, ALUControlOut, en => '1', clk => clk, rst => '0');
	ImmValBuf : registerDD GENERIC MAP(2) PORT MAP(ImmValIn, ImmValOut, en => '1', clk => clk, rst => '0');

END bufferDecodeExControl_arch; -- arch