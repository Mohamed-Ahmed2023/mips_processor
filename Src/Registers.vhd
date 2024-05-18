

LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Registers IS PORT (
    clk, rst, rw : IN STD_LOGIC;
    readRg1, readRg2, writeRg : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    readData1, readData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0)

);
END Registers;

ARCHITECTURE RegistersArch OF Registers IS
    TYPE registerFile IS ARRAY(31 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL regFile : registerFile;
    SIGNAL t0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL address : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN

    PROCESS (clk, rst)
        VARIABLE zVector : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    BEGIN
        IF rst = '1' THEN
            -- Initialize all registers to Zeros on reset
            FOR i IN regFile'RANGE LOOP
                regFile(i) <= zVector;
            END LOOP;
        ELSIF rising_edge(clk) THEN
            -- Writing process 
            IF rw = '1' THEN
                regFile(to_integer(unsigned(writeRg))) <= writeData;
            END IF;
        END IF;
    END PROCESS;

    -- Get registers data
    readData1 <= regFile(to_integer(unsigned(readRg1)));
    readData2 <= regFile(to_integer(unsigned(readRg2)));
    t0 <= regFile(to_integer(unsigned(address)));
END RegistersArch;