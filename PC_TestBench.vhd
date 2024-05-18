library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_Testbench is
end PC_Testbench;

architecture Behavioral of PC_Testbench is
    component PC
        port(
            clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;
	    signal  clk : STD_LOGIC;
        signal  reset : STD_LOGIC;
        signal  din : STD_LOGIC_VECTOR (31 downto 0);
        signal  dout : STD_LOGIC_VECTOR (31 downto 0);

	begin 
	pcc: PC port map(clk=>clk,reset=>reset,din=>din,dout=>dout);  
	process
	begin
	clk<='1';
	wait for 100ns ;
	Clk<='0'  ;
	Wait for 100ns ;
	End process;
	process	 
	begin
		reset<='0';
	din<=x"ffffffff";
	wait for 100ns;
	reset<='1';
	din<=x"ffffcccc";
	wait for 100ns;
	reset<='1';
	din<=x"ffffccca";
	wait for 100ns;
	reset<='1';
	din<=x"ffffcccf";
	wait for 100ns;
end process;
end Behavioral;