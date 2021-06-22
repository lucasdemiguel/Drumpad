----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2021 18:42:00
-- Design Name: 
-- Module Name: Mult_tb - Behavioral
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

entity Mult_tb is
end Mult_tb;

architecture Behavioral of Mult_tb is
    component Mult
        port (data_in  : in std_logic_vector (63 downto 0);
              volumen  : in std_logic_vector (7 downto 0);
              data_out : out std_logic_vector (70 downto 0));
    end component;

    signal data_in  : std_logic_vector (63 downto 0);
    signal volumen  : std_logic_vector (7 downto 0);
    signal data_out : std_logic_vector (70 downto 0);

begin

    dut : Mult
    port map (data_in  => data_in,
              volumen  => volumen,
              data_out => data_out);

    stimuli : process
    begin
        data_in <= (others => '0');
        volumen <= (others => '0');

        wait for 1 us;
        data_in <= (others => '1');
        volumen <= (others => '1');
        wait for 1 us;
        data_in <= x"000000000000FE34";
        volumen <= x"34";

        wait;
    end process;
end Behavioral;
