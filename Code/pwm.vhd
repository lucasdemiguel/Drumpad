----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2021 20:19:24
-- Design Name: 
-- Module Name: pwm - Behavioral
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

entity pwm is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sample_in : in STD_LOGIC_VECTOR(72 downto 0);
           pwm_pulse : out STD_LOGIC);
end pwm;

architecture Behavioral of pwm is

    signal cont_reg, cont_next : STD_LOGIC_VECTOR (10 downto 0);
    signal pwm_reg, pwm_next : STD_LOGIC;
    signal sample_zero : STD_LOGIC_VECTOR(72 downto 0) := (others => '0');

begin

    SYNC_PROC : process(clk,reset)
    begin
        if(reset = '1') then
            cont_reg <= (others => '0');
            pwm_reg <= '0';
        elsif(clk'event and clk= '1') then
           cont_reg <= cont_next;
           pwm_reg <= pwm_next;
        end if;    
    end process;
    
    OUTPUT_DECODE : process(cont_reg, pwm_reg, sample_in)
    begin
        cont_next <= cont_reg;
        pwm_next <= '0';
        
        --logica contador        
        if (cont_reg = "100011100000") then --2272
            cont_next <= (others => '0');
        else
            cont_next <= STD_LOGIC_VECTOR(unsigned(cont_reg) + 1);
        end if;
        
        
        --logica pwm
        if ((cont_reg < ('0'&sample_in)) or (sample_in = sample_zero)) then
            pwm_next <= '1';
        end if;
        
    end process;
    
    --output logic
    pwm_pulse <= pwm_reg;

end Behavioral;
