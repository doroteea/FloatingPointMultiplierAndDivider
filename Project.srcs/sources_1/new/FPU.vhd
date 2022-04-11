----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2021 09:16:30 PM
-- Design Name: 
-- Module Name: FPU - Behavioral
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

entity FPU is
  Port (
            a1 : in std_logic_vector(3 downto 0);
            a2 : in std_logic_vector(3 downto 0);
           operation : in std_logic ;
           Nout : out STD_LOGIC_VECTOR (31 downto 0)
   );
end FPU;

architecture Behavioral of FPU is
signal tempOutMul : std_logic_vector(31 downto 0) := (others => '0');
signal tempOutDiv : std_logic_vector(31 downto 0) := (others => '0');
signal tempOut1 : std_logic_vector(31 downto 0) := (others => '0');
signal tempOut2 : std_logic_vector(31 downto 0) := (others => '0');
signal checkSpecialCase : std_logic := '0';
signal exponent1 : std_logic_vector(7 downto 0);
signal exponent2 : std_logic_vector(7 downto 0);
signal mantissa1 : std_logic_vector(22 downto 0); 
signal mantissa2 : std_logic_vector(22 downto 0);
signal specialCaseFlag : std_logic_vector(3 downto 0):="0000";
signal exponentOutMul : std_logic_vector(8 downto 0);
signal exponentOutDiv : std_logic_vector(8 downto 0);
signal claOutMul : std_logic_vector(8 downto 0);
signal claOutDiv : std_logic_vector(8 downto 0);
signal cin,cin1,cin2,cin3 : std_logic :='0';
signal cout,cout1,cout2,cout3 : std_logic;
signal Minus127 : std_logic_vector(7 downto 0):="10000001"; --in 2's complement
signal Plus127 : std_logic_vector(7 downto 0):="01111111";
signal multOut : std_logic_vector(47 downto 0);
signal divOut : std_logic_vector(25 downto 0);
signal NoutMul :  STD_LOGIC_VECTOR (31 downto 0);
signal NoutDiv :  STD_LOGIC_VECTOR (31 downto 0);
signal N1 : STD_LOGIC_VECTOR (31 downto 0);
signal N2 : STD_LOGIC_VECTOR (31 downto 0);
 

component adderCla
    Port ( e1 : in STD_LOGIC_VECTOR (8 downto 0);
           e2 : in STD_LOGIC_VECTOR (8 downto 0);
           carry_in : in STD_LOGIC;
           e_out : out STD_LOGIC_VECTOR (8 downto 0);
           carry_out : out STD_LOGIC);
end component;

component MULT is
  Port (
  A : in std_logic_vector(23 downto 0);
  B : in std_logic_vector(23 downto 0);
  result : out std_logic_vector(47 downto 0)
   );
end component;

component DIV is
  Port (  
  A : in std_logic_vector(23 downto 0);
  B : in std_logic_vector(23 downto 0);
  result : out std_logic_vector(25 downto 0)
  );
end component;

component standardizeMul is
  Port (
            signBit : in std_logic;
            exponentBits : in std_logic_vector(8 downto 0);
            mantissaBits : in std_logic_vector(47 downto 0);
            Result : out std_logic_vector(31 downto 0)
   );
end component;


component standardizeDiv is
  Port (
            signBit : in std_logic;
            exponentBits : in std_logic_vector(8 downto 0);
            mantissaBits : in std_logic_vector(25 downto 0);
            Result : out std_logic_vector(31 downto 0)
   );
end component;

component ROM is
    Port ( N : out STD_LOGIC_VECTOR (31 downto 0);
           addr : in STD_LOGIC_VECTOR (3 downto 0));
end component;

begin

ROMINput1 : ROM port map (N1,a1);
ROMINput2 : ROM port map (N2,a2);  

exponent1 <=N1(30 downto 23); 
exponent2 <= N2(30 downto 23);
mantissa1<=N1(22 downto 0);
mantissa2<=N2(22 downto 0);


claMul : adderCLA port map ('0' & exponent1,'0' & exponent2, cin ,claOutMul,cout);
claBiasMul : adderCLA port map (claOutMul,'1'&Minus127, cin1 ,exponentOutMul,cout1);
claDiv : adderCLA port map ('0' & exponent1,(('1' &not(exponent2))+1), cin2 ,claOutDiv,cout2);
claBiasDiv : adderCLA port map (claOutDiv,'0'&Plus127, cin3 ,exponentOutDiv,cout3);
mulM : mult port map ('1'& mantissa1,'1' & mantissa2,multOut);
divD : div port map('1'& mantissa1,'1' & mantissa2,divOut);
standMultResult : standardizeMul port map (N1(31) xor N2(31),exponentOutMul,multOut,NoutMul);
standDivResult : standardizeDiv port map (N1(31) xor N2(31),exponentOutDiv,divOut,NoutDiv);

checkForSpecialCasesMultiplication : process(operation,N1,N2,exponent1,exponent2,mantissa1,mantissa2,exponentOutMul,exponentOutDiv)
begin
tempOut1(31)<=N1(31) xor N2(31);
tempOut2(31)<=N1(31) xor N2(31);
--------special cases--------------------
if (operation = '1') then--mul   
        if (operation = '1' and ((exponent1 = X"FF" and  mantissa1 =X"0") or (exponent2 = X"FF" and  mantissa2 =X"0")))then --N1=infinity or N2=infinity
            tempOut1(30 downto 23) <= "11111111";
            tempOut1(22 downto 0) <= (others => '0');
            specialCaseFlag <= "0001"; --Nout=infinity
        elsif (operation = '1' and ((exponent1 = X"0" and  mantissa1 =X"0") or (exponent2 = X"0" and  mantissa2 =X"0")) ) then--N1=0 or N2=0 
            tempOut1(30 downto 0)<= (others => '0');
            specialCaseFlag <="0010";--Nout=0
        elsif(operation = '1' and exponentOutMul(8)='1') then
             if (exponentOutMul(7)='0') then--overflow
                tempOut1(30 downto 23)<="11111111";
                tempOut1(22 downto 0) <= (others => '0');
                specialCaseFlag<="0011";--Nout=infinity
             else
             tempOut1(30 downto 0)<= (others => '0');--underflow
            specialCaseFlag <="0100";--Nout=0
            end if;
        end if;
    end if;
   if (operation = '0') then--div
        if ((exponent1 = X"0" and  mantissa1 =X"0") and (exponent2 = X"0" and  mantissa2 =X"0") ) then --0/0
            tempOut2(30 downto 23) <= X"FF";
            tempOut2(22 downto 2) <= (others => '0');
            tempOut2(1)<='1';
            tempOut2(0)<='1';
            specialCaseFlag <= "0110";
         elsif ((exponent2 = X"0" and  mantissa2 =X"0")) then 
            tempOut2(30 downto 0)<= (others => '0');
            specialCaseFlag <= "0101";    
         elsif(exponentOutDiv(8) = '1') then
             if (exponentOutDiv(8)='1' and exponentOutDiv(7)='0') then--overflow
                tempOut2(30 downto 23)<="11111111";
                tempOut2(22 downto 0) <= (others => '0');
                specialCaseFlag<="0111";--Nout=infinity
             else
             tempOut2(30 downto 0)<= (others => '0');--underflow
            specialCaseFlag <="1000";--Nout=0
          end if;
         end if;
       end if;
end process;
---------------------works------------------------
finalResult : process(operation,tempOut1,NoutMul,specialCaseFlag,tempOut2,NoutDiv,N1,N2)
begin
    if(operation = '1') then --multiplication
       if(specialCaseFlag = "0000") then
           Nout<=NoutMul;
       else
           Nout<=tempOut1;
       end if;
    else 
    if(specialCaseFlag = "0000") then
           Nout<=NoutDiv;
       else
           Nout<=tempOut2;
       end if;
    end if;  
end process;
end Behavioral;
