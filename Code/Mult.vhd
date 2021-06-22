----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2021 18:30:57
-- Design Name: 
-- Module Name: Mult - Behavioral
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

entity Mult is
    Port ( data_in : in STD_LOGIC_VECTOR(63 downto 0);
           volumen : in STD_LOGIC_VECTOR(15 downto 0);
           mult_out : out STD_LOGIC_VECTOR(70 downto 0));
end Mult;

architecture Behavioral of Mult is
    
    signal mult: integer;
    
begin

    mult <= to_integer(unsigned(data_in)) * to_integer(unsigned(volumen));
    mult_out <= std_logic_vector(to_unsigned(mult , mult_out'length) );

end Behavioral;
