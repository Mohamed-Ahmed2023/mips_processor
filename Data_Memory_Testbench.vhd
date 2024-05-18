
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Data_Memory_Testbench is
end Data_Memory_Testbench;

architecture Data_Memory_Testbench of Data_Memory_Testbench is	

component Data_Memory
	port(
		clk  :in  std_logic;
		MemRead,MemWrite :in  std_logic;	 
		Address          :in  std_logic_vector(31 downto 0);	
		WriteData        :in  std_logic_vector(31 downto 0); 
		ReadData         :out std_logic_vector(31 downto 0)
	);	   
end component;	

signal clk      : std_logic := '0' ;
signal MemRead,MemWrite : std_logic := '0' ;
signal Address          : std_logic_vector(31 downto 0) := (others => '0');	
signal WriteData        : std_logic_vector(31 downto 0) := (others => '0'); 
signal ReadData         : std_logic_vector(31 downto 0) := (others => '0');		

constant clk_period : time := 10 ns;

begin 	  
	
tree : Data_Memory port map(
	clk	=> clk,
	--enable => enable,
	MemRead => MemRead,
	MemWrite => MemWrite,
	Address => Address,
	WriteData => WriteData,	 
	ReadData => ReadData
);

-- clk process
process 
begin
	clk <= '0';
	wait for clk_period/2;
	clk	<= '1';		 
	wait for clk_period/2;
end process; 

--
process
begin	

    wait for clk_period*10; 
	
	MemRead <= '1';
	MemWrite <= '0';
	--enable <= '0';
	Address <= x"0000_0000";
	WriteData <= x"0000_0000";
	
	wait for clk_period*10;
	
	Address <= x"0000_0004";
	
	wait for clk_period*10;
	----------------------------
	MemRead <= '0';
	MemWrite <= '1';
	writeData <= x"0000_1111";
	
	wait for clk_period*10;
	----------------------------
	MemWrite <= '0';
	MemRead <= '1';
	writeData <= x"0000_0000";

    wait;
end process;   


	
end Data_Memory_Testbench;
