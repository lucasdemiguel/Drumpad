----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2021 16:55:22
-- Design Name: 
-- Module Name: Audio_Contr_tb - Behavioral
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

entity Audio_Contr_tb is
end Audio_Contr_tb;

architecture Behavioral of Audio_Contr_tb is
    
    component Audio_Contr
        port (clk       : in std_logic;
              sys_clk_i : in std_logic;
              reset     : in std_logic;
              pad       : in std_logic_vector (2 downto 0);
              volumen   : in std_logic_vector (7 downto 0);
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
              odt       : out std_logic_vector (0 downto 0));
    end component;
    
    component ddr2_model 
        Port (ck : in STD_LOGIC_VECTOR (0 downto 0);
              ck_n : in STD_LOGIC_VECTOR (0 downto 0);
              cke : in STD_LOGIC_VECTOR (0 downto 0);
              cs_n : in STD_LOGIC_VECTOR (0 downto 0);
              ras_n : in STD_LOGIC;
              cas_n : in STD_LOGIC;
              we_n : in STD_LOGIC;
              dm_rdqs : inout STD_LOGIC_VECTOR (1 downto 0);
              ba : in STD_LOGIC_VECTOR (2 downto 0);
              addr : in STD_LOGIC_VECTOR (12 downto 0);
              dq : inout STD_LOGIC_VECTOR (15 downto 0);
              dqs : inout STD_LOGIC_VECTOR (1 downto 0);
              dqs_n : inout STD_LOGIC_VECTOR (1 downto 0);
              rdqs_n : out STD_LOGIC_VECTOR (1 downto 0);
              odt  : in STD_LOGIC_VECTOR (0 downto 0));
    end component;

    signal clk       : std_logic := '0';
    signal sys_clk_i : std_logic := '0';
    signal reset     : std_logic;
    signal pad       : std_logic_vector (2 downto 0);
    signal volumen   : std_logic_vector (7 downto 0);
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

    constant TbPeriod : time := 10 ns; --100MHz

begin

    dut1 : Audio_Contr
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
              odt       => odt);
    
    dut2 : ddr2_model
    port map (dq             => dq,
              dqs_n          => dqs_n,
              dqs            => dqs,
              addr           => addr,
              ba             => ba,
              ras_n          => ras_n,
              cas_n          => cas_n,
              we_n           => we_n,
              ck             => ck,
              ck_n           => ck_n,
              cke            => cke,
              cs_n           => cs_n,
              dm_rdqs        => dm_rdqs,
              rdqs_n         => rdqs_n,
              odt            => odt);
    
    -- Clock generation
    clk <= not clk after TbPeriod/2;
    sys_clk_i <= not sys_clk_i after TbPeriod/2;

    stimuli : process
    begin
        pad <= (others => '0');
        volumen <= (others => '0');
        new_pulse <= '0';
        rdqs_n <= (others => '0');

        -- Reset generation
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        wait for 100 * TbPeriod;
        wait for 50 us;
        pad <= "001";
        volumen <= "00110011";
        new_pulse <= '1';
        wait for 1 us;
        new_pulse <= '0';
        wait for 2 us;
        pad <= "011";
        volumen <= "00111100";
        new_pulse <= '1';
        wait for 1 us;
        new_pulse <= '0';
        wait for 2 us;
        pad <= "111";
        volumen <= "00000100";
        new_pulse <= '1';
        wait for 1 us;
        new_pulse <= '0';
        wait for 2 us;
        pad <= "010";
        volumen <= "00011101";
        new_pulse <= '1';
        wait for 1 us;
        new_pulse <= '0';
        wait for 2 us;
        pad <= "101";
        volumen <= "10101001";
        new_pulse <= '1';
        wait for 1 us;
        new_pulse <= '0';
        wait for 2 us;
        pad <= "110";
        volumen <= "00101111";
        new_pulse <= '1';
        wait for 1 us;
        new_pulse <= '0';
        
        wait for 5 us;
        pad <= (others => '0');
        volumen <= (others => '0');
        new_pulse <= '0';
               
        wait;
    end process;
    
end Behavioral;
