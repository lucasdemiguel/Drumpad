----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2021 11:45:33
-- Design Name: 
-- Module Name: MA_Data - Behavioral
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

entity MA_Data is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           act_orden : in STD_LOGIC;
           --Mem_Access 1
           MA1_orden_in : in STD_LOGIC_VECTOR(2 downto 0);
           MA1_orden_out : out STD_LOGIC_VECTOR(2 downto 0);
           MA1_volumen_in : in STD_LOGIC_VECTOR(15 downto 0);
           MA1_volumen_out : out STD_LOGIC_VECTOR(15 downto 0);
           MA1_uso_in : in STD_LOGIC;
           MA1_uso_out : out STD_LOGIC;
           MA1_dir_inicial : out STD_LOGIC_VECTOR(26 downto 0);
           MA1_dir_final : out STD_LOGIC_VECTOR(26 downto 0);
           MA1_dir_act_in : in STD_LOGIC_VECTOR(26 downto 0);
           MA1_pad : in STD_LOGIC_VECTOR(2 downto 0);
           MA1_uso_rst : in STD_LOGIC;
           --Mem_Access 2
           MA2_orden_in : in STD_LOGIC_VECTOR(2 downto 0);
           MA2_orden_out : out STD_LOGIC_VECTOR(2 downto 0);
           MA2_volumen_in : in STD_LOGIC_VECTOR(15 downto 0);
           MA2_volumen_out : out STD_LOGIC_VECTOR(15 downto 0);
           MA2_uso_in : in STD_LOGIC;
           MA2_uso_out : out STD_LOGIC;
           MA2_dir_inicial : out STD_LOGIC_VECTOR(26 downto 0);
           MA2_dir_final : out STD_LOGIC_VECTOR(26 downto 0);
           MA2_dir_act_in : in STD_LOGIC_VECTOR(26 downto 0);
           MA2_pad : in STD_LOGIC_VECTOR(2 downto 0);
           MA2_uso_rst : in STD_LOGIC;
           --Mem_Access 3
           MA3_orden_in : in STD_LOGIC_VECTOR(2 downto 0);
           MA3_orden_out : out STD_LOGIC_VECTOR(2 downto 0);
           MA3_volumen_in : in STD_LOGIC_VECTOR(15 downto 0);
           MA3_volumen_out : out STD_LOGIC_VECTOR(15 downto 0);
           MA3_uso_in : in STD_LOGIC;
           MA3_uso_out : out STD_LOGIC;
           MA3_dir_inicial : out STD_LOGIC_VECTOR(26 downto 0);
           MA3_dir_final : out STD_LOGIC_VECTOR(26 downto 0);
           MA3_dir_act_in : in STD_LOGIC_VECTOR(26 downto 0);
           MA3_pad : in STD_LOGIC_VECTOR(2 downto 0);
           MA3_uso_rst : in STD_LOGIC;
           --Mem_Access 4
           MA4_orden_in : in STD_LOGIC_VECTOR(2 downto 0);
           MA4_orden_out : out STD_LOGIC_VECTOR(2 downto 0);
           MA4_volumen_in : in STD_LOGIC_VECTOR(15 downto 0);
           MA4_volumen_out : out STD_LOGIC_VECTOR(15 downto 0);
           MA4_uso_in : in STD_LOGIC;
           MA4_uso_out : out STD_LOGIC;
           MA4_dir_inicial : out STD_LOGIC_VECTOR(26 downto 0);
           MA4_dir_final : out STD_LOGIC_VECTOR(26 downto 0);
           MA4_dir_act_in : in STD_LOGIC_VECTOR(26 downto 0);
           MA4_pad : in STD_LOGIC_VECTOR(2 downto 0);
           MA4_uso_rst : in STD_LOGIC);
end MA_Data;

architecture Behavioral of MA_Data is

    component Pad_Data
        port (clk         : in std_logic;
              reset       : in std_logic;
              act_orden   : in std_logic;
              orden_in    : in std_logic_vector (2 downto 0);
              orden_out   : out std_logic_vector (2 downto 0);
              volumen_in  : in std_logic_vector (15 downto 0);
              volumen_out : out std_logic_vector (15 downto 0);
              uso_in      : in std_logic;
              uso_out     : out std_logic;
              dir_inicial : out std_logic_vector (26 downto 0);
              dir_final   : out std_logic_vector (26 downto 0);
              dir_act_in  : in std_logic_vector (26 downto 0);
              pad         : in std_logic_vector (2 downto 0);
              uso_rst     : in std_logic);
    end component;

begin

    MA1_Data : Pad_Data
    port map (clk         => clk,
              reset       => reset,
              act_orden   => act_orden,
              orden_in    => MA1_orden_in,
              orden_out   => MA1_orden_out,
              volumen_in  => MA1_volumen_in,
              volumen_out => MA1_volumen_out,
              uso_in      => MA1_uso_in,
              uso_out     => MA1_uso_out,
              dir_inicial => MA1_dir_inicial,
              dir_final   => MA1_dir_final,
              dir_act_in  => MA1_dir_act_in,
              pad         => MA1_pad,
              uso_rst     => MA1_uso_rst);
    
    MA2_Data : Pad_Data
    port map (clk         => clk,
              reset       => reset,
              act_orden   => act_orden,
              orden_in    => MA2_orden_in,
              orden_out   => MA2_orden_out,
              volumen_in  => MA2_volumen_in,
              volumen_out => MA2_volumen_out,
              uso_in      => MA2_uso_in,
              uso_out     => MA2_uso_out,
              dir_inicial => MA2_dir_inicial,
              dir_final   => MA2_dir_final,
              dir_act_in  => MA2_dir_act_in,
              pad         => MA2_pad,
              uso_rst     => MA2_uso_rst);
    
    MA3_Data : Pad_Data
    port map (clk         => clk,
              reset       => reset,
              act_orden   => act_orden,
              orden_in    => MA3_orden_in,
              orden_out   => MA3_orden_out,
              volumen_in  => MA3_volumen_in,
              volumen_out => MA3_volumen_out,
              uso_in      => MA3_uso_in,
              uso_out     => MA3_uso_out,
              dir_inicial => MA3_dir_inicial,
              dir_final   => MA3_dir_final,
              dir_act_in  => MA3_dir_act_in,
              pad         => MA3_pad,
              uso_rst     => MA3_uso_rst);
              
    MA4_Data : Pad_Data
    port map (clk         => clk,
              reset       => reset,
              act_orden   => act_orden,
              orden_in    => MA4_orden_in,
              orden_out   => MA4_orden_out,
              volumen_in  => MA4_volumen_in,
              volumen_out => MA4_volumen_out,
              uso_in      => MA4_uso_in,
              uso_out     => MA4_uso_out,
              dir_inicial => MA4_dir_inicial,
              dir_final   => MA4_dir_final,
              dir_act_in  => MA4_dir_act_in,
              pad         => MA4_pad,
              uso_rst     => MA4_uso_rst);
end Behavioral;
