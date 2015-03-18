
-------------------------------------------------------------------
-- System Generator version 14.3 VHDL source file.
--
-- Copyright(C) 2012 by Xilinx, Inc.  All rights reserved.  This
-- text/file contains proprietary, confidential information of Xilinx,
-- Inc., is distributed under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
-- this text/file solely for design, simulation, implementation and
-- creation of design files limited to Xilinx devices or technologies.
-- Use with non-Xilinx devices or technologies is expressly prohibited
-- and immediately terminates your license unless covered by a separate
-- agreement.
--
-- Xilinx is providing this design, code, or information "as is" solely
-- for use in developing programs and solutions for Xilinx devices.  By
-- providing this design, code, or information as one possible
-- implementation of this feature, application or standard, Xilinx is
-- making no representation that this implementation is free from any
-- claims of infringement.  You are responsible for obtaining any rights
-- you may require for your implementation.  Xilinx expressly disclaims
-- any warranty whatsoever with respect to the adequacy of the
-- implementation, including but not limited to warranties of
-- merchantability or fitness for a particular purpose.
--
-- Xilinx products are not intended for use in life support appliances,
-- devices, or systems.  Use in such applications is expressly prohibited.
--
-- Any modifications that are made to the source code are done at the user's
-- sole risk and will be unsupported.
--
-- This copyright and support notice must be retained as part of this
-- text at all times.  (c) Copyright 1995-2012 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------

-------------------------------------------------------------------
-- System Generator version 14.3 VHDL source file.
--
-- Copyright(C) 2012 by Xilinx, Inc.  All rights reserved.  This
-- text/file contains proprietary, confidential information of Xilinx,
-- Inc., is distributed under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
-- this text/file solely for design, simulation, implementation and
-- creation of design files limited to Xilinx devices or technologies.
-- Use with non-Xilinx devices or technologies is expressly prohibited
-- and immediately terminates your license unless covered by a separate
-- agreement.
--
-- Xilinx is providing this design, code, or information "as is" solely
-- for use in developing programs and solutions for Xilinx devices.  By
-- providing this design, code, or information as one possible
-- implementation of this feature, application or standard, Xilinx is
-- making no representation that this implementation is free from any
-- claims of infringement.  You are responsible for obtaining any rights
-- you may require for your implementation.  Xilinx expressly disclaims
-- any warranty whatsoever with respect to the adequacy of the
-- implementation, including but not limited to warranties of
-- merchantability or fitness for a particular purpose.
--
-- Xilinx products are not intended for use in life support appliances,
-- devices, or systems.  Use in such applications is expressly prohibited.
--
-- Any modifications that are made to the source code are done at the user's
-- sole risk and will be unsupported.
--
-- This copyright and support notice must be retained as part of this
-- text at all times.  (c) Copyright 1995-2012 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on
entity xlclockdriver is
  generic (
    period: integer := 2;
    log_2_period: integer := 0;
    pipeline_regs: integer := 5;
    use_bufg: integer := 0
  );
  port (
    sysclk: in std_logic;
    sysclr: in std_logic;
    sysce: in std_logic;
    clk: out std_logic;
    clr: out std_logic;
    ce: out std_logic;
    ce_logic: out std_logic
  );
end xlclockdriver;
architecture behavior of xlclockdriver is
  component bufg
    port (
      i: in std_logic;
      o: out std_logic
    );
  end component;
  component synth_reg_w_init
    generic (
      width: integer;
      init_index: integer;
      init_value: bit_vector;
      latency: integer
    );
    port (
      i: in std_logic_vector(width - 1 downto 0);
      ce: in std_logic;
      clr: in std_logic;
      clk: in std_logic;
      o: out std_logic_vector(width - 1 downto 0)
    );
  end component;
  function size_of_uint(inp: integer; power_of_2: boolean)
    return integer
  is
    constant inp_vec: std_logic_vector(31 downto 0) :=
      integer_to_std_logic_vector(inp,32, xlUnsigned);
    variable result: integer;
  begin
    result := 32;
    for i in 0 to 31 loop
      if inp_vec(i) = '1' then
        result := i;
      end if;
    end loop;
    if power_of_2 then
      return result;
    else
      return result+1;
    end if;
  end;
  function is_power_of_2(inp: std_logic_vector)
    return boolean
  is
    constant width: integer := inp'length;
    variable vec: std_logic_vector(width - 1 downto 0);
    variable single_bit_set: boolean;
    variable more_than_one_bit_set: boolean;
    variable result: boolean;
  begin
    vec := inp;
    single_bit_set := false;
    more_than_one_bit_set := false;
    -- synopsys translate_off
    if (is_XorU(vec)) then
      return false;
    end if;
     -- synopsys translate_on
    if width > 0 then
      for i in 0 to width - 1 loop
        if vec(i) = '1' then
          if single_bit_set then
            more_than_one_bit_set := true;
          end if;
          single_bit_set := true;
        end if;
      end loop;
    end if;
    if (single_bit_set and not(more_than_one_bit_set)) then
      result := true;
    else
      result := false;
    end if;
    return result;
  end;
  function ce_reg_init_val(index, period : integer)
    return integer
  is
     variable result: integer;
   begin
      result := 0;
      if ((index mod period) = 0) then
          result := 1;
      end if;
      return result;
  end;
  function remaining_pipe_regs(num_pipeline_regs, period : integer)
    return integer
  is
     variable factor, result: integer;
  begin
      factor := (num_pipeline_regs / period);
      result := num_pipeline_regs - (period * factor) + 1;
      return result;
  end;

  function sg_min(L, R: INTEGER) return INTEGER is
  begin
      if L < R then
            return L;
      else
            return R;
      end if;
  end;
  constant max_pipeline_regs : integer := 8;
  constant pipe_regs : integer := 5;
  constant num_pipeline_regs : integer := sg_min(pipeline_regs, max_pipeline_regs);
  constant rem_pipeline_regs : integer := remaining_pipe_regs(num_pipeline_regs,period);
  constant period_floor: integer := max(2, period);
  constant power_of_2_counter: boolean :=
    is_power_of_2(integer_to_std_logic_vector(period_floor,32, xlUnsigned));
  constant cnt_width: integer :=
    size_of_uint(period_floor, power_of_2_counter);
  constant clk_for_ce_pulse_minus1: std_logic_vector(cnt_width - 1 downto 0) :=
    integer_to_std_logic_vector((period_floor - 2),cnt_width, xlUnsigned);
  constant clk_for_ce_pulse_minus2: std_logic_vector(cnt_width - 1 downto 0) :=
    integer_to_std_logic_vector(max(0,period - 3),cnt_width, xlUnsigned);
  constant clk_for_ce_pulse_minus_regs: std_logic_vector(cnt_width - 1 downto 0) :=
    integer_to_std_logic_vector(max(0,period - rem_pipeline_regs),cnt_width, xlUnsigned);
  signal clk_num: unsigned(cnt_width - 1 downto 0) := (others => '0');
  signal ce_vec : std_logic_vector(num_pipeline_regs downto 0);
  attribute MAX_FANOUT : string;
  attribute MAX_FANOUT of ce_vec:signal is "REDUCE";
  signal ce_vec_logic : std_logic_vector(num_pipeline_regs downto 0);
  attribute MAX_FANOUT of ce_vec_logic:signal is "REDUCE";
  signal internal_ce: std_logic_vector(0 downto 0);
  signal internal_ce_logic: std_logic_vector(0 downto 0);
  signal cnt_clr, cnt_clr_dly: std_logic_vector (0 downto 0);
begin
  clk <= sysclk;
  clr <= sysclr;
  cntr_gen: process(sysclk)
  begin
    if sysclk'event and sysclk = '1'  then
      if (sysce = '1') then
        if ((cnt_clr_dly(0) = '1') or (sysclr = '1')) then
          clk_num <= (others => '0');
        else
          clk_num <= clk_num + 1;
        end if;
    end if;
    end if;
  end process;
  clr_gen: process(clk_num, sysclr)
  begin
    if power_of_2_counter then
      cnt_clr(0) <= sysclr;
    else
      if (unsigned_to_std_logic_vector(clk_num) = clk_for_ce_pulse_minus1
          or sysclr = '1') then
        cnt_clr(0) <= '1';
      else
        cnt_clr(0) <= '0';
      end if;
    end if;
  end process;
  clr_reg: synth_reg_w_init
    generic map (
      width => 1,
      init_index => 0,
      init_value => b"0000",
      latency => 1
    )
    port map (
      i => cnt_clr,
      ce => sysce,
      clr => sysclr,
      clk => sysclk,
      o => cnt_clr_dly
    );
  pipelined_ce : if period > 1 generate
      ce_gen: process(clk_num)
      begin
          if unsigned_to_std_logic_vector(clk_num) = clk_for_ce_pulse_minus_regs then
              ce_vec(num_pipeline_regs) <= '1';
          else
              ce_vec(num_pipeline_regs) <= '0';
          end if;
      end process;
      ce_pipeline: for index in num_pipeline_regs downto 1 generate
          ce_reg : synth_reg_w_init
              generic map (
                  width => 1,
                  init_index => ce_reg_init_val(index, period),
                  init_value => b"0000",
                  latency => 1
                  )
              port map (
                  i => ce_vec(index downto index),
                  ce => sysce,
                  clr => sysclr,
                  clk => sysclk,
                  o => ce_vec(index-1 downto index-1)
                  );
      end generate;
      internal_ce <= ce_vec(0 downto 0);
  end generate;
  pipelined_ce_logic: if period > 1 generate
      ce_gen_logic: process(clk_num)
      begin
          if unsigned_to_std_logic_vector(clk_num) = clk_for_ce_pulse_minus_regs then
              ce_vec_logic(num_pipeline_regs) <= '1';
          else
              ce_vec_logic(num_pipeline_regs) <= '0';
          end if;
      end process;
      ce_logic_pipeline: for index in num_pipeline_regs downto 1 generate
          ce_logic_reg : synth_reg_w_init
              generic map (
                  width => 1,
                  init_index => ce_reg_init_val(index, period),
                  init_value => b"0000",
                  latency => 1
                  )
              port map (
                  i => ce_vec_logic(index downto index),
                  ce => sysce,
                  clr => sysclr,
                  clk => sysclk,
                  o => ce_vec_logic(index-1 downto index-1)
                  );
      end generate;
      internal_ce_logic <= ce_vec_logic(0 downto 0);
  end generate;
  use_bufg_true: if period > 1 and use_bufg = 1 generate
    ce_bufg_inst: bufg
      port map (
        i => internal_ce(0),
        o => ce
      );
    ce_bufg_inst_logic: bufg
      port map (
        i => internal_ce_logic(0),
        o => ce_logic
      );
  end generate;
  use_bufg_false: if period > 1 and (use_bufg = 0) generate
    ce <= internal_ce(0);
    ce_logic <= internal_ce_logic(0);
  end generate;
  generate_system_clk: if period = 1 generate
    ce <= sysce;
    ce_logic <= sysce;
  end generate;
end architecture behavior;

-------------------------------------------------------------------
-- System Generator version 14.3 VHDL source file.
--
-- Copyright(C) 2012 by Xilinx, Inc.  All rights reserved.  This
-- text/file contains proprietary, confidential information of Xilinx,
-- Inc., is distributed under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
-- this text/file solely for design, simulation, implementation and
-- creation of design files limited to Xilinx devices or technologies.
-- Use with non-Xilinx devices or technologies is expressly prohibited
-- and immediately terminates your license unless covered by a separate
-- agreement.
--
-- Xilinx is providing this design, code, or information "as is" solely
-- for use in developing programs and solutions for Xilinx devices.  By
-- providing this design, code, or information as one possible
-- implementation of this feature, application or standard, Xilinx is
-- making no representation that this implementation is free from any
-- claims of infringement.  You are responsible for obtaining any rights
-- you may require for your implementation.  Xilinx expressly disclaims
-- any warranty whatsoever with respect to the adequacy of the
-- implementation, including but not limited to warranties of
-- merchantability or fitness for a particular purpose.
--
-- Xilinx products are not intended for use in life support appliances,
-- devices, or systems.  Use in such applications is expressly prohibited.
--
-- Any modifications that are made to the source code are done at the user's
-- sole risk and will be unsupported.
--
-- This copyright and support notice must be retained as part of this
-- text at all times.  (c) Copyright 1995-2012 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity xland2 is
  port (
    a : in std_logic;
    b : in std_logic;
    dout : out std_logic
    );
end xland2;
architecture behavior of xland2 is
begin
    dout <= a and b;
end behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity default_clock_driver_wlan_mac_dcf_hw is
  port (
    sysce: in std_logic; 
    sysce_clr: in std_logic; 
    sysclk: in std_logic; 
    ce_1: out std_logic; 
    clk_1: out std_logic
  );
end default_clock_driver_wlan_mac_dcf_hw;

architecture structural of default_clock_driver_wlan_mac_dcf_hw is
  attribute syn_noprune: boolean;
  attribute syn_noprune of structural : architecture is true;
  attribute optimize_primitives: boolean;
  attribute optimize_primitives of structural : architecture is false;
  attribute dont_touch: boolean;
  attribute dont_touch of structural : architecture is true;

  signal sysce_clr_x0: std_logic;
  signal sysce_x0: std_logic;
  signal sysclk_x0: std_logic;
  signal xlclockdriver_1_ce: std_logic;
  signal xlclockdriver_1_clk: std_logic;

begin
  sysce_x0 <= sysce;
  sysce_clr_x0 <= sysce_clr;
  sysclk_x0 <= sysclk;
  ce_1 <= xlclockdriver_1_ce;
  clk_1 <= xlclockdriver_1_clk;

  xlclockdriver_1: entity work.xlclockdriver
    generic map (
      log_2_period => 1,
      period => 1,
      use_bufg => 0
    )
    port map (
      sysce => sysce_x0,
      sysclk => sysclk_x0,
      sysclr => sysce_clr_x0,
      ce => xlclockdriver_1_ce,
      clk => xlclockdriver_1_clk
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity plb_clock_driver_wlan_mac_dcf_hw is
  port (
    sysce: in std_logic; 
    sysce_clr: in std_logic; 
    sysclk: in std_logic; 
    plb_ce_1: out std_logic; 
    plb_clk_1: out std_logic
  );
end plb_clock_driver_wlan_mac_dcf_hw;

architecture structural of plb_clock_driver_wlan_mac_dcf_hw is
  attribute syn_noprune: boolean;
  attribute syn_noprune of structural : architecture is true;
  attribute optimize_primitives: boolean;
  attribute optimize_primitives of structural : architecture is false;
  attribute dont_touch: boolean;
  attribute dont_touch of structural : architecture is true;

  signal sysce_clr_x0: std_logic;
  signal sysce_x0: std_logic;
  signal sysclk_x0: std_logic;
  signal xlclockdriver_1_ce: std_logic;
  signal xlclockdriver_1_clk: std_logic;

begin
  sysce_x0 <= sysce;
  sysce_clr_x0 <= sysce_clr;
  sysclk_x0 <= sysclk;
  plb_ce_1 <= xlclockdriver_1_ce;
  plb_clk_1 <= xlclockdriver_1_clk;

  xlclockdriver_1: entity work.xlclockdriver
    generic map (
      log_2_period => 1,
      period => 1,
      use_bufg => 0
    )
    port map (
      sysce => sysce_x0,
      sysclk => sysclk_x0,
      sysclr => sysce_clr_x0,
      ce => xlclockdriver_1_ce,
      clk => xlclockdriver_1_clk
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity wlan_mac_dcf_hw_cw is
  port (
    axi_aresetn: in std_logic; 
    ce: in std_logic := '1'; 
    clk: in std_logic; -- clock period = 10.0 ns (100.0 Mhz)
    phy_cca_ind_busy: in std_logic; 
    phy_rx_data_byte: in std_logic_vector(7 downto 0); 
    phy_rx_data_bytenum: in std_logic_vector(13 downto 0); 
    phy_rx_data_done_ind: in std_logic; 
    phy_rx_data_ind: in std_logic; 
    phy_rx_end_ind: in std_logic; 
    phy_rx_end_rxerror: in std_logic_vector(1 downto 0); 
    phy_rx_fcs_good_ind: in std_logic; 
    phy_rx_start_ind: in std_logic; 
    phy_rx_start_phy_sel: in std_logic; 
    phy_rx_start_sig_length: in std_logic_vector(11 downto 0); 
    phy_rx_start_sig_rate: in std_logic_vector(3 downto 0); 
    phy_tx_done: in std_logic; 
    phy_tx_started: in std_logic; 
    s_axi_araddr: in std_logic_vector(31 downto 0); 
    s_axi_arburst: in std_logic_vector(1 downto 0); 
    s_axi_arcache: in std_logic_vector(3 downto 0); 
    s_axi_arid: in std_logic_vector(7 downto 0); 
    s_axi_arlen: in std_logic_vector(7 downto 0); 
    s_axi_arlock: in std_logic_vector(1 downto 0); 
    s_axi_arprot: in std_logic_vector(2 downto 0); 
    s_axi_arsize: in std_logic_vector(2 downto 0); 
    s_axi_arvalid: in std_logic; 
    s_axi_awaddr: in std_logic_vector(31 downto 0); 
    s_axi_awburst: in std_logic_vector(1 downto 0); 
    s_axi_awcache: in std_logic_vector(3 downto 0); 
    s_axi_awid: in std_logic_vector(7 downto 0); 
    s_axi_awlen: in std_logic_vector(7 downto 0); 
    s_axi_awlock: in std_logic_vector(1 downto 0); 
    s_axi_awprot: in std_logic_vector(2 downto 0); 
    s_axi_awsize: in std_logic_vector(2 downto 0); 
    s_axi_awvalid: in std_logic; 
    s_axi_bready: in std_logic; 
    s_axi_rready: in std_logic; 
    s_axi_wdata: in std_logic_vector(31 downto 0); 
    s_axi_wlast: in std_logic; 
    s_axi_wstrb: in std_logic_vector(3 downto 0); 
    s_axi_wvalid: in std_logic; 
    xps_ce: in std_logic := '1'; 
    xps_clk: in std_logic; -- clock period = 10.0 ns (100.0 Mhz)
    dbg_backoff_active: out std_logic; 
    dbg_eifs_sel: out std_logic; 
    dbg_idle_for_difs: out std_logic; 
    dbg_mpdu_tx_pending: out std_logic; 
    dbg_nav_active: out std_logic; 
    phy_rx_block_pktdet: out std_logic; 
    phy_tx_ant_mask: out std_logic_vector(3 downto 0); 
    phy_tx_gain_a: out std_logic_vector(5 downto 0); 
    phy_tx_gain_b: out std_logic_vector(5 downto 0); 
    phy_tx_gain_c: out std_logic_vector(5 downto 0); 
    phy_tx_gain_d: out std_logic_vector(5 downto 0); 
    phy_tx_pkt_buf: out std_logic_vector(3 downto 0); 
    phy_tx_start: out std_logic; 
    s_axi_arready: out std_logic; 
    s_axi_awready: out std_logic; 
    s_axi_bid: out std_logic_vector(7 downto 0); 
    s_axi_bresp: out std_logic_vector(1 downto 0); 
    s_axi_bvalid: out std_logic; 
    s_axi_rdata: out std_logic_vector(31 downto 0); 
    s_axi_rid: out std_logic_vector(7 downto 0); 
    s_axi_rlast: out std_logic; 
    s_axi_rresp: out std_logic_vector(1 downto 0); 
    s_axi_rvalid: out std_logic; 
    s_axi_wready: out std_logic; 
    timestamp_lsb: out std_logic_vector(31 downto 0); 
    timestamp_msb: out std_logic_vector(31 downto 0); 
    tx_start_timestamp_lsb: out std_logic_vector(31 downto 0); 
    tx_start_timestamp_msb: out std_logic_vector(31 downto 0)
  );
end wlan_mac_dcf_hw_cw;

architecture structural of wlan_mac_dcf_hw_cw is
  component xlpersistentdff
    port (
      clk: in std_logic; 
      d: in std_logic; 
      q: out std_logic
    );
  end component;
  attribute syn_black_box: boolean;
  attribute syn_black_box of xlpersistentdff: component is true;
  attribute box_type: string;
  attribute box_type of xlpersistentdff: component is "black_box";
  attribute syn_noprune: boolean;
  attribute optimize_primitives: boolean;
  attribute dont_touch: boolean;
  attribute syn_noprune of xlpersistentdff: component is true;
  attribute optimize_primitives of xlpersistentdff: component is false;
  attribute dont_touch of xlpersistentdff: component is true;

  signal AUTO_TX_GAINS_reg_ce: std_logic;
  signal AUTO_TX_PARAMS_reg_ce: std_logic;
  signal BACKOFF_CTRL_reg_ce: std_logic;
  signal CALIB_TIMES_reg_ce: std_logic;
  signal Control_reg_ce: std_logic;
  signal IFS_INTERVALS1_reg_ce: std_logic;
  signal IFS_INTERVALS2_reg_ce: std_logic;
  signal LATEST_RX_BYTE_reg_ce: std_logic;
  signal MPDU_TX_GAINS_reg_ce: std_logic;
  signal MPDU_TX_PARAMS_reg_ce: std_logic;
  signal NAV_VALUE_reg_ce: std_logic;
  signal RX_RATE_LENGTH_reg_ce: std_logic;
  signal RX_START_TIMESTAMP_LSB_reg_ce: std_logic;
  signal RX_START_TIMESTAMP_MSB_reg_ce: std_logic;
  signal Status_reg_ce: std_logic;
  signal TIMESTAMP_INSERT_OFFSET_reg_ce: std_logic;
  signal TIMESTAMP_LSB_reg_ce: std_logic;
  signal TIMESTAMP_MSB_reg_ce: std_logic;
  signal TIMESTAMP_SET_LSB_reg_ce: std_logic;
  signal TIMESTAMP_SET_MSB_reg_ce: std_logic;
  signal TX_START_TIMESTAMP_LSB_reg_ce: std_logic;
  signal TX_START_TIMESTAMP_MSB_reg_ce: std_logic;
  signal TX_START_reg_ce: std_logic;
  signal axi_aresetn_net: std_logic;
  signal ce_1_sg_x49: std_logic;
  attribute MAX_FANOUT: string;
  attribute MAX_FANOUT of ce_1_sg_x49: signal is "REDUCE";
  signal clkNet: std_logic;
  signal clkNet_x0: std_logic;
  signal clk_1_sg_x49: std_logic;
  signal convert5_dout_net_x1: std_logic;
  signal convert5_dout_net_x2: std_logic;
  signal data_in_net: std_logic_vector(31 downto 0);
  signal data_in_x0_net: std_logic_vector(31 downto 0);
  signal data_in_x10_net: std_logic_vector(31 downto 0);
  signal data_in_x11_net: std_logic_vector(31 downto 0);
  signal data_in_x12_net: std_logic_vector(31 downto 0);
  signal data_in_x13_net: std_logic_vector(31 downto 0);
  signal data_in_x14_net: std_logic_vector(31 downto 0);
  signal data_in_x15_net: std_logic_vector(31 downto 0);
  signal data_in_x16_net: std_logic_vector(31 downto 0);
  signal data_in_x17_net: std_logic_vector(31 downto 0);
  signal data_in_x18_net: std_logic_vector(31 downto 0);
  signal data_in_x19_net: std_logic_vector(31 downto 0);
  signal data_in_x1_net: std_logic_vector(31 downto 0);
  signal data_in_x20_net: std_logic_vector(31 downto 0);
  signal data_in_x21_net: std_logic_vector(31 downto 0);
  signal data_in_x2_net: std_logic_vector(31 downto 0);
  signal data_in_x3_net: std_logic_vector(31 downto 0);
  signal data_in_x4_net: std_logic_vector(31 downto 0);
  signal data_in_x5_net: std_logic_vector(31 downto 0);
  signal data_in_x6_net: std_logic_vector(31 downto 0);
  signal data_in_x7_net: std_logic_vector(31 downto 0);
  signal data_in_x8_net: std_logic_vector(31 downto 0);
  signal data_in_x9_net: std_logic_vector(31 downto 0);
  signal data_out_net: std_logic_vector(31 downto 0);
  signal data_out_x0_net: std_logic_vector(31 downto 0);
  signal data_out_x10_net: std_logic_vector(31 downto 0);
  signal data_out_x11_net: std_logic_vector(31 downto 0);
  signal data_out_x12_net: std_logic_vector(31 downto 0);
  signal data_out_x13_net: std_logic_vector(31 downto 0);
  signal data_out_x14_net: std_logic_vector(31 downto 0);
  signal data_out_x15_net: std_logic_vector(31 downto 0);
  signal data_out_x16_net: std_logic_vector(31 downto 0);
  signal data_out_x17_net: std_logic_vector(31 downto 0);
  signal data_out_x18_net: std_logic_vector(31 downto 0);
  signal data_out_x19_net: std_logic_vector(31 downto 0);
  signal data_out_x1_net: std_logic_vector(31 downto 0);
  signal data_out_x20_net: std_logic_vector(31 downto 0);
  signal data_out_x21_net: std_logic_vector(31 downto 0);
  signal data_out_x2_net: std_logic_vector(31 downto 0);
  signal data_out_x3_net: std_logic_vector(31 downto 0);
  signal data_out_x4_net: std_logic_vector(31 downto 0);
  signal data_out_x5_net: std_logic_vector(31 downto 0);
  signal data_out_x6_net: std_logic_vector(31 downto 0);
  signal data_out_x7_net: std_logic_vector(31 downto 0);
  signal data_out_x8_net: std_logic_vector(31 downto 0);
  signal data_out_x9_net: std_logic_vector(31 downto 0);
  signal dbg_backoff_active_net: std_logic;
  signal dbg_eifs_sel_net: std_logic;
  signal dbg_idle_for_difs_net: std_logic;
  signal dbg_mpdu_tx_pending_net: std_logic;
  signal dbg_nav_active_net: std_logic;
  signal en_net: std_logic;
  signal en_x0_net: std_logic;
  signal en_x10_net: std_logic;
  signal en_x11_net: std_logic;
  signal en_x12_net: std_logic;
  signal en_x13_net: std_logic;
  signal en_x14_net: std_logic;
  signal en_x15_net: std_logic;
  signal en_x16_net: std_logic;
  signal en_x19_net: std_logic;
  signal en_x1_net: std_logic;
  signal en_x2_net: std_logic;
  signal en_x3_net: std_logic;
  signal en_x4_net: std_logic;
  signal en_x5_net: std_logic;
  signal en_x6_net: std_logic;
  signal en_x7_net: std_logic;
  signal en_x8_net: std_logic;
  signal en_x9_net: std_logic;
  signal persistentdff_inst_q: std_logic;
  attribute syn_keep: boolean;
  attribute syn_keep of persistentdff_inst_q: signal is true;
  attribute keep: boolean;
  attribute keep of persistentdff_inst_q: signal is true;
  attribute preserve_signal: boolean;
  attribute preserve_signal of persistentdff_inst_q: signal is true;
  signal phy_cca_ind_busy_net: std_logic;
  signal phy_rx_block_pktdet_net: std_logic;
  signal phy_rx_data_byte_net: std_logic_vector(7 downto 0);
  signal phy_rx_data_bytenum_net: std_logic_vector(13 downto 0);
  signal phy_rx_data_done_ind_net: std_logic;
  signal phy_rx_data_ind_net: std_logic;
  signal phy_rx_end_ind_net: std_logic;
  signal phy_rx_end_rxerror_net: std_logic_vector(1 downto 0);
  signal phy_rx_fcs_good_ind_net: std_logic;
  signal phy_rx_start_ind_net: std_logic;
  signal phy_rx_start_phy_sel_net: std_logic;
  signal phy_rx_start_sig_length_net: std_logic_vector(11 downto 0);
  signal phy_rx_start_sig_rate_net: std_logic_vector(3 downto 0);
  signal phy_tx_ant_mask_net: std_logic_vector(3 downto 0);
  signal phy_tx_done_net: std_logic;
  signal phy_tx_gain_a_net: std_logic_vector(5 downto 0);
  signal phy_tx_gain_b_net: std_logic_vector(5 downto 0);
  signal phy_tx_gain_c_net: std_logic_vector(5 downto 0);
  signal phy_tx_gain_d_net: std_logic_vector(5 downto 0);
  signal phy_tx_pkt_buf_net: std_logic_vector(3 downto 0);
  signal phy_tx_start_net: std_logic;
  signal phy_tx_started_net: std_logic;
  signal plb_ce_1_sg_x1: std_logic;
  attribute MAX_FANOUT of plb_ce_1_sg_x1: signal is "REDUCE";
  signal plb_clk_1_sg_x1: std_logic;
  signal register15_q_net_x1: std_logic;
  signal register15_q_net_x2: std_logic;
  signal s_axi_araddr_net: std_logic_vector(31 downto 0);
  signal s_axi_arburst_net: std_logic_vector(1 downto 0);
  signal s_axi_arcache_net: std_logic_vector(3 downto 0);
  signal s_axi_arid_net: std_logic_vector(7 downto 0);
  signal s_axi_arlen_net: std_logic_vector(7 downto 0);
  signal s_axi_arlock_net: std_logic_vector(1 downto 0);
  signal s_axi_arprot_net: std_logic_vector(2 downto 0);
  signal s_axi_arready_net: std_logic;
  signal s_axi_arsize_net: std_logic_vector(2 downto 0);
  signal s_axi_arvalid_net: std_logic;
  signal s_axi_awaddr_net: std_logic_vector(31 downto 0);
  signal s_axi_awburst_net: std_logic_vector(1 downto 0);
  signal s_axi_awcache_net: std_logic_vector(3 downto 0);
  signal s_axi_awid_net: std_logic_vector(7 downto 0);
  signal s_axi_awlen_net: std_logic_vector(7 downto 0);
  signal s_axi_awlock_net: std_logic_vector(1 downto 0);
  signal s_axi_awprot_net: std_logic_vector(2 downto 0);
  signal s_axi_awready_net: std_logic;
  signal s_axi_awsize_net: std_logic_vector(2 downto 0);
  signal s_axi_awvalid_net: std_logic;
  signal s_axi_bid_net: std_logic_vector(7 downto 0);
  signal s_axi_bready_net: std_logic;
  signal s_axi_bresp_net: std_logic_vector(1 downto 0);
  signal s_axi_bvalid_net: std_logic;
  signal s_axi_rdata_net: std_logic_vector(31 downto 0);
  signal s_axi_rid_net: std_logic_vector(7 downto 0);
  signal s_axi_rlast_net: std_logic;
  signal s_axi_rready_net: std_logic;
  signal s_axi_rresp_net: std_logic_vector(1 downto 0);
  signal s_axi_rvalid_net: std_logic;
  signal s_axi_wdata_net: std_logic_vector(31 downto 0);
  signal s_axi_wlast_net: std_logic;
  signal s_axi_wready_net: std_logic;
  signal s_axi_wstrb_net: std_logic_vector(3 downto 0);
  signal s_axi_wvalid_net: std_logic;
  signal timestamp_lsb_net: std_logic_vector(31 downto 0);
  signal timestamp_msb_net: std_logic_vector(31 downto 0);
  signal tx_start_timestamp_lsb_net: std_logic_vector(31 downto 0);
  signal tx_start_timestamp_msb_net: std_logic_vector(31 downto 0);

begin
  axi_aresetn_net <= axi_aresetn;
  clkNet <= clk;
  phy_cca_ind_busy_net <= phy_cca_ind_busy;
  phy_rx_data_byte_net <= phy_rx_data_byte;
  phy_rx_data_bytenum_net <= phy_rx_data_bytenum;
  phy_rx_data_done_ind_net <= phy_rx_data_done_ind;
  phy_rx_data_ind_net <= phy_rx_data_ind;
  phy_rx_end_ind_net <= phy_rx_end_ind;
  phy_rx_end_rxerror_net <= phy_rx_end_rxerror;
  phy_rx_fcs_good_ind_net <= phy_rx_fcs_good_ind;
  phy_rx_start_ind_net <= phy_rx_start_ind;
  phy_rx_start_phy_sel_net <= phy_rx_start_phy_sel;
  phy_rx_start_sig_length_net <= phy_rx_start_sig_length;
  phy_rx_start_sig_rate_net <= phy_rx_start_sig_rate;
  phy_tx_done_net <= phy_tx_done;
  phy_tx_started_net <= phy_tx_started;
  s_axi_araddr_net <= s_axi_araddr;
  s_axi_arburst_net <= s_axi_arburst;
  s_axi_arcache_net <= s_axi_arcache;
  s_axi_arid_net <= s_axi_arid;
  s_axi_arlen_net <= s_axi_arlen;
  s_axi_arlock_net <= s_axi_arlock;
  s_axi_arprot_net <= s_axi_arprot;
  s_axi_arsize_net <= s_axi_arsize;
  s_axi_arvalid_net <= s_axi_arvalid;
  s_axi_awaddr_net <= s_axi_awaddr;
  s_axi_awburst_net <= s_axi_awburst;
  s_axi_awcache_net <= s_axi_awcache;
  s_axi_awid_net <= s_axi_awid;
  s_axi_awlen_net <= s_axi_awlen;
  s_axi_awlock_net <= s_axi_awlock;
  s_axi_awprot_net <= s_axi_awprot;
  s_axi_awsize_net <= s_axi_awsize;
  s_axi_awvalid_net <= s_axi_awvalid;
  s_axi_bready_net <= s_axi_bready;
  s_axi_rready_net <= s_axi_rready;
  s_axi_wdata_net <= s_axi_wdata;
  s_axi_wlast_net <= s_axi_wlast;
  s_axi_wstrb_net <= s_axi_wstrb;
  s_axi_wvalid_net <= s_axi_wvalid;
  clkNet_x0 <= xps_clk;
  dbg_backoff_active <= dbg_backoff_active_net;
  dbg_eifs_sel <= dbg_eifs_sel_net;
  dbg_idle_for_difs <= dbg_idle_for_difs_net;
  dbg_mpdu_tx_pending <= dbg_mpdu_tx_pending_net;
  dbg_nav_active <= dbg_nav_active_net;
  phy_rx_block_pktdet <= phy_rx_block_pktdet_net;
  phy_tx_ant_mask <= phy_tx_ant_mask_net;
  phy_tx_gain_a <= phy_tx_gain_a_net;
  phy_tx_gain_b <= phy_tx_gain_b_net;
  phy_tx_gain_c <= phy_tx_gain_c_net;
  phy_tx_gain_d <= phy_tx_gain_d_net;
  phy_tx_pkt_buf <= phy_tx_pkt_buf_net;
  phy_tx_start <= phy_tx_start_net;
  s_axi_arready <= s_axi_arready_net;
  s_axi_awready <= s_axi_awready_net;
  s_axi_bid <= s_axi_bid_net;
  s_axi_bresp <= s_axi_bresp_net;
  s_axi_bvalid <= s_axi_bvalid_net;
  s_axi_rdata <= s_axi_rdata_net;
  s_axi_rid <= s_axi_rid_net;
  s_axi_rlast <= s_axi_rlast_net;
  s_axi_rresp <= s_axi_rresp_net;
  s_axi_rvalid <= s_axi_rvalid_net;
  s_axi_wready <= s_axi_wready_net;
  timestamp_lsb <= timestamp_lsb_net;
  timestamp_msb <= timestamp_msb_net;
  tx_start_timestamp_lsb <= tx_start_timestamp_lsb_net;
  tx_start_timestamp_msb <= tx_start_timestamp_msb_net;

  AUTO_TX_GAINS: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => AUTO_TX_GAINS_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x2_net,
      o => data_out_x12_net
    );

  AUTO_TX_GAINS_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x2_net,
      dout => AUTO_TX_GAINS_reg_ce
    );

  AUTO_TX_PARAMS: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000010101010000",
      latency => 1
    )
    port map (
      ce => AUTO_TX_PARAMS_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_net,
      o => data_out_x21_net
    );

  AUTO_TX_PARAMS_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_net,
      dout => AUTO_TX_PARAMS_reg_ce
    );

  BACKOFF_CTRL: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => BACKOFF_CTRL_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x11_net,
      o => data_out_x9_net
    );

  BACKOFF_CTRL_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x11_net,
      dout => BACKOFF_CTRL_reg_ce
    );

  CALIB_TIMES: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000100000100",
      latency => 1
    )
    port map (
      ce => CALIB_TIMES_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x0_net,
      o => data_out_x20_net
    );

  CALIB_TIMES_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x0_net,
      dout => CALIB_TIMES_reg_ce
    );

  Control: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000010010",
      latency => 1
    )
    port map (
      ce => Control_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x8_net,
      o => data_out_x14_net
    );

  Control_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x8_net,
      dout => Control_reg_ce
    );

  IFS_INTERVALS1: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00010001100000000000000001011010",
      latency => 1
    )
    port map (
      ce => IFS_INTERVALS1_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x5_net,
      o => data_out_x17_net
    );

  IFS_INTERVALS1_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x5_net,
      dout => IFS_INTERVALS1_reg_ce
    );

  IFS_INTERVALS2: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000001101110000000010101100100",
      latency => 1
    )
    port map (
      ce => IFS_INTERVALS2_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x4_net,
      o => data_out_x18_net
    );

  IFS_INTERVALS2_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x4_net,
      dout => IFS_INTERVALS2_reg_ce
    );

  LATEST_RX_BYTE: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => LATEST_RX_BYTE_reg_ce,
      clk => clk_1_sg_x49,
      clr => '0',
      i => data_in_x13_net,
      o => data_out_x7_net
    );

  LATEST_RX_BYTE_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x49,
      b => en_x13_net,
      dout => LATEST_RX_BYTE_reg_ce
    );

  MPDU_TX_GAINS: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => MPDU_TX_GAINS_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x1_net,
      o => data_out_x19_net
    );

  MPDU_TX_GAINS_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x1_net,
      dout => MPDU_TX_GAINS_reg_ce
    );

  MPDU_TX_PARAMS: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000001000000000000001100000100",
      latency => 1
    )
    port map (
      ce => MPDU_TX_PARAMS_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x7_net,
      o => data_out_x15_net
    );

  MPDU_TX_PARAMS_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x7_net,
      dout => MPDU_TX_PARAMS_reg_ce
    );

  NAV_VALUE: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => NAV_VALUE_reg_ce,
      clk => clk_1_sg_x49,
      clr => '0',
      i => data_in_x19_net,
      o => data_out_x1_net
    );

  NAV_VALUE_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x49,
      b => en_x19_net,
      dout => NAV_VALUE_reg_ce
    );

  RX_RATE_LENGTH: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => RX_RATE_LENGTH_reg_ce,
      clk => clk_1_sg_x49,
      clr => '0',
      i => data_in_x16_net,
      o => data_out_x4_net
    );

  RX_RATE_LENGTH_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x49,
      b => en_x16_net,
      dout => RX_RATE_LENGTH_reg_ce
    );

  RX_START_TIMESTAMP_LSB: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => RX_START_TIMESTAMP_LSB_reg_ce,
      clk => clk_1_sg_x49,
      clr => '0',
      i => data_in_x17_net,
      o => data_out_x3_net
    );

  RX_START_TIMESTAMP_LSB_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x49,
      b => convert5_dout_net_x1,
      dout => RX_START_TIMESTAMP_LSB_reg_ce
    );

  RX_START_TIMESTAMP_MSB: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => RX_START_TIMESTAMP_MSB_reg_ce,
      clk => clk_1_sg_x49,
      clr => '0',
      i => data_in_x18_net,
      o => data_out_x2_net
    );

  RX_START_TIMESTAMP_MSB_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x49,
      b => convert5_dout_net_x2,
      dout => RX_START_TIMESTAMP_MSB_reg_ce
    );

  Status: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => Status_reg_ce,
      clk => clk_1_sg_x49,
      clr => '0',
      i => data_in_x12_net,
      o => data_out_x8_net
    );

  Status_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x49,
      b => en_x12_net,
      dout => Status_reg_ce
    );

  TIMESTAMP_INSERT_OFFSET: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => TIMESTAMP_INSERT_OFFSET_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x3_net,
      o => data_out_x13_net
    );

  TIMESTAMP_INSERT_OFFSET_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x3_net,
      dout => TIMESTAMP_INSERT_OFFSET_reg_ce
    );

  TIMESTAMP_LSB_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x49,
      b => en_x14_net,
      dout => TIMESTAMP_LSB_reg_ce
    );

  TIMESTAMP_LSB_x0: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => TIMESTAMP_LSB_reg_ce,
      clk => clk_1_sg_x49,
      clr => '0',
      i => data_in_x14_net,
      o => data_out_x6_net
    );

  TIMESTAMP_MSB_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x49,
      b => en_x15_net,
      dout => TIMESTAMP_MSB_reg_ce
    );

  TIMESTAMP_MSB_x0: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => TIMESTAMP_MSB_reg_ce,
      clk => clk_1_sg_x49,
      clr => '0',
      i => data_in_x15_net,
      o => data_out_x5_net
    );

  TIMESTAMP_SET_LSB: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => TIMESTAMP_SET_LSB_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x9_net,
      o => data_out_x11_net
    );

  TIMESTAMP_SET_LSB_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x9_net,
      dout => TIMESTAMP_SET_LSB_reg_ce
    );

  TIMESTAMP_SET_MSB: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => TIMESTAMP_SET_MSB_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x10_net,
      o => data_out_x10_net
    );

  TIMESTAMP_SET_MSB_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x10_net,
      dout => TIMESTAMP_SET_MSB_reg_ce
    );

  TX_START: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => TX_START_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x6_net,
      o => data_out_x16_net
    );

  TX_START_TIMESTAMP_LSB_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x49,
      b => register15_q_net_x1,
      dout => TX_START_TIMESTAMP_LSB_reg_ce
    );

  TX_START_TIMESTAMP_LSB_x0: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => TX_START_TIMESTAMP_LSB_reg_ce,
      clk => clk_1_sg_x49,
      clr => '0',
      i => data_in_x20_net,
      o => data_out_x0_net
    );

  TX_START_TIMESTAMP_MSB_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x49,
      b => register15_q_net_x2,
      dout => TX_START_TIMESTAMP_MSB_reg_ce
    );

  TX_START_TIMESTAMP_MSB_x0: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => TX_START_TIMESTAMP_MSB_reg_ce,
      clk => clk_1_sg_x49,
      clr => '0',
      i => data_in_x21_net,
      o => data_out_net
    );

  TX_START_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x6_net,
      dout => TX_START_reg_ce
    );

  default_clock_driver_wlan_mac_dcf_hw_x0: entity work.default_clock_driver_wlan_mac_dcf_hw
    port map (
      sysce => '1',
      sysce_clr => '0',
      sysclk => clkNet,
      ce_1 => ce_1_sg_x49,
      clk_1 => clk_1_sg_x49
    );

  persistentdff_inst: xlpersistentdff
    port map (
      clk => clkNet,
      d => persistentdff_inst_q,
      q => persistentdff_inst_q
    );

  plb_clock_driver_wlan_mac_dcf_hw_x0: entity work.plb_clock_driver_wlan_mac_dcf_hw
    port map (
      sysce => '1',
      sysce_clr => '0',
      sysclk => clkNet_x0,
      plb_ce_1 => plb_ce_1_sg_x1,
      plb_clk_1 => plb_clk_1_sg_x1
    );

  wlan_mac_dcf_hw_x0: entity work.wlan_mac_dcf_hw
    port map (
      axi_aresetn => axi_aresetn_net,
      ce_1 => ce_1_sg_x49,
      clk_1 => clk_1_sg_x49,
      data_out => data_out_net,
      data_out_x0 => data_out_x0_net,
      data_out_x1 => data_out_x1_net,
      data_out_x10 => data_out_x10_net,
      data_out_x11 => data_out_x11_net,
      data_out_x12 => data_out_x12_net,
      data_out_x13 => data_out_x13_net,
      data_out_x14 => data_out_x14_net,
      data_out_x15 => data_out_x15_net,
      data_out_x16 => data_out_x16_net,
      data_out_x17 => data_out_x17_net,
      data_out_x18 => data_out_x18_net,
      data_out_x19 => data_out_x19_net,
      data_out_x2 => data_out_x2_net,
      data_out_x20 => data_out_x20_net,
      data_out_x21 => data_out_x21_net,
      data_out_x3 => data_out_x3_net,
      data_out_x4 => data_out_x4_net,
      data_out_x5 => data_out_x5_net,
      data_out_x6 => data_out_x6_net,
      data_out_x7 => data_out_x7_net,
      data_out_x8 => data_out_x8_net,
      data_out_x9 => data_out_x9_net,
      dout => data_out_x21_net,
      dout_x0 => data_out_x20_net,
      dout_x1 => data_out_x19_net,
      dout_x10 => data_out_x10_net,
      dout_x11 => data_out_x9_net,
      dout_x2 => data_out_x12_net,
      dout_x3 => data_out_x13_net,
      dout_x4 => data_out_x18_net,
      dout_x5 => data_out_x17_net,
      dout_x6 => data_out_x16_net,
      dout_x7 => data_out_x15_net,
      dout_x8 => data_out_x14_net,
      dout_x9 => data_out_x11_net,
      phy_cca_ind_busy => phy_cca_ind_busy_net,
      phy_rx_data_byte => phy_rx_data_byte_net,
      phy_rx_data_bytenum => phy_rx_data_bytenum_net,
      phy_rx_data_done_ind => phy_rx_data_done_ind_net,
      phy_rx_data_ind => phy_rx_data_ind_net,
      phy_rx_end_ind => phy_rx_end_ind_net,
      phy_rx_end_rxerror => phy_rx_end_rxerror_net,
      phy_rx_fcs_good_ind => phy_rx_fcs_good_ind_net,
      phy_rx_start_ind => phy_rx_start_ind_net,
      phy_rx_start_phy_sel => phy_rx_start_phy_sel_net,
      phy_rx_start_sig_length => phy_rx_start_sig_length_net,
      phy_rx_start_sig_rate => phy_rx_start_sig_rate_net,
      phy_tx_done => phy_tx_done_net,
      phy_tx_started => phy_tx_started_net,
      plb_ce_1 => plb_ce_1_sg_x1,
      plb_clk_1 => plb_clk_1_sg_x1,
      s_axi_araddr => s_axi_araddr_net,
      s_axi_arburst => s_axi_arburst_net,
      s_axi_arcache => s_axi_arcache_net,
      s_axi_arid => s_axi_arid_net,
      s_axi_arlen => s_axi_arlen_net,
      s_axi_arlock => s_axi_arlock_net,
      s_axi_arprot => s_axi_arprot_net,
      s_axi_arsize => s_axi_arsize_net,
      s_axi_arvalid => s_axi_arvalid_net,
      s_axi_awaddr => s_axi_awaddr_net,
      s_axi_awburst => s_axi_awburst_net,
      s_axi_awcache => s_axi_awcache_net,
      s_axi_awid => s_axi_awid_net,
      s_axi_awlen => s_axi_awlen_net,
      s_axi_awlock => s_axi_awlock_net,
      s_axi_awprot => s_axi_awprot_net,
      s_axi_awsize => s_axi_awsize_net,
      s_axi_awvalid => s_axi_awvalid_net,
      s_axi_bready => s_axi_bready_net,
      s_axi_rready => s_axi_rready_net,
      s_axi_wdata => s_axi_wdata_net,
      s_axi_wlast => s_axi_wlast_net,
      s_axi_wstrb => s_axi_wstrb_net,
      s_axi_wvalid => s_axi_wvalid_net,
      data_in => data_in_net,
      data_in_x0 => data_in_x0_net,
      data_in_x1 => data_in_x1_net,
      data_in_x10 => data_in_x10_net,
      data_in_x11 => data_in_x11_net,
      data_in_x12 => data_in_x12_net,
      data_in_x13 => data_in_x13_net,
      data_in_x14 => data_in_x14_net,
      data_in_x15 => data_in_x15_net,
      data_in_x16 => data_in_x16_net,
      data_in_x17 => data_in_x17_net,
      data_in_x18 => data_in_x18_net,
      data_in_x19 => data_in_x19_net,
      data_in_x2 => data_in_x2_net,
      data_in_x20 => data_in_x20_net,
      data_in_x21 => data_in_x21_net,
      data_in_x3 => data_in_x3_net,
      data_in_x4 => data_in_x4_net,
      data_in_x5 => data_in_x5_net,
      data_in_x6 => data_in_x6_net,
      data_in_x7 => data_in_x7_net,
      data_in_x8 => data_in_x8_net,
      data_in_x9 => data_in_x9_net,
      dbg_backoff_active => dbg_backoff_active_net,
      dbg_eifs_sel => dbg_eifs_sel_net,
      dbg_idle_for_difs => dbg_idle_for_difs_net,
      dbg_mpdu_tx_pending => dbg_mpdu_tx_pending_net,
      dbg_nav_active => dbg_nav_active_net,
      en => en_net,
      en_x0 => en_x0_net,
      en_x1 => en_x1_net,
      en_x10 => en_x10_net,
      en_x11 => en_x11_net,
      en_x12 => en_x12_net,
      en_x13 => en_x13_net,
      en_x14 => en_x14_net,
      en_x15 => en_x15_net,
      en_x16 => en_x16_net,
      en_x17 => convert5_dout_net_x1,
      en_x18 => convert5_dout_net_x2,
      en_x19 => en_x19_net,
      en_x2 => en_x2_net,
      en_x20 => register15_q_net_x1,
      en_x21 => register15_q_net_x2,
      en_x3 => en_x3_net,
      en_x4 => en_x4_net,
      en_x5 => en_x5_net,
      en_x6 => en_x6_net,
      en_x7 => en_x7_net,
      en_x8 => en_x8_net,
      en_x9 => en_x9_net,
      phy_rx_block_pktdet => phy_rx_block_pktdet_net,
      phy_tx_ant_mask => phy_tx_ant_mask_net,
      phy_tx_gain_a => phy_tx_gain_a_net,
      phy_tx_gain_b => phy_tx_gain_b_net,
      phy_tx_gain_c => phy_tx_gain_c_net,
      phy_tx_gain_d => phy_tx_gain_d_net,
      phy_tx_pkt_buf => phy_tx_pkt_buf_net,
      phy_tx_start => phy_tx_start_net,
      s_axi_arready => s_axi_arready_net,
      s_axi_awready => s_axi_awready_net,
      s_axi_bid => s_axi_bid_net,
      s_axi_bresp => s_axi_bresp_net,
      s_axi_bvalid => s_axi_bvalid_net,
      s_axi_rdata => s_axi_rdata_net,
      s_axi_rid => s_axi_rid_net,
      s_axi_rlast => s_axi_rlast_net,
      s_axi_rresp => s_axi_rresp_net,
      s_axi_rvalid => s_axi_rvalid_net,
      s_axi_wready => s_axi_wready_net,
      timestamp_lsb => timestamp_lsb_net,
      timestamp_msb => timestamp_msb_net,
      tx_start_timestamp_lsb => tx_start_timestamp_lsb_net,
      tx_start_timestamp_msb => tx_start_timestamp_msb_net
    );

end structural;
