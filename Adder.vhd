-- Code your design here
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY Adder IS
  port (a : in std_logic_vector(31 downto 0);
        b : in std_logic_vector(31 downto 0);
        c : out std_logic_vector(31 downto 0));
end Adder;

ARCHITECTURE adder_impl OF Adder IS
begin
	c <= a + b;
end adder_impl;