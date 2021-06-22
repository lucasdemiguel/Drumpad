----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2021 11:14:30
-- Design Name: 
-- Module Name: En_Contr_tb - Behavioral
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

entity En_Contr_tb is
end En_Contr_tb;

architecture Behavioral of En_Contr_tb is

    component En_Contr
        port (clk    : in std_logic;
              reset  : in std_logic;
              en1    : out std_logic;
              en2    : out std_logic;
              en3    : out std_logic;
              en4    : out std_logic);
    end component;

    signal clk    : std_logic := '0';
    signal reset  : std_logic;
    signal en1    : std_logic;
    signal en2    : std_logic;
    signal en3    : std_logic;
    signal en4    : std_logic;

    constant TbPeriod : time := 10 ns; --100MHz

begin

    dut : En_Contr
    port map (clk    => clk,
              reset  => reset,
              en1    => en1,
              en2    => en2,
              en3    => en3,
              en4    => en4);

    -- Clock generation
    clk <= not clk after TbPeriod/2;

    stimuli : process
    begin
        -- Reset generation
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- Stimuli
        wait for 100 * TbPeriod;

        wait;
    end process;
end Behavioral;
