----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.06.2021 17:52:11
-- Design Name: 
-- Module Name: peak_fsm - Behavioral
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

entity peak_fsm is
  Port ( clk         : in STD_LOGIC;
         rst         : in STD_LOGIC;
         volumen_in  : in STD_LOGIC_VECTOR(15 downto 0);
         new_pulse   : out STD_LOGIC;
         volumen_out : out STD_LOGIC_VECTOR(15 downto 0));
end peak_fsm;

architecture Behavioral of peak_fsm is

    signal vol_reg, vol_next : std_logic_vector(15 downto 0);
    signal new_pulse_reg, new_pulse_next : std_logic;
    type state is (idle, subida, bajada);
    signal state_reg, state_next : state;
    constant umbral : std_logic_vector := x"0005";    

begin

    SYNC_PROC : process (clk, rst)
    begin
        if (rst = '1') then
            state_reg <= idle;
            vol_reg <= (others => '0');
            new_pulse_reg <= '0';
        elsif (clk'event and clk = '1') then
            state_reg <= state_next;
            vol_reg <= vol_next;
            new_pulse_reg <= new_pulse_next;
        end if;
    end process;

    NEXT_STATE_LOGIC : process (state_reg, volumen_in, vol_reg)
    begin
        vol_next <= volumen_in;
        new_pulse_next <= '0';
        
        case state_reg is
            when idle =>                
                
            when subida =>
                if(volumen_in < vol_reg) then
--                    volumen_out <= vol_reg;
                    vol_next <= vol_reg;
                    new_pulse_next <= '1';
                end if;
            
            when bajada =>
                
        end case;
    end process; 
    
    NEXT_STATE_DECODE : process (state_reg, volumen_in, vol_reg)
    begin
        state_next <= state_reg;
        
        case state_reg is
            when idle =>
                if(volumen_in > vol_reg AND volumen_in > umbral) then
                    state_next <= subida;
                else
                    state_next <= idle;
                end if;
                
            when subida =>
                if(volumen_in < vol_reg) then
                    state_next <= bajada;
                else
                    state_next <= subida;
                end if;
                
            when bajada =>
                if(volumen_in < vol_reg AND volumen_in > umbral) then
                    state_next <= bajada;
                elsif(volumen_in > vol_reg AND volumen_in > umbral) then
                    state_next <= subida;
                elsif(volumen_in < umbral) then
                    state_next <=idle;
                end if;
            
        end case;
    end process;  
    
    volumen_out <= vol_reg when(new_pulse_next = '1') else (others => '0');
--    volumen_out <= vol_reg;
    new_pulse <= new_pulse_next;

end Behavioral;
