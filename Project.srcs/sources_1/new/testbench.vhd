----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2022 02:28:32 PM
-- Design Name: 
-- Module Name: testbench - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is
component FPU is
  Port (
            a1 : in std_logic_vector(3 downto 0);
            a2 : in std_logic_vector(3 downto 0);
           operation : in std_logic ;
           Nout : out STD_LOGIC_VECTOR (31 downto 0)
   );
end component;
signal a1 : std_logic_vector(3 downto 0);
signal a2 : std_logic_vector(3 downto 0);
signal operation : std_logic;
signal Nout : STD_LOGIC_VECTOR (31 downto 0);

begin
UUT :FPU port map(a1,a2,operation,Nout);
TEST : process
begin
    a1<="0000"; --0
    a2<="0001"; --1
    operation<='1';
    wait for 10ns;
    
    a1<="0010"; --2
    a2<="0011"; --3
    operation<='1';
    wait for 10ns;
    
    operation<='0';
    wait for 10ns;
    
    a1<="0100"; --4
    a2<="0101"; --5
    operation<='1';
    wait for 10ns;
    
    a1<="0110"; --6
    a2<="0111"; --7
    operation<='1';
    wait for 10ns;
    
    operation<='0';
    wait for 10ns;
    
    a1<="1000"; --8
    a2<="1001"; --9
    operation<='1';
    wait for 10ns;
    
    operation<='0'; 
    wait for 10ns;
    
    a1<="1010";--10
    a2<="1011"; --11
    operation<='1';
    wait for 10ns;
    
    a1<="1100";--12
    a2<="1101"; --13
    operation<='0';
    wait for 10ns;
    
    a1<="1110";--14
    a2<="1111";--15
    operation<='1';
    wait for 10ns;
       
    
end process; 

end Behavioral;
