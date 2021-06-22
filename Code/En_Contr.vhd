----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2021 20:07:34
-- Design Name: 
-- Module Name: En_Contr - Behavioral
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
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity En_Contr is
    Port ( clk : in STD_LOGIC; --100MHz, Muestras cada 44kHz --> 2272,73 ciclos
           reset : in STD_LOGIC;
           en1 : out STD_LOGIC;
           en2 : out STD_LOGIC;
           en3 : out STD_LOGIC;
           en4 : out STD_LOGIC);
end En_Contr;

architecture Behavioral of En_Contr is

    signal current_state, next_state: integer := 0;

begin

    NEXT_STATE_DECODE : process(current_state)
    begin 
        if(current_state < 80) then
            next_state <= current_state + 1;
        else
            next_state <= 0;
        end if;
    end process;
    
    SYNC_PROC : process(clk, reset)
    begin
        if(reset = '1') then
            current_state <= 0;
        elsif(clk'event and clk= '1') then
            current_state <= next_state;
        end if;
    end process;
    
    --output logic
    -- data_valid tarda 15 ciclos (a 100MHz)
    en1 <= '1' when (current_state < 20) else '0';
    en2 <= '1' when ((current_state >= 20) and (current_state < 40)) else '0';
    en3 <= '1' when ((current_state >= 40) and (current_state < 60)) else '0';
    en4 <= '1' when ((current_state >= 60) and (current_state < 80)) else '0';

end Behavioral;
