----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2021 11:14:30
-- Design Name: 
-- Module Name: Play_Contr_tb - Behavioral
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

entity Play_Contr_tb is
end Play_Contr_tb;

architecture Behavioral of Play_Contr_tb is

    component Play_Contr_fsm
        port (clk                 : in std_logic;
              reset               : in std_logic;
              pad                 : in std_logic_vector (2 downto 0);
              volumen             : in std_logic_vector (7 downto 0);
              new_pulse           : in std_logic;
              MA1_uso             : in std_logic;
              MA2_uso             : in std_logic;
              MA3_uso             : in std_logic;
              MA4_uso             : in std_logic;
              MA1_uso_out         : out std_logic;
              MA2_uso_out         : out std_logic;
              MA3_uso_out         : out std_logic;
              MA4_uso_out         : out std_logic;
              MA1_orden           : in std_logic_vector (2 downto 0);
              MA2_orden           : in std_logic_vector (2 downto 0);
              MA3_orden           : in std_logic_vector (2 downto 0);
              MA4_orden           : in std_logic_vector (2 downto 0);
              MA1_orden_out       : out std_logic_vector (2 downto 0);
              MA2_orden_out       : out std_logic_vector (2 downto 0);
              MA3_orden_out       : out std_logic_vector (2 downto 0);
              MA4_orden_out       : out std_logic_vector (2 downto 0);
              MA1_vol_out         : out std_logic_vector (7 downto 0);
              MA2_vol_out         : out std_logic_vector (7 downto 0);
              MA3_vol_out         : out std_logic_vector (7 downto 0);
              MA4_vol_out         : out std_logic_vector (7 downto 0);
              MA1_pad_out         : out std_logic_vector (2 downto 0);
              MA2_pad_out         : out std_logic_vector (2 downto 0);
              MA3_pad_out         : out std_logic_vector (2 downto 0);
              MA4_pad_out         : out std_logic_vector (2 downto 0));
    end component;

    signal clk                 : std_logic := '0';
    signal reset               : std_logic;
    signal pad                 : std_logic_vector (2 downto 0);
    signal volumen             : std_logic_vector (7 downto 0);
    signal new_pulse           : std_logic;
    signal MA1_uso             : std_logic;
    signal MA2_uso             : std_logic;
    signal MA3_uso             : std_logic;
    signal MA4_uso             : std_logic;
    signal MA1_uso_out         : std_logic;
    signal MA2_uso_out         : std_logic;
    signal MA3_uso_out         : std_logic;
    signal MA4_uso_out         : std_logic;
    signal MA1_orden           : std_logic_vector (2 downto 0);
    signal MA2_orden           : std_logic_vector (2 downto 0);
    signal MA3_orden           : std_logic_vector (2 downto 0);
    signal MA4_orden           : std_logic_vector (2 downto 0);
    signal MA1_orden_out       : std_logic_vector (2 downto 0);
    signal MA2_orden_out       : std_logic_vector (2 downto 0);
    signal MA3_orden_out       : std_logic_vector (2 downto 0);
    signal MA4_orden_out       : std_logic_vector (2 downto 0);
    signal MA1_vol_out         : std_logic_vector (7 downto 0);
    signal MA2_vol_out         : std_logic_vector (7 downto 0);
    signal MA3_vol_out         : std_logic_vector (7 downto 0);
    signal MA4_vol_out         : std_logic_vector (7 downto 0);
    signal MA1_pad_out         : std_logic_vector (2 downto 0);
    signal MA2_pad_out         : std_logic_vector (2 downto 0);
    signal MA3_pad_out         : std_logic_vector (2 downto 0);
    signal MA4_pad_out         : std_logic_vector (2 downto 0);

    constant TbPeriod : time := 10 ns;

begin

    dut : Play_Contr_fsm
    port map (clk                 => clk,
              reset               => reset,
              pad                 => pad,
              volumen             => volumen,
              new_pulse           => new_pulse,
              MA1_uso             => MA1_uso,
              MA2_uso             => MA2_uso,
              MA3_uso             => MA3_uso,
              MA4_uso             => MA4_uso,
              MA1_uso_out         => MA1_uso_out,
              MA2_uso_out         => MA2_uso_out,
              MA3_uso_out         => MA3_uso_out,
              MA4_uso_out         => MA4_uso_out,
              MA1_orden           => MA1_orden,
              MA2_orden           => MA2_orden,
              MA3_orden           => MA3_orden,
              MA4_orden           => MA4_orden,
              MA1_orden_out       => MA1_orden_out,
              MA2_orden_out       => MA2_orden_out,
              MA3_orden_out       => MA3_orden_out,
              MA4_orden_out       => MA4_orden_out,
              MA1_vol_out         => MA1_vol_out,
              MA2_vol_out         => MA2_vol_out,
              MA3_vol_out         => MA3_vol_out,
              MA4_vol_out         => MA4_vol_out,
              MA1_pad_out         => MA1_pad_out,
              MA2_pad_out         => MA2_pad_out,
              MA3_pad_out         => MA3_pad_out,
              MA4_pad_out         => MA4_pad_out);

    -- Clock generation
    clk <= not clk after TbPeriod/2;

    stimuli : process
    begin
        -- Initialization
        pad <= (others => '0');
        volumen <= (others => '0');
        new_pulse <= '0';
        MA1_uso <= '0';
        MA2_uso <= '0';
        MA3_uso <= '0';
        MA4_uso <= '0';
        MA1_orden <= (others => '0');
        MA2_orden <= (others => '0');
        MA3_orden <= (others => '0');
        MA4_orden <= (others => '0');

        -- Reset generation
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- Stimuli
        wait for 5*TbPeriod;
        pad <= "001";
        volumen <= "00110011";
        new_pulse <= '1';
        wait for TbPeriod;
        MA1_uso <= '1';
        MA1_orden <= "001";
        new_pulse <= '0';
        
        wait for 1 us;
        pad <= "011";
        volumen <= "00111100";
        new_pulse <= '1';
        wait for TbPeriod;
        MA1_orden <= "010";
        MA2_uso <= '1';
        MA2_orden <= "001";
        new_pulse <= '0';
        
        wait for 1 us;
        pad <= "111";
        volumen <= "00000100";
        new_pulse <= '1';
        wait for TbPeriod;
        MA1_orden <= "011";
        MA2_orden <= "010";
        MA3_uso <= '1';
        MA3_orden <= "001";
        new_pulse <= '0';
        
        wait for 1 us;
        pad <= "010";
        volumen <= "00011101";
        new_pulse <= '1';
        wait for TbPeriod;
        MA1_orden <= "100";
        MA2_orden <= "011";
        MA3_orden <= "010";
        MA4_uso <= '1';
        MA4_orden <= "001";
        new_pulse <= '0';
        
        wait for 1 us;
        pad <= "101";
        volumen <= "10101001";
        new_pulse <= '1';
        wait for TbPeriod;
        MA1_orden <= "001";
        MA2_orden <= "100";
        MA3_orden <= "011";
        MA4_orden <= "010";
        new_pulse <= '0';
        
        wait for 1 us;
        pad <= "110";
        volumen <= "00101111";
        new_pulse <= '1';
        wait for TbPeriod;
        MA1_orden <= "010";
        MA2_orden <= "001";
        MA3_orden <= "100";
        MA4_orden <= "011";
        new_pulse <= '0';
        
        wait for 1 us;
        MA1_uso <= '0';
        wait for 1 us;
        pad <= "001";
        volumen <= "01111100";
        new_pulse <= '1';
        wait for TbPeriod;
        MA1_uso <= '1';
        MA1_orden <= "001";
        MA2_orden <= "010";
        MA3_orden <= "100";
        MA4_orden <= "011";
        new_pulse <= '0';
        
        wait for 1 us;
        MA3_uso <= '0';
        wait for 1 us;
        pad <= "110";
        volumen <= "00000111";
        new_pulse <= '1';
        wait for TbPeriod;
        MA3_uso <= '1';
        MA1_orden <= "010";
        MA2_orden <= "011";
        MA3_orden <= "001";
        MA4_orden <= "100";
        new_pulse <= '0';
        
        wait for 1 us;
        MA2_uso <= '0';
        wait for 1 us;
        pad <= "010";
        volumen <= "01100111";
        new_pulse <= '1';
        wait for TbPeriod;
        MA2_uso <= '1';
        MA1_orden <= "011";
        MA2_orden <= "001";
        MA3_orden <= "010";
        MA4_orden <= "100";
        new_pulse <= '0';
        
        wait for 1 us;
        MA4_uso <= '0';
        wait for 1 us;
        pad <= "100";
        volumen <= "10010111";
        new_pulse <= '1';
        wait for TbPeriod;
        MA4_uso <= '1';
        MA1_orden <= "100";
        MA2_orden <= "010";
        MA3_orden <= "011";
        MA4_orden <= "001";
        new_pulse <= '0';
        
        wait;
    end process;
end Behavioral;
