----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/15/2021 10:08:55 AM
-- Design Name: 
-- Module Name: standardize - Behavioral
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

entity standardizeMul is
  Port (
            signBit : in std_logic;
            exponentBits : in std_logic_vector(8 downto 0);
            mantissaBits : in std_logic_vector(47 downto 0);
            Result : out std_logic_vector(31 downto 0)
   );
end standardizeMul;

architecture Behavioral of standardizeMul is
signal addToExponent : std_logic;
signal  mantissa : std_logic_vector(22 downto 0):= (others => '0');
signal exponent : std_logic_vector(8 downto 0):= (others => '0');
begin
--normalization & rounding
normalization : process(exponentBits,mantissaBits)
begin
if (mantissaBits(47)='1') then 
    mantissa(22 downto 0) <= (mantissaBits(46 downto 24) + mantissaBits(23));
    addToExponent<='1';
else
    mantissa <= (mantissaBits(45 downto 23) + mantissaBits(22));
    addToExponent<='0';
end if;
exponent<=exponentBits+addToExponent;
end process;

Result(31)<= signBit;
Result(30 downto 23)<=exponent(7 downto 0);
Result(22 downto 0)<= mantissa;
end Behavioral;
