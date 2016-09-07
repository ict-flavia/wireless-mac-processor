
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

entity default_clock_driver_wlan_phy_rx_pmd is
  port (
    sysce: in std_logic; 
    sysce_clr: in std_logic; 
    sysclk: in std_logic; 
    ce_1: out std_logic; 
    ce_16: out std_logic; 
    ce_4: out std_logic; 
    ce_64: out std_logic; 
    ce_8: out std_logic; 
    ce_logic_8: out std_logic; 
    clk_1: out std_logic; 
    clk_16: out std_logic; 
    clk_4: out std_logic; 
    clk_64: out std_logic; 
    clk_8: out std_logic
  );
end default_clock_driver_wlan_phy_rx_pmd;

architecture structural of default_clock_driver_wlan_phy_rx_pmd is
  attribute syn_noprune: boolean;
  attribute syn_noprune of structural : architecture is true;
  attribute optimize_primitives: boolean;
  attribute optimize_primitives of structural : architecture is false;
  attribute dont_touch: boolean;
  attribute dont_touch of structural : architecture is true;

  signal sysce_clr_x0: std_logic;
  signal sysce_x0: std_logic;
  signal sysclk_x0: std_logic;
  signal xlclockdriver_16_ce: std_logic;
  signal xlclockdriver_16_clk: std_logic;
  signal xlclockdriver_1_ce: std_logic;
  signal xlclockdriver_1_clk: std_logic;
  signal xlclockdriver_4_ce: std_logic;
  signal xlclockdriver_4_clk: std_logic;
  signal xlclockdriver_64_ce: std_logic;
  signal xlclockdriver_64_clk: std_logic;
  signal xlclockdriver_8_ce: std_logic;
  signal xlclockdriver_8_ce_logic: std_logic;
  signal xlclockdriver_8_clk: std_logic;

begin
  sysce_x0 <= sysce;
  sysce_clr_x0 <= sysce_clr;
  sysclk_x0 <= sysclk;
  ce_1 <= xlclockdriver_1_ce;
  ce_16 <= xlclockdriver_16_ce;
  ce_4 <= xlclockdriver_4_ce;
  ce_64 <= xlclockdriver_64_ce;
  ce_8 <= xlclockdriver_8_ce;
  ce_logic_8 <= xlclockdriver_8_ce_logic;
  clk_1 <= xlclockdriver_1_clk;
  clk_16 <= xlclockdriver_16_clk;
  clk_4 <= xlclockdriver_4_clk;
  clk_64 <= xlclockdriver_64_clk;
  clk_8 <= xlclockdriver_8_clk;

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

  xlclockdriver_16: entity work.xlclockdriver
    generic map (
      log_2_period => 5,
      period => 16,
      use_bufg => 0
    )
    port map (
      sysce => sysce_x0,
      sysclk => sysclk_x0,
      sysclr => sysce_clr_x0,
      ce => xlclockdriver_16_ce,
      clk => xlclockdriver_16_clk
    );

  xlclockdriver_4: entity work.xlclockdriver
    generic map (
      log_2_period => 3,
      period => 4,
      use_bufg => 0
    )
    port map (
      sysce => sysce_x0,
      sysclk => sysclk_x0,
      sysclr => sysce_clr_x0,
      ce => xlclockdriver_4_ce,
      clk => xlclockdriver_4_clk
    );

  xlclockdriver_64: entity work.xlclockdriver
    generic map (
      log_2_period => 7,
      period => 64,
      use_bufg => 0
    )
    port map (
      sysce => sysce_x0,
      sysclk => sysclk_x0,
      sysclr => sysce_clr_x0,
      ce => xlclockdriver_64_ce,
      clk => xlclockdriver_64_clk
    );

  xlclockdriver_8: entity work.xlclockdriver
    generic map (
      log_2_period => 4,
      period => 8,
      use_bufg => 0
    )
    port map (
      sysce => sysce_x0,
      sysclk => sysclk_x0,
      sysclr => sysce_clr_x0,
      ce => xlclockdriver_8_ce,
      ce_logic => xlclockdriver_8_ce_logic,
      clk => xlclockdriver_8_clk
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity plb_clock_driver_wlan_phy_rx_pmd is
  port (
    sysce: in std_logic; 
    sysce_clr: in std_logic; 
    sysclk: in std_logic; 
    plb_ce_1: out std_logic; 
    plb_clk_1: out std_logic
  );
end plb_clock_driver_wlan_phy_rx_pmd;

architecture structural of plb_clock_driver_wlan_phy_rx_pmd is
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

entity wlan_phy_rx_pmd_cw is
  port (
    adc_rx_clk: in std_logic; 
    agc_done: in std_logic; 
    axi_aresetn: in std_logic; 
    bram_din: in std_logic_vector(63 downto 0); 
    ce: in std_logic := '1'; 
    clk: in std_logic; -- clock period = 6.25 ns (160.0 Mhz)
    phy_rx_block_pktdet: in std_logic; 
    pkt_det_in: in std_logic; 
    rfa_g_bb: in std_logic_vector(4 downto 0); 
    rfa_g_rf: in std_logic_vector(1 downto 0); 
    rfa_rssi: in std_logic_vector(9 downto 0); 
    rfa_rx_i: in std_logic_vector(15 downto 0); 
    rfa_rx_q: in std_logic_vector(15 downto 0); 
    rfb_g_bb: in std_logic_vector(4 downto 0); 
    rfb_g_rf: in std_logic_vector(1 downto 0); 
    rfb_rssi: in std_logic_vector(9 downto 0); 
    rfb_rx_i: in std_logic_vector(15 downto 0); 
    rfb_rx_q: in std_logic_vector(15 downto 0); 
    rfc_g_bb: in std_logic_vector(4 downto 0); 
    rfc_g_rf: in std_logic_vector(1 downto 0); 
    rfc_rssi: in std_logic_vector(9 downto 0); 
    rfc_rx_i: in std_logic_vector(15 downto 0); 
    rfc_rx_q: in std_logic_vector(15 downto 0); 
    rfd_g_bb: in std_logic_vector(4 downto 0); 
    rfd_g_rf: in std_logic_vector(1 downto 0); 
    rfd_rssi: in std_logic_vector(9 downto 0); 
    rfd_rx_i: in std_logic_vector(15 downto 0); 
    rfd_rx_q: in std_logic_vector(15 downto 0); 
    rx_sigs_invalid: in std_logic; 
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
    xps_clk: in std_logic; -- clock period = 6.25 ns (160.0 Mhz)
    bram_addr: out std_logic_vector(31 downto 0); 
    bram_dout: out std_logic_vector(63 downto 0); 
    bram_en: out std_logic; 
    bram_reset: out std_logic; 
    bram_wen: out std_logic_vector(7 downto 0); 
    dbg_dsss_rx_active: out std_logic; 
    dbg_eq_i: out std_logic_vector(13 downto 0); 
    dbg_eq_q: out std_logic_vector(13 downto 0); 
    dbg_fcs_good: out std_logic; 
    dbg_gpio: out std_logic_vector(7 downto 0); 
    dbg_lts_timeout: out std_logic; 
    dbg_payload: out std_logic; 
    dbg_pkt_det_dsss: out std_logic; 
    dbg_pkt_det_ofdm: out std_logic; 
    dbg_rssi_det: out std_logic; 
    dbg_signal_err_disp: out std_logic_vector(3 downto 0); 
    lts_sync: out std_logic; 
    phy_cca_ind_busy: out std_logic; 
    phy_rx_data_byte: out std_logic_vector(7 downto 0); 
    phy_rx_data_bytenum: out std_logic_vector(13 downto 0); 
    phy_rx_data_done_ind: out std_logic; 
    phy_rx_data_ind: out std_logic; 
    phy_rx_end_ind: out std_logic; 
    phy_rx_end_rxerror: out std_logic_vector(1 downto 0); 
    phy_rx_fcs_good_ind: out std_logic; 
    phy_rx_start_ind: out std_logic; 
    phy_rx_start_phy_sel: out std_logic; 
    phy_rx_start_sig_length: out std_logic_vector(11 downto 0); 
    phy_rx_start_sig_rate: out std_logic_vector(3 downto 0); 
    pkt_det_o: out std_logic; 
    rssi_adc_clk: out std_logic; 
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
    s_axi_wready: out std_logic
  );
end wlan_phy_rx_pmd_cw;

architecture structural of wlan_phy_rx_pmd_cw is
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

  signal CONFIG_reg_ce: std_logic;
  signal Control_reg_ce: std_logic;
  signal DEBUG_GPIO_reg_ce: std_logic;
  signal DSSS_RX_CONFIG_reg_ce: std_logic;
  signal FEC_CONFIG_reg_ce: std_logic;
  signal FFT_Config_reg_ce: std_logic;
  signal LTS_Corr_Config_reg_ce: std_logic;
  signal LTS_Corr_Thresh_reg_ce: std_logic;
  signal PHY_CCA_CONFIG_reg_ce: std_logic;
  signal PKTBUF_MAX_WRITE_ADDR_reg_ce: std_logic;
  signal PKTDET_AUTOCORR_CONFIG_reg_ce: std_logic;
  signal PKTDET_DSSS_CONFIG_reg_ce: std_logic;
  signal PKTDET_RSSI_CONFIG_reg_ce: std_logic;
  signal PKT_BUF_SEL_reg_ce: std_logic;
  signal RSSI_THRESH_reg_ce: std_logic;
  signal RX_PKT_AGC_GAINS_reg_ce: std_logic;
  signal RX_PKT_RSSI_AB_reg_ce: std_logic;
  signal RX_PKT_RSSI_CD_reg_ce: std_logic;
  signal Status_reg_ce: std_logic;
  signal adc_rx_clk_net: std_logic;
  signal agc_done_net: std_logic;
  signal axi_aresetn_net: std_logic;
  signal bram_addr_net: std_logic_vector(31 downto 0);
  signal bram_din_net: std_logic_vector(63 downto 0);
  signal bram_dout_net: std_logic_vector(63 downto 0);
  signal bram_en_net: std_logic;
  signal bram_reset_net: std_logic;
  signal bram_wen_net: std_logic_vector(7 downto 0);
  signal ce_16_sg_x37: std_logic;
  attribute MAX_FANOUT: string;
  attribute MAX_FANOUT of ce_16_sg_x37: signal is "REDUCE";
  signal ce_1_sg_x303: std_logic;
  attribute MAX_FANOUT of ce_1_sg_x303: signal is "REDUCE";
  signal ce_4_sg_x4: std_logic;
  attribute MAX_FANOUT of ce_4_sg_x4: signal is "REDUCE";
  signal ce_64_sg_x3: std_logic;
  attribute MAX_FANOUT of ce_64_sg_x3: signal is "REDUCE";
  signal ce_8_sg_x29: std_logic;
  attribute MAX_FANOUT of ce_8_sg_x29: signal is "REDUCE";
  signal ce_logic_8_sg_x2: std_logic;
  signal clkNet: std_logic;
  signal clkNet_x0: std_logic;
  signal clk_16_sg_x37: std_logic;
  signal clk_1_sg_x303: std_logic;
  signal clk_4_sg_x4: std_logic;
  signal clk_64_sg_x3: std_logic;
  signal clk_8_sg_x29: std_logic;
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
  signal data_in_x1_net: std_logic_vector(31 downto 0);
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
  signal data_out_x1_net: std_logic_vector(31 downto 0);
  signal data_out_x2_net: std_logic_vector(31 downto 0);
  signal data_out_x3_net: std_logic_vector(31 downto 0);
  signal data_out_x4_net: std_logic_vector(31 downto 0);
  signal data_out_x5_net: std_logic_vector(31 downto 0);
  signal data_out_x6_net: std_logic_vector(31 downto 0);
  signal data_out_x7_net: std_logic_vector(31 downto 0);
  signal data_out_x8_net: std_logic_vector(31 downto 0);
  signal data_out_x9_net: std_logic_vector(31 downto 0);
  signal dbg_dsss_rx_active_net: std_logic;
  signal dbg_eq_i_net: std_logic_vector(13 downto 0);
  signal dbg_eq_q_net: std_logic_vector(13 downto 0);
  signal dbg_fcs_good_net: std_logic;
  signal dbg_gpio_net: std_logic_vector(7 downto 0);
  signal dbg_lts_timeout_net: std_logic;
  signal dbg_payload_net: std_logic;
  signal dbg_pkt_det_dsss_net: std_logic;
  signal dbg_pkt_det_ofdm_net: std_logic;
  signal dbg_rssi_det_net: std_logic;
  signal dbg_signal_err_disp_net: std_logic_vector(3 downto 0);
  signal en_net: std_logic;
  signal en_x0_net: std_logic;
  signal en_x10_net: std_logic;
  signal en_x11_net: std_logic;
  signal en_x12_net: std_logic;
  signal en_x13_net: std_logic;
  signal en_x14_net: std_logic;
  signal en_x15_net: std_logic;
  signal en_x16_net: std_logic;
  signal en_x17_net: std_logic;
  signal en_x1_net: std_logic;
  signal en_x2_net: std_logic;
  signal en_x3_net: std_logic;
  signal en_x4_net: std_logic;
  signal en_x5_net: std_logic;
  signal en_x6_net: std_logic;
  signal en_x7_net: std_logic;
  signal en_x8_net: std_logic;
  signal en_x9_net: std_logic;
  signal lts_sync_net: std_logic;
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
  signal pkt_det_in_net: std_logic;
  signal pkt_det_o_net: std_logic;
  signal plb_ce_1_sg_x1: std_logic;
  attribute MAX_FANOUT of plb_ce_1_sg_x1: signal is "REDUCE";
  signal plb_clk_1_sg_x1: std_logic;
  signal rfa_g_bb_net: std_logic_vector(4 downto 0);
  signal rfa_g_rf_net: std_logic_vector(1 downto 0);
  signal rfa_rssi_net: std_logic_vector(9 downto 0);
  signal rfa_rx_i_net: std_logic_vector(15 downto 0);
  signal rfa_rx_q_net: std_logic_vector(15 downto 0);
  signal rfb_g_bb_net: std_logic_vector(4 downto 0);
  signal rfb_g_rf_net: std_logic_vector(1 downto 0);
  signal rfb_rssi_net: std_logic_vector(9 downto 0);
  signal rfb_rx_i_net: std_logic_vector(15 downto 0);
  signal rfb_rx_q_net: std_logic_vector(15 downto 0);
  signal rfc_g_bb_net: std_logic_vector(4 downto 0);
  signal rfc_g_rf_net: std_logic_vector(1 downto 0);
  signal rfc_rssi_net: std_logic_vector(9 downto 0);
  signal rfc_rx_i_net: std_logic_vector(15 downto 0);
  signal rfc_rx_q_net: std_logic_vector(15 downto 0);
  signal rfd_g_bb_net: std_logic_vector(4 downto 0);
  signal rfd_g_rf_net: std_logic_vector(1 downto 0);
  signal rfd_rssi_net: std_logic_vector(9 downto 0);
  signal rfd_rx_i_net: std_logic_vector(15 downto 0);
  signal rfd_rx_q_net: std_logic_vector(15 downto 0);
  signal rssi_adc_clk_net: std_logic;
  signal rx_sigs_invalid_net: std_logic;
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

begin
  adc_rx_clk_net <= adc_rx_clk;
  agc_done_net <= agc_done;
  axi_aresetn_net <= axi_aresetn;
  bram_din_net <= bram_din;
  clkNet <= clk;
  phy_rx_block_pktdet_net <= phy_rx_block_pktdet;
  pkt_det_in_net <= pkt_det_in;
  rfa_g_bb_net <= rfa_g_bb;
  rfa_g_rf_net <= rfa_g_rf;
  rfa_rssi_net <= rfa_rssi;
  rfa_rx_i_net <= rfa_rx_i;
  rfa_rx_q_net <= rfa_rx_q;
  rfb_g_bb_net <= rfb_g_bb;
  rfb_g_rf_net <= rfb_g_rf;
  rfb_rssi_net <= rfb_rssi;
  rfb_rx_i_net <= rfb_rx_i;
  rfb_rx_q_net <= rfb_rx_q;
  rfc_g_bb_net <= rfc_g_bb;
  rfc_g_rf_net <= rfc_g_rf;
  rfc_rssi_net <= rfc_rssi;
  rfc_rx_i_net <= rfc_rx_i;
  rfc_rx_q_net <= rfc_rx_q;
  rfd_g_bb_net <= rfd_g_bb;
  rfd_g_rf_net <= rfd_g_rf;
  rfd_rssi_net <= rfd_rssi;
  rfd_rx_i_net <= rfd_rx_i;
  rfd_rx_q_net <= rfd_rx_q;
  rx_sigs_invalid_net <= rx_sigs_invalid;
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
  bram_addr <= bram_addr_net;
  bram_dout <= bram_dout_net;
  bram_en <= bram_en_net;
  bram_reset <= bram_reset_net;
  bram_wen <= bram_wen_net;
  dbg_dsss_rx_active <= dbg_dsss_rx_active_net;
  dbg_eq_i <= dbg_eq_i_net;
  dbg_eq_q <= dbg_eq_q_net;
  dbg_fcs_good <= dbg_fcs_good_net;
  dbg_gpio <= dbg_gpio_net;
  dbg_lts_timeout <= dbg_lts_timeout_net;
  dbg_payload <= dbg_payload_net;
  dbg_pkt_det_dsss <= dbg_pkt_det_dsss_net;
  dbg_pkt_det_ofdm <= dbg_pkt_det_ofdm_net;
  dbg_rssi_det <= dbg_rssi_det_net;
  dbg_signal_err_disp <= dbg_signal_err_disp_net;
  lts_sync <= lts_sync_net;
  phy_cca_ind_busy <= phy_cca_ind_busy_net;
  phy_rx_data_byte <= phy_rx_data_byte_net;
  phy_rx_data_bytenum <= phy_rx_data_bytenum_net;
  phy_rx_data_done_ind <= phy_rx_data_done_ind_net;
  phy_rx_data_ind <= phy_rx_data_ind_net;
  phy_rx_end_ind <= phy_rx_end_ind_net;
  phy_rx_end_rxerror <= phy_rx_end_rxerror_net;
  phy_rx_fcs_good_ind <= phy_rx_fcs_good_ind_net;
  phy_rx_start_ind <= phy_rx_start_ind_net;
  phy_rx_start_phy_sel <= phy_rx_start_phy_sel_net;
  phy_rx_start_sig_length <= phy_rx_start_sig_length_net;
  phy_rx_start_sig_rate <= phy_rx_start_sig_rate_net;
  pkt_det_o <= pkt_det_o_net;
  rssi_adc_clk <= rssi_adc_clk_net;
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

  CONFIG_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x1_net,
      dout => CONFIG_reg_ce
    );

  CONFIG_x0: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000001000000001101011111",
      latency => 1
    )
    port map (
      ce => CONFIG_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x1_net,
      o => data_out_x14_net
    );

  Control: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => Control_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x6_net,
      o => data_out_x9_net
    );

  Control_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x6_net,
      dout => Control_reg_ce
    );

  DEBUG_GPIO: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => DEBUG_GPIO_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_net,
      o => data_out_x16_net
    );

  DEBUG_GPIO_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_net,
      dout => DEBUG_GPIO_reg_ce
    );

  DSSS_RX_CONFIG: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"10001100000000000111000000100000",
      latency => 1
    )
    port map (
      ce => DSSS_RX_CONFIG_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x2_net,
      o => data_out_x13_net
    );

  DSSS_RX_CONFIG_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x2_net,
      dout => DSSS_RX_CONFIG_reg_ce
    );

  FEC_CONFIG: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000100001000000110",
      latency => 1
    )
    port map (
      ce => FEC_CONFIG_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x5_net,
      o => data_out_x10_net
    );

  FEC_CONFIG_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x5_net,
      dout => FEC_CONFIG_reg_ce
    );

  FFT_Config: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000101000000110001000001000000",
      latency => 1
    )
    port map (
      ce => FFT_Config_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x12_net,
      o => data_out_x4_net
    );

  FFT_Config_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x12_net,
      dout => FFT_Config_reg_ce
    );

  LTS_Corr_Config: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000011001000000011111010",
      latency => 1
    )
    port map (
      ce => LTS_Corr_Config_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x9_net,
      o => data_out_x6_net
    );

  LTS_Corr_Config_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x9_net,
      dout => LTS_Corr_Config_reg_ce
    );

  LTS_Corr_Thresh: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00100111000100000010011100010000",
      latency => 1
    )
    port map (
      ce => LTS_Corr_Thresh_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x7_net,
      o => data_out_x8_net
    );

  LTS_Corr_Thresh_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x7_net,
      dout => LTS_Corr_Thresh_reg_ce
    );

  PHY_CCA_CONFIG: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000011110000000100101100000",
      latency => 1
    )
    port map (
      ce => PHY_CCA_CONFIG_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x10_net,
      o => data_out_x5_net
    );

  PHY_CCA_CONFIG_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x10_net,
      dout => PHY_CCA_CONFIG_reg_ce
    );

  PKTBUF_MAX_WRITE_ADDR: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000111011011000",
      latency => 1
    )
    port map (
      ce => PKTBUF_MAX_WRITE_ADDR_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x11_net,
      o => data_out_x17_net
    );

  PKTBUF_MAX_WRITE_ADDR_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x11_net,
      dout => PKTBUF_MAX_WRITE_ADDR_reg_ce
    );

  PKTDET_AUTOCORR_CONFIG: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"11111101000000000000000111000000",
      latency => 1
    )
    port map (
      ce => PKTDET_AUTOCORR_CONFIG_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x4_net,
      o => data_out_x11_net
    );

  PKTDET_AUTOCORR_CONFIG_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x4_net,
      dout => PKTDET_AUTOCORR_CONFIG_reg_ce
    );

  PKTDET_DSSS_CONFIG: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"01010000011110011001000001100000",
      latency => 1
    )
    port map (
      ce => PKTDET_DSSS_CONFIG_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x8_net,
      o => data_out_x7_net
    );

  PKTDET_DSSS_CONFIG_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x8_net,
      dout => PKTDET_DSSS_CONFIG_reg_ce
    );

  PKTDET_RSSI_CONFIG: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000010000010010110000001000",
      latency => 1
    )
    port map (
      ce => PKTDET_RSSI_CONFIG_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x13_net,
      o => data_out_x3_net
    );

  PKTDET_RSSI_CONFIG_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x13_net,
      dout => PKTDET_RSSI_CONFIG_reg_ce
    );

  PKT_BUF_SEL: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000001000000000000000000000000",
      latency => 1
    )
    port map (
      ce => PKT_BUF_SEL_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x3_net,
      o => data_out_x12_net
    );

  PKT_BUF_SEL_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x3_net,
      dout => PKT_BUF_SEL_reg_ce
    );

  RSSI_THRESH: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000001001011000",
      latency => 1
    )
    port map (
      ce => RSSI_THRESH_reg_ce,
      clk => plb_clk_1_sg_x1,
      clr => '0',
      i => data_in_x0_net,
      o => data_out_x15_net
    );

  RSSI_THRESH_ce_and2_comp: entity work.xland2
    port map (
      a => plb_ce_1_sg_x1,
      b => en_x0_net,
      dout => RSSI_THRESH_reg_ce
    );

  RX_PKT_AGC_GAINS: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => RX_PKT_AGC_GAINS_reg_ce,
      clk => clk_1_sg_x303,
      clr => '0',
      i => data_in_x16_net,
      o => data_out_x0_net
    );

  RX_PKT_AGC_GAINS_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x303,
      b => en_x16_net,
      dout => RX_PKT_AGC_GAINS_reg_ce
    );

  RX_PKT_RSSI_AB: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => RX_PKT_RSSI_AB_reg_ce,
      clk => clk_1_sg_x303,
      clr => '0',
      i => data_in_x15_net,
      o => data_out_x1_net
    );

  RX_PKT_RSSI_AB_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x303,
      b => en_x15_net,
      dout => RX_PKT_RSSI_AB_reg_ce
    );

  RX_PKT_RSSI_CD: entity work.synth_reg_w_init
    generic map (
      width => 32,
      init_index => 2,
      init_value => b"00000000000000000000000000000000",
      latency => 1
    )
    port map (
      ce => RX_PKT_RSSI_CD_reg_ce,
      clk => clk_1_sg_x303,
      clr => '0',
      i => data_in_x17_net,
      o => data_out_net
    );

  RX_PKT_RSSI_CD_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x303,
      b => en_x17_net,
      dout => RX_PKT_RSSI_CD_reg_ce
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
      clk => clk_1_sg_x303,
      clr => '0',
      i => data_in_x14_net,
      o => data_out_x2_net
    );

  Status_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x303,
      b => en_x14_net,
      dout => Status_reg_ce
    );

  default_clock_driver_wlan_phy_rx_pmd_x0: entity work.default_clock_driver_wlan_phy_rx_pmd
    port map (
      sysce => '1',
      sysce_clr => '0',
      sysclk => clkNet,
      ce_1 => ce_1_sg_x303,
      ce_16 => ce_16_sg_x37,
      ce_4 => ce_4_sg_x4,
      ce_64 => ce_64_sg_x3,
      ce_8 => ce_8_sg_x29,
      ce_logic_8 => ce_logic_8_sg_x2,
      clk_1 => clk_1_sg_x303,
      clk_16 => clk_16_sg_x37,
      clk_4 => clk_4_sg_x4,
      clk_64 => clk_64_sg_x3,
      clk_8 => clk_8_sg_x29
    );

  persistentdff_inst: xlpersistentdff
    port map (
      clk => clkNet,
      d => persistentdff_inst_q,
      q => persistentdff_inst_q
    );

  plb_clock_driver_wlan_phy_rx_pmd_x0: entity work.plb_clock_driver_wlan_phy_rx_pmd
    port map (
      sysce => '1',
      sysce_clr => '0',
      sysclk => clkNet_x0,
      plb_ce_1 => plb_ce_1_sg_x1,
      plb_clk_1 => plb_clk_1_sg_x1
    );

  wlan_phy_rx_pmd_x0: entity work.wlan_phy_rx_pmd
    port map (
      adc_rx_clk => adc_rx_clk_net,
      agc_done => agc_done_net,
      axi_aresetn => axi_aresetn_net,
      bram_din => bram_din_net,
      ce_1 => ce_1_sg_x303,
      ce_16 => ce_16_sg_x37,
      ce_4 => ce_4_sg_x4,
      ce_64 => ce_64_sg_x3,
      ce_8 => ce_8_sg_x29,
      ce_logic_8 => ce_logic_8_sg_x2,
      clk_1 => clk_1_sg_x303,
      clk_16 => clk_16_sg_x37,
      clk_4 => clk_4_sg_x4,
      clk_64 => clk_64_sg_x3,
      clk_8 => clk_8_sg_x29,
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
      data_out_x2 => data_out_x2_net,
      data_out_x3 => data_out_x3_net,
      data_out_x4 => data_out_x4_net,
      data_out_x5 => data_out_x5_net,
      data_out_x6 => data_out_x6_net,
      data_out_x7 => data_out_x7_net,
      data_out_x8 => data_out_x8_net,
      data_out_x9 => data_out_x9_net,
      dout => data_out_x16_net,
      dout_x0 => data_out_x15_net,
      dout_x1 => data_out_x14_net,
      dout_x10 => data_out_x5_net,
      dout_x11 => data_out_x17_net,
      dout_x12 => data_out_x4_net,
      dout_x13 => data_out_x3_net,
      dout_x2 => data_out_x13_net,
      dout_x3 => data_out_x12_net,
      dout_x4 => data_out_x11_net,
      dout_x5 => data_out_x10_net,
      dout_x6 => data_out_x9_net,
      dout_x7 => data_out_x8_net,
      dout_x8 => data_out_x7_net,
      dout_x9 => data_out_x6_net,
      phy_rx_block_pktdet => phy_rx_block_pktdet_net,
      pkt_det_in => pkt_det_in_net,
      plb_ce_1 => plb_ce_1_sg_x1,
      plb_clk_1 => plb_clk_1_sg_x1,
      rfa_g_bb => rfa_g_bb_net,
      rfa_g_rf => rfa_g_rf_net,
      rfa_rssi => rfa_rssi_net,
      rfa_rx_i => rfa_rx_i_net,
      rfa_rx_q => rfa_rx_q_net,
      rfb_g_bb => rfb_g_bb_net,
      rfb_g_rf => rfb_g_rf_net,
      rfb_rssi => rfb_rssi_net,
      rfb_rx_i => rfb_rx_i_net,
      rfb_rx_q => rfb_rx_q_net,
      rfc_g_bb => rfc_g_bb_net,
      rfc_g_rf => rfc_g_rf_net,
      rfc_rssi => rfc_rssi_net,
      rfc_rx_i => rfc_rx_i_net,
      rfc_rx_q => rfc_rx_q_net,
      rfd_g_bb => rfd_g_bb_net,
      rfd_g_rf => rfd_g_rf_net,
      rfd_rssi => rfd_rssi_net,
      rfd_rx_i => rfd_rx_i_net,
      rfd_rx_q => rfd_rx_q_net,
      rx_sigs_invalid => rx_sigs_invalid_net,
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
      bram_addr => bram_addr_net,
      bram_dout => bram_dout_net,
      bram_en => bram_en_net,
      bram_reset => bram_reset_net,
      bram_wen => bram_wen_net,
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
      data_in_x2 => data_in_x2_net,
      data_in_x3 => data_in_x3_net,
      data_in_x4 => data_in_x4_net,
      data_in_x5 => data_in_x5_net,
      data_in_x6 => data_in_x6_net,
      data_in_x7 => data_in_x7_net,
      data_in_x8 => data_in_x8_net,
      data_in_x9 => data_in_x9_net,
      dbg_dsss_rx_active => dbg_dsss_rx_active_net,
      dbg_eq_i => dbg_eq_i_net,
      dbg_eq_q => dbg_eq_q_net,
      dbg_fcs_good => dbg_fcs_good_net,
      dbg_gpio => dbg_gpio_net,
      dbg_lts_timeout => dbg_lts_timeout_net,
      dbg_payload => dbg_payload_net,
      dbg_pkt_det_dsss => dbg_pkt_det_dsss_net,
      dbg_pkt_det_ofdm => dbg_pkt_det_ofdm_net,
      dbg_rssi_det => dbg_rssi_det_net,
      dbg_signal_err_disp => dbg_signal_err_disp_net,
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
      en_x17 => en_x17_net,
      en_x2 => en_x2_net,
      en_x3 => en_x3_net,
      en_x4 => en_x4_net,
      en_x5 => en_x5_net,
      en_x6 => en_x6_net,
      en_x7 => en_x7_net,
      en_x8 => en_x8_net,
      en_x9 => en_x9_net,
      lts_sync => lts_sync_net,
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
      pkt_det_o => pkt_det_o_net,
      rssi_adc_clk => rssi_adc_clk_net,
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
      s_axi_wready => s_axi_wready_net
    );

end structural;
