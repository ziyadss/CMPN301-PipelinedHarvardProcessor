LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY forwardingUnit IS
    PORT (
        clk : IN STD_LOGIC; -- not sure if useful
        data1Dst, data2Dst, dataMemDst, dataWbDst : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        --aluResultMem, aluResultWb : in std_logic_vector (31 downto 0); -- Not needed, use in mux instead

        selData1, selData2 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
    );
END forwardingUnit;

ARCHITECTURE forwardingUnit_arch OF forwardingUnit IS

BEGIN

    selData1 <= "01" WHEN data1Dst = dataMemDst ELSE
        "10" WHEN data1Dst = dataWbDst ELSE
        "00";

    selData2 <= "01" WHEN data2Dst = dataMemDst ELSE
        "10" WHEN data2Dst = dataWbDst ELSE
        "00";

END forwardingUnit_arch;