----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.06.2021 17:07:02
-- Design Name: 
-- Module Name: XADC_controller - Behavioral
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

entity XADC_controller is
  Port (clk       : in std_logic;
        rst       : in std_logic;
        vauxp2    : in std_logic;
        vauxn2    : in std_logic;
        vauxp3    : in std_logic;
        vauxn3    : in std_logic;
        vauxp10   : in std_logic;
        vauxn10   : in std_logic;
        vauxp11   : in std_logic;
        vauxn11   : in std_logic;
        vp_in     : in STD_LOGIC;
        vn_in     : in STD_LOGIC;
        new_pulse : out STD_LOGIC;
        volumen   : out STD_LOGIC_VECTOR (15 downto 0);
        LED1      : out STD_LOGIC;
        LED       : out STD_LOGIC_VECTOR(15 downto 0));
end XADC_controller;

architecture Behavioral of XADC_controller is

    component peak_fsm
        port (clk         : in std_logic;
              rst         : in std_logic;
              volumen_in  : in std_logic_vector (15 downto 0);
              new_pulse   : out std_logic;
              volumen_out : out std_logic_vector (15 downto 0));
    end component;
    
    component adc_fsm
        port (clk       : in std_logic;
              rst       : in std_logic;
              vauxp2    : in std_logic;
              vauxn2    : in std_logic;
              vauxp3    : in std_logic;
              vauxn3    : in std_logic;
              vauxp10   : in std_logic;
              vauxn10   : in std_logic;
              vauxp11   : in std_logic;
              vauxn11   : in std_logic;
              vp_in     : in STD_LOGIC;
              vn_in     : in STD_LOGIC;
              LED       : out STD_LOGIC_VECTOR(15 downto 0);
              pad       : out STD_LOGIC_VECTOR(2 downto 0);
              volumen   : out STD_LOGIC_VECTOR(15 downto 0));
    end component;
    
    signal volumen_in  : std_logic_vector (15 downto 0);
    signal pad         : STD_LOGIC_VECTOR(2 downto 0);
    signal led_reg, led_next : std_logic;

begin

    PEAK : peak_fsm
    port map (clk         => clk,
              rst         => rst,
              volumen_in  => volumen_in,
              new_pulse   => new_pulse,
              volumen_out => volumen);
    
    ADC : adc_fsm
    port map (clk     => clk,
              rst     => rst,        
              vauxp2  => vauxp2,
              vauxn2  => vauxn2,
              vauxp3  => vauxp3,
              vauxn3  => vauxn3,
              vauxp10 => vauxp10,
              vauxn10 => vauxn10,
              vauxp11 => vauxp11,
              vauxn11 => vauxn11,
              vp_in   => '0',
              vn_in   => '0',
              LED     => LED,
              pad     => pad,
              volumen => volumen_in);

    SYNC_PROC : process (clk, rst)
    begin
        if (rst = '1') then
            led_reg <= '0';
        elsif (clk'event and clk = '1') then
            led_reg <= led_next;
        end if;
    end process;

--    NEXT_STATE_LOGIC : process (new_pulse, led_reg)
--    begin
--        if(new_pulse = '1') then
--            led_next <= not led_reg;
--        else 
--            led_next <= led_reg;
--        end if;
--    end process;

    LED1 <= led_reg;
    
end Behavioral;
