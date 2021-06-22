----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2021 18:30:57
-- Design Name: 
-- Module Name: Sum - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sum is
    Port ( MA1 : in STD_LOGIC_VECTOR(70 downto 0);
           MA2 : in STD_LOGIC_VECTOR(70 downto 0);
           MA3 : in STD_LOGIC_VECTOR(70 downto 0);
           MA4 : in STD_LOGIC_VECTOR(70 downto 0);
           sum_out : out STD_LOGIC_VECTOR(72 downto 0));
end Sum;

architecture Behavioral of Sum is

    signal sum: integer;

begin

    sum <= to_integer(unsigned(MA1)) + to_integer(unsigned(MA2)) + to_integer(unsigned(MA3)) + to_integer(unsigned(MA4));
    sum_out <= std_logic_vector(to_unsigned(sum , sum_out'length) );
    
end Behavioral;
