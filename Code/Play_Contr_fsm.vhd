----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 18:14:49
-- Design Name: 
-- Module Name: Play_Contr_fsm - Behavioral
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

entity Play_Contr_fsm is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           pad : in STD_LOGIC_VECTOR(2 downto 0);
           volumen : in STD_LOGIC_VECTOR(15 downto 0);
           new_pulse : in STD_LOGIC;
           act_orden : out STD_LOGIC;
           --USO
           MA1_uso : in STD_LOGIC;
           MA2_uso : in STD_LOGIC;
           MA3_uso : in STD_LOGIC;
           MA4_uso : in STD_LOGIC;
           MA1_uso_out : out STD_LOGIC;
           MA2_uso_out : out STD_LOGIC;
           MA3_uso_out : out STD_LOGIC;
           MA4_uso_out : out STD_LOGIC;
           --ORDEN
           MA1_orden : in STD_LOGIC_VECTOR(2 downto 0);
           MA2_orden : in STD_LOGIC_VECTOR(2 downto 0);
           MA3_orden : in STD_LOGIC_VECTOR(2 downto 0);
           MA4_orden : in STD_LOGIC_VECTOR(2 downto 0);
           MA1_orden_out : out STD_LOGIC_VECTOR(2 downto 0);
           MA2_orden_out : out STD_LOGIC_VECTOR(2 downto 0);
           MA3_orden_out : out STD_LOGIC_VECTOR(2 downto 0);
           MA4_orden_out : out STD_LOGIC_VECTOR(2 downto 0);
           --VOL
           MA1_vol_out : out STD_LOGIC_VECTOR(15 downto 0);
           MA2_vol_out : out STD_LOGIC_VECTOR(15 downto 0);
           MA3_vol_out : out STD_LOGIC_VECTOR(15 downto 0);
           MA4_vol_out : out STD_LOGIC_VECTOR(15 downto 0);
           --PADS
           MA1_pad_out : out STD_LOGIC_VECTOR(2 downto 0);
           MA2_pad_out : out STD_LOGIC_VECTOR(2 downto 0);
           MA3_pad_out : out STD_LOGIC_VECTOR(2 downto 0);
           MA4_pad_out : out STD_LOGIC_VECTOR(2 downto 0));
end Play_Contr_fsm;

architecture Behavioral of Play_Contr_fsm is

    type state is (idle, search_older, sound1, sound2, sound3, sound4);
    signal state_reg, state_next : state;
    signal vol_reg, vol_next : STD_LOGIC_VECTOR(15 downto 0);
    signal pad_reg, pad_next : STD_LOGIC_VECTOR(2 downto 0);
    signal MA1_orden_next, MA1_orden_reg, MA2_orden_next, MA2_orden_reg : STD_LOGIC_VECTOR(2 downto 0); 
    signal MA3_orden_next, MA3_orden_reg, MA4_orden_next, MA4_orden_reg : STD_LOGIC_VECTOR(2 downto 0);
    signal flag_reg, flag_next : STD_LOGIC;

begin

    SYNC_PROC : process (clk, reset)
    begin
        if (reset = '1') then
            state_reg <= idle;
            vol_reg <= (others => '0');
            pad_reg <= (others => '0');
            MA1_orden_reg <= (others => '0');
            MA2_orden_reg <= (others => '0');
            MA3_orden_reg <= (others => '0');
            MA4_orden_reg <= (others => '0');
            flag_reg <= '0';          
        elsif (clk'event and clk = '1') then
            state_reg <= state_next;
            vol_reg <= vol_next; 
            pad_reg <= pad_next;
            MA1_orden_reg <= MA1_orden_next;
            MA2_orden_reg <= MA2_orden_next;
            MA3_orden_reg <= MA3_orden_next;
            MA4_orden_reg <= MA4_orden_next;
            flag_reg <= flag_next;
        end if;
    end process;
    
    NEXT_STATE_LOGIC : process(volumen, pad, state_reg, vol_reg, pad_reg, MA1_orden_reg, MA2_orden_reg, MA3_orden_reg, MA4_orden_reg, flag_reg)
    begin 
        vol_next <= vol_reg; 
        pad_next <= pad_reg;
        MA1_orden_next <= MA1_orden_reg;
        MA2_orden_next <= MA2_orden_reg;
        MA3_orden_next <= MA3_orden_reg;
        MA4_orden_next <= MA4_orden_reg;
        MA1_uso_out <= '0';
        MA2_uso_out <= '0';
        MA3_uso_out <= '0';
        MA4_uso_out <= '0';
        act_orden <= '0';
                                  
        case state_reg is
            
            when idle => 
                vol_next <= volumen;
                pad_next <= pad;
                MA1_orden_next <= MA1_orden;
                MA2_orden_next <= MA2_orden;
                MA3_orden_next <= MA3_orden;
                MA4_orden_next <= MA4_orden;
                
                if (new_pulse = '1') then
                    if (flag_reg = '1') then
                        MA1_orden_next <= MA1_orden_reg;
                        MA2_orden_next <= MA2_orden_reg;
                        MA3_orden_next <= MA3_orden_reg;
                        MA4_orden_next <= MA4_orden_reg;
                        if (MA1_uso = '0')then
                            flag_next <= '0';
                            if (MA1_orden_reg = "001") then
                                MA2_orden_next <= STD_LOGIC_VECTOR(unsigned(MA2_orden_reg) - 1);
                                MA3_orden_next <= STD_LOGIC_VECTOR(unsigned(MA3_orden_reg) - 1);
                                MA4_orden_next <= STD_LOGIC_VECTOR(unsigned(MA4_orden_reg) - 1);
                            elsif (MA1_orden_reg = "010") then
                                if (MA2_orden_reg = "011" OR MA2_orden_reg = "100") then
                                    MA2_orden_next <= STD_LOGIC_VECTOR(unsigned(MA2_orden_reg) - 1);
                                elsif (MA3_orden_reg = "011" OR MA3_orden_reg = "100") then
                                    MA3_orden_next <= STD_LOGIC_VECTOR(unsigned(MA3_orden_reg) - 1);
                                elsif (MA4_orden_reg = "011" OR MA4_orden_reg = "100") then
                                    MA4_orden_next <= STD_LOGIC_VECTOR(unsigned(MA4_orden_reg) - 1);
                                end if;
                            elsif (MA1_orden_reg = "011") then
                                if (MA2_orden_reg = "100") then
                                    MA2_orden_next <= STD_LOGIC_VECTOR(unsigned(MA2_orden_reg) - 1);
                                elsif (MA3_orden_reg = "100") then
                                    MA3_orden_next <= STD_LOGIC_VECTOR(unsigned(MA3_orden_reg) - 1);
                                elsif (MA4_orden_reg = "100") then
                                    MA4_orden_next <= STD_LOGIC_VECTOR(unsigned(MA4_orden_reg) - 1);
                                end if;
                            end if;
                        elsif (MA2_uso = '0')then
                            flag_next <= '0';
                            if (MA2_orden_reg = "001") then
                                MA1_orden_next <= STD_LOGIC_VECTOR(unsigned(MA1_orden_reg) - 1);
                                MA3_orden_next <= STD_LOGIC_VECTOR(unsigned(MA3_orden_reg) - 1);
                                MA4_orden_next <= STD_LOGIC_VECTOR(unsigned(MA4_orden_reg) - 1);
                            elsif (MA2_orden_reg = "010") then
                                if (MA1_orden_reg = "011" OR MA1_orden_reg = "100") then
                                    MA1_orden_next <= STD_LOGIC_VECTOR(unsigned(MA1_orden_reg) - 1);
                                elsif (MA3_orden_reg = "011" OR MA3_orden_reg = "100") then
                                    MA3_orden_next <= STD_LOGIC_VECTOR(unsigned(MA3_orden_reg) - 1);
                                elsif (MA4_orden_reg = "011" OR MA4_orden_reg = "100") then
                                    MA4_orden_next <= STD_LOGIC_VECTOR(unsigned(MA4_orden_reg) - 1);
                                end if;
                            elsif (MA2_orden_reg = "011") then
                                if (MA1_orden_reg = "100") then
                                    MA1_orden_next <= STD_LOGIC_VECTOR(unsigned(MA1_orden_reg) - 1);
                                elsif (MA3_orden_reg = "100") then
                                    MA3_orden_next <= STD_LOGIC_VECTOR(unsigned(MA3_orden_reg) - 1);
                                elsif (MA4_orden_reg = "100") then
                                    MA4_orden_next <= STD_LOGIC_VECTOR(unsigned(MA4_orden_reg) - 1);
                                end if;
                            end if;
                        elsif (MA3_uso = '0')then
                            flag_next <= '0';
                            if (MA3_orden_reg = "001") then
                                MA2_orden_next <= STD_LOGIC_VECTOR(unsigned(MA2_orden_reg) - 1);
                                MA1_orden_next <= STD_LOGIC_VECTOR(unsigned(MA1_orden_reg) - 1);
                                MA4_orden_next <= STD_LOGIC_VECTOR(unsigned(MA4_orden_reg) - 1);
                            elsif (MA3_orden_reg = "010") then
                                if (MA2_orden_reg = "011" OR MA2_orden_reg = "100") then
                                    MA2_orden_next <= STD_LOGIC_VECTOR(unsigned(MA2_orden_reg) - 1);
                                elsif (MA1_orden_reg = "011" OR MA1_orden_reg = "100") then
                                    MA1_orden_next <= STD_LOGIC_VECTOR(unsigned(MA1_orden_reg) - 1);
                                elsif (MA4_orden_reg = "011" OR MA4_orden_reg = "100") then
                                    MA4_orden_next <= STD_LOGIC_VECTOR(unsigned(MA4_orden_reg) - 1);
                                end if;
                            elsif (MA3_orden_reg = "011") then
                                if (MA2_orden_reg = "100") then
                                    MA2_orden_next <= STD_LOGIC_VECTOR(unsigned(MA2_orden_reg) - 1);
                                elsif (MA1_orden_reg = "100") then
                                    MA1_orden_next <= STD_LOGIC_VECTOR(unsigned(MA1_orden_reg) - 1);
                                elsif (MA4_orden_reg = "100") then
                                    MA4_orden_next <= STD_LOGIC_VECTOR(unsigned(MA4_orden_reg) - 1);
                                end if;
                            end if;
                        elsif (MA4_uso = '0')then
                            flag_next <= '0';
                            if (MA4_orden_reg = "001") then
                                MA2_orden_next <= STD_LOGIC_VECTOR(unsigned(MA2_orden_reg) - 1);
                                MA3_orden_next <= STD_LOGIC_VECTOR(unsigned(MA3_orden_reg) - 1);
                                MA1_orden_next <= STD_LOGIC_VECTOR(unsigned(MA1_orden_reg) - 1);
                            elsif (MA4_orden_reg = "010") then
                                if (MA2_orden_reg = "011" OR MA2_orden_reg = "100") then
                                    MA2_orden_next <= STD_LOGIC_VECTOR(unsigned(MA2_orden_reg) - 1);
                                elsif (MA3_orden_reg = "011" OR MA3_orden_reg = "100") then
                                    MA3_orden_next <= STD_LOGIC_VECTOR(unsigned(MA3_orden_reg) - 1);
                                elsif (MA1_orden_reg = "011" OR MA1_orden_reg = "100") then
                                    MA1_orden_next <= STD_LOGIC_VECTOR(unsigned(MA1_orden_reg) - 1);
                                end if;
                            elsif (MA4_orden_reg = "011") then
                                if (MA2_orden_reg = "100") then
                                    MA2_orden_next <= STD_LOGIC_VECTOR(unsigned(MA2_orden_reg) - 1);
                                elsif (MA3_orden_reg = "100") then
                                    MA3_orden_next <= STD_LOGIC_VECTOR(unsigned(MA3_orden_reg) - 1);
                                elsif (MA1_orden_reg = "100") then
                                    MA1_orden_next <= STD_LOGIC_VECTOR(unsigned(MA1_orden_reg) - 1);
                                end if;
                            end if;
                        end if;
                    else
                        MA1_orden_next <= MA1_orden;
                        MA2_orden_next <= MA2_orden;
                        MA3_orden_next <= MA3_orden;
                        MA4_orden_next <= MA4_orden;
                    end if;
                end if;

                 
            when search_older => 
                flag_next <= '1';
                
            when sound1 =>
                MA1_uso_out <= '1';
                act_orden <= '1';
                MA1_orden_next <= "001";
                if (MA2_orden_reg /= "000") then
                    MA2_orden_next <= STD_LOGIC_VECTOR(unsigned(MA2_orden_reg) + 1);
                end if;
                if (MA3_orden_reg /= "000") then
                    MA3_orden_next <= STD_LOGIC_VECTOR(unsigned(MA3_orden_reg) + 1);
                end if;
                if (MA4_orden_reg /= "000") then
                    MA4_orden_next <= STD_LOGIC_VECTOR(unsigned(MA4_orden_reg) + 1);
                end if;
                MA1_vol_out <= vol_reg;
                MA1_pad_out <= pad_reg;
            
            when sound2 =>
                MA2_uso_out <= '1';
                act_orden <= '1';
                if (MA1_orden_reg /= "000") then
                    MA1_orden_next <= STD_LOGIC_VECTOR(unsigned(MA1_orden_reg) + 1);
                end if;
                MA2_orden_next <= "001";
                if (MA3_orden_reg /= "000") then
                    MA3_orden_next <= STD_LOGIC_VECTOR(unsigned(MA3_orden_reg) + 1);
                end if;
                if (MA4_orden_reg /= "000") then
                    MA4_orden_next <= STD_LOGIC_VECTOR(unsigned(MA4_orden_reg) + 1);
                end if;
                MA2_vol_out <= vol_reg;
                MA2_pad_out <= pad_reg;
            
            when sound3 =>
                MA3_uso_out <= '1';
                act_orden <= '1';
                if (MA1_orden_reg /= "000") then
                    MA1_orden_next <= STD_LOGIC_VECTOR(unsigned(MA1_orden_reg) + 1);
                end if;
                if (MA2_orden_reg /= "000") then
                    MA2_orden_next <= STD_LOGIC_VECTOR(unsigned(MA2_orden_reg) + 1);
                end if;
                MA3_orden_next <= "001";
                if (MA4_orden_reg /= "000") then
                    MA4_orden_next <= STD_LOGIC_VECTOR(unsigned(MA4_orden_reg) + 1);
                end if;
                MA3_vol_out <= vol_reg;
                MA3_pad_out <= pad_reg;
            
            when sound4 =>
                MA4_uso_out <= '1';
                act_orden <= '1';
                if (MA1_orden_reg /= "000") then
                    MA1_orden_next <= STD_LOGIC_VECTOR(unsigned(MA1_orden_reg) + 1);
                end if;
                if (MA2_orden_reg /= "000") then
                    MA2_orden_next <= STD_LOGIC_VECTOR(unsigned(MA2_orden_reg) + 1);
                end if;
                if (MA3_orden_reg /= "000") then
                    MA3_orden_next <= STD_LOGIC_VECTOR(unsigned(MA3_orden_reg) + 1);
                end if;
                MA4_orden_next <= "001";
                MA4_vol_out <= vol_reg;
                MA4_pad_out <= pad_reg;                      
                
        end case;
    end process;
    
    NEXT_STATE_DECODE : process(state_reg, MA1_uso, MA2_uso, MA3_uso, MA4_uso, MA1_orden_reg, MA2_orden_reg, MA3_orden_reg, MA4_orden_reg, new_pulse)
    begin
        
        state_next <= idle;
        
        case state_reg is

            when idle => 
                if (new_pulse = '1') then
                    if (MA1_uso = '1')then
                        if (MA2_uso = '1')then
                            if (MA3_uso = '1')then
                                if (MA4_uso = '1')then
                                    state_next <= search_older;
                                else
                                    state_next <= sound4;
                                end if;
                            else
                                state_next <= sound3;
                            end if;
                        else
                            state_next <= sound2;
                        end if;
                    else
                        state_next <= sound1;
                    end if;
                else
                    state_next <= idle;
                end if;
                                
            when search_older => 
                if (MA1_orden_reg = "100")then
                        state_next <= sound1;
                    else
                        if (MA2_orden_reg = "100")then
                            state_next <= sound2;
                        else
                            if (MA3_orden_reg = "100")then
                                state_next <= sound3;
                            else
                                if (MA4_orden_reg = "100")then
                                    state_next <= sound4;
                                else
                                    state_next <= idle;
                                end if;
                            end if;
                        end if;
                    end if;  
                
            when sound1 =>
                state_next <= idle;
            
            when sound2 =>
                state_next <= idle;
            
            when sound3 => 
                state_next <= idle;
            
            when sound4 =>
                state_next <= idle;
            
        end case;
    end process;
    
    MA1_orden_out <= MA1_orden_next;
    MA2_orden_out <= MA2_orden_next;
    MA3_orden_out <= MA3_orden_next;
    MA4_orden_out <= MA4_orden_next;

end Behavioral;
