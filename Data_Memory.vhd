
library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use ieee.numeric_std.all;

entity Data_Memory is	
	port(		  
		clk              :in  std_logic;
		MemRead,MemWrite :in  std_logic;	 
		Address          :in  std_logic_vector(31 downto 0);	
		WriteData        :in  std_logic_vector(31 downto 0); 
		ReadData         :out std_logic_vector(31 downto 0)
	);
end Data_Memory;

architecture Data_Memory of Data_Memory is
begin
process(clk,MemRead,Address) 

subtype Register0 is std_logic_vector(31 downto 0);
type REG_Bank is array(31 downto 0) OF Register0;
variable DataMemory : REG_Bank := ( 
	x"0000_0003",
	x"0000_0004",
	x"0000_0005",
	x"0000_0006",
others => (others => '0') 
);			 

begin 
	if falling_edge(clk) then
		if (MemWrite='1') then 
			ReadData <= (others => '0') ;
			DataMemory(To_Integer(unsigned(Address(6 downto 2)))) := WriteData; 
		end if;
	end if;	
	if (MemRead='1') then
		ReadData <= DataMemory(To_Integer(unsigned(Address(6 downto 2)))) ;
	end if;
	
  end process;
			
  end Data_Memory;
