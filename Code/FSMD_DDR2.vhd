----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Lucas de Miguel
-- 
-- Create Date: 03.03.2021 19:57:01
-- Design Name: 
-- Module Name: FSMD_DDR2 - Behavioral
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

entity FSMD_DDR2 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           read_req : in STD_LOGIC;
           app_rdy : in STD_LOGIC;
           app_rd_data : in STD_LOGIC_VECTOR (63 downto 0);
           app_rd_data_valid : in STD_LOGIC;
           app_rd_data_end : in STD_LOGIC;
           addr_in : in STD_LOGIC_VECTOR (26 downto 0);
           app_addr : out STD_LOGIC_VECTOR (26 downto 0);
           app_wdf_wren : out STD_LOGIC;
           app_wdf_end : out STD_LOGIC;
           app_wdf_mask : out STD_LOGIC_VECTOR (7 downto 0);
           app_en : out STD_LOGIC;
           app_cmd : out STD_LOGIC_VECTOR (2 downto 0);
           data_out : out STD_LOGIC_VECTOR (63 downto 0));
end FSMD_DDR2;

architecture Behavioral of FSMD_DDR2 is

    type state is (idle, read_wait, read, read_cmd);
    signal state_reg, state_next : state;
    constant addr0 : STD_LOGIC_VECTOR (26 downto 0) := (others => '0');
    constant read_mask : STD_LOGIC_VECTOR (7 downto 0) := "00000000";

begin

    SYNC_PROC : process (clk, reset)
    begin
        if (reset = '1') then
            state_reg <= idle;
        elsif (clk'event and clk = '1') then
            state_reg <= state_next;
        end if;
    end process;

    NEXT_STATE_LOGIC : process(state_reg, read_req, app_rd_data_valid, app_rdy)
    begin
        
        app_en <= '1';
        app_cmd <= "000";
        app_wdf_wren <= '0';
        app_wdf_end <= '1';
        app_wdf_mask <= read_mask;
        app_addr <= addr0;
        
        case state_reg is
            
            when idle => 
                app_addr <= addr0;
                app_en <= '0';
                if(read_req = '1' and app_rdy = '1') then
                    app_cmd <= "001";
                    app_en <= '1';
                end if;
                                
            when read   =>
                app_cmd <= "001";
                app_en <= '0';
                app_wdf_mask <= read_mask;
                data_out <= app_rd_data;
                app_addr <= addr_in;     
                
            when read_cmd =>
                app_en <='1';
                app_cmd <= "001";
                app_wdf_mask <= read_mask;
                app_addr <= addr_in;
            
            when read_wait =>
                app_en <='0';
                app_cmd <= "001";   
                app_wdf_mask <= read_mask;
                app_addr <= addr_in;                        
                
        end case;
    end process;
    
    NEXT_STATE_DECODE : process (state_reg, read_req, app_rd_data_valid, app_rdy)
    begin
        
        state_next <= idle;
        
        case state_reg is
            
            when idle => 
                if(read_req = '1') then
                    state_next <= read_cmd;
                end if;
                
            when read_cmd =>
                if(app_rdy='1' and app_rd_data_valid = '1') then
                    state_next <= read;
                else
                    state_next <= read_wait;
                end if;                
            
            when read_wait =>
                if(app_rdy='1' and app_rd_data_valid = '1') then
                    state_next <= read;
                else
                    state_next <= read_wait;
                end if;   
                                
            when read => 
                state_next <= idle; 
            
        end case;
    end process; 

end Behavioral;