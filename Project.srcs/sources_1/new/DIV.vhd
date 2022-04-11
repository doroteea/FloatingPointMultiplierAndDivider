----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/13/2021 06:17:00 PM
-- Design Name: 
-- Module Name: DIV - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;




entity DIV is
  Port (  A : in std_logic_vector(23 downto 0);
  B : in std_logic_vector(23 downto 0);
  result : out std_logic_vector(25 downto 0));
end DIV;

architecture Behavioral of DIV is
signal remainder :  std_logic_vector(24 downto 0):= (others => '0');
begin

divv : process(a,b)
variable b1 : std_logic_vector(23 downto 0);
variable partial_remainder : STD_LOGIC_VECTOR (24 downto 0);
variable tmp_remainder : STD_LOGIC_VECTOR (24 downto 0);
variable r : std_logic_vector(25 downto 0);
begin
b1:=b;
partial_remainder:='0'&A;
digit_loop: for i in 25 downto 0 loop
tmp_remainder:=partial_remainder-('0'&b1);
if(tmp_remainder(24)='0') then
r(i):='1';
partial_remainder:=tmp_remainder;
else
r(i):='0';
end if;
partial_remainder:=partial_remainder(23 downto 0) & '0';
end loop;
result(25 downto 0)<=r;
end process;

end Behavioral;
