----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2021 11:59:12
-- Design Name: 
-- Module Name: Audio_Contr - Behavioral
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

entity Audio_Contr is
    Port ( clk : in STD_LOGIC;
           sys_clk_i : in STD_LOGIC;
           reset : in STD_LOGIC;
           --PADS
           pad : in STD_LOGIC_VECTOR (2 downto 0);
           volumen : in STD_LOGIC_VECTOR(15 downto 0);
           new_pulse : in STD_LOGIC;
           --MIG: Conectar con la ddr
           ck : out STD_LOGIC_VECTOR (0 downto 0);
           ck_n : out STD_LOGIC_VECTOR (0 downto 0);
           cke : out STD_LOGIC_VECTOR (0 downto 0);
           cs_n : out STD_LOGIC_VECTOR (0 downto 0);
           ras_n : out STD_LOGIC;
           cas_n : out STD_LOGIC;
           we_n : out STD_LOGIC;
           dm_rdqs : inout STD_LOGIC_VECTOR (1 downto 0);
           ba : inout STD_LOGIC_VECTOR (2 downto 0);
           addr : out STD_LOGIC_VECTOR (12 downto 0);
           dq : inout STD_LOGIC_VECTOR (15 downto 0);
           dqs : inout STD_LOGIC_VECTOR (1 downto 0);
           dqs_n : inout STD_LOGIC_VECTOR (1 downto 0);
           rdqs_n : in STD_LOGIC_VECTOR (1 downto 0);
           odt  : out STD_LOGIC_VECTOR (0 downto 0);
           --PWM
           pwm_pulse : out STD_LOGIC);
end Audio_Contr;

architecture Behavioral of Audio_Contr is

--Component declaration
    component En_Contr
        port (clk    : in std_logic;
              reset  : in std_logic;
              en1    : out std_logic;
              en2    : out std_logic;
              en3    : out std_logic;
              en4    : out std_logic);
    end component;
    
    component Play_Contr_fsm
        port (clk                 : in std_logic;
              reset               : in std_logic;
              pad                 : in std_logic_vector (2 downto 0);
              volumen             : in std_logic_vector (15 downto 0);
              new_pulse           : in std_logic;
              act_orden           : out std_logic;
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
              MA1_vol_out         : out std_logic_vector (15 downto 0);
              MA2_vol_out         : out std_logic_vector (15 downto 0);
              MA3_vol_out         : out std_logic_vector (15 downto 0);
              MA4_vol_out         : out std_logic_vector (15 downto 0);
              MA1_pad_out         : out std_logic_vector (2 downto 0);
              MA2_pad_out         : out std_logic_vector (2 downto 0);
              MA3_pad_out         : out std_logic_vector (2 downto 0);
              MA4_pad_out         : out std_logic_vector (2 downto 0));
    end component;
    
    component MA_Data
        port (clk             : in std_logic;
              reset           : in std_logic;
              act_orden       : in std_logic;
              MA1_orden_in    : in std_logic_vector (2 downto 0);
              MA1_orden_out   : out std_logic_vector (2 downto 0);
              MA1_volumen_in  : in std_logic_vector (15 downto 0);
              MA1_volumen_out : out std_logic_vector (15 downto 0);
              MA1_uso_in      : in std_logic;
              MA1_uso_out     : out std_logic;
              MA1_dir_inicial : out std_logic_vector (26 downto 0);
              MA1_dir_final   : out std_logic_vector (26 downto 0);
              MA1_dir_act_in  : in std_logic_vector (26 downto 0);
              MA1_pad         : in std_logic_vector (2 downto 0);
              MA1_uso_rst     : in std_logic;
              MA2_orden_in    : in std_logic_vector (2 downto 0);
              MA2_orden_out   : out std_logic_vector (2 downto 0);
              MA2_volumen_in  : in std_logic_vector (15 downto 0);
              MA2_volumen_out : out std_logic_vector (15 downto 0);
              MA2_uso_in      : in std_logic;
              MA2_uso_out     : out std_logic;
              MA2_dir_inicial : out std_logic_vector (26 downto 0);
              MA2_dir_final   : out std_logic_vector (26 downto 0);
              MA2_dir_act_in  : in std_logic_vector (26 downto 0);
              MA2_pad         : in std_logic_vector (2 downto 0);
              MA2_uso_rst     : in std_logic;
              MA3_orden_in    : in std_logic_vector (2 downto 0);
              MA3_orden_out   : out std_logic_vector (2 downto 0);
              MA3_volumen_in  : in std_logic_vector (15 downto 0);
              MA3_volumen_out : out std_logic_vector (15 downto 0);
              MA3_uso_in      : in std_logic;
              MA3_uso_out     : out std_logic;
              MA3_dir_inicial : out std_logic_vector (26 downto 0);
              MA3_dir_final   : out std_logic_vector (26 downto 0);
              MA3_dir_act_in  : in std_logic_vector (26 downto 0);
              MA3_pad         : in std_logic_vector (2 downto 0);
              MA3_uso_rst     : in std_logic;
              MA4_orden_in    : in std_logic_vector (2 downto 0);
              MA4_orden_out   : out std_logic_vector (2 downto 0);
              MA4_volumen_in  : in std_logic_vector (15 downto 0);
              MA4_volumen_out : out std_logic_vector (15 downto 0);
              MA4_uso_in      : in std_logic;
              MA4_uso_out     : out std_logic;
              MA4_dir_inicial : out std_logic_vector (26 downto 0);
              MA4_dir_final   : out std_logic_vector (26 downto 0);
              MA4_dir_act_in  : in std_logic_vector (26 downto 0);
              MA4_pad         : in std_logic_vector (2 downto 0);
              MA4_uso_rst     : in std_logic);
    end component;
    
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
    
    component mig 
        port( --Inouts
              ddr2_dq             : inout std_logic_vector (15 downto 0);
              ddr2_dqs_n          : inout std_logic_vector (1 downto 0);
              ddr2_dqs_p          : inout std_logic_vector (1 downto 0);
              --Outputs
              ddr2_addr           : out std_logic_vector (12 downto 0);
              ddr2_ba             : out std_logic_vector (2 downto 0);
              ddr2_ras_n          : out std_logic;
              ddr2_cas_n          : out std_logic;
              ddr2_we_n           : out std_logic;
              ddr2_ck_p           : out std_logic_vector (0 downto 0);
              ddr2_ck_n           : out std_logic_vector (0 downto 0);
              ddr2_cke            : out std_logic_vector (0 downto 0);
              ddr2_cs_n           : out std_logic_vector (0 downto 0);
              ddr2_dm             : out std_logic_vector (1 downto 0);
              ddr2_odt            : out std_logic_vector (0 downto 0);
              --Inputs
              --Single-ended system clock
              sys_clk_i           : in std_logic;
              --user interface signals
              app_addr            : in std_logic_vector (26 downto 0);
              app_cmd             : in std_logic_vector (2 downto 0);
              app_en              : in std_logic;
              app_wdf_data        : in std_logic_vector (63 downto 0);
              app_wdf_end         : in std_logic;
              app_wdf_mask        : in std_logic_vector (7 downto 0);
              app_wdf_wren        : in std_logic;        
              app_rd_data         : out std_logic_vector (63 downto 0);
              app_rd_data_end     : out std_logic;
              app_rd_data_valid   : out std_logic;
              app_rdy             : out std_logic;
              app_wdf_rdy         : out std_logic;
              app_sr_req          : in std_logic;
              app_ref_req         : in std_logic;
              app_zq_req          : in std_logic;
              app_sr_active       : out std_logic;
              app_ref_ack         : out std_logic;
              app_zq_ack          : out std_logic;
              ui_clk              : out std_logic;
              ui_clk_sync_rst     : out std_logic;
              init_calib_complete : out std_logic;                                  
              sys_rst             : in std_logic);
    end component;
    
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
    
    component Mult
        port (data_in  : in std_logic_vector (63 downto 0);
              volumen  : in std_logic_vector (15 downto 0);
              mult_out : out std_logic_vector (70 downto 0));
    end component;
    
    component Sum
        port (MA1     : in std_logic_vector (70 downto 0);
              MA2     : in std_logic_vector (70 downto 0);
              MA3     : in std_logic_vector (70 downto 0);
              MA4     : in std_logic_vector (70 downto 0);
              sum_out : out std_logic_vector (72 downto 0));
    end component;
    
    component pwm
        port (clk       : in std_logic;
              reset     : in std_logic;
              sample_in : in std_logic_vector (72 downto 0);
              pwm_pulse : out std_logic);
    end component;
    
   component sync_en_pulse
   port(
      clk, reset: in std_logic;
      en_in: in std_logic;
      en_out: out std_logic
   );
   end component;
    
--Signal declaration    
    signal new_pulse_tmp       : std_logic;
    signal act_orden           : std_logic;
    signal en1                 : std_logic;
    signal en2                 : std_logic;
    signal en3                 : std_logic;
    signal en4                 : std_logic;
    signal read_req            : std_logic;
    signal read_req1            : std_logic;
    signal read_req2           : std_logic;
    signal read_req3           : std_logic;
    signal read_req4           : std_logic;
    signal app_rdy             : std_logic;
    signal app_rd_data         : std_logic_vector (63 downto 0);
    signal app_rd_data_valid   : std_logic;
    signal app_rd_data_end     : std_logic;
    signal addr_in             : std_logic_vector (26 downto 0);
    signal addr_in1            : std_logic_vector (26 downto 0);
    signal addr_in2            : std_logic_vector (26 downto 0);
    signal addr_in3            : std_logic_vector (26 downto 0);
    signal addr_in4            : std_logic_vector (26 downto 0);
    signal app_addr            : std_logic_vector (26 downto 0);
    signal app_wdf_wren        : std_logic;
    signal app_wdf_end         : std_logic;
    signal app_wdf_mask        : std_logic_vector (7 downto 0);
    signal app_en              : std_logic;
    signal app_cmd             : std_logic_vector (2 downto 0);
    signal data_out_ddr        : std_logic_vector (63 downto 0);
    signal MA1_orden_new       : std_logic_vector (2 downto 0);
    signal MA2_orden_new       : std_logic_vector (2 downto 0);
    signal MA3_orden_new       : std_logic_vector (2 downto 0);
    signal MA4_orden_new       : std_logic_vector (2 downto 0);
    signal MA1_orden_reg       : std_logic_vector (2 downto 0);
    signal MA2_orden_reg       : std_logic_vector (2 downto 0);
    signal MA3_orden_reg       : std_logic_vector (2 downto 0);
    signal MA4_orden_reg       : std_logic_vector (2 downto 0);
    signal MA1_volumen_new     : std_logic_vector (15 downto 0);
    signal MA2_volumen_new     : std_logic_vector (15 downto 0);
    signal MA3_volumen_new     : std_logic_vector (15 downto 0);
    signal MA4_volumen_new     : std_logic_vector (15 downto 0);
    signal MA1_volumen_reg     : std_logic_vector (15 downto 0);
    signal MA2_volumen_reg     : std_logic_vector (15 downto 0);
    signal MA3_volumen_reg     : std_logic_vector (15 downto 0);
    signal MA4_volumen_reg     : std_logic_vector (15 downto 0);
    signal MA1_uso_new         : std_logic;
    signal MA2_uso_new         : std_logic;
    signal MA3_uso_new         : std_logic;
    signal MA4_uso_new         : std_logic;
    signal MA1_uso_reg         : std_logic;
    signal MA2_uso_reg         : std_logic;
    signal MA3_uso_reg         : std_logic;
    signal MA4_uso_reg         : std_logic;
    signal MA1_dir_inicial     : std_logic_vector (26 downto 0);
    signal MA2_dir_inicial     : std_logic_vector (26 downto 0);
    signal MA3_dir_inicial     : std_logic_vector (26 downto 0);
    signal MA4_dir_inicial     : std_logic_vector (26 downto 0);
    signal MA1_dir_final       : std_logic_vector (26 downto 0);
    signal MA2_dir_final       : std_logic_vector (26 downto 0);
    signal MA3_dir_final       : std_logic_vector (26 downto 0);
    signal MA4_dir_final       : std_logic_vector (26 downto 0);
    signal MA1_dir_act_new     : std_logic_vector (26 downto 0);
    signal MA2_dir_act_new     : std_logic_vector (26 downto 0);
    signal MA3_dir_act_new     : std_logic_vector (26 downto 0);
    signal MA4_dir_act_new     : std_logic_vector (26 downto 0);
    signal MA1_pad_new         : std_logic_vector (2 downto 0);
    signal MA2_pad_new         : std_logic_vector (2 downto 0);
    signal MA3_pad_new         : std_logic_vector (2 downto 0);
    signal MA4_pad_new         : std_logic_vector (2 downto 0);
    signal MA1_pad_reg         : std_logic_vector (2 downto 0);
    signal MA2_pad_reg         : std_logic_vector (2 downto 0);
    signal MA3_pad_reg         : std_logic_vector (2 downto 0);
    signal MA4_pad_reg         : std_logic_vector (2 downto 0);
    signal MA1_uso_rst         : std_logic;
    signal MA2_uso_rst         : std_logic;
    signal MA3_uso_rst         : std_logic;
    signal MA4_uso_rst         : std_logic;
    signal MA1_data_out        : std_logic_vector (63 downto 0);
    signal MA2_data_out        : std_logic_vector (63 downto 0);
    signal MA3_data_out        : std_logic_vector (63 downto 0);
    signal MA4_data_out        : std_logic_vector (63 downto 0);
    signal app_wdf_data        : std_logic_vector (63 downto 0);
    signal app_wdf_rdy         : std_logic;
    signal app_sr_req          : std_logic;
    signal app_ref_req         : std_logic;
    signal app_zq_req          : std_logic;
    signal app_sr_active       : std_logic;
    signal app_ref_ack         : std_logic;
    signal app_zq_ack          : std_logic;
    signal ui_clk              : std_logic;
    signal ui_clk_sync_rst     : std_logic;
    signal init_calib_complete : std_logic;
    signal sys_rst             : std_logic;
    signal mult1_out           : std_logic_vector (70 downto 0);
    signal mult2_out           : std_logic_vector (70 downto 0);
    signal mult3_out           : std_logic_vector (70 downto 0);
    signal mult4_out           : std_logic_vector (70 downto 0);
    signal sum_out             : std_logic_vector (72 downto 0);
    
begin

    SYNC : sync_en_pulse
    port map ( clk    => clk,
               reset  => reset,
               en_in  => new_pulse,
               en_out => new_pulse_tmp);
    
    EN : En_Contr
    port map (clk    => clk,
              reset  => reset,
              en1    => en1,
              en2    => en2,
              en3    => en3,
              en4    => en4);
    
    PLAY_CONTR : Play_Contr_fsm
    port map (clk                 => clk,
              reset               => reset,
              pad                 => pad,
              volumen             => volumen,
              new_pulse           => new_pulse_tmp,
              act_orden           => act_orden,
              MA1_uso             => MA1_uso_reg,
              MA2_uso             => MA2_uso_reg,
              MA3_uso             => MA3_uso_reg,
              MA4_uso             => MA4_uso_reg,
              MA1_uso_out         => MA1_uso_new,
              MA2_uso_out         => MA2_uso_new,
              MA3_uso_out         => MA3_uso_new,
              MA4_uso_out         => MA4_uso_new,
              MA1_orden           => MA1_orden_reg,
              MA2_orden           => MA2_orden_reg,
              MA3_orden           => MA3_orden_reg,
              MA4_orden           => MA4_orden_reg,
              MA1_orden_out       => MA1_orden_new,
              MA2_orden_out       => MA2_orden_new,
              MA3_orden_out       => MA3_orden_new,
              MA4_orden_out       => MA4_orden_new,
              MA1_vol_out         => MA1_volumen_new,
              MA2_vol_out         => MA2_volumen_new,
              MA3_vol_out         => MA3_volumen_new,
              MA4_vol_out         => MA4_volumen_new,
              MA1_pad_out         => MA1_pad_new,
              MA2_pad_out         => MA2_pad_new,
              MA3_pad_out         => MA3_pad_new,
              MA4_pad_out         => MA4_pad_new);
    
    MA_REG : MA_Data
    port map (clk             => clk,
              reset           => reset,
              act_orden       => act_orden,
              MA1_orden_in    => MA1_orden_new,
              MA1_orden_out   => MA1_orden_reg,
              MA1_volumen_in  => MA1_volumen_new,
              MA1_volumen_out => MA1_volumen_reg,
              MA1_uso_in      => MA1_uso_new,
              MA1_uso_out     => MA1_uso_reg,
              MA1_dir_inicial => MA1_dir_inicial,
              MA1_dir_final   => MA1_dir_final,
              MA1_dir_act_in  => MA1_dir_act_new,
              MA1_pad         => MA1_pad_reg,
              MA1_uso_rst     => MA1_uso_rst,
              MA2_orden_in    => MA2_orden_new,
              MA2_orden_out   => MA2_orden_reg,
              MA2_volumen_in  => MA2_volumen_new,
              MA2_volumen_out => MA2_volumen_reg,
              MA2_uso_in      => MA2_uso_new,
              MA2_uso_out     => MA2_uso_reg,
              MA2_dir_inicial => MA2_dir_inicial,
              MA2_dir_final   => MA2_dir_final,
              MA2_dir_act_in  => MA2_dir_act_new,
              MA2_pad         => MA2_pad_reg,
              MA2_uso_rst     => MA2_uso_rst,
              MA3_orden_in    => MA3_orden_new,
              MA3_orden_out   => MA3_orden_reg,
              MA3_volumen_in  => MA3_volumen_new,
              MA3_volumen_out => MA3_volumen_reg,
              MA3_uso_in      => MA3_uso_new,
              MA3_uso_out     => MA3_uso_reg,
              MA3_dir_inicial => MA3_dir_inicial,
              MA3_dir_final   => MA3_dir_final,
              MA3_dir_act_in  => MA3_dir_act_new,
              MA3_pad         => MA3_pad_reg,
              MA3_uso_rst     => MA3_uso_rst,
              MA4_orden_in    => MA4_orden_new,
              MA4_orden_out   => MA4_orden_reg,
              MA4_volumen_in  => MA4_volumen_new,
              MA4_volumen_out => MA4_volumen_reg,
              MA4_uso_in      => MA4_uso_new,
              MA4_uso_out     => MA4_uso_reg,
              MA4_dir_inicial => MA4_dir_inicial,
              MA4_dir_final   => MA4_dir_final,
              MA4_dir_act_in  => MA4_dir_act_new,
              MA4_pad         => MA4_pad_reg,
              MA4_uso_rst     => MA4_uso_rst);
    
    DDR_FSM : FSMD_DDR2
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
              data_out          => data_out_ddr);
    
    MIG1 : mig
    port map (ddr2_dq             => dq,
              ddr2_dqs_n          => dqs_n,
              ddr2_dqs_p          => dqs,
              ddr2_addr           => addr,
              ddr2_ba             => ba,
              ddr2_ras_n          => ras_n,
              ddr2_cas_n          => cas_n,
              ddr2_we_n           => we_n,
              ddr2_ck_p           => ck,
              ddr2_ck_n           => ck_n,
              ddr2_cke            => cke,
              ddr2_cs_n           => cs_n,
              ddr2_dm             => dm_rdqs,
              ddr2_odt            => odt,
              sys_clk_i           => sys_clk_i,
              app_addr            => app_addr,
              app_cmd             => app_cmd,
              app_en              => app_en,
              app_wdf_data        => app_wdf_data,
              app_wdf_end         => app_wdf_end,
              app_wdf_mask        => app_wdf_mask,
              app_wdf_wren        => app_wdf_wren,
              app_rd_data         => app_rd_data,
              app_rd_data_end     => app_rd_data_end,
              app_rd_data_valid   => app_rd_data_valid,
              app_rdy             => app_rdy,
              app_wdf_rdy         => app_wdf_rdy,
              app_sr_req          => app_sr_req,
              app_ref_req         => app_ref_req,
              app_zq_req          => app_zq_req,
              app_sr_active       => app_sr_active,
              app_ref_ack         => app_ref_ack,
              app_zq_ack          => app_zq_ack,
              ui_clk              => ui_clk,
              ui_clk_sync_rst     => ui_clk_sync_rst,
              init_calib_complete => init_calib_complete,
              sys_rst             => sys_rst);
    
    app_sr_req <= '0';          
    app_ref_req <= '0';
    app_zq_req <= '0';
    app_wdf_data <= (others => '0');
    app_wdf_end <= '0';
    app_wdf_wren <= '0';
    sys_rst <= not reset;
    
    MA1_FSM : Mem_Acess_fsm
    port map (clk         => clk,
              reset       => reset,
              en          => en1,
              data_in     => data_out_ddr,
              data_valid  => app_rd_data_valid,
              uso         => MA1_uso_reg,
              dir_inicial => MA1_dir_inicial,
              dir_final   => MA1_dir_final,
              pad_in      => MA1_pad_new,
              pad_out     => MA1_pad_reg,
              dir_act_out => MA1_dir_act_new,
              read_req    => read_req1,
              dir_req     => addr_in1,
              uso_rst     => MA1_uso_rst,
              data_out    => MA1_data_out);
    
    MA2_FSM : Mem_Acess_fsm
    port map (clk         => clk,
              reset       => reset,
              en          => en2,
              data_in     => data_out_ddr,
              data_valid  => app_rd_data_valid,
              uso         => MA2_uso_reg,
              dir_inicial => MA2_dir_inicial,
              dir_final   => MA2_dir_final,
              pad_in      => MA2_pad_new,
              pad_out     => MA2_pad_reg,
              dir_act_out => MA2_dir_act_new,
              read_req    => read_req2,
              dir_req     => addr_in2,
              uso_rst     => MA2_uso_rst,
              data_out    => MA2_data_out);
    
    MA3_FSM : Mem_Acess_fsm
    port map (clk         => clk,
              reset       => reset,
              en          => en3,
              data_in     => data_out_ddr,
              data_valid  => app_rd_data_valid,
              uso         => MA3_uso_reg,
              dir_inicial => MA3_dir_inicial,
              dir_final   => MA3_dir_final,
              pad_in      => MA3_pad_new,
              pad_out     => MA3_pad_reg,
              dir_act_out => MA3_dir_act_new,
              read_req    => read_req3,
              dir_req     => addr_in3,
              uso_rst     => MA3_uso_rst,
              data_out    => MA3_data_out);
    
    MA4_FSM : Mem_Acess_fsm
    port map (clk         => clk,
              reset       => reset,
              en          => en4,
              data_in     => data_out_ddr,
              data_valid  => app_rd_data_valid,
              uso         => MA4_uso_reg,
              dir_inicial => MA4_dir_inicial,
              dir_final   => MA4_dir_final,
              pad_in      => MA4_pad_new,
              pad_out     => MA4_pad_reg,
              dir_act_out => MA4_dir_act_new,
              read_req    => read_req4,
              dir_req     => addr_in4,
              uso_rst     => MA4_uso_rst,
              data_out    => MA4_data_out);
    
    ADDR_DECODE : process(addr_in1, addr_in2, addr_in3, addr_in4, read_req1, read_req2, read_req3, read_req4, en1, en2, en3, en4)
    begin 
        if(en1 = '1') then
            addr_in <= addr_in1;
            read_req <= read_req1;
        elsif(en2 = '1') then
            addr_in <= addr_in2;
            read_req <= read_req2;
        elsif(en3 = '1') then
            addr_in <= addr_in3; 
            read_req <= read_req3;   
        else
            addr_in <= addr_in4;
            read_req <= read_req4;
        end if;
    end process;
    
    Mult1 : Mult
    port map (data_in  => MA1_data_out,
              volumen  => MA1_volumen_reg,
              mult_out => mult1_out);
              
    Mult2 : Mult
    port map (data_in  => MA2_data_out,
              volumen  => MA2_volumen_reg,
              mult_out => mult2_out);          
    
    Mult3 : Mult
    port map (data_in  => MA3_data_out,
              volumen  => MA3_volumen_reg,
              mult_out => mult3_out);
    
    Mult4 : Mult
    port map (data_in  => MA4_data_out,
              volumen  => MA4_volumen_reg,
              mult_out => mult4_out);
    
    Sum_Data : Sum
    port map (MA1     => mult1_out,
              MA2     => mult2_out,
              MA3     => mult3_out,
              MA4     => mult4_out,
              sum_out => sum_out);
    
    PWM_Gen : pwm
    port map (clk       => clk,
              reset     => reset,
              sample_in => sum_out,
              pwm_pulse => pwm_pulse);
    
end Behavioral;
