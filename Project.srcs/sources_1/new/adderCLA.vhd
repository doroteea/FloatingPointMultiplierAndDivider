----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/16/2021 11:56:59 PM
-- Design Name: 
-- Module Name: adderCLA - Behavioral
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
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.std_logic_signed.ALL;

entity adderCLA is
    Port ( e1 : in STD_LOGIC_VECTOR (8 downto 0);
           e2 : in STD_LOGIC_VECTOR (8 downto 0);
           carry_in : in STD_LOGIC;
           e_out : out STD_LOGIC_VECTOR (8 downto 0);
           carry_out : out STD_LOGIC);
end adderCLA;

architecture Behavioral of adderCLA is
signal sum_temp : STD_LOGIC_VECTOR(8 DOWNTO 0);
signal G : STD_LOGIC_VECTOR(8 DOWNTO 0);
signal P : STD_LOGIC_VECTOR(8 DOWNTO 0);
signal c : STD_LOGIC_VECTOR(8 DOWNTO 0);

begin
    sum_temp <= e1 XOR e2;
    G <= e1 AND e2;
    P <= e1 OR e2;
    
    process (G,P,c,carry_in)
    begin
    c(0)<= carry_in;
    c(1) <= G(0) OR (P(0) AND carry_in);
    CARRY: for i in 1 to 7 loop
          c(i+1) <= G(i) OR (P(i) AND c(i));
          end loop;
    carry_out <= G(8) OR (P(8) AND c(8));
    end process;
    e_out <=sum_temp XOR C;
end behavioral;  
