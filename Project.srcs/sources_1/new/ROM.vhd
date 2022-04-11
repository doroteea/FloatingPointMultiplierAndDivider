----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2022 02:13:41 PM
-- Design Name: 
-- Module Name: ROM - Behavioral
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
    Port ( N : out STD_LOGIC_VECTOR (31 downto 0);
           addr : in STD_LOGIC_VECTOR (3 downto 0));
end ROM;

architecture Behavioral of ROM is
type rom_type is array(0 to 15) of STD_LOGIC_VECTOR (31 downto 0);
signal mem : rom_type := ( 
    b"0_10000101_11111100001000000000000", -- 127.03125 (0). 
    b"1_01110010_01100100100001000000111", -- 16.9375 (1). 
    b"1_10000011_11001110000000000000000", -- -28.875 (2).
    b"1_10000000_11000000000000000000000",  -- -3.5 (3).
    b"0_10000101_11110100100000000000000", -- 125.125 (4)
    b"0_10000010_10000010000000000000000", -- 12.0625 (5)
    b"0_10000010_00011000000000000000000", -- 8.75 (6).
    b"1_10000000_11000000000000000000000", -- -3.5 (7).
    b"0_00000000_00000000000000000000000", -- 0 (8).
    b"0_10000000_11000000000000000000000", --3.5 (9).
    b"0_11111111_00000000000000000000000", -- Infinity (10).
    b"0_10000000_01000000000000000000000", --2.5 (11).
    b"0_00000000_00000000000000000000000",--0 (12).
    b"0_00000000_00000000000000000000000",--0 (13).
    b"0_11111000_01000000000000000000000", -- 7c200000 (14).
    b"0_11111100_11000000000000000000000" -- 7e600000 (15).
 );
begin
    process(addr)
    begin
        N <= mem(conv_integer(addr));
    end process;

end Behavioral;
