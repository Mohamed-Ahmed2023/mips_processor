

LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

Entity Registers is port(
	clk,rst,rw: IN std_logic;	
	readRg1,readRg2,writeRg:IN std_logic_vector(4 downto 0);
	readData1,readData2: OUT std_logic_vector(31 downto 0);
	writeData: IN std_logic_vector(31 downto 0)

	);
End Registers;

architecture RegistersArch of Registers is
    type registerFile is array(31 downto 0) of std_logic_vector(31 downto 0);
    signal regFile: registerFile;
	signal t0: std_logic_vector(31 downto 0);
	signal address: std_logic_vector(4 downto 0);
begin

    process(clk, rst)
        variable zVector: std_logic_vector(31 downto 0) := (others => '0');
    begin
        if rst = '1' then
            -- Initialize all registers to Zeros on reset
            for i in regFile'range loop
                regFile(i) <= zVector;
            end loop;
        elsif rising_edge(clk) then
            -- Writing process 
			if rw = '1' then
				regFile(to_integer(unsigned(writeRg))) <= writeData;
			end if;
        end if;
    end process;
	
	-- Get registers data
	readData1 <= regFile(to_integer(unsigned(readRg1)));
	readData2 <= regFile(to_integer(unsigned(readRg2)));
	t0 <= regFile(to_integer(unsigned(address)));
end RegistersArch;















