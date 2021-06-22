----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2021 11:14:30
-- Design Name: 
-- Module Name: Pad_Data_tb - Behavioral
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

entity Pad_Data_tb is
end Pad_Data_tb;

architecture Behavioral of Pad_Data_tb is
    component Pad_Data
        port (clk         : in std_logic;
              reset       : in std_logic;
              act_orden   : in std_logic;
              orden_in    : in std_logic_vector (2 downto 0);
              orden_out   : out std_logic_vector (2 downto 0);
              volumen_in  : in std_logic_vector (7 downto 0);
              volumen_out : out std_logic_vector (7 downto 0);
              uso_in      : in std_logic;
              uso_out     : out std_logic;
              dir_inicial : out std_logic_vector (26 downto 0);
              dir_final   : out std_logic_vector (26 downto 0);
              dir_act_in  : in std_logic_vector (26 downto 0);
              pad         : in std_logic_vector (2 downto 0);
              uso_rst     : in std_logic);
    end component;

    signal clk         : std_logic := '0';
    signal reset       : std_logic;
    signal orden_in    : std_logic_vector (2 downto 0);
    signal orden_out   : std_logic_vector (2 downto 0);
    signal volumen_in  : std_logic_vector (7 downto 0);
    signal volumen_out : std_logic_vector (7 downto 0);
    signal uso_in      : std_logic;
    signal uso_out     : std_logic;
    signal dir_inicial : std_logic_vector (26 downto 0);
    signal dir_final   : std_logic_vector (26 downto 0);
    signal dir_act_in  : std_logic_vector (26 downto 0);
    signal pad         : std_logic_vector (2 downto 0);
    signal uso_rst     : std_logic;
    signal act_orden   : std_logic;

    constant TbPeriod : time := 11363.64 ps;

begin

    dut : Pad_Data
    port map (clk         => clk,
              reset       => reset,
              act_orden   => act_orden,
              orden_in    => orden_in,
              orden_out   => orden_out,
              volumen_in  => volumen_in,
              volumen_out => volumen_out,
              uso_in      => uso_in,
              uso_out     => uso_out,
              dir_inicial => dir_inicial,
              dir_final   => dir_final,
              dir_act_in  => dir_act_in,
              pad         => pad,
              uso_rst     => uso_rst);

    -- Clock generation
    clk <= not clk after TbPeriod/2;

    stimuli : process
    begin
        -- Initialization
        orden_in <= (others => '0');
        volumen_in <= (others => '0');
        uso_in <= '0';
        dir_act_in <= (others => '0');
        pad <= (others => '0');
        uso_rst <= '0';
        act_orden <= '0';

        -- Reset generation
        reset <= '1';
        uso_rst <= '1';
        wait for 100 ns;
        reset <= '0';
        uso_rst <= '0';
        wait for 100 ns;

        -- Stimuli
        wait for 100 * TbPeriod;
            orden_in    <= "001";
            act_orden <= '1';
            volumen_in  <= (others => '1');
            uso_in      <= '1';
            dir_act_in  <= (others => '1');
            pad         <= "001";
            uso_rst     <= '0';
        wait for 1us;
            uso_in      <= '0';
            act_orden <= '0';
            
        
        wait for 500 * TbPeriod;
            orden_in    <= "010";
            act_orden <= '1';
            uso_in      <= '1';
            volumen_in  <= (others => '1');
            dir_act_in  <= (others => '1');
            pad         <= "011";
            uso_rst     <= '0';
        wait for 1us;
            uso_in      <= '0';
            act_orden <= '0';
        wait for 15us;     
            uso_rst     <= '1';
        wait for 1us;
            uso_rst     <= '0';
        
        wait for 100 * TbPeriod;
            orden_in    <= "001";
            act_orden <= '1';
            volumen_in  <= (others => '1');
            uso_in      <= '1';
            dir_act_in  <= (others => '1');
            pad         <= "010";
            uso_rst     <= '0';
        wait for 1us;
            uso_in      <= '0';
            act_orden <= '0';         
        wait for 10us;    
            uso_rst     <= '1';
        wait for 1us;
            uso_rst     <= '0';
            
        wait;
    end process;
end Behavioral;
