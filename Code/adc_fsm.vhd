----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2021 12:26:41
-- Design Name: 
-- Module Name: adc_fsm - Behavioral
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

entity adc_fsm is
    Port ( clk       : in STD_LOGIC;
           rst       : in STD_LOGIC;
           vauxp2    : in  STD_LOGIC; -- Auxiliary Channel 2
           vauxn2    : in  STD_LOGIC;
           vauxp3    : in  STD_LOGIC; -- Auxiliary Channel 3
           vauxn3    : in  STD_LOGIC;
           vauxp10   : in  STD_LOGIC; -- Auxiliary Channel 10
           vauxn10   : in  STD_LOGIC;
           vauxp11   : in  STD_LOGIC; -- Auxiliary Channel 11
           vauxn11   : in  STD_LOGIC;
           vp_in     : in STD_LOGIC;
           vn_in     : in STD_LOGIC;
           volumen   : out STD_LOGIC_VECTOR(15 downto 0);
           pad       : out STD_LOGIC_VECTOR(2 downto 0);
           LED       : out STD_LOGIC_VECTOR(15 downto 0));
end adc_fsm;

architecture Behavioral of adc_fsm is

    component XADC_core
        port (CLK100MHZ           : in std_logic;
              vauxp2        : in std_logic;
              vauxn2        : in std_logic;
              vauxp3        : in std_logic;
              vauxn3        : in std_logic;
              vauxp10       : in std_logic;
              vauxn10       : in std_logic;
              vauxp11       : in std_logic;
              vauxn11       : in std_logic;
              vp_in         : in std_logic;
              vn_in         : in std_logic;
              sw            : in std_logic_vector (1 downto 0);
              drdy          : out std_logic;
              LED           : out std_logic_vector (15 downto 0);
              data_out      : out std_logic_vector (15 downto 0));
    end component;

    signal data_xadc : std_logic_vector (15 downto 0); 
    
    type state is (read_reg12, read_reg13, read_reg1A, read_reg1B);
    signal state_reg, state_next : state;
    signal SW : std_logic_vector(1 downto 0);
    signal drdy : std_logic;
    
begin

    XADC : XADC_core
    port map (CLK100MHz     => clk,
              vauxp2        => vauxp2,
              vauxn2        => vauxn2,
              vauxp3        => vauxp3,
              vauxn3        => vauxn3,
              vauxp10       => vauxp10,
              vauxn10       => vauxn10,
              vauxp11       => vauxp11,
              vauxn11       => vauxn11,
              vp_in         => vp_in,
              vn_in         => vn_in,
              sw            => SW,
              drdy          => drdy,
              LED           => LED,
              data_out      => data_xadc);

    SYNC_PROC : process (clk, rst)
    begin
        if (rst = '1') then
            state_reg <= read_reg12;
        elsif (clk'event and clk = '1') then
            state_reg <= state_next;
        end if;
    end process;
    
    NEXT_STATE_LOGIC : process(state_reg, data_xadc, drdy)
    begin
        --volumen <= data_xadc;
        pad <= "000";
        SW <= "00";
        
        case state_reg is
            when read_reg12 =>
                SW <= "00";
                pad <= "000";
            when read_reg13 =>
                SW <= "01";
                pad <= "001";
            when read_reg1A =>
                SW <= "10";
                pad <= "010";
            when read_reg1B =>
                SW <= "11";
                pad <= "011";
        end case;        
    end process;
    
    NEXT_STATE_DECODE : process (state_reg, drdy)
    begin    
        state_next <= state_reg;
        
        case state_reg is
            when read_reg12 =>
                if(drdy = '1') then
                    state_next <= read_reg13;
                end if;
            when read_reg13 =>
                if(drdy = '1') then
                    state_next <= read_reg1A;
                end if;
            when read_reg1A =>
                if(drdy = '1') then
                    state_next <= read_reg1B;
                end if;
            when read_reg1B =>
                if(drdy = '1') then
                    state_next <= read_reg12;
                end if;
        end case;
    end process;
    
    volumen <= data_xadc;

end Behavioral;
