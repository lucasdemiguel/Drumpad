----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2021 11:14:30
-- Design Name: 
-- Module Name: Mem_Access_tb - Behavioral
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

entity Mem_Access_tb is
end Mem_Access_tb;

architecture Behavioral of Mem_Access_tb is
    component Mem_Acess_fsm
        port (clk         : in std_logic;
              reset       : in std_logic;
              en          : in std_logic;
              data_in     : in std_logic_vector (63 downto 0);
              data_valid  : in std_logic;
              uso         : in std_logic;
              dir_inicial : in std_logic_vector (26 downto 0);
              dir_final   : in std_logic_vector (26 downto 0);
              pad_in      : in std_logic_vector (2 downto 0);
              pad_out     : out std_logic_vector (2 downto 0);
              dir_act_out : out std_logic_vector (26 downto 0);
              read_req    : out std_logic;
              dir_req     : out std_logic_vector (26 downto 0);
              uso_rst     : out std_logic;
              data_out    : out std_logic_vector (63 downto 0));
    end component;

    signal clk         : std_logic := '0';
    signal reset       : std_logic; 
    signal en          : std_logic; 
    signal data_in     : std_logic_vector (63 downto 0);
    signal data_valid  : std_logic;
    signal uso         : std_logic;
    signal dir_inicial : std_logic_vector (26 downto 0);
    signal dir_final   : std_logic_vector (26 downto 0);
    signal pad_in      : std_logic_vector (2 downto 0);
    signal pad_out     : std_logic_vector (2 downto 0);
    signal dir_act_out : std_logic_vector (26 downto 0);
    signal read_req    : std_logic;
    signal dir_req     : std_logic_vector (26 downto 0);
    signal uso_rst     : std_logic;
    signal data_out    : std_logic_vector (63 downto 0);

    constant TbPeriod : time := 10 ns;

begin

    dut : Mem_Acess_fsm
    port map (clk         => clk,
              reset       => reset,
              en          => en,
              data_in     => data_in,
              data_valid  => data_valid,
              uso         => uso,
              dir_inicial => dir_inicial,
              dir_final   => dir_final,
              pad_in      => pad_in,
              pad_out     => pad_out,
              dir_act_out => dir_act_out,
              read_req    => read_req,
              dir_req     => dir_req,
              uso_rst     => uso_rst,
              data_out    => data_out);

    -- Clock generation
    clk <= not clk after TbPeriod/2 ;

    stimuli : process
    begin
        -- Initialization
        en <= '0';
        data_in <= (others => '0');
        data_valid <= '0';
        uso <= '0';
        dir_inicial <= (others => '0');
        dir_final <= (others => '0');
        pad_in <= (others => '0');

        -- Reset generation
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- Stimuli
        wait for 100 * TbPeriod;
        en <= '1';          
        data_in <= (others => '0'); 
        uso <= '1';   
        dir_inicial <= (others => '0'); 
        dir_final <= "000000000000000000000000011"; 
        pad_in <= "001";
        
        wait for 15*TbPeriod;
        data_in <= "0001010100101010100101001010101000111110000100101011101010101001";
        data_valid <= '1';
        wait for TbPeriod;
        data_valid <= '0';
        wait for 4*TbPeriod;
        en <= '0';
        
        wait for 2272*TbPeriod;
        en <= '1';
        wait for 15*TbPeriod;
        data_in <= "1111000110101001010101010100000111101010110011001010100101010100";
        data_valid <= '1';
        wait for TbPeriod;
        data_valid <= '0';
        wait for 4*TbPeriod;
        en <= '0';
        
        wait for 2272*TbPeriod;
        en <= '1';
        wait for 15*TbPeriod;
        data_in <= "0000111101010101010100011100110010100101010101101001010100100101";
        data_valid <= '1';
        wait for TbPeriod;
        data_valid <= '0';
        wait for 4*TbPeriod;
        en <= '0';
        
        wait for 2272*TbPeriod;
        en <= '1';
        wait for 15*TbPeriod;
        data_in <= "1111000111000111000110011001010101100110011100011100010101010100";
        uso <= '0';
        data_valid <= '1';
        wait for TbPeriod;
        data_valid <= '0';
        wait for 4*TbPeriod;
        en <= '0';

        wait;
    end process;
end Behavioral;
