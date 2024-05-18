LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY RegisterFile_tb IS
END RegisterFile_tb;

ARCHITECTURE tb OF RegisterFile_tb IS
    COMPONENT Registers PORT (
        clk, rst, rw : IN STD_LOGIC;
        readRg1, readRg2, writeRg : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        readData1, readData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0));
    END COMPONENT;

    SIGNAL clk, rst, rw : STD_LOGIC;
    SIGNAL readRg1, readRg2, writeRg : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL readData1, readData2, writeData : STD_LOGIC_VECTOR(31 DOWNTO 0);
    CONSTANT clk_period : TIME := 100ns;

BEGIN
    -- Clock process
    PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clk_period / 2;
        clk <= '1';
        WAIT FOR clk_period / 2;
    END PROCESS;

    -- Port the signals to the Register File
    rg : Registers PORT MAP(
        clk => clk,
        rst => rst,
        rw => rw,
        readRg1 => readRg1,
        readRg2 => readRg2,
        writeRg => writeRg,
        readData1 => readData1,
        readData2 => readData2,
        writeData => writeData
    );

    PROCESS
    BEGIN
        rst <= '0';
        rw <= '1';
        writeRg <= "00000"; -- Write at 0
        writeData <= (2 => '1', 0 => '1', OTHERS => '0'); -- "00,,,101" = 5
        readRg1 <= "00000"; -- 0 
        readRg2 <= "00001"; -- 1  
        WAIT FOR clk_period;
        rw <= '1';
        writeRg <= "00001"; -- Write at 1
        writeData <= (2 => '1', 1 => '1', 0 => '1', OTHERS => '0'); -- "00,,,111" = 7
        readRg1 <= "00000"; -- 0 
        readRg2 <= "00001"; -- 1  
        WAIT FOR clk_period;
        rw <= '1';
        writeRg <= "00011"; -- Write at 3
        writeData <= (2 => '1', 1 => '1', 0 => '1', OTHERS => '0'); -- "00,,,111" = 7
        readRg1 <= "00000"; -- 0 
        readRg2 <= "00001"; -- 1 
        WAIT FOR clk_period;
        rw <= '0';
        writeRg <= "00100"; -- Write at 4 & rw = 0
        writeData <= (2 => '1', 1 => '1', 0 => '1', OTHERS => '0'); -- "00,,,111" = 7
        readRg1 <= "00011"; -- 3
        readRg2 <= "00100"; -- 4
        WAIT FOR clk_period;
        rst <= '1';
        WAIT FOR clk_period;
    END PROCESS;
END tb;