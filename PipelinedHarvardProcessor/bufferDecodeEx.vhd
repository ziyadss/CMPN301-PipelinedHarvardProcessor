LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY bufferDecodeEx IS
    PORT (
        clk : IN STD_LOGIC;
        data1In, data2In : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        immdValIn : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        shiftImmdValIn : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        addOutputIn : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        instructionIn : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        regWriteIn : IN STD_LOGIC;
        ALUSrcIn : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        ALUControlIn : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
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
        outPortEnIn : IN STD_LOGIC;
        DataSrcIn : IN STD_LOGIC;

        data1Out, data2Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        immdValOut : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        shiftImmdValOut : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        addOutputOut : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        instructionOut : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        regWriteOut : OUT STD_LOGIC;
        ALUSrcOut : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        ALUControlOut : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        RegDstOut : OUT STD_LOGIC;
        MemWriteOut : OUT STD_LOGIC;
        MemReadOut : OUT STD_LOGIC;
        StackEnOut : OUT STD_LOGIC;
        Mem2RegOut : OUT STD_LOGIC;
        CallRetEnOut : OUT STD_LOGIC;
        FlagOpOut : OUT STD_LOGIC;
        JmpOpEnOut : OUT STD_LOGIC;
        JmpOPOut : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        ImmValOut : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        data1SrcOut, data2SrcOut : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        outPortEnOut : OUT STD_LOGIC;
        DataSrcOut : OUT STD_LOGIC

    );

END bufferDecodeEx;

ARCHITECTURE bufferDecodeEx_arch OF bufferDecodeEx IS

    COMPONENT registerDD IS
        GENERIC (n : INTEGER := 32);
        PORT (
            d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            en, clk, rst : IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT bufferDecodeExControl IS
        PORT (

            clk : IN STD_LOGIC;

            ALUSrcIn : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            ALUControlIn : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            ImmValIn : IN STD_LOGIC_VECTOR (1 DOWNTO 0);

            ALUSrcOut : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
            ALUControlOut : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            ImmValOut : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)

        );
    END COMPONENT;

    COMPONENT bufferMemWbControl IS
        PORT (
            clk : IN STD_LOGIC;

            outPortEnIn : IN STD_LOGIC;
            Mem2RegIn : IN STD_LOGIC;
            RegWriteIn : IN STD_LOGIC;

            outPortEnOut : OUT STD_LOGIC;
            Mem2RegOut : OUT STD_LOGIC;
            RegWriteOut : OUT STD_LOGIC

        );
    END COMPONENT;

    COMPONENT bufferExMemControl IS
        PORT (
            clk : IN STD_LOGIC;

            memWriteIn : IN STD_LOGIC;
            memReadIn : IN STD_LOGIC;
            stackEnIn : IN STD_LOGIC;
            DataSrcIn : IN STD_LOGIC;
            CallRetEnIn : IN STD_LOGIC;

            memWriteOut : OUT STD_LOGIC;
            memReadOut : OUT STD_LOGIC;
            stackEnOut : OUT STD_LOGIC;
            DataSrcOut : OUT STD_LOGIC;
            CallRetEnOut : OUT STD_LOGIC

        );
    END COMPONENT;

BEGIN

    CtrlBufExMem : bufferExMemControl PORT MAP(clk, memWriteIn, memReadIn, stackEnIn, DataSrcIn, CallRetEnIn, memWriteOut, memReadOut, stackEnOut, DataSrcOut, CallRetEnOut);

    CtrlBufMemWb : bufferMemWbControl PORT MAP(clk, outPortEnIn, Mem2RegIn, RegWriteIn, outPortEnOut, Mem2RegOut, RegWriteOut);

    CtrlBufferDecodeEx : bufferDecodeExControl PORT MAP(clk, ALUSrcIn, ALUControlIn, ImmValIn, ALUSrcOut, ALUControlOut, ImmValOut);

    data1Buff : registerDD GENERIC MAP(32) PORT MAP(data1In, data1Out, en => '1', clk => clk, rst => '0');
    data2Buff : registerDD GENERIC MAP(32) PORT MAP(data2In, data2Out, en => '1', clk => clk, rst => '0');
    immdValBuff : registerDD GENERIC MAP(32) PORT MAP(immdValIn, immdValOut, en => '1', clk => clk, rst => '0');
    shiftImmdValBuff : registerDD GENERIC MAP(32) PORT MAP(shiftImmdValIn, shiftImmdValOut, en => '1', clk => clk, rst => '0');
    addOutputBuff : registerDD GENERIC MAP(16) PORT MAP(addOutputIn, addOutputOut, en => '1', clk => clk, rst => '0');
    instructionBuff : registerDD GENERIC MAP(32) PORT MAP(instructionIn, instructionOut, en => '1', clk => clk, rst => '0');

END bufferDecodeEx_arch;