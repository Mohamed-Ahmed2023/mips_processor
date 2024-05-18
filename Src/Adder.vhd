-- Code your design here
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.NUMERIC_STD.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Adder IS
  PORT (
    a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    c : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END Adder;

ARCHITECTURE adder_impl OF Adder IS
BEGIN
  c <= a + b;
END adder_impl;