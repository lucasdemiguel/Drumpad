----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 18:56:44
-- Design Name: 
-- Module Name: Pad_Data - Behavioral
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

entity Pad_Data is 
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           act_orden : in STD_LOGIC;
           orden_in : in STD_LOGIC_VECTOR(2 downto 0);
           orden_out : out STD_LOGIC_VECTOR(2 downto 0);
           volumen_in : in STD_LOGIC_VECTOR(15 downto 0);
           volumen_out : out STD_LOGIC_VECTOR(15 downto 0);
           uso_in : in STD_LOGIC;
           uso_out : out STD_LOGIC;
           dir_inicial : out STD_LOGIC_VECTOR(26 downto 0);
           dir_final : out STD_LOGIC_VECTOR(26 downto 0);
           dir_act_in : in STD_LOGIC_VECTOR(26 downto 0);
           pad : in STD_LOGIC_VECTOR(2 downto 0);
           uso_rst : in STD_LOGIC);
end Pad_Data;

architecture Behavioral of Pad_Data is

--    signal data_array_reg : STD_LOGIC_VECTOR(92 downto 0);
--    alias orden_reg : STD_LOGIC_VECTOR(2 downto 0) is data_array_reg(92 downto 90);
--    alias volumen_reg : STD_LOGIC_VECTOR(7 downto 0) is data_array_reg(89 downto 82);
--    alias uso_reg : STD_LOGIC is data_array_reg(81);
--    alias dir_ini_reg : STD_LOGIC_VECTOR(26 downto 0) is data_array_reg(80 downto 54);
--    alias dir_fin_reg : STD_LOGIC_VECTOR(26 downto 0) is data_array_reg(53 downto 27);
--    alias dir_act_reg : STD_LOGIC_VECTOR(26 downto 0) is data_array_reg(26 downto 0);
    
--    signal data_array_next : STD_LOGIC_VECTOR(92 downto 0);                            
--    alias orden_next : STD_LOGIC_VECTOR(2 downto  0) is data_array_reg(92 downto 90);   
--    alias volumen_next : STD_LOGIC_VECTOR(7 downto 0) is data_array_reg(89 downto 82); 
--    alias uso_next : STD_LOGIC is data_array_next(81);                                  
--    alias dir_ini_next : STD_LOGIC_VECTOR(26 downto 0) is data_array_reg(80 downto 54);
--    alias dir_fin_next : STD_LOGIC_VECTOR(26 downto 0) is data_array_reg(53 downto 27);
--    alias dir_act_next : STD_LOGIC_VECTOR(26 downto 0) is data_array_reg(26 downto 0); 
    
    signal orden_reg : STD_LOGIC_VECTOR(2 downto 0);
    signal volumen_reg : STD_LOGIC_VECTOR(15 downto 0); 
    signal uso_reg : STD_LOGIC; 
    signal dir_ini_reg : STD_LOGIC_VECTOR(26 downto 0);
    signal dir_fin_reg : STD_LOGIC_VECTOR(26 downto 0);
    signal dir_act_reg : STD_LOGIC_VECTOR(26 downto 0);
    signal orden_next : STD_LOGIC_VECTOR(2 downto  0);
    signal volumen_next : STD_LOGIC_VECTOR(15 downto 0); 
    signal uso_next : STD_LOGIC;
    signal dir_ini_next : STD_LOGIC_VECTOR(26 downto 0);
    signal dir_fin_next : STD_LOGIC_VECTOR(26 downto 0);
    signal dir_act_next : STD_LOGIC_VECTOR(26 downto 0);

    constant dir_ini_1 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000000000100";
    constant dir_ini_2 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000000001000";
    constant dir_ini_3 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000000010000";
    constant dir_ini_4 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000000100000";
    constant dir_ini_5 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000001000000";
    constant dir_ini_6 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000010000000";
    constant dir_ini_7 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000100000000";
    constant dir_ini_8 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000001000000000";

    constant dir_fin_1 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000000000110";
    constant dir_fin_2 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000000001010";
    constant dir_fin_3 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000000010010";
    constant dir_fin_4 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000000100010";
    constant dir_fin_5 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000001000010";
    constant dir_fin_6 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000010000010";
    constant dir_fin_7 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000100000010";
    constant dir_fin_8 : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000001000000010";

begin

    NEXT_STATE_DECODE : process(pad, act_orden, uso_rst, orden_in, volumen_in, dir_act_in, uso_in, orden_reg, volumen_reg, dir_act_reg, uso_reg, dir_ini_reg, dir_fin_reg)
    begin  
        
        dir_ini_next <= dir_ini_reg;
        dir_fin_next <= dir_fin_reg;
        
        if (act_orden = '1') then
            orden_next <= orden_in;
        else
            orden_next <= orden_reg;
        end if;
        
        if (uso_in = '1') then         
            --orden_next <= orden_in;   
            --orden_next <= STD_LOGIC_VECTOR(unsigned(orden_in) + 1); 
            volumen_next <= volumen_in;
            dir_act_next <= dir_act_in;
            uso_next <= '1'; 
            
            if(pad = "000") then
                dir_ini_next <= dir_ini_1;
                dir_fin_next <= dir_fin_1;
            elsif(pad = "001") then
                dir_ini_next <= dir_ini_2;
                dir_fin_next <= dir_fin_2;
            elsif(pad = "010") then
                dir_ini_next <= dir_ini_3;
                dir_fin_next <= dir_fin_3;
            elsif(pad = "011") then
                dir_ini_next <= dir_ini_4;
                dir_fin_next <= dir_fin_4;
            elsif(pad = "100") then
                dir_ini_next <= dir_ini_5;
                dir_fin_next <= dir_fin_5;
            elsif(pad = "101") then
                dir_ini_next <= dir_ini_6;
                dir_fin_next <= dir_fin_6;
            elsif(pad = "110") then
                dir_ini_next <= dir_ini_7;
                dir_fin_next <= dir_fin_7;
            elsif(pad = "111") then
                dir_ini_next <= dir_ini_8;
                dir_fin_next <= dir_fin_8;
            else 
                dir_ini_next <= (others => '0');
                dir_fin_next <= (others => '0');
            end if;
            
        else
            --orden_next <= orden_reg;
            volumen_next <= volumen_reg;
            dir_act_next <= dir_act_reg;
            
            if(uso_rst = '1') then 
                uso_next <= '0';
            else
                uso_next <= uso_reg;
            end if;
        end if;
    end process;
    
    SYNC_PROC : process(clk, reset)
    begin
        if(reset = '1') then
            orden_reg <= (others => '0');
            volumen_reg <= (others => '0');
            uso_reg <= '0';
            dir_ini_reg <= (others => '0');
            dir_fin_reg <= (others => '0'); 
            dir_act_reg <= (others => '0');       
        elsif(clk'event and clk= '1') then
            orden_reg <= orden_next;
            volumen_reg <= volumen_next;
            uso_reg <= uso_next;
            dir_ini_reg <= dir_ini_next;
            dir_fin_reg <= dir_fin_next;
            dir_act_reg <= dir_act_next;
        end if;
    end process;
    
    --output logic
    orden_out <= orden_reg;    
    volumen_out <= volumen_reg;
    dir_inicial <= dir_ini_reg;
    dir_final <= dir_fin_reg;
    uso_out <= uso_reg;

end Behavioral;
