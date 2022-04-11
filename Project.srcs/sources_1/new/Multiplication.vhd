----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2021 05:02:03 PM
-- Design Name: 
-- Module Name: Multiplication - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Multiplication is             
    Port ( multiplicand : in STD_LOGIC_VECTOR (23 downto 0);
           multiplier : in STD_LOGIC_VECTOR (23 downto 0);
           product : out STD_LOGIC_VECTOR (47 downto 0));
end Multiplication;

architecture Behavioral of Multiplication is

begin

    process(multiplicand, multiplier)
		
		constant x_zeros : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
		constant y_zeros : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
		
		variable A, S, P : STD_LOGIC_VECTOR(49 downto 0);
		variable mn      : STD_LOGIC_VECTOR(23 downto 0);
	
	begin
		
		A := (others => '0');
		S := (others => '0');
		P := (others => '0');
		
		if (multiplicand /= x_zeros and multiplier /= y_zeros) then
			
			A(48 downto 25) := multiplicand;
			A(49) := multiplicand(23);
			
			mn := (not multiplicand) + 1;
			
			S(48 downto 25) := mn;
			S(49) := not(multiplicand(23));
			
			P(24 downto 1) := multiplier;
			
			for i in 1 to 24 loop
				
				if (P(1 downto 0) = "01") then
					P := P + A;
				elsif (P(1 downto 0) = "10") then
					P := P + S;
				end if;
				
				P(48 downto 0) := P(49 downto 1);
			
			end loop;
			
		end if;
		
		product <= P(48 downto 1);
		
end process;
              
end Behavioral;
