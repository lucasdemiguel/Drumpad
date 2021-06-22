----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2021 12:35:55
-- Design Name: 
-- Module Name: Sistema_completo - Behavioral
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

entity Sistema_completo is
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
        pwm_pulse : out STD_LOGIC;
        LED1      : out STD_LOGIC;
        LED       : out STD_LOGIC_VECTOR(15 downto 0));
end Sistema_completo;

architecture Behavioral of Sistema_completo is

    component XADC_controller
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
              vp_in     : in std_logic;
              vn_in     : in std_logic;
              new_pulse : out std_logic;
              volumen   : out std_logic_vector (15 downto 0);
              LED1      : out std_logic;
              LED       : out std_logic_vector (15 downto 0));
    end component;
    
    component Audio_Contr
        port (clk       : in std_logic;
              sys_clk_i : in std_logic;
              reset     : in std_logic;
              pad       : in std_logic_vector (2 downto 0);
              volumen   : in std_logic_vector (15 downto 0);
              new_pulse : in std_logic;
              ck        : out std_logic_vector (0 downto 0);
              ck_n      : out std_logic_vector (0 downto 0);
              cke       : out std_logic_vector (0 downto 0);
              cs_n      : out std_logic_vector (0 downto 0);
              ras_n     : out std_logic;
              cas_n     : out std_logic;
              we_n      : out std_logic;
              dm_rdqs   : inout std_logic_vector (1 downto 0);
              ba        : inout std_logic_vector (2 downto 0);
              addr      : out std_logic_vector (12 downto 0);
              dq        : inout std_logic_vector (15 downto 0);
              dqs       : inout std_logic_vector (1 downto 0);
              dqs_n     : inout std_logic_vector (1 downto 0);
              rdqs_n    : in std_logic_vector (1 downto 0);
              odt       : out std_logic_vector (0 downto 0);
              pwm_pulse : out std_logic);
    end component;
    
--    component ddr2_model 
--        Port (ck : in STD_LOGIC_VECTOR (0 downto 0);
--              ck_n : in STD_LOGIC_VECTOR (0 downto 0);
--              cke : in STD_LOGIC_VECTOR (0 downto 0);
--              cs_n : in STD_LOGIC_VECTOR (0 downto 0);
--              ras_n : in STD_LOGIC;
--              cas_n : in STD_LOGIC;
--              we_n : in STD_LOGIC;
--              dm_rdqs : inout STD_LOGIC_VECTOR (1 downto 0);
--              ba : in STD_LOGIC_VECTOR (2 downto 0);
--              addr : in STD_LOGIC_VECTOR (12 downto 0);
--              dq : inout STD_LOGIC_VECTOR (15 downto 0);
--              dqs : inout STD_LOGIC_VECTOR (1 downto 0);
--              dqs_n : inout STD_LOGIC_VECTOR (1 downto 0);
--              rdqs_n : out STD_LOGIC_VECTOR (1 downto 0);
--              odt  : in STD_LOGIC_VECTOR (0 downto 0));
--    end component;

    signal sys_clk_i : std_logic;
    signal reset     : std_logic;
    signal pad       : std_logic_vector (2 downto 0);
    signal volumen   : std_logic_vector (15 downto 0);
    signal new_pulse : std_logic;
    signal ck        : std_logic_vector (0 downto 0);
    signal ck_n      : std_logic_vector (0 downto 0);
    signal cke       : std_logic_vector (0 downto 0);
    signal cs_n      : std_logic_vector (0 downto 0);
    signal ras_n     : std_logic;
    signal cas_n     : std_logic;
    signal we_n      : std_logic;
    signal dm_rdqs   : std_logic_vector (1 downto 0);
    signal ba        : std_logic_vector (2 downto 0);
    signal addr      : std_logic_vector (12 downto 0);
    signal dq        : std_logic_vector (15 downto 0);
    signal dqs       : std_logic_vector (1 downto 0);
    signal dqs_n     : std_logic_vector (1 downto 0);
    signal rdqs_n    : std_logic_vector (1 downto 0);
    signal odt       : std_logic_vector (0 downto 0);

begin

    XADC : XADC_controller
    port map (clk       => clk,
              rst       => rst,
              vauxp2    => vauxp2,
              vauxn2    => vauxn2,
              vauxp3    => vauxp3,
              vauxn3    => vauxn3,
              vauxp10   => vauxp10,
              vauxn10   => vauxn10,
              vauxp11   => vauxp11,
              vauxn11   => vauxn11,
              vp_in     => vp_in,
              vn_in     => vn_in,
              new_pulse => new_pulse,
              volumen   => volumen,
              LED1      => LED1,
              LED       => LED);

    AUDIO : Audio_Contr
    port map (clk       => clk,
              sys_clk_i => sys_clk_i,
              reset     => reset,
              pad       => pad,
              volumen   => volumen,
              new_pulse => new_pulse,
              ck        => ck,
              ck_n      => ck_n,
              cke       => cke,
              cs_n      => cs_n,
              ras_n     => ras_n,
              cas_n     => cas_n,
              we_n      => we_n,
              dm_rdqs   => dm_rdqs,
              ba        => ba,
              addr      => addr,
              dq        => dq,
              dqs       => dqs,
              dqs_n     => dqs_n,
              rdqs_n    => rdqs_n,
              odt       => odt,
              pwm_pulse => pwm_pulse);

--    DDR2 : ddr2_model
--    port map (dq             => dq,
--              dqs_n          => dqs_n,
--              dqs            => dqs,
--              addr           => addr,
--              ba             => ba,
--              ras_n          => ras_n,
--              cas_n          => cas_n,
--              we_n           => we_n,
--              ck             => ck,
--              ck_n           => ck_n,
--              cke            => cke,
--              cs_n           => cs_n,
--              dm_rdqs        => dm_rdqs,
--              rdqs_n         => rdqs_n,
--              odt            => odt);
    
end Behavioral;
