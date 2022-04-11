----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/27/2021 01:17:54 AM
-- Design Name: 
-- Module Name: standardiveDiv - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity standardizeDiv is
  Port (
            signBit : in std_logic;
            exponentBits : in std_logic_vector(8 downto 0);
            mantissaBits : in std_logic_vector(25 downto 0);
            Result : out std_logic_vector(31 downto 0)
   );
end standardizeDiv;

architecture Behavioral of standardizeDiv is
signal  mantissa : std_logic_vector(22 downto 0):= (others => '0');
signal exponent : std_logic_vector(8 downto 0):= (others => '0');
begin
--normalization & rounding
normalization : process(exponentBits,mantissaBits)
variable m : std_logic_vector(25 downto 0);
begin
m:=mantissaBits+1;
if (m(25)='1') then --1.xxxx
    mantissa <= m(24 downto 2);
    exponent<=exponentBits;
else --0.1xxx
    mantissa <= m(23 downto 1);
    exponent<=exponentBits-'1';
end if;

end process;
Result(31)<= signBit;
Result(30 downto 23)<=exponent(7 downto 0);
Result(22 downto 0)<= mantissa;
end Behavioral;

