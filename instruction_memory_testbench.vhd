LIBRARY ieee;
USE ieee.std_logic_1164.all;


USE ieee.numeric_std.all;
 
ENTITY instruction_memory_testbench IS
end instruction_memory_testbench;
 
ARCHITECTURE behavior OF instruction_memory_testbench IS 
 
    
 
    COMPONENT instruction_memory
    port(
         READ_ADDRESS : in  std_logic_vector(31 downto 0);
         INSTRUCTION : out  std_logic_vector(31 downto 0)
        );
    end COMPONENT;
    

   --inputs
   signal READ_ADDRESS : std_logic_vector(31 downto 0) := (others => '0');

 	--outputs
   signal INSTRUCTION : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
begin
 
	-- instantiate the Unit Under Test (UUT)
   uut: instruction_memory port map (
          READ_ADDRESS => READ_ADDRESS,
          INSTRUCTION => INSTRUCTION
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
		
		READ_ADDRESS <= x"0000_0000";
		
		wait for 30 ns;
		
		READ_ADDRESS <= x"0000_0004";
		
		wait for 30 ns;
		
		READ_ADDRESS <= x"0000_0008";
		
		wait for 30 ns;
		
		READ_ADDRESS <= x"0000_000C";
		
		wait for 30 ns;
		
		READ_ADDRESS <= x"0000_0010";
		
		wait for 30 ns;
		
		READ_ADDRESS <= x"0000_0014";
		
		wait for 30 ns;
		

      wait;
   end process;

end;