----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2021 03:36:44 PM
-- Design Name: 
-- Module Name: MULT - Behavioral
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

entity MULT is
  Port (
  A : in std_logic_vector(23 downto 0);
  B : in std_logic_vector(23 downto 0);
  result : out std_logic_vector(47 downto 0));
end MULT;

architecture Behavioral of MULT is
signal M : std_logic_vector(23 downto 0);
begin
M<=A;
multpl: process(M)
variable Q,temp:  std_logic_vector(23 downto 0);
variable tempAcc:  std_logic_vector(24 downto 0);
variable Acc : std_logic_vector(48 downto 0);
begin
    Q:= B;
    Acc:=(others=>'0');
    Acc(23 downto 0):=A;
    for i in 0 to 23 loop
        if(Acc(0) = '1') then 
            tempAcc:=Acc(48 downto 24);
            Acc(48 downto 24) := tempAcc + Q; 
        end if;
        Acc(48 downto 0) := '0' & Acc(48 downto 1);
        Acc(48):= '0';
         end loop; 
result(47 downto 0)<=Acc(47 downto 0);    
end process;
end Behavioral;
