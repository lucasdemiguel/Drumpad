----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 18:14:49
-- Design Name: 
-- Module Name: Mem_Acess_fsm - Behavioral
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

entity Mem_Acess_fsm is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           en : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR(63 downto 0);
           data_valid : in STD_LOGIC;
           uso : in STD_LOGIC;
           dir_inicial : in STD_LOGIC_VECTOR(26 downto 0);
           dir_final : in STD_LOGIC_VECTOR(26 downto 0);
           pad_in : in STD_LOGIC_VECTOR(2 downto 0);
           pad_out : out STD_LOGIC_VECTOR(2 downto 0);
           dir_act_out : out STD_LOGIC_VECTOR(26 downto 0);
           read_req : out STD_LOGIC;
           dir_req : out STD_LOGIC_VECTOR(26 downto 0);
           uso_rst : out STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR(63 downto 0));
end Mem_Acess_fsm;

architecture Behavioral of Mem_Acess_fsm is

    type state is (idle, wait_en, wait_data, data_req, data);
    signal state_reg, state_next : state;
    signal dir_act_reg, dir_act_next : STD_LOGIC_VECTOR(26 downto 0);
    signal data_reg, data_next : STD_LOGIC_VECTOR(63 downto 0);

begin

    SYNC_PROC : process (clk, reset)
    begin
        if (reset = '1') then
            state_reg <= idle;
            dir_act_reg <= (others => '0');
            data_reg <= (others => '0');
        elsif (clk'event and clk = '1') then
            state_reg <= state_next;
            dir_act_reg <= dir_act_next;
            data_reg <= data_next;
        end if;
    end process;
    
    NEXT_STATE_LOGIC : process(state_reg, dir_act_reg, dir_inicial, dir_final, data_in, pad_in, data_reg)
    begin
        dir_act_next <= dir_act_reg;
        read_req <= '0';
        dir_req <= (others => '0');
        uso_rst <= '0';
        pad_out <= pad_in;
        data_next <= data_reg;
        
        case state_reg is
            
            when idle => 
                dir_act_next <= dir_inicial;
                pad_out <= pad_in;
                          
            when wait_en =>
                
            when data_req =>
                dir_req <= dir_act_reg;
                read_req <= '1';
            
            when wait_data => --espera a la señal de valid
            
            when data =>    
                data_next <= data_in;
                if(dir_act_reg = dir_final) then
                    uso_rst <= '1';
                    dir_act_next <= dir_inicial;
                else
                    dir_act_next <= STD_LOGIC_VECTOR(unsigned(dir_act_reg) + 1);
                end if;
                
        end case;
    end process;
    
    NEXT_STATE_DECODE : process(state_reg, uso, en, data_valid, dir_act_reg, dir_final)
    begin
        
        state_next <= idle;
        
        case state_reg is

            when idle => 
                if(uso = '1') then
                    state_next <= wait_en;
                else
                    state_next <= idle;
                end if;
                                
            when wait_en => 
                if(en = '1') then
                    state_next <= data_req;
                else
                    state_next <= wait_en;
                end if;  
                
            when data_req =>
                state_next <= wait_data;
            
            when wait_data =>
                if(data_valid = '0') then
                    state_next <= wait_data;
                else
                    state_next <= data;
                end if;
            
            when data => 
                if(dir_act_reg = dir_final) then
                    state_next <= idle;
                else
                    state_next <= wait_en;
                end if;
            
        end case;
    end process;
    
    dir_act_out <= dir_act_reg when en = '1' else (others => 'Z');
    data_out <= data_reg;

end Behavioral;
