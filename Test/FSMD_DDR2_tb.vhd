----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2021 11:14:30
-- Design Name: 
-- Module Name: FSMD_DDR2_tb - Behavioral
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

entity FSMD_DDR2_tb is
end FSMD_DDR2_tb;

architecture Behavioral of FSMD_DDR2_tb is

    component FSMD_DDR2
        port (clk               : in std_logic;
              reset             : in std_logic;
              read_req          : in std_logic;
              app_rdy           : in std_logic;
              app_rd_data       : in std_logic_vector (63 downto 0);
              app_rd_data_valid : in std_logic;
              app_rd_data_end   : in std_logic;
              addr_in           : in std_logic_vector (26 downto 0);
              app_addr          : out std_logic_vector (26 downto 0);
              app_wdf_wren      : out std_logic;
              app_wdf_end       : out std_logic;
              app_wdf_mask      : out std_logic_vector (7 downto 0);
              app_en            : out std_logic;
              app_cmd           : out std_logic_vector (2 downto 0);
              data_out          : out std_logic_vector (63 downto 0));
    end component;

    signal clk               : std_logic;
    signal reset             : std_logic;
    signal read_req          : std_logic;
    signal app_rdy           : std_logic;
    signal app_rd_data       : std_logic_vector (63 downto 0);
    signal app_rd_data_valid : std_logic;
    signal app_rd_data_end   : std_logic;
    signal addr_in           : std_logic_vector (26 downto 0);
    signal app_addr          : std_logic_vector (26 downto 0);
    signal app_wdf_wren      : std_logic;
    signal app_wdf_end       : std_logic;
    signal app_wdf_mask      : std_logic_vector (7 downto 0);
    signal app_en            : std_logic;
    signal app_cmd           : std_logic_vector (2 downto 0);
    signal data_out          : std_logic_vector (63 downto 0);

    constant TbPeriod : time := 1000 ns;

begin

    dut : FSMD_DDR2
    port map (clk               => clk,
              reset             => reset,
              read_req          => read_req,
              app_rdy           => app_rdy,
              app_rd_data       => app_rd_data,
              app_rd_data_valid => app_rd_data_valid,
              app_rd_data_end   => app_rd_data_end,
              addr_in           => addr_in,
              app_addr          => app_addr,
              app_wdf_wren      => app_wdf_wren,
              app_wdf_end       => app_wdf_end,
              app_wdf_mask      => app_wdf_mask,
              app_en            => app_en,
              app_cmd           => app_cmd,
              data_out          => data_out);

    -- Clock generation
    clk <= not clk after TbPeriod/2;

    stimuli : process
    begin
        -- Initialization
        read_req <= '0';
        app_rdy <= '0';
        app_rd_data <= (others => '0');
        app_rd_data_valid <= '0';
        app_rd_data_end <= '0';
        addr_in <= (others => '0');

        -- Reset generation
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- Stimuli
        wait for 100 * TbPeriod;

        wait;
    end process;
end Behavioral;
