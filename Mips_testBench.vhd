
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 

ENTITY Mips_testBench IS
END Mips_testBench;
 
ARCHITECTURE behavior OF Mips_testBench IS 
 
   
 
    COMPONENT Mips_Processor
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic
        );
    END COMPONENT;
    

  
   signal clk : std_logic := '0';
   signal reset : std_logic := '1';

  
   constant clk_period : time := 100 ns;
 
BEGIN
 

   uut: MIPS_processor PORT MAP (
          clk,
          reset
        );

  
   clk_input:process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

  
   --stimulus_process: process
--   begin		
--      
--      wait for 110 ns;	
--		
--		reset <= '0';
--
--      wait for clk_period*10;
--
--      
--
--      wait;
--   end process;
--
END;