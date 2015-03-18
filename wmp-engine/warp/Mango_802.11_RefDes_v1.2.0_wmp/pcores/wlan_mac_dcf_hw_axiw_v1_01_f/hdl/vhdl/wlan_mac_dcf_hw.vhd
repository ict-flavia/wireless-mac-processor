--------------------------------------------------------------------------------
--    This file is owned and controlled by Xilinx and must be used solely     --
--    for design, simulation, implementation and creation of design files     --
--    limited to Xilinx devices or technologies. Use with non-Xilinx          --
--    devices or technologies is expressly prohibited and immediately         --
--    terminates your license.                                                --
--                                                                            --
--    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY    --
--    FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY    --
--    PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE             --
--    IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS      --
--    MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY      --
--    CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY       --
--    RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY       --
--    DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE   --
--    IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR          --
--    REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF         --
--    INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A   --
--    PARTICULAR PURPOSE.                                                     --
--                                                                            --
--    Xilinx products are not intended for use in life support appliances,    --
--    devices, or systems.  Use in such applications are expressly            --
--    prohibited.                                                             --
--                                                                            --
--    (c) Copyright 1995-2013 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- You must compile the wrapper file addsb_11_0_38dd91dde0ab1a97.vhd when simulating
-- the core, addsb_11_0_38dd91dde0ab1a97. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
LIBRARY XilinxCoreLib;
-- synthesis translate_on
ENTITY addsb_11_0_38dd91dde0ab1a97 IS
  PORT (
    a : IN STD_LOGIC_VECTOR(21 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(21 DOWNTO 0);
    s : OUT STD_LOGIC_VECTOR(21 DOWNTO 0)
  );
END addsb_11_0_38dd91dde0ab1a97;

ARCHITECTURE addsb_11_0_38dd91dde0ab1a97_a OF addsb_11_0_38dd91dde0ab1a97 IS
-- synthesis translate_off
COMPONENT wrapped_addsb_11_0_38dd91dde0ab1a97
  PORT (
    a : IN STD_LOGIC_VECTOR(21 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(21 DOWNTO 0);
    s : OUT STD_LOGIC_VECTOR(21 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_addsb_11_0_38dd91dde0ab1a97 USE ENTITY XilinxCoreLib.c_addsub_v11_0(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 22,
      c_add_mode => 0,
      c_ainit_val => "0",
      c_b_constant => 0,
      c_b_type => 0,
      c_b_value => "0000000000000000000000",
      c_b_width => 22,
      c_borrow_low => 1,
      c_bypass_low => 0,
      c_ce_overrides_bypass => 1,
      c_ce_overrides_sclr => 0,
      c_has_bypass => 0,
      c_has_c_in => 0,
      c_has_c_out => 0,
      c_has_ce => 0,
      c_has_sclr => 0,
      c_has_sinit => 0,
      c_has_sset => 0,
      c_implementation => 0,
      c_latency => 0,
      c_out_width => 22,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_addsb_11_0_38dd91dde0ab1a97
  PORT MAP (
    a => a,
    b => b,
    s => s
  );
-- synthesis translate_on

END addsb_11_0_38dd91dde0ab1a97_a;
--------------------------------------------------------------------------------
--    This file is owned and controlled by Xilinx and must be used solely     --
--    for design, simulation, implementation and creation of design files     --
--    limited to Xilinx devices or technologies. Use with non-Xilinx          --
--    devices or technologies is expressly prohibited and immediately         --
--    terminates your license.                                                --
--                                                                            --
--    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY    --
--    FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY    --
--    PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE             --
--    IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS      --
--    MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY      --
--    CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY       --
--    RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY       --
--    DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE   --
--    IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR          --
--    REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF         --
--    INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A   --
--    PARTICULAR PURPOSE.                                                     --
--                                                                            --
--    Xilinx products are not intended for use in life support appliances,    --
--    devices, or systems.  Use in such applications are expressly            --
--    prohibited.                                                             --
--                                                                            --
--    (c) Copyright 1995-2014 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- You must compile the wrapper file addsb_11_0_3c1d0ac9b6b8f403.vhd when simulating
-- the core, addsb_11_0_3c1d0ac9b6b8f403. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
LIBRARY XilinxCoreLib;
-- synthesis translate_on
ENTITY addsb_11_0_3c1d0ac9b6b8f403 IS
  PORT (
    a : IN STD_LOGIC_VECTOR(65 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(65 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(65 DOWNTO 0)
  );
END addsb_11_0_3c1d0ac9b6b8f403;

ARCHITECTURE addsb_11_0_3c1d0ac9b6b8f403_a OF addsb_11_0_3c1d0ac9b6b8f403 IS
-- synthesis translate_off
COMPONENT wrapped_addsb_11_0_3c1d0ac9b6b8f403
  PORT (
    a : IN STD_LOGIC_VECTOR(65 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(65 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(65 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_addsb_11_0_3c1d0ac9b6b8f403 USE ENTITY XilinxCoreLib.c_addsub_v11_0(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 66,
      c_add_mode => 0,
      c_ainit_val => "0",
      c_b_constant => 0,
      c_b_type => 0,
      c_b_value => "000000000000000000000000000000000000000000000000000000000000000000",
      c_b_width => 66,
      c_borrow_low => 1,
      c_bypass_low => 0,
      c_ce_overrides_bypass => 1,
      c_ce_overrides_sclr => 0,
      c_has_bypass => 0,
      c_has_c_in => 0,
      c_has_c_out => 0,
      c_has_ce => 1,
      c_has_sclr => 0,
      c_has_sinit => 0,
      c_has_sset => 0,
      c_implementation => 0,
      c_latency => 1,
      c_out_width => 66,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_addsb_11_0_3c1d0ac9b6b8f403
  PORT MAP (
    a => a,
    b => b,
    clk => clk,
    ce => ce,
    s => s
  );
-- synthesis translate_on

END addsb_11_0_3c1d0ac9b6b8f403_a;
--------------------------------------------------------------------------------
--    This file is owned and controlled by Xilinx and must be used solely     --
--    for design, simulation, implementation and creation of design files     --
--    limited to Xilinx devices or technologies. Use with non-Xilinx          --
--    devices or technologies is expressly prohibited and immediately         --
--    terminates your license.                                                --
--                                                                            --
--    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY    --
--    FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY    --
--    PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE             --
--    IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS      --
--    MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY      --
--    CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY       --
--    RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY       --
--    DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE   --
--    IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR          --
--    REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF         --
--    INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A   --
--    PARTICULAR PURPOSE.                                                     --
--                                                                            --
--    Xilinx products are not intended for use in life support appliances,    --
--    devices, or systems.  Use in such applications are expressly            --
--    prohibited.                                                             --
--                                                                            --
--    (c) Copyright 1995-2013 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- You must compile the wrapper file cntr_11_0_23bc6491dc8a06da.vhd when simulating
-- the core, cntr_11_0_23bc6491dc8a06da. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
LIBRARY XilinxCoreLib;
-- synthesis translate_on
ENTITY cntr_11_0_23bc6491dc8a06da IS
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
  );
END cntr_11_0_23bc6491dc8a06da;

ARCHITECTURE cntr_11_0_23bc6491dc8a06da_a OF cntr_11_0_23bc6491dc8a06da IS
-- synthesis translate_off
COMPONENT wrapped_cntr_11_0_23bc6491dc8a06da
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_cntr_11_0_23bc6491dc8a06da USE ENTITY XilinxCoreLib.c_counter_binary_v11_0(behavioral)
    GENERIC MAP (
      c_ainit_val => "0",
      c_ce_overrides_sync => 0,
      c_count_by => "1",
      c_count_mode => 0,
      c_count_to => "1",
      c_fb_latency => 0,
      c_has_ce => 1,
      c_has_load => 0,
      c_has_sclr => 0,
      c_has_sinit => 1,
      c_has_sset => 0,
      c_has_thresh0 => 0,
      c_implementation => 0,
      c_latency => 1,
      c_load_low => 0,
      c_restrict_count => 0,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "1",
      c_thresh0_value => "1",
      c_verbosity => 0,
      c_width => 14,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_cntr_11_0_23bc6491dc8a06da
  PORT MAP (
    clk => clk,
    ce => ce,
    sinit => sinit,
    q => q
  );
-- synthesis translate_on

END cntr_11_0_23bc6491dc8a06da_a;
--------------------------------------------------------------------------------
--    This file is owned and controlled by Xilinx and must be used solely     --
--    for design, simulation, implementation and creation of design files     --
--    limited to Xilinx devices or technologies. Use with non-Xilinx          --
--    devices or technologies is expressly prohibited and immediately         --
--    terminates your license.                                                --
--                                                                            --
--    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY    --
--    FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY    --
--    PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE             --
--    IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS      --
--    MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY      --
--    CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY       --
--    RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY       --
--    DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE   --
--    IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR          --
--    REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF         --
--    INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A   --
--    PARTICULAR PURPOSE.                                                     --
--                                                                            --
--    Xilinx products are not intended for use in life support appliances,    --
--    devices, or systems.  Use in such applications are expressly            --
--    prohibited.                                                             --
--                                                                            --
--    (c) Copyright 1995-2013 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- You must compile the wrapper file cntr_11_0_33b670dfb2dd60f1.vhd when simulating
-- the core, cntr_11_0_33b670dfb2dd60f1. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
LIBRARY XilinxCoreLib;
-- synthesis translate_on
ENTITY cntr_11_0_33b670dfb2dd60f1 IS
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    load : IN STD_LOGIC;
    l : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    q : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
  );
END cntr_11_0_33b670dfb2dd60f1;

ARCHITECTURE cntr_11_0_33b670dfb2dd60f1_a OF cntr_11_0_33b670dfb2dd60f1 IS
-- synthesis translate_off
COMPONENT wrapped_cntr_11_0_33b670dfb2dd60f1
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    load : IN STD_LOGIC;
    l : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    q : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_cntr_11_0_33b670dfb2dd60f1 USE ENTITY XilinxCoreLib.c_counter_binary_v11_0(behavioral)
    GENERIC MAP (
      c_ainit_val => "0",
      c_ce_overrides_sync => 0,
      c_count_by => "1",
      c_count_mode => 1,
      c_count_to => "1",
      c_fb_latency => 0,
      c_has_ce => 1,
      c_has_load => 1,
      c_has_sclr => 0,
      c_has_sinit => 1,
      c_has_sset => 0,
      c_has_thresh0 => 0,
      c_implementation => 0,
      c_latency => 1,
      c_load_low => 0,
      c_restrict_count => 0,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_thresh0_value => "1",
      c_verbosity => 0,
      c_width => 20,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_cntr_11_0_33b670dfb2dd60f1
  PORT MAP (
    clk => clk,
    ce => ce,
    sinit => sinit,
    load => load,
    l => l,
    q => q
  );
-- synthesis translate_on

END cntr_11_0_33b670dfb2dd60f1_a;
--------------------------------------------------------------------------------
--    This file is owned and controlled by Xilinx and must be used solely     --
--    for design, simulation, implementation and creation of design files     --
--    limited to Xilinx devices or technologies. Use with non-Xilinx          --
--    devices or technologies is expressly prohibited and immediately         --
--    terminates your license.                                                --
--                                                                            --
--    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY    --
--    FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY    --
--    PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE             --
--    IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS      --
--    MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY      --
--    CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY       --
--    RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY       --
--    DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE   --
--    IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR          --
--    REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF         --
--    INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A   --
--    PARTICULAR PURPOSE.                                                     --
--                                                                            --
--    Xilinx products are not intended for use in life support appliances,    --
--    devices, or systems.  Use in such applications are expressly            --
--    prohibited.                                                             --
--                                                                            --
--    (c) Copyright 1995-2013 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- You must compile the wrapper file cntr_11_0_5b0a1653ddb23333.vhd when simulating
-- the core, cntr_11_0_5b0a1653ddb23333. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
LIBRARY XilinxCoreLib;
-- synthesis translate_on
ENTITY cntr_11_0_5b0a1653ddb23333 IS
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END cntr_11_0_5b0a1653ddb23333;

ARCHITECTURE cntr_11_0_5b0a1653ddb23333_a OF cntr_11_0_5b0a1653ddb23333 IS
-- synthesis translate_off
COMPONENT wrapped_cntr_11_0_5b0a1653ddb23333
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_cntr_11_0_5b0a1653ddb23333 USE ENTITY XilinxCoreLib.c_counter_binary_v11_0(behavioral)
    GENERIC MAP (
      c_ainit_val => "0",
      c_ce_overrides_sync => 0,
      c_count_by => "1",
      c_count_mode => 0,
      c_count_to => "1",
      c_fb_latency => 0,
      c_has_ce => 1,
      c_has_load => 0,
      c_has_sclr => 0,
      c_has_sinit => 1,
      c_has_sset => 0,
      c_has_thresh0 => 0,
      c_implementation => 0,
      c_latency => 1,
      c_load_low => 0,
      c_restrict_count => 0,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_thresh0_value => "1",
      c_verbosity => 0,
      c_width => 16,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_cntr_11_0_5b0a1653ddb23333
  PORT MAP (
    clk => clk,
    ce => ce,
    sinit => sinit,
    q => q
  );
-- synthesis translate_on

END cntr_11_0_5b0a1653ddb23333_a;
--------------------------------------------------------------------------------
--    This file is owned and controlled by Xilinx and must be used solely     --
--    for design, simulation, implementation and creation of design files     --
--    limited to Xilinx devices or technologies. Use with non-Xilinx          --
--    devices or technologies is expressly prohibited and immediately         --
--    terminates your license.                                                --
--                                                                            --
--    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY    --
--    FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY    --
--    PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE             --
--    IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS      --
--    MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY      --
--    CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY       --
--    RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY       --
--    DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE   --
--    IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR          --
--    REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF         --
--    INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A   --
--    PARTICULAR PURPOSE.                                                     --
--                                                                            --
--    Xilinx products are not intended for use in life support appliances,    --
--    devices, or systems.  Use in such applications are expressly            --
--    prohibited.                                                             --
--                                                                            --
--    (c) Copyright 1995-2013 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- You must compile the wrapper file cntr_11_0_5e62871cb125c52e.vhd when simulating
-- the core, cntr_11_0_5e62871cb125c52e. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
LIBRARY XilinxCoreLib;
-- synthesis translate_on
ENTITY cntr_11_0_5e62871cb125c52e IS
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    load : IN STD_LOGIC;
    l : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    q : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
  );
END cntr_11_0_5e62871cb125c52e;

ARCHITECTURE cntr_11_0_5e62871cb125c52e_a OF cntr_11_0_5e62871cb125c52e IS
-- synthesis translate_off
COMPONENT wrapped_cntr_11_0_5e62871cb125c52e
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    load : IN STD_LOGIC;
    l : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    q : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_cntr_11_0_5e62871cb125c52e USE ENTITY XilinxCoreLib.c_counter_binary_v11_0(behavioral)
    GENERIC MAP (
      c_ainit_val => "0",
      c_ce_overrides_sync => 0,
      c_count_by => "1",
      c_count_mode => 0,
      c_count_to => "1",
      c_fb_latency => 0,
      c_has_ce => 1,
      c_has_load => 1,
      c_has_sclr => 0,
      c_has_sinit => 1,
      c_has_sset => 0,
      c_has_thresh0 => 0,
      c_implementation => 0,
      c_latency => 1,
      c_load_low => 0,
      c_restrict_count => 0,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_thresh0_value => "1",
      c_verbosity => 0,
      c_width => 64,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_cntr_11_0_5e62871cb125c52e
  PORT MAP (
    clk => clk,
    ce => ce,
    sinit => sinit,
    load => load,
    l => l,
    q => q
  );
-- synthesis translate_on

END cntr_11_0_5e62871cb125c52e_a;
--------------------------------------------------------------------------------
--    This file is owned and controlled by Xilinx and must be used solely     --
--    for design, simulation, implementation and creation of design files     --
--    limited to Xilinx devices or technologies. Use with non-Xilinx          --
--    devices or technologies is expressly prohibited and immediately         --
--    terminates your license.                                                --
--                                                                            --
--    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY    --
--    FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY    --
--    PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE             --
--    IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS      --
--    MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY      --
--    CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY       --
--    RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY       --
--    DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE   --
--    IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR          --
--    REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF         --
--    INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A   --
--    PARTICULAR PURPOSE.                                                     --
--                                                                            --
--    Xilinx products are not intended for use in life support appliances,    --
--    devices, or systems.  Use in such applications are expressly            --
--    prohibited.                                                             --
--                                                                            --
--    (c) Copyright 1995-2013 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- You must compile the wrapper file cntr_11_0_66919a0f29965143.vhd when simulating
-- the core, cntr_11_0_66919a0f29965143. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
LIBRARY XilinxCoreLib;
-- synthesis translate_on
ENTITY cntr_11_0_66919a0f29965143 IS
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
  );
END cntr_11_0_66919a0f29965143;

ARCHITECTURE cntr_11_0_66919a0f29965143_a OF cntr_11_0_66919a0f29965143 IS
-- synthesis translate_off
COMPONENT wrapped_cntr_11_0_66919a0f29965143
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_cntr_11_0_66919a0f29965143 USE ENTITY XilinxCoreLib.c_counter_binary_v11_0(behavioral)
    GENERIC MAP (
      c_ainit_val => "0",
      c_ce_overrides_sync => 0,
      c_count_by => "1",
      c_count_mode => 0,
      c_count_to => "1",
      c_fb_latency => 0,
      c_has_ce => 1,
      c_has_load => 0,
      c_has_sclr => 0,
      c_has_sinit => 1,
      c_has_sset => 0,
      c_has_thresh0 => 0,
      c_implementation => 0,
      c_latency => 1,
      c_load_low => 0,
      c_restrict_count => 0,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_thresh0_value => "1",
      c_verbosity => 0,
      c_width => 14,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_cntr_11_0_66919a0f29965143
  PORT MAP (
    clk => clk,
    ce => ce,
    sinit => sinit,
    q => q
  );
-- synthesis translate_on

END cntr_11_0_66919a0f29965143_a;
--------------------------------------------------------------------------------
--    This file is owned and controlled by Xilinx and must be used solely     --
--    for design, simulation, implementation and creation of design files     --
--    limited to Xilinx devices or technologies. Use with non-Xilinx          --
--    devices or technologies is expressly prohibited and immediately         --
--    terminates your license.                                                --
--                                                                            --
--    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY    --
--    FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY    --
--    PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE             --
--    IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS      --
--    MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY      --
--    CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY       --
--    RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY       --
--    DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE   --
--    IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR          --
--    REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF         --
--    INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A   --
--    PARTICULAR PURPOSE.                                                     --
--                                                                            --
--    Xilinx products are not intended for use in life support appliances,    --
--    devices, or systems.  Use in such applications are expressly            --
--    prohibited.                                                             --
--                                                                            --
--    (c) Copyright 1995-2013 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- You must compile the wrapper file cntr_11_0_6b6e5f4ca8671604.vhd when simulating
-- the core, cntr_11_0_6b6e5f4ca8671604. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
LIBRARY XilinxCoreLib;
-- synthesis translate_on
ENTITY cntr_11_0_6b6e5f4ca8671604 IS
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END cntr_11_0_6b6e5f4ca8671604;

ARCHITECTURE cntr_11_0_6b6e5f4ca8671604_a OF cntr_11_0_6b6e5f4ca8671604 IS
-- synthesis translate_off
COMPONENT wrapped_cntr_11_0_6b6e5f4ca8671604
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_cntr_11_0_6b6e5f4ca8671604 USE ENTITY XilinxCoreLib.c_counter_binary_v11_0(behavioral)
    GENERIC MAP (
      c_ainit_val => "0",
      c_ce_overrides_sync => 0,
      c_count_by => "1",
      c_count_mode => 0,
      c_count_to => "1",
      c_fb_latency => 0,
      c_has_ce => 1,
      c_has_load => 0,
      c_has_sclr => 0,
      c_has_sinit => 1,
      c_has_sset => 0,
      c_has_thresh0 => 0,
      c_implementation => 0,
      c_latency => 1,
      c_load_low => 0,
      c_restrict_count => 0,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "1",
      c_thresh0_value => "1",
      c_verbosity => 0,
      c_width => 16,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_cntr_11_0_6b6e5f4ca8671604
  PORT MAP (
    clk => clk,
    ce => ce,
    sinit => sinit,
    q => q
  );
-- synthesis translate_on

END cntr_11_0_6b6e5f4ca8671604_a;
--------------------------------------------------------------------------------
--    This file is owned and controlled by Xilinx and must be used solely     --
--    for design, simulation, implementation and creation of design files     --
--    limited to Xilinx devices or technologies. Use with non-Xilinx          --
--    devices or technologies is expressly prohibited and immediately         --
--    terminates your license.                                                --
--                                                                            --
--    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY    --
--    FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY    --
--    PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE             --
--    IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS      --
--    MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY      --
--    CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY       --
--    RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY       --
--    DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE   --
--    IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR          --
--    REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF         --
--    INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A   --
--    PARTICULAR PURPOSE.                                                     --
--                                                                            --
--    Xilinx products are not intended for use in life support appliances,    --
--    devices, or systems.  Use in such applications are expressly            --
--    prohibited.                                                             --
--                                                                            --
--    (c) Copyright 1995-2013 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- You must compile the wrapper file cntr_11_0_86806e294f737f4c.vhd when simulating
-- the core, cntr_11_0_86806e294f737f4c. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
LIBRARY XilinxCoreLib;
-- synthesis translate_on
ENTITY cntr_11_0_86806e294f737f4c IS
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END cntr_11_0_86806e294f737f4c;

ARCHITECTURE cntr_11_0_86806e294f737f4c_a OF cntr_11_0_86806e294f737f4c IS
-- synthesis translate_off
COMPONENT wrapped_cntr_11_0_86806e294f737f4c
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_cntr_11_0_86806e294f737f4c USE ENTITY XilinxCoreLib.c_counter_binary_v11_0(behavioral)
    GENERIC MAP (
      c_ainit_val => "0",
      c_ce_overrides_sync => 0,
      c_count_by => "1",
      c_count_mode => 0,
      c_count_to => "1",
      c_fb_latency => 0,
      c_has_ce => 1,
      c_has_load => 0,
      c_has_sclr => 0,
      c_has_sinit => 1,
      c_has_sset => 0,
      c_has_thresh0 => 0,
      c_implementation => 0,
      c_latency => 1,
      c_load_low => 0,
      c_restrict_count => 0,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_thresh0_value => "1",
      c_verbosity => 0,
      c_width => 8,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_cntr_11_0_86806e294f737f4c
  PORT MAP (
    clk => clk,
    ce => ce,
    sinit => sinit,
    q => q
  );
-- synthesis translate_on

END cntr_11_0_86806e294f737f4c_a;
--------------------------------------------------------------------------------
--    This file is owned and controlled by Xilinx and must be used solely     --
--    for design, simulation, implementation and creation of design files     --
--    limited to Xilinx devices or technologies. Use with non-Xilinx          --
--    devices or technologies is expressly prohibited and immediately         --
--    terminates your license.                                                --
--                                                                            --
--    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY    --
--    FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY    --
--    PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE             --
--    IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS      --
--    MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY      --
--    CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY       --
--    RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY       --
--    DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE   --
--    IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR          --
--    REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF         --
--    INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A   --
--    PARTICULAR PURPOSE.                                                     --
--                                                                            --
--    Xilinx products are not intended for use in life support appliances,    --
--    devices, or systems.  Use in such applications are expressly            --
--    prohibited.                                                             --
--                                                                            --
--    (c) Copyright 1995-2014 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- You must compile the wrapper file cntr_11_0_bc4e334678893d0e.vhd when simulating
-- the core, cntr_11_0_bc4e334678893d0e. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
LIBRARY XilinxCoreLib;
-- synthesis translate_on
ENTITY cntr_11_0_bc4e334678893d0e IS
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    load : IN STD_LOGIC;
    l : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END cntr_11_0_bc4e334678893d0e;

ARCHITECTURE cntr_11_0_bc4e334678893d0e_a OF cntr_11_0_bc4e334678893d0e IS
-- synthesis translate_off
COMPONENT wrapped_cntr_11_0_bc4e334678893d0e
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    load : IN STD_LOGIC;
    l : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_cntr_11_0_bc4e334678893d0e USE ENTITY XilinxCoreLib.c_counter_binary_v11_0(behavioral)
    GENERIC MAP (
      c_ainit_val => "0",
      c_ce_overrides_sync => 0,
      c_count_by => "1",
      c_count_mode => 1,
      c_count_to => "1",
      c_fb_latency => 0,
      c_has_ce => 1,
      c_has_load => 1,
      c_has_sclr => 0,
      c_has_sinit => 1,
      c_has_sset => 0,
      c_has_thresh0 => 0,
      c_implementation => 0,
      c_latency => 1,
      c_load_low => 0,
      c_restrict_count => 0,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_thresh0_value => "1",
      c_verbosity => 0,
      c_width => 16,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_cntr_11_0_bc4e334678893d0e
  PORT MAP (
    clk => clk,
    ce => ce,
    sinit => sinit,
    load => load,
    l => l,
    q => q
  );
-- synthesis translate_on

END cntr_11_0_bc4e334678893d0e_a;
--------------------------------------------------------------------------------
--    This file is owned and controlled by Xilinx and must be used solely     --
--    for design, simulation, implementation and creation of design files     --
--    limited to Xilinx devices or technologies. Use with non-Xilinx          --
--    devices or technologies is expressly prohibited and immediately         --
--    terminates your license.                                                --
--                                                                            --
--    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY    --
--    FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY    --
--    PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE             --
--    IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS      --
--    MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY      --
--    CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY       --
--    RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY       --
--    DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE   --
--    IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR          --
--    REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF         --
--    INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A   --
--    PARTICULAR PURPOSE.                                                     --
--                                                                            --
--    Xilinx products are not intended for use in life support appliances,    --
--    devices, or systems.  Use in such applications are expressly            --
--    prohibited.                                                             --
--                                                                            --
--    (c) Copyright 1995-2013 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- You must compile the wrapper file mult_11_2_7def12de86dcdc6a.vhd when simulating
-- the core, mult_11_2_7def12de86dcdc6a. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
LIBRARY XilinxCoreLib;
-- synthesis translate_on
ENTITY mult_11_2_7def12de86dcdc6a IS
  PORT (
    clk : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    p : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
  );
END mult_11_2_7def12de86dcdc6a;

ARCHITECTURE mult_11_2_7def12de86dcdc6a_a OF mult_11_2_7def12de86dcdc6a IS
-- synthesis translate_off
COMPONENT wrapped_mult_11_2_7def12de86dcdc6a
  PORT (
    clk : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    p : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_mult_11_2_7def12de86dcdc6a USE ENTITY XilinxCoreLib.mult_gen_v11_2(behavioral)
    GENERIC MAP (
      c_a_type => 1,
      c_a_width => 4,
      c_b_type => 1,
      c_b_value => "10000001",
      c_b_width => 16,
      c_ccm_imp => 0,
      c_ce_overrides_sclr => 1,
      c_has_ce => 1,
      c_has_sclr => 1,
      c_has_zero_detect => 0,
      c_latency => 1,
      c_model_type => 0,
      c_mult_type => 1,
      c_optimize_goal => 1,
      c_out_high => 19,
      c_out_low => 0,
      c_round_output => 0,
      c_round_pt => 0,
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_mult_11_2_7def12de86dcdc6a
  PORT MAP (
    clk => clk,
    a => a,
    b => b,
    ce => ce,
    sclr => sclr,
    p => p
  );
-- synthesis translate_on

END mult_11_2_7def12de86dcdc6a_a;

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
package conv_pkg is
    constant simulating : boolean := false
      -- synopsys translate_off
        or true
      -- synopsys translate_on
    ;
    constant xlUnsigned : integer := 1;
    constant xlSigned : integer := 2;
    constant xlFloat : integer := 3;
    constant xlWrap : integer := 1;
    constant xlSaturate : integer := 2;
    constant xlTruncate : integer := 1;
    constant xlRound : integer := 2;
    constant xlRoundBanker : integer := 3;
    constant xlAddMode : integer := 1;
    constant xlSubMode : integer := 2;
    attribute black_box : boolean;
    attribute syn_black_box : boolean;
    attribute fpga_dont_touch: string;
    attribute box_type :  string;
    attribute keep : string;
    attribute syn_keep : boolean;
    function std_logic_vector_to_unsigned(inp : std_logic_vector) return unsigned;
    function unsigned_to_std_logic_vector(inp : unsigned) return std_logic_vector;
    function std_logic_vector_to_signed(inp : std_logic_vector) return signed;
    function signed_to_std_logic_vector(inp : signed) return std_logic_vector;
    function unsigned_to_signed(inp : unsigned) return signed;
    function signed_to_unsigned(inp : signed) return unsigned;
    function pos(inp : std_logic_vector; arith : INTEGER) return boolean;
    function all_same(inp: std_logic_vector) return boolean;
    function all_zeros(inp: std_logic_vector) return boolean;
    function is_point_five(inp: std_logic_vector) return boolean;
    function all_ones(inp: std_logic_vector) return boolean;
    function convert_type (inp : std_logic_vector; old_width, old_bin_pt,
                           old_arith, new_width, new_bin_pt, new_arith,
                           quantization, overflow : INTEGER)
        return std_logic_vector;
    function cast (inp : std_logic_vector; old_bin_pt,
                   new_width, new_bin_pt, new_arith : INTEGER)
        return std_logic_vector;
    function shift_division_result(quotient, fraction: std_logic_vector;
                                   fraction_width, shift_value, shift_dir: INTEGER)
        return std_logic_vector;
    function shift_op (inp: std_logic_vector;
                       result_width, shift_value, shift_dir: INTEGER)
        return std_logic_vector;
    function vec_slice (inp : std_logic_vector; upper, lower : INTEGER)
        return std_logic_vector;
    function s2u_slice (inp : signed; upper, lower : INTEGER)
        return unsigned;
    function u2u_slice (inp : unsigned; upper, lower : INTEGER)
        return unsigned;
    function s2s_cast (inp : signed; old_bin_pt,
                   new_width, new_bin_pt : INTEGER)
        return signed;
    function u2s_cast (inp : unsigned; old_bin_pt,
                   new_width, new_bin_pt : INTEGER)
        return signed;
    function s2u_cast (inp : signed; old_bin_pt,
                   new_width, new_bin_pt : INTEGER)
        return unsigned;
    function u2u_cast (inp : unsigned; old_bin_pt,
                   new_width, new_bin_pt : INTEGER)
        return unsigned;
    function u2v_cast (inp : unsigned; old_bin_pt,
                   new_width, new_bin_pt : INTEGER)
        return std_logic_vector;
    function s2v_cast (inp : signed; old_bin_pt,
                   new_width, new_bin_pt : INTEGER)
        return std_logic_vector;
    function trunc (inp : std_logic_vector; old_width, old_bin_pt, old_arith,
                    new_width, new_bin_pt, new_arith : INTEGER)
        return std_logic_vector;
    function round_towards_inf (inp : std_logic_vector; old_width, old_bin_pt,
                                old_arith, new_width, new_bin_pt,
                                new_arith : INTEGER) return std_logic_vector;
    function round_towards_even (inp : std_logic_vector; old_width, old_bin_pt,
                                old_arith, new_width, new_bin_pt,
                                new_arith : INTEGER) return std_logic_vector;
    function max_signed(width : INTEGER) return std_logic_vector;
    function min_signed(width : INTEGER) return std_logic_vector;
    function saturation_arith(inp:  std_logic_vector;  old_width, old_bin_pt,
                              old_arith, new_width, new_bin_pt, new_arith
                              : INTEGER) return std_logic_vector;
    function wrap_arith(inp:  std_logic_vector;  old_width, old_bin_pt,
                        old_arith, new_width, new_bin_pt, new_arith : INTEGER)
                        return std_logic_vector;
    function fractional_bits(a_bin_pt, b_bin_pt: INTEGER) return INTEGER;
    function integer_bits(a_width, a_bin_pt, b_width, b_bin_pt: INTEGER)
        return INTEGER;
    function sign_ext(inp : std_logic_vector; new_width : INTEGER)
        return std_logic_vector;
    function zero_ext(inp : std_logic_vector; new_width : INTEGER)
        return std_logic_vector;
    function zero_ext(inp : std_logic; new_width : INTEGER)
        return std_logic_vector;
    function extend_MSB(inp : std_logic_vector; new_width, arith : INTEGER)
        return std_logic_vector;
    function align_input(inp : std_logic_vector; old_width, delta, new_arith,
                          new_width: INTEGER)
        return std_logic_vector;
    function pad_LSB(inp : std_logic_vector; new_width: integer)
        return std_logic_vector;
    function pad_LSB(inp : std_logic_vector; new_width, arith : integer)
        return std_logic_vector;
    function max(L, R: INTEGER) return INTEGER;
    function min(L, R: INTEGER) return INTEGER;
    function "="(left,right: STRING) return boolean;
    function boolean_to_signed (inp : boolean; width: integer)
        return signed;
    function boolean_to_unsigned (inp : boolean; width: integer)
        return unsigned;
    function boolean_to_vector (inp : boolean)
        return std_logic_vector;
    function std_logic_to_vector (inp : std_logic)
        return std_logic_vector;
    function integer_to_std_logic_vector (inp : integer;  width, arith : integer)
        return std_logic_vector;
    function std_logic_vector_to_integer (inp : std_logic_vector;  arith : integer)
        return integer;
    function std_logic_to_integer(constant inp : std_logic := '0')
        return integer;
    function bin_string_element_to_std_logic_vector (inp : string;  width, index : integer)
        return std_logic_vector;
    function bin_string_to_std_logic_vector (inp : string)
        return std_logic_vector;
    function hex_string_to_std_logic_vector (inp : string; width : integer)
        return std_logic_vector;
    function makeZeroBinStr (width : integer) return STRING;
    function and_reduce(inp: std_logic_vector) return std_logic;
    -- synopsys translate_off
    function is_binary_string_invalid (inp : string)
        return boolean;
    function is_binary_string_undefined (inp : string)
        return boolean;
    function is_XorU(inp : std_logic_vector)
        return boolean;
    function to_real(inp : std_logic_vector; bin_pt : integer; arith : integer)
        return real;
    function std_logic_to_real(inp : std_logic; bin_pt : integer; arith : integer)
        return real;
    function real_to_std_logic_vector (inp : real;  width, bin_pt, arith : integer)
        return std_logic_vector;
    function real_string_to_std_logic_vector (inp : string;  width, bin_pt, arith : integer)
        return std_logic_vector;
    constant display_precision : integer := 20;
    function real_to_string (inp : real) return string;
    function valid_bin_string(inp : string) return boolean;
    function std_logic_vector_to_bin_string(inp : std_logic_vector) return string;
    function std_logic_to_bin_string(inp : std_logic) return string;
    function std_logic_vector_to_bin_string_w_point(inp : std_logic_vector; bin_pt : integer)
        return string;
    function real_to_bin_string(inp : real;  width, bin_pt, arith : integer)
        return string;
    type stdlogic_to_char_t is array(std_logic) of character;
    constant to_char : stdlogic_to_char_t := (
        'U' => 'U',
        'X' => 'X',
        '0' => '0',
        '1' => '1',
        'Z' => 'Z',
        'W' => 'W',
        'L' => 'L',
        'H' => 'H',
        '-' => '-');
    -- synopsys translate_on
end conv_pkg;
package body conv_pkg is
    function std_logic_vector_to_unsigned(inp : std_logic_vector)
        return unsigned
    is
    begin
        return unsigned (inp);
    end;
    function unsigned_to_std_logic_vector(inp : unsigned)
        return std_logic_vector
    is
    begin
        return std_logic_vector(inp);
    end;
    function std_logic_vector_to_signed(inp : std_logic_vector)
        return signed
    is
    begin
        return  signed (inp);
    end;
    function signed_to_std_logic_vector(inp : signed)
        return std_logic_vector
    is
    begin
        return std_logic_vector(inp);
    end;
    function unsigned_to_signed (inp : unsigned)
        return signed
    is
    begin
        return signed(std_logic_vector(inp));
    end;
    function signed_to_unsigned (inp : signed)
        return unsigned
    is
    begin
        return unsigned(std_logic_vector(inp));
    end;
    function pos(inp : std_logic_vector; arith : INTEGER)
        return boolean
    is
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
    begin
        vec := inp;
        if arith = xlUnsigned then
            return true;
        else
            if vec(width-1) = '0' then
                return true;
            else
                return false;
            end if;
        end if;
        return true;
    end;
    function max_signed(width : INTEGER)
        return std_logic_vector
    is
        variable ones : std_logic_vector(width-2 downto 0);
        variable result : std_logic_vector(width-1 downto 0);
    begin
        ones := (others => '1');
        result(width-1) := '0';
        result(width-2 downto 0) := ones;
        return result;
    end;
    function min_signed(width : INTEGER)
        return std_logic_vector
    is
        variable zeros : std_logic_vector(width-2 downto 0);
        variable result : std_logic_vector(width-1 downto 0);
    begin
        zeros := (others => '0');
        result(width-1) := '1';
        result(width-2 downto 0) := zeros;
        return result;
    end;
    function and_reduce(inp: std_logic_vector) return std_logic
    is
        variable result: std_logic;
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
    begin
        vec := inp;
        result := vec(0);
        if width > 1 then
            for i in 1 to width-1 loop
                result := result and vec(i);
            end loop;
        end if;
        return result;
    end;
    function all_same(inp: std_logic_vector) return boolean
    is
        variable result: boolean;
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
    begin
        vec := inp;
        result := true;
        if width > 0 then
            for i in 1 to width-1 loop
                if vec(i) /= vec(0) then
                    result := false;
                end if;
            end loop;
        end if;
        return result;
    end;
    function all_zeros(inp: std_logic_vector)
        return boolean
    is
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
        variable zero : std_logic_vector(width-1 downto 0);
        variable result : boolean;
    begin
        zero := (others => '0');
        vec := inp;
        -- synopsys translate_off
        if (is_XorU(vec)) then
            return false;
        end if;
         -- synopsys translate_on
        if (std_logic_vector_to_unsigned(vec) = std_logic_vector_to_unsigned(zero)) then
            result := true;
        else
            result := false;
        end if;
        return result;
    end;
    function is_point_five(inp: std_logic_vector)
        return boolean
    is
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
        variable result : boolean;
    begin
        vec := inp;
        -- synopsys translate_off
        if (is_XorU(vec)) then
            return false;
        end if;
         -- synopsys translate_on
        if (width > 1) then
           if ((vec(width-1) = '1') and (all_zeros(vec(width-2 downto 0)) = true)) then
               result := true;
           else
               result := false;
           end if;
        else
           if (vec(width-1) = '1') then
               result := true;
           else
               result := false;
           end if;
        end if;
        return result;
    end;
    function all_ones(inp: std_logic_vector)
        return boolean
    is
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
        variable one : std_logic_vector(width-1 downto 0);
        variable result : boolean;
    begin
        one := (others => '1');
        vec := inp;
        -- synopsys translate_off
        if (is_XorU(vec)) then
            return false;
        end if;
         -- synopsys translate_on
        if (std_logic_vector_to_unsigned(vec) = std_logic_vector_to_unsigned(one)) then
            result := true;
        else
            result := false;
        end if;
        return result;
    end;
    function full_precision_num_width(quantization, overflow, old_width,
                                      old_bin_pt, old_arith,
                                      new_width, new_bin_pt, new_arith : INTEGER)
        return integer
    is
        variable result : integer;
    begin
        result := old_width + 2;
        return result;
    end;
    function quantized_num_width(quantization, overflow, old_width, old_bin_pt,
                                 old_arith, new_width, new_bin_pt, new_arith
                                 : INTEGER)
        return integer
    is
        variable right_of_dp, left_of_dp, result : integer;
    begin
        right_of_dp := max(new_bin_pt, old_bin_pt);
        left_of_dp := max((new_width - new_bin_pt), (old_width - old_bin_pt));
        result := (old_width + 2) + (new_bin_pt - old_bin_pt);
        return result;
    end;
    function convert_type (inp : std_logic_vector; old_width, old_bin_pt,
                           old_arith, new_width, new_bin_pt, new_arith,
                           quantization, overflow : INTEGER)
        return std_logic_vector
    is
        constant fp_width : integer :=
            full_precision_num_width(quantization, overflow, old_width,
                                     old_bin_pt, old_arith, new_width,
                                     new_bin_pt, new_arith);
        constant fp_bin_pt : integer := old_bin_pt;
        constant fp_arith : integer := old_arith;
        variable full_precision_result : std_logic_vector(fp_width-1 downto 0);
        constant q_width : integer :=
            quantized_num_width(quantization, overflow, old_width, old_bin_pt,
                                old_arith, new_width, new_bin_pt, new_arith);
        constant q_bin_pt : integer := new_bin_pt;
        constant q_arith : integer := old_arith;
        variable quantized_result : std_logic_vector(q_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        result := (others => '0');
        full_precision_result := cast(inp, old_bin_pt, fp_width, fp_bin_pt,
                                      fp_arith);
        if (quantization = xlRound) then
            quantized_result := round_towards_inf(full_precision_result,
                                                  fp_width, fp_bin_pt,
                                                  fp_arith, q_width, q_bin_pt,
                                                  q_arith);
        elsif (quantization = xlRoundBanker) then
            quantized_result := round_towards_even(full_precision_result,
                                                  fp_width, fp_bin_pt,
                                                  fp_arith, q_width, q_bin_pt,
                                                  q_arith);
        else
            quantized_result := trunc(full_precision_result, fp_width, fp_bin_pt,
                                      fp_arith, q_width, q_bin_pt, q_arith);
        end if;
        if (overflow = xlSaturate) then
            result := saturation_arith(quantized_result, q_width, q_bin_pt,
                                       q_arith, new_width, new_bin_pt, new_arith);
        else
             result := wrap_arith(quantized_result, q_width, q_bin_pt, q_arith,
                                  new_width, new_bin_pt, new_arith);
        end if;
        return result;
    end;
    function cast (inp : std_logic_vector; old_bin_pt, new_width,
                   new_bin_pt, new_arith : INTEGER)
        return std_logic_vector
    is
        constant old_width : integer := inp'length;
        constant left_of_dp : integer := (new_width - new_bin_pt)
                                         - (old_width - old_bin_pt);
        constant right_of_dp : integer := (new_bin_pt - old_bin_pt);
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
        variable j   : integer;
    begin
        vec := inp;
        for i in new_width-1 downto 0 loop
            j := i - right_of_dp;
            if ( j > old_width-1) then
                if (new_arith = xlUnsigned) then
                    result(i) := '0';
                else
                    result(i) := vec(old_width-1);
                end if;
            elsif ( j >= 0) then
                result(i) := vec(j);
            else
                result(i) := '0';
            end if;
        end loop;
        return result;
    end;
    function shift_division_result(quotient, fraction: std_logic_vector;
                                   fraction_width, shift_value, shift_dir: INTEGER)
        return std_logic_vector
    is
        constant q_width : integer := quotient'length;
        constant f_width : integer := fraction'length;
        constant vec_MSB : integer := q_width+f_width-1;
        constant result_MSB : integer := q_width+fraction_width-1;
        constant result_LSB : integer := vec_MSB-result_MSB;
        variable vec : std_logic_vector(vec_MSB downto 0);
        variable result : std_logic_vector(result_MSB downto 0);
    begin
        vec := ( quotient & fraction );
        if shift_dir = 1 then
            for i in vec_MSB downto 0 loop
                if (i < shift_value) then
                     vec(i) := '0';
                else
                    vec(i) := vec(i-shift_value);
                end if;
            end loop;
        else
            for i in 0 to vec_MSB loop
                if (i > vec_MSB-shift_value) then
                    vec(i) := vec(vec_MSB);
                else
                    vec(i) := vec(i+shift_value);
                end if;
            end loop;
        end if;
        result := vec(vec_MSB downto result_LSB);
        return result;
    end;
    function shift_op (inp: std_logic_vector;
                       result_width, shift_value, shift_dir: INTEGER)
        return std_logic_vector
    is
        constant inp_width : integer := inp'length;
        constant vec_MSB : integer := inp_width-1;
        constant result_MSB : integer := result_width-1;
        constant result_LSB : integer := vec_MSB-result_MSB;
        variable vec : std_logic_vector(vec_MSB downto 0);
        variable result : std_logic_vector(result_MSB downto 0);
    begin
        vec := inp;
        if shift_dir = 1 then
            for i in vec_MSB downto 0 loop
                if (i < shift_value) then
                     vec(i) := '0';
                else
                    vec(i) := vec(i-shift_value);
                end if;
            end loop;
        else
            for i in 0 to vec_MSB loop
                if (i > vec_MSB-shift_value) then
                    vec(i) := vec(vec_MSB);
                else
                    vec(i) := vec(i+shift_value);
                end if;
            end loop;
        end if;
        result := vec(vec_MSB downto result_LSB);
        return result;
    end;
    function vec_slice (inp : std_logic_vector; upper, lower : INTEGER)
      return std_logic_vector
    is
    begin
        return inp(upper downto lower);
    end;
    function s2u_slice (inp : signed; upper, lower : INTEGER)
      return unsigned
    is
    begin
        return unsigned(vec_slice(std_logic_vector(inp), upper, lower));
    end;
    function u2u_slice (inp : unsigned; upper, lower : INTEGER)
      return unsigned
    is
    begin
        return unsigned(vec_slice(std_logic_vector(inp), upper, lower));
    end;
    function s2s_cast (inp : signed; old_bin_pt, new_width, new_bin_pt : INTEGER)
        return signed
    is
    begin
        return signed(cast(std_logic_vector(inp), old_bin_pt, new_width, new_bin_pt, xlSigned));
    end;
    function s2u_cast (inp : signed; old_bin_pt, new_width,
                   new_bin_pt : INTEGER)
        return unsigned
    is
    begin
        return unsigned(cast(std_logic_vector(inp), old_bin_pt, new_width, new_bin_pt, xlSigned));
    end;
    function u2s_cast (inp : unsigned; old_bin_pt, new_width,
                   new_bin_pt : INTEGER)
        return signed
    is
    begin
        return signed(cast(std_logic_vector(inp), old_bin_pt, new_width, new_bin_pt, xlUnsigned));
    end;
    function u2u_cast (inp : unsigned; old_bin_pt, new_width,
                   new_bin_pt : INTEGER)
        return unsigned
    is
    begin
        return unsigned(cast(std_logic_vector(inp), old_bin_pt, new_width, new_bin_pt, xlUnsigned));
    end;
    function u2v_cast (inp : unsigned; old_bin_pt, new_width,
                   new_bin_pt : INTEGER)
        return std_logic_vector
    is
    begin
        return cast(std_logic_vector(inp), old_bin_pt, new_width, new_bin_pt, xlUnsigned);
    end;
    function s2v_cast (inp : signed; old_bin_pt, new_width,
                   new_bin_pt : INTEGER)
        return std_logic_vector
    is
    begin
        return cast(std_logic_vector(inp), old_bin_pt, new_width, new_bin_pt, xlSigned);
    end;
    function boolean_to_signed (inp : boolean; width : integer)
        return signed
    is
        variable result : signed(width - 1 downto 0);
    begin
        result := (others => '0');
        if inp then
          result(0) := '1';
        else
          result(0) := '0';
        end if;
        return result;
    end;
    function boolean_to_unsigned (inp : boolean; width : integer)
        return unsigned
    is
        variable result : unsigned(width - 1 downto 0);
    begin
        result := (others => '0');
        if inp then
          result(0) := '1';
        else
          result(0) := '0';
        end if;
        return result;
    end;
    function boolean_to_vector (inp : boolean)
        return std_logic_vector
    is
        variable result : std_logic_vector(1 - 1 downto 0);
    begin
        result := (others => '0');
        if inp then
          result(0) := '1';
        else
          result(0) := '0';
        end if;
        return result;
    end;
    function std_logic_to_vector (inp : std_logic)
        return std_logic_vector
    is
        variable result : std_logic_vector(1 - 1 downto 0);
    begin
        result(0) := inp;
        return result;
    end;
    function trunc (inp : std_logic_vector; old_width, old_bin_pt, old_arith,
                                new_width, new_bin_pt, new_arith : INTEGER)
        return std_logic_vector
    is
        constant right_of_dp : integer := (old_bin_pt - new_bin_pt);
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if right_of_dp >= 0 then
            if new_arith = xlUnsigned then
                result := zero_ext(vec(old_width-1 downto right_of_dp), new_width);
            else
                result := sign_ext(vec(old_width-1 downto right_of_dp), new_width);
            end if;
        else
            if new_arith = xlUnsigned then
                result := zero_ext(pad_LSB(vec, old_width +
                                           abs(right_of_dp)), new_width);
            else
                result := sign_ext(pad_LSB(vec, old_width +
                                           abs(right_of_dp)), new_width);
            end if;
        end if;
        return result;
    end;
    function round_towards_inf (inp : std_logic_vector; old_width, old_bin_pt,
                                old_arith, new_width, new_bin_pt, new_arith
                                : INTEGER)
        return std_logic_vector
    is
        constant right_of_dp : integer := (old_bin_pt - new_bin_pt);
        constant expected_new_width : integer :=  old_width - right_of_dp  + 1;
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable one_or_zero : std_logic_vector(new_width-1 downto 0);
        variable truncated_val : std_logic_vector(new_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if right_of_dp >= 0 then
            if new_arith = xlUnsigned then
                truncated_val := zero_ext(vec(old_width-1 downto right_of_dp),
                                          new_width);
            else
                truncated_val := sign_ext(vec(old_width-1 downto right_of_dp),
                                          new_width);
            end if;
        else
            if new_arith = xlUnsigned then
                truncated_val := zero_ext(pad_LSB(vec, old_width +
                                                  abs(right_of_dp)), new_width);
            else
                truncated_val := sign_ext(pad_LSB(vec, old_width +
                                                  abs(right_of_dp)), new_width);
            end if;
        end if;
        one_or_zero := (others => '0');
        if (new_arith = xlSigned) then
            if (vec(old_width-1) = '0') then
                one_or_zero(0) := '1';
            end if;
            if (right_of_dp >= 2) and (right_of_dp <= old_width) then
                if (all_zeros(vec(right_of_dp-2 downto 0)) = false) then
                    one_or_zero(0) := '1';
                end if;
            end if;
            if (right_of_dp >= 1) and (right_of_dp <= old_width) then
                if vec(right_of_dp-1) = '0' then
                    one_or_zero(0) := '0';
                end if;
            else
                one_or_zero(0) := '0';
            end if;
        else
            if (right_of_dp >= 1) and (right_of_dp <= old_width) then
                one_or_zero(0) :=  vec(right_of_dp-1);
            end if;
        end if;
        if new_arith = xlSigned then
            result := signed_to_std_logic_vector(std_logic_vector_to_signed(truncated_val) +
                                                 std_logic_vector_to_signed(one_or_zero));
        else
            result := unsigned_to_std_logic_vector(std_logic_vector_to_unsigned(truncated_val) +
                                                  std_logic_vector_to_unsigned(one_or_zero));
        end if;
        return result;
    end;
    function round_towards_even (inp : std_logic_vector; old_width, old_bin_pt,
                                old_arith, new_width, new_bin_pt, new_arith
                                : INTEGER)
        return std_logic_vector
    is
        constant right_of_dp : integer := (old_bin_pt - new_bin_pt);
        constant expected_new_width : integer :=  old_width - right_of_dp  + 1;
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable one_or_zero : std_logic_vector(new_width-1 downto 0);
        variable truncated_val : std_logic_vector(new_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if right_of_dp >= 0 then
            if new_arith = xlUnsigned then
                truncated_val := zero_ext(vec(old_width-1 downto right_of_dp),
                                          new_width);
            else
                truncated_val := sign_ext(vec(old_width-1 downto right_of_dp),
                                          new_width);
            end if;
        else
            if new_arith = xlUnsigned then
                truncated_val := zero_ext(pad_LSB(vec, old_width +
                                                  abs(right_of_dp)), new_width);
            else
                truncated_val := sign_ext(pad_LSB(vec, old_width +
                                                  abs(right_of_dp)), new_width);
            end if;
        end if;
        one_or_zero := (others => '0');
        if (right_of_dp >= 1) and (right_of_dp <= old_width) then
            if (is_point_five(vec(right_of_dp-1 downto 0)) = false) then
                one_or_zero(0) :=  vec(right_of_dp-1);
            else
                one_or_zero(0) :=  vec(right_of_dp);
            end if;
        end if;
        if new_arith = xlSigned then
            result := signed_to_std_logic_vector(std_logic_vector_to_signed(truncated_val) +
                                                 std_logic_vector_to_signed(one_or_zero));
        else
            result := unsigned_to_std_logic_vector(std_logic_vector_to_unsigned(truncated_val) +
                                                  std_logic_vector_to_unsigned(one_or_zero));
        end if;
        return result;
    end;
    function saturation_arith(inp:  std_logic_vector;  old_width, old_bin_pt,
                              old_arith, new_width, new_bin_pt, new_arith
                              : INTEGER)
        return std_logic_vector
    is
        constant left_of_dp : integer := (old_width - old_bin_pt) -
                                         (new_width - new_bin_pt);
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
        variable overflow : boolean;
    begin
        vec := inp;
        overflow := true;
        result := (others => '0');
        if (new_width >= old_width) then
            overflow := false;
        end if;
        if ((old_arith = xlSigned and new_arith = xlSigned) and (old_width > new_width)) then
            if all_same(vec(old_width-1 downto new_width-1)) then
                overflow := false;
            end if;
        end if;
        if (old_arith = xlSigned and new_arith = xlUnsigned) then
            if (old_width > new_width) then
                if all_zeros(vec(old_width-1 downto new_width)) then
                    overflow := false;
                end if;
            else
                if (old_width = new_width) then
                    if (vec(new_width-1) = '0') then
                        overflow := false;
                    end if;
                end if;
            end if;
        end if;
        if (old_arith = xlUnsigned and new_arith = xlUnsigned) then
            if (old_width > new_width) then
                if all_zeros(vec(old_width-1 downto new_width)) then
                    overflow := false;
                end if;
            else
                if (old_width = new_width) then
                    overflow := false;
                end if;
            end if;
        end if;
        if ((old_arith = xlUnsigned and new_arith = xlSigned) and (old_width > new_width)) then
            if all_same(vec(old_width-1 downto new_width-1)) then
                overflow := false;
            end if;
        end if;
        if overflow then
            if new_arith = xlSigned then
                if vec(old_width-1) = '0' then
                    result := max_signed(new_width);
                else
                    result := min_signed(new_width);
                end if;
            else
                if ((old_arith = xlSigned) and vec(old_width-1) = '1') then
                    result := (others => '0');
                else
                    result := (others => '1');
                end if;
            end if;
        else
            if (old_arith = xlSigned) and (new_arith = xlUnsigned) then
                if (vec(old_width-1) = '1') then
                    vec := (others => '0');
                end if;
            end if;
            if new_width <= old_width then
                result := vec(new_width-1 downto 0);
            else
                if new_arith = xlUnsigned then
                    result := zero_ext(vec, new_width);
                else
                    result := sign_ext(vec, new_width);
                end if;
            end if;
        end if;
        return result;
    end;
   function wrap_arith(inp:  std_logic_vector;  old_width, old_bin_pt,
                       old_arith, new_width, new_bin_pt, new_arith : INTEGER)
        return std_logic_vector
    is
        variable result : std_logic_vector(new_width-1 downto 0);
        variable result_arith : integer;
    begin
        if (old_arith = xlSigned) and (new_arith = xlUnsigned) then
            result_arith := xlSigned;
        end if;
        result := cast(inp, old_bin_pt, new_width, new_bin_pt, result_arith);
        return result;
    end;
    function fractional_bits(a_bin_pt, b_bin_pt: INTEGER) return INTEGER is
    begin
        return max(a_bin_pt, b_bin_pt);
    end;
    function integer_bits(a_width, a_bin_pt, b_width, b_bin_pt: INTEGER)
        return INTEGER is
    begin
        return  max(a_width - a_bin_pt, b_width - b_bin_pt);
    end;
    function pad_LSB(inp : std_logic_vector; new_width: integer)
        return STD_LOGIC_VECTOR
    is
        constant orig_width : integer := inp'length;
        variable vec : std_logic_vector(orig_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
        variable pos : integer;
        constant pad_pos : integer := new_width - orig_width - 1;
    begin
        vec := inp;
        pos := new_width-1;
        if (new_width >= orig_width) then
            for i in orig_width-1 downto 0 loop
                result(pos) := vec(i);
                pos := pos - 1;
            end loop;
            if pad_pos >= 0 then
                for i in pad_pos downto 0 loop
                    result(i) := '0';
                end loop;
            end if;
        end if;
        return result;
    end;
    function sign_ext(inp : std_logic_vector; new_width : INTEGER)
        return std_logic_vector
    is
        constant old_width : integer := inp'length;
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if new_width >= old_width then
            result(old_width-1 downto 0) := vec;
            if new_width-1 >= old_width then
                for i in new_width-1 downto old_width loop
                    result(i) := vec(old_width-1);
                end loop;
            end if;
        else
            result(new_width-1 downto 0) := vec(new_width-1 downto 0);
        end if;
        return result;
    end;
    function zero_ext(inp : std_logic_vector; new_width : INTEGER)
        return std_logic_vector
    is
        constant old_width : integer := inp'length;
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if new_width >= old_width then
            result(old_width-1 downto 0) := vec;
            if new_width-1 >= old_width then
                for i in new_width-1 downto old_width loop
                    result(i) := '0';
                end loop;
            end if;
        else
            result(new_width-1 downto 0) := vec(new_width-1 downto 0);
        end if;
        return result;
    end;
    function zero_ext(inp : std_logic; new_width : INTEGER)
        return std_logic_vector
    is
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        result(0) := inp;
        for i in new_width-1 downto 1 loop
            result(i) := '0';
        end loop;
        return result;
    end;
    function extend_MSB(inp : std_logic_vector; new_width, arith : INTEGER)
        return std_logic_vector
    is
        constant orig_width : integer := inp'length;
        variable vec : std_logic_vector(orig_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if arith = xlUnsigned then
            result := zero_ext(vec, new_width);
        else
            result := sign_ext(vec, new_width);
        end if;
        return result;
    end;
    function pad_LSB(inp : std_logic_vector; new_width, arith: integer)
        return STD_LOGIC_VECTOR
    is
        constant orig_width : integer := inp'length;
        variable vec : std_logic_vector(orig_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
        variable pos : integer;
    begin
        vec := inp;
        pos := new_width-1;
        if (arith = xlUnsigned) then
            result(pos) := '0';
            pos := pos - 1;
        else
            result(pos) := vec(orig_width-1);
            pos := pos - 1;
        end if;
        if (new_width >= orig_width) then
            for i in orig_width-1 downto 0 loop
                result(pos) := vec(i);
                pos := pos - 1;
            end loop;
            if pos >= 0 then
                for i in pos downto 0 loop
                    result(i) := '0';
                end loop;
            end if;
        end if;
        return result;
    end;
    function align_input(inp : std_logic_vector; old_width, delta, new_arith,
                         new_width: INTEGER)
        return std_logic_vector
    is
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable padded_inp : std_logic_vector((old_width + delta)-1  downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if delta > 0 then
            padded_inp := pad_LSB(vec, old_width+delta);
            result := extend_MSB(padded_inp, new_width, new_arith);
        else
            result := extend_MSB(vec, new_width, new_arith);
        end if;
        return result;
    end;
    function max(L, R: INTEGER) return INTEGER is
    begin
        if L > R then
            return L;
        else
            return R;
        end if;
    end;
    function min(L, R: INTEGER) return INTEGER is
    begin
        if L < R then
            return L;
        else
            return R;
        end if;
    end;
    function "="(left,right: STRING) return boolean is
    begin
        if (left'length /= right'length) then
            return false;
        else
            test : for i in 1 to left'length loop
                if left(i) /= right(i) then
                    return false;
                end if;
            end loop test;
            return true;
        end if;
    end;
    -- synopsys translate_off
    function is_binary_string_invalid (inp : string)
        return boolean
    is
        variable vec : string(1 to inp'length);
        variable result : boolean;
    begin
        vec := inp;
        result := false;
        for i in 1 to vec'length loop
            if ( vec(i) = 'X' ) then
                result := true;
            end if;
        end loop;
        return result;
    end;
    function is_binary_string_undefined (inp : string)
        return boolean
    is
        variable vec : string(1 to inp'length);
        variable result : boolean;
    begin
        vec := inp;
        result := false;
        for i in 1 to vec'length loop
            if ( vec(i) = 'U' ) then
                result := true;
            end if;
        end loop;
        return result;
    end;
    function is_XorU(inp : std_logic_vector)
        return boolean
    is
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
        variable result : boolean;
    begin
        vec := inp;
        result := false;
        for i in 0 to width-1 loop
            if (vec(i) = 'U') or (vec(i) = 'X') then
                result := true;
            end if;
        end loop;
        return result;
    end;
    function to_real(inp : std_logic_vector; bin_pt : integer; arith : integer)
        return real
    is
        variable  vec : std_logic_vector(inp'length-1 downto 0);
        variable result, shift_val, undefined_real : real;
        variable neg_num : boolean;
    begin
        vec := inp;
        result := 0.0;
        neg_num := false;
        if vec(inp'length-1) = '1' then
            neg_num := true;
        end if;
        for i in 0 to inp'length-1 loop
            if  vec(i) = 'U' or vec(i) = 'X' then
                return undefined_real;
            end if;
            if arith = xlSigned then
                if neg_num then
                    if vec(i) = '0' then
                        result := result + 2.0**i;
                    end if;
                else
                    if vec(i) = '1' then
                        result := result + 2.0**i;
                    end if;
                end if;
            else
                if vec(i) = '1' then
                    result := result + 2.0**i;
                end if;
            end if;
        end loop;
        if arith = xlSigned then
            if neg_num then
                result := result + 1.0;
                result := result * (-1.0);
            end if;
        end if;
        shift_val := 2.0**(-1*bin_pt);
        result := result * shift_val;
        return result;
    end;
    function std_logic_to_real(inp : std_logic; bin_pt : integer; arith : integer)
        return real
    is
        variable result : real := 0.0;
    begin
        if inp = '1' then
            result := 1.0;
        end if;
        if arith = xlSigned then
            assert false
                report "It doesn't make sense to convert a 1 bit number to a signed real.";
        end if;
        return result;
    end;
    -- synopsys translate_on
    function integer_to_std_logic_vector (inp : integer;  width, arith : integer)
        return std_logic_vector
    is
        variable result : std_logic_vector(width-1 downto 0);
        variable unsigned_val : unsigned(width-1 downto 0);
        variable signed_val : signed(width-1 downto 0);
    begin
        if (arith = xlSigned) then
            signed_val := to_signed(inp, width);
            result := signed_to_std_logic_vector(signed_val);
        else
            unsigned_val := to_unsigned(inp, width);
            result := unsigned_to_std_logic_vector(unsigned_val);
        end if;
        return result;
    end;
    function std_logic_vector_to_integer (inp : std_logic_vector;  arith : integer)
        return integer
    is
        constant width : integer := inp'length;
        variable unsigned_val : unsigned(width-1 downto 0);
        variable signed_val : signed(width-1 downto 0);
        variable result : integer;
    begin
        if (arith = xlSigned) then
            signed_val := std_logic_vector_to_signed(inp);
            result := to_integer(signed_val);
        else
            unsigned_val := std_logic_vector_to_unsigned(inp);
            result := to_integer(unsigned_val);
        end if;
        return result;
    end;
    function std_logic_to_integer(constant inp : std_logic := '0')
        return integer
    is
    begin
        if inp = '1' then
            return 1;
        else
            return 0;
        end if;
    end;
    function makeZeroBinStr (width : integer) return STRING is
        variable result : string(1 to width+3);
    begin
        result(1) := '0';
        result(2) := 'b';
        for i in 3 to width+2 loop
            result(i) := '0';
        end loop;
        result(width+3) := '.';
        return result;
    end;
    -- synopsys translate_off
    function real_string_to_std_logic_vector (inp : string;  width, bin_pt, arith : integer)
        return std_logic_vector
    is
        variable result : std_logic_vector(width-1 downto 0);
    begin
        result := (others => '0');
        return result;
    end;
    function real_to_std_logic_vector (inp : real;  width, bin_pt, arith : integer)
        return std_logic_vector
    is
        variable real_val : real;
        variable int_val : integer;
        variable result : std_logic_vector(width-1 downto 0) := (others => '0');
        variable unsigned_val : unsigned(width-1 downto 0) := (others => '0');
        variable signed_val : signed(width-1 downto 0) := (others => '0');
    begin
        real_val := inp;
        int_val := integer(real_val * 2.0**(bin_pt));
        if (arith = xlSigned) then
            signed_val := to_signed(int_val, width);
            result := signed_to_std_logic_vector(signed_val);
        else
            unsigned_val := to_unsigned(int_val, width);
            result := unsigned_to_std_logic_vector(unsigned_val);
        end if;
        return result;
    end;
    -- synopsys translate_on
    function valid_bin_string (inp : string)
        return boolean
    is
        variable vec : string(1 to inp'length);
    begin
        vec := inp;
        if (vec(1) = '0' and vec(2) = 'b') then
            return true;
        else
            return false;
        end if;
    end;
    function hex_string_to_std_logic_vector(inp: string; width : integer)
        return std_logic_vector is
        constant strlen       : integer := inp'LENGTH;
        variable result       : std_logic_vector(width-1 downto 0);
        variable bitval       : std_logic_vector((strlen*4)-1 downto 0);
        variable posn         : integer;
        variable ch           : character;
        variable vec          : string(1 to strlen);
    begin
        vec := inp;
        result := (others => '0');
        posn := (strlen*4)-1;
        for i in 1 to strlen loop
            ch := vec(i);
            case ch is
                when '0' => bitval(posn downto posn-3) := "0000";
                when '1' => bitval(posn downto posn-3) := "0001";
                when '2' => bitval(posn downto posn-3) := "0010";
                when '3' => bitval(posn downto posn-3) := "0011";
                when '4' => bitval(posn downto posn-3) := "0100";
                when '5' => bitval(posn downto posn-3) := "0101";
                when '6' => bitval(posn downto posn-3) := "0110";
                when '7' => bitval(posn downto posn-3) := "0111";
                when '8' => bitval(posn downto posn-3) := "1000";
                when '9' => bitval(posn downto posn-3) := "1001";
                when 'A' | 'a' => bitval(posn downto posn-3) := "1010";
                when 'B' | 'b' => bitval(posn downto posn-3) := "1011";
                when 'C' | 'c' => bitval(posn downto posn-3) := "1100";
                when 'D' | 'd' => bitval(posn downto posn-3) := "1101";
                when 'E' | 'e' => bitval(posn downto posn-3) := "1110";
                when 'F' | 'f' => bitval(posn downto posn-3) := "1111";
                when others => bitval(posn downto posn-3) := "XXXX";
                               -- synopsys translate_off
                               ASSERT false
                                   REPORT "Invalid hex value" SEVERITY ERROR;
                               -- synopsys translate_on
            end case;
            posn := posn - 4;
        end loop;
        if (width <= strlen*4) then
            result :=  bitval(width-1 downto 0);
        else
            result((strlen*4)-1 downto 0) := bitval;
        end if;
        return result;
    end;
    function bin_string_to_std_logic_vector (inp : string)
        return std_logic_vector
    is
        variable pos : integer;
        variable vec : string(1 to inp'length);
        variable result : std_logic_vector(inp'length-1 downto 0);
    begin
        vec := inp;
        pos := inp'length-1;
        result := (others => '0');
        for i in 1 to vec'length loop
            -- synopsys translate_off
            if (pos < 0) and (vec(i) = '0' or vec(i) = '1' or vec(i) = 'X' or vec(i) = 'U')  then
                assert false
                    report "Input string is larger than output std_logic_vector. Truncating output.";
                return result;
            end if;
            -- synopsys translate_on
            if vec(i) = '0' then
                result(pos) := '0';
                pos := pos - 1;
            end if;
            if vec(i) = '1' then
                result(pos) := '1';
                pos := pos - 1;
            end if;
            -- synopsys translate_off
            if (vec(i) = 'X' or vec(i) = 'U') then
                result(pos) := 'U';
                pos := pos - 1;
            end if;
            -- synopsys translate_on
        end loop;
        return result;
    end;
    function bin_string_element_to_std_logic_vector (inp : string;  width, index : integer)
        return std_logic_vector
    is
        constant str_width : integer := width + 4;
        constant inp_len : integer := inp'length;
        constant num_elements : integer := (inp_len + 1)/str_width;
        constant reverse_index : integer := (num_elements-1) - index;
        variable left_pos : integer;
        variable right_pos : integer;
        variable vec : string(1 to inp'length);
        variable result : std_logic_vector(width-1 downto 0);
    begin
        vec := inp;
        result := (others => '0');
        if (reverse_index = 0) and (reverse_index < num_elements) and (inp_len-3 >= width) then
            left_pos := 1;
            right_pos := width + 3;
            result := bin_string_to_std_logic_vector(vec(left_pos to right_pos));
        end if;
        if (reverse_index > 0) and (reverse_index < num_elements) and (inp_len-3 >= width) then
            left_pos := (reverse_index * str_width) + 1;
            right_pos := left_pos + width + 2;
            result := bin_string_to_std_logic_vector(vec(left_pos to right_pos));
        end if;
        return result;
    end;
   -- synopsys translate_off
    function std_logic_vector_to_bin_string(inp : std_logic_vector)
        return string
    is
        variable vec : std_logic_vector(1 to inp'length);
        variable result : string(vec'range);
    begin
        vec := inp;
        for i in vec'range loop
            result(i) := to_char(vec(i));
        end loop;
        return result;
    end;
    function std_logic_to_bin_string(inp : std_logic)
        return string
    is
        variable result : string(1 to 3);
    begin
        result(1) := '0';
        result(2) := 'b';
        result(3) := to_char(inp);
        return result;
    end;
    function std_logic_vector_to_bin_string_w_point(inp : std_logic_vector; bin_pt : integer)
        return string
    is
        variable width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
        variable str_pos : integer;
        variable result : string(1 to width+3);
    begin
        vec := inp;
        str_pos := 1;
        result(str_pos) := '0';
        str_pos := 2;
        result(str_pos) := 'b';
        str_pos := 3;
        for i in width-1 downto 0  loop
            if (((width+3) - bin_pt) = str_pos) then
                result(str_pos) := '.';
                str_pos := str_pos + 1;
            end if;
            result(str_pos) := to_char(vec(i));
            str_pos := str_pos + 1;
        end loop;
        if (bin_pt = 0) then
            result(str_pos) := '.';
        end if;
        return result;
    end;
    function real_to_bin_string(inp : real;  width, bin_pt, arith : integer)
        return string
    is
        variable result : string(1 to width);
        variable vec : std_logic_vector(width-1 downto 0);
    begin
        vec := real_to_std_logic_vector(inp, width, bin_pt, arith);
        result := std_logic_vector_to_bin_string(vec);
        return result;
    end;
    function real_to_string (inp : real) return string
    is
        variable result : string(1 to display_precision) := (others => ' ');
    begin
        result(real'image(inp)'range) := real'image(inp);
        return result;
    end;
    -- synopsys translate_on
end conv_pkg;

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
-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity srl17e is
    generic (width : integer:=16;
             latency : integer :=8);
    port (clk   : in std_logic;
          ce    : in std_logic;
          d     : in std_logic_vector(width-1 downto 0);
          q     : out std_logic_vector(width-1 downto 0));
end srl17e;
architecture structural of srl17e is
    component SRL16E
        port (D   : in STD_ULOGIC;
              CE  : in STD_ULOGIC;
              CLK : in STD_ULOGIC;
              A0  : in STD_ULOGIC;
              A1  : in STD_ULOGIC;
              A2  : in STD_ULOGIC;
              A3  : in STD_ULOGIC;
              Q   : out STD_ULOGIC);
    end component;
    attribute syn_black_box of SRL16E : component is true;
    attribute fpga_dont_touch of SRL16E : component is "true";
    component FDE
        port(
            Q  :        out   STD_ULOGIC;
            D  :        in    STD_ULOGIC;
            C  :        in    STD_ULOGIC;
            CE :        in    STD_ULOGIC);
    end component;
    attribute syn_black_box of FDE : component is true;
    attribute fpga_dont_touch of FDE : component is "true";
    constant a : std_logic_vector(4 downto 0) :=
        integer_to_std_logic_vector(latency-2,5,xlSigned);
    signal d_delayed : std_logic_vector(width-1 downto 0);
    signal srl16_out : std_logic_vector(width-1 downto 0);
begin
    d_delayed <= d after 200 ps;
    reg_array : for i in 0 to width-1 generate
        srl16_used: if latency > 1 generate
            u1 : srl16e port map(clk => clk,
                                 d => d_delayed(i),
                                 q => srl16_out(i),
                                 ce => ce,
                                 a0 => a(0),
                                 a1 => a(1),
                                 a2 => a(2),
                                 a3 => a(3));
        end generate;
        srl16_not_used: if latency <= 1 generate
            srl16_out(i) <= d_delayed(i);
        end generate;
        fde_used: if latency /= 0  generate
            u2 : fde port map(c => clk,
                              d => srl16_out(i),
                              q => q(i),
                              ce => ce);
        end generate;
        fde_not_used: if latency = 0  generate
            q(i) <= srl16_out(i);
        end generate;
    end generate;
 end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity synth_reg is
    generic (width           : integer := 8;
             latency         : integer := 1);
    port (i       : in std_logic_vector(width-1 downto 0);
          ce      : in std_logic;
          clr     : in std_logic;
          clk     : in std_logic;
          o       : out std_logic_vector(width-1 downto 0));
end synth_reg;
architecture structural of synth_reg is
    component srl17e
        generic (width : integer:=16;
                 latency : integer :=8);
        port (clk : in std_logic;
              ce  : in std_logic;
              d   : in std_logic_vector(width-1 downto 0);
              q   : out std_logic_vector(width-1 downto 0));
    end component;
    function calc_num_srl17es (latency : integer)
        return integer
    is
        variable remaining_latency : integer;
        variable result : integer;
    begin
        result := latency / 17;
        remaining_latency := latency - (result * 17);
        if (remaining_latency /= 0) then
            result := result + 1;
        end if;
        return result;
    end;
    constant complete_num_srl17es : integer := latency / 17;
    constant num_srl17es : integer := calc_num_srl17es(latency);
    constant remaining_latency : integer := latency - (complete_num_srl17es * 17);
    type register_array is array (num_srl17es downto 0) of
        std_logic_vector(width-1 downto 0);
    signal z : register_array;
begin
    z(0) <= i;
    complete_ones : if complete_num_srl17es > 0 generate
        srl17e_array: for i in 0 to complete_num_srl17es-1 generate
            delay_comp : srl17e
                generic map (width => width,
                             latency => 17)
                port map (clk => clk,
                          ce  => ce,
                          d       => z(i),
                          q       => z(i+1));
        end generate;
    end generate;
    partial_one : if remaining_latency > 0 generate
        last_srl17e : srl17e
            generic map (width => width,
                         latency => remaining_latency)
            port map (clk => clk,
                      ce  => ce,
                      d   => z(num_srl17es-1),
                      q   => z(num_srl17es));
    end generate;
    o <= z(num_srl17es);
end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity synth_reg_reg is
    generic (width           : integer := 8;
             latency         : integer := 1);
    port (i       : in std_logic_vector(width-1 downto 0);
          ce      : in std_logic;
          clr     : in std_logic;
          clk     : in std_logic;
          o       : out std_logic_vector(width-1 downto 0));
end synth_reg_reg;
architecture behav of synth_reg_reg is
  type reg_array_type is array (latency-1 downto 0) of std_logic_vector(width -1 downto 0);
  signal reg_bank : reg_array_type := (others => (others => '0'));
  signal reg_bank_in : reg_array_type := (others => (others => '0'));
  attribute syn_allow_retiming : boolean;
  attribute syn_srlstyle : string;
  attribute syn_allow_retiming of reg_bank : signal is true;
  attribute syn_allow_retiming of reg_bank_in : signal is true;
  attribute syn_srlstyle of reg_bank : signal is "registers";
  attribute syn_srlstyle of reg_bank_in : signal is "registers";
begin
  latency_eq_0: if latency = 0 generate
    o <= i;
  end generate latency_eq_0;
  latency_gt_0: if latency >= 1 generate
    o <= reg_bank(latency-1);
    reg_bank_in(0) <= i;
    loop_gen: for idx in latency-2 downto 0 generate
      reg_bank_in(idx+1) <= reg_bank(idx);
    end generate loop_gen;
    sync_loop: for sync_idx in latency-1 downto 0 generate
      sync_proc: process (clk)
      begin
        if clk'event and clk = '1' then
          if clr = '1' then
            reg_bank_in <= (others => (others => '0'));
          elsif ce = '1'  then
            reg_bank(sync_idx) <= reg_bank_in(sync_idx);
          end if;
        end if;
      end process sync_proc;
    end generate sync_loop;
  end generate latency_gt_0;
end behav;

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
-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity single_reg_w_init is
  generic (
    width: integer := 8;
    init_index: integer := 0;
    init_value: bit_vector := b"0000"
  );
  port (
    i: in std_logic_vector(width - 1 downto 0);
    ce: in std_logic;
    clr: in std_logic;
    clk: in std_logic;
    o: out std_logic_vector(width - 1 downto 0)
  );
end single_reg_w_init;
architecture structural of single_reg_w_init is
  function build_init_const(width: integer;
                            init_index: integer;
                            init_value: bit_vector)
    return std_logic_vector
  is
    variable result: std_logic_vector(width - 1 downto 0);
  begin
    if init_index = 0 then
      result := (others => '0');
    elsif init_index = 1 then
      result := (others => '0');
      result(0) := '1';
    else
      result := to_stdlogicvector(init_value);
    end if;
    return result;
  end;
  component fdre
    port (
      q: out std_ulogic;
      d: in  std_ulogic;
      c: in  std_ulogic;
      ce: in  std_ulogic;
      r: in  std_ulogic
    );
  end component;
  attribute syn_black_box of fdre: component is true;
  attribute fpga_dont_touch of fdre: component is "true";
  component fdse
    port (
      q: out std_ulogic;
      d: in  std_ulogic;
      c: in  std_ulogic;
      ce: in  std_ulogic;
      s: in  std_ulogic
    );
  end component;
  attribute syn_black_box of fdse: component is true;
  attribute fpga_dont_touch of fdse: component is "true";
  constant init_const: std_logic_vector(width - 1 downto 0)
    := build_init_const(width, init_index, init_value);
begin
  fd_prim_array: for index in 0 to width - 1 generate
    bit_is_0: if (init_const(index) = '0') generate
      fdre_comp: fdre
        port map (
          c => clk,
          d => i(index),
          q => o(index),
          ce => ce,
          r => clr
        );
    end generate;
    bit_is_1: if (init_const(index) = '1') generate
      fdse_comp: fdse
        port map (
          c => clk,
          d => i(index),
          q => o(index),
          ce => ce,
          s => clr
        );
    end generate;
  end generate;
end architecture structural;
-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity synth_reg_w_init is
  generic (
    width: integer := 8;
    init_index: integer := 0;
    init_value: bit_vector := b"0000";
    latency: integer := 1
  );
  port (
    i: in std_logic_vector(width - 1 downto 0);
    ce: in std_logic;
    clr: in std_logic;
    clk: in std_logic;
    o: out std_logic_vector(width - 1 downto 0)
  );
end synth_reg_w_init;
architecture structural of synth_reg_w_init is
  component single_reg_w_init
    generic (
      width: integer := 8;
      init_index: integer := 0;
      init_value: bit_vector := b"0000"
    );
    port (
      i: in std_logic_vector(width - 1 downto 0);
      ce: in std_logic;
      clr: in std_logic;
      clk: in std_logic;
      o: out std_logic_vector(width - 1 downto 0)
    );
  end component;
  signal dly_i: std_logic_vector((latency + 1) * width - 1 downto 0);
  signal dly_clr: std_logic;
begin
  latency_eq_0: if (latency = 0) generate
    o <= i;
  end generate;
  latency_gt_0: if (latency >= 1) generate
    dly_i((latency + 1) * width - 1 downto latency * width) <= i
      after 200 ps;
    dly_clr <= clr after 200 ps;
    fd_array: for index in latency downto 1 generate
       reg_comp: single_reg_w_init
          generic map (
            width => width,
            init_index => init_index,
            init_value => init_value
          )
          port map (
            clk => clk,
            i => dly_i((index + 1) * width - 1 downto index * width),
            o => dly_i(index * width - 1 downto (index - 1) * width),
            ce => ce,
            clr => dly_clr
          );
    end generate;
    o <= dly_i(width - 1 downto 0);
  end generate;
end structural;

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
use work.conv_pkg.all;
entity xldelay is
   generic(width        : integer := -1;
           latency      : integer := -1;
           reg_retiming : integer :=  0;
           reset        : integer :=  0);
   port(d       : in std_logic_vector (width-1 downto 0);
        ce      : in std_logic;
        clk     : in std_logic;
        en      : in std_logic;
        rst     : in std_logic;
        q       : out std_logic_vector (width-1 downto 0));
end xldelay;
architecture behavior of xldelay is
   component synth_reg
      generic (width       : integer;
               latency     : integer);
      port (i       : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component;
   component synth_reg_reg
      generic (width       : integer;
               latency     : integer);
      port (i       : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component;
   signal internal_ce  : std_logic;
begin
   internal_ce  <= ce and en;
   srl_delay: if ((reg_retiming = 0) and (reset = 0)) or (latency < 1) generate
     synth_reg_srl_inst : synth_reg
       generic map (
         width   => width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => '0',
         clk => clk,
         o   => q);
   end generate srl_delay;
   reg_delay: if ((reg_retiming = 1) or (reset = 1)) and (latency >= 1) generate
     synth_reg_reg_inst : synth_reg_reg
       generic map (
         width   => width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => rst,
         clk => clk,
         o   => q);
   end generate reg_delay;
end architecture behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity inverter_e5b38cca3b is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter_e5b38cca3b;


architecture behavior of inverter_e5b38cca3b is
  signal ip_1_26: boolean;
  type array_type_op_mem_22_20 is array (0 to (1 - 1)) of boolean;
  signal op_mem_22_20: array_type_op_mem_22_20 := (
    0 => false);
  signal op_mem_22_20_front_din: boolean;
  signal op_mem_22_20_back: boolean;
  signal op_mem_22_20_push_front_pop_back_en: std_logic;
  signal internal_ip_12_1_bitnot: boolean;
begin
  ip_1_26 <= ((ip) = "1");
  op_mem_22_20_back <= op_mem_22_20(0);
  proc_op_mem_22_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_22_20_push_front_pop_back_en = '1')) then
        op_mem_22_20(0) <= op_mem_22_20_front_din;
      end if;
    end if;
  end process proc_op_mem_22_20;
  internal_ip_12_1_bitnot <= ((not boolean_to_vector(ip_1_26)) = "1");
  op_mem_22_20_push_front_pop_back_en <= '0';
  op <= boolean_to_vector(internal_ip_12_1_bitnot);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity logical_80f90b97d0 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_80f90b97d0;


architecture behavior of logical_80f90b97d0 is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  fully_2_1_bit <= d0_1_24 and d1_1_27;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;


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
-- synopsys translate_off
library XilinxCoreLib;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity xlcounter_free_wlan_mac_dcf_hw is
  generic (
    core_name0: string := "";
    op_width: integer := 5;
    op_arith: integer := xlSigned
  );
  port (
    ce: in std_logic;
    clr: in std_logic;
    clk: in std_logic;
    op: out std_logic_vector(op_width - 1 downto 0);
    up: in std_logic_vector(0 downto 0) := (others => '0');
    load: in std_logic_vector(0 downto 0) := (others => '0');
    din: in std_logic_vector(op_width - 1 downto 0) := (others => '0');
    en: in std_logic_vector(0 downto 0);
    rst: in std_logic_vector(0 downto 0)
  );
end xlcounter_free_wlan_mac_dcf_hw ;
architecture behavior of xlcounter_free_wlan_mac_dcf_hw is
  component cntr_11_0_86806e294f737f4c
    port (
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of cntr_11_0_86806e294f737f4c:
    component is true;
  attribute fpga_dont_touch of cntr_11_0_86806e294f737f4c:
    component is "true";
  attribute box_type of cntr_11_0_86806e294f737f4c:
    component  is "black_box";
  component cntr_11_0_5e62871cb125c52e
    port (
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      load: in std_logic;
      l: in std_logic_vector(op_width - 1 downto 0);
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of cntr_11_0_5e62871cb125c52e:
    component is true;
  attribute fpga_dont_touch of cntr_11_0_5e62871cb125c52e:
    component is "true";
  attribute box_type of cntr_11_0_5e62871cb125c52e:
    component  is "black_box";
  component cntr_11_0_66919a0f29965143
    port (
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of cntr_11_0_66919a0f29965143:
    component is true;
  attribute fpga_dont_touch of cntr_11_0_66919a0f29965143:
    component is "true";
  attribute box_type of cntr_11_0_66919a0f29965143:
    component  is "black_box";
  component cntr_11_0_23bc6491dc8a06da
    port (
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of cntr_11_0_23bc6491dc8a06da:
    component is true;
  attribute fpga_dont_touch of cntr_11_0_23bc6491dc8a06da:
    component is "true";
  attribute box_type of cntr_11_0_23bc6491dc8a06da:
    component  is "black_box";
  component cntr_11_0_bc4e334678893d0e
    port (
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      load: in std_logic;
      l: in std_logic_vector(op_width - 1 downto 0);
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of cntr_11_0_bc4e334678893d0e:
    component is true;
  attribute fpga_dont_touch of cntr_11_0_bc4e334678893d0e:
    component is "true";
  attribute box_type of cntr_11_0_bc4e334678893d0e:
    component  is "black_box";
  component cntr_11_0_5b0a1653ddb23333
    port (
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of cntr_11_0_5b0a1653ddb23333:
    component is true;
  attribute fpga_dont_touch of cntr_11_0_5b0a1653ddb23333:
    component is "true";
  attribute box_type of cntr_11_0_5b0a1653ddb23333:
    component  is "black_box";
  component cntr_11_0_33b670dfb2dd60f1
    port (
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      load: in std_logic;
      l: in std_logic_vector(op_width - 1 downto 0);
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of cntr_11_0_33b670dfb2dd60f1:
    component is true;
  attribute fpga_dont_touch of cntr_11_0_33b670dfb2dd60f1:
    component is "true";
  attribute box_type of cntr_11_0_33b670dfb2dd60f1:
    component  is "black_box";
  component cntr_11_0_6b6e5f4ca8671604
    port (
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of cntr_11_0_6b6e5f4ca8671604:
    component is true;
  attribute fpga_dont_touch of cntr_11_0_6b6e5f4ca8671604:
    component is "true";
  attribute box_type of cntr_11_0_6b6e5f4ca8671604:
    component  is "black_box";
-- synopsys translate_off
  constant zeroVec: std_logic_vector(op_width - 1 downto 0) := (others => '0');
  constant oneVec: std_logic_vector(op_width - 1 downto 0) := (others => '1');
  constant zeroStr: string(1 to op_width) :=
    std_logic_vector_to_bin_string(zeroVec);
  constant oneStr: string(1 to op_width) :=
    std_logic_vector_to_bin_string(oneVec);
-- synopsys translate_on
  signal core_sinit: std_logic;
  signal core_ce: std_logic;
  signal op_net: std_logic_vector(op_width - 1 downto 0);
begin
  core_ce <= ce and en(0);
  core_sinit <= (clr or rst(0)) and ce;
  op <= op_net;
  comp0: if ((core_name0 = "cntr_11_0_86806e294f737f4c")) generate
    core_instance0: cntr_11_0_86806e294f737f4c
      port map (
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        q => op_net
      );
  end generate;
  comp1: if ((core_name0 = "cntr_11_0_5e62871cb125c52e")) generate
    core_instance1: cntr_11_0_5e62871cb125c52e
      port map (
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        load => load(0),
        l => din,
        q => op_net
      );
  end generate;
  comp2: if ((core_name0 = "cntr_11_0_66919a0f29965143")) generate
    core_instance2: cntr_11_0_66919a0f29965143
      port map (
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        q => op_net
      );
  end generate;
  comp3: if ((core_name0 = "cntr_11_0_23bc6491dc8a06da")) generate
    core_instance3: cntr_11_0_23bc6491dc8a06da
      port map (
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        q => op_net
      );
  end generate;
  comp4: if ((core_name0 = "cntr_11_0_bc4e334678893d0e")) generate
    core_instance4: cntr_11_0_bc4e334678893d0e
      port map (
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        load => load(0),
        l => din,
        q => op_net
      );
  end generate;
  comp5: if ((core_name0 = "cntr_11_0_5b0a1653ddb23333")) generate
    core_instance5: cntr_11_0_5b0a1653ddb23333
      port map (
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        q => op_net
      );
  end generate;
  comp6: if ((core_name0 = "cntr_11_0_33b670dfb2dd60f1")) generate
    core_instance6: cntr_11_0_33b670dfb2dd60f1
      port map (
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        load => load(0),
        l => din,
        q => op_net
      );
  end generate;
  comp7: if ((core_name0 = "cntr_11_0_6b6e5f4ca8671604")) generate
    core_instance7: cntr_11_0_6b6e5f4ca8671604
      port map (
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        q => op_net
      );
  end generate;
end behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_5f4d695836 is
  port (
    op : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_5f4d695836;


architecture behavior of constant_5f4d695836 is
begin
  op <= "10011111";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity logical_aacf6e1b0e is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_aacf6e1b0e;


architecture behavior of logical_aacf6e1b0e is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  fully_2_1_bit <= d0_1_24 or d1_1_27;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_54048c8b02 is
  port (
    a : in std_logic_vector((8 - 1) downto 0);
    b : in std_logic_vector((8 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_54048c8b02;


architecture behavior of relational_54048c8b02 is
  signal a_1_31: unsigned((8 - 1) downto 0);
  signal b_1_34: unsigned((8 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;


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
use IEEE.std_logic_arith.all;
use work.conv_pkg.all;
entity xlslice is
    generic (
        new_msb      : integer := 9;
        new_lsb      : integer := 1;
        x_width      : integer := 16;
        y_width      : integer := 8);
    port (
        x : in std_logic_vector (x_width-1 downto 0);
        y : out std_logic_vector (y_width-1 downto 0));
end xlslice;
architecture behavior of xlslice is
begin
    y <= x(new_msb downto new_lsb);
end  behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_62c4475a80 is
  port (
    in0 : in std_logic_vector((32 - 1) downto 0);
    in1 : in std_logic_vector((32 - 1) downto 0);
    y : out std_logic_vector((64 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_62c4475a80;


architecture behavior of concat_62c4475a80 is
  signal in0_1_23: unsigned((32 - 1) downto 0);
  signal in1_1_27: unsigned((32 - 1) downto 0);
  signal y_2_1_concat: unsigned((64 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;


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
use work.conv_pkg.all;
entity xlregister is
   generic (d_width          : integer := 5;
            init_value       : bit_vector := b"00");
   port (d   : in std_logic_vector (d_width-1 downto 0);
         rst : in std_logic_vector(0 downto 0) := "0";
         en  : in std_logic_vector(0 downto 0) := "1";
         ce  : in std_logic;
         clk : in std_logic;
         q   : out std_logic_vector (d_width-1 downto 0));
end xlregister;
architecture behavior of xlregister is
   component synth_reg_w_init
      generic (width      : integer;
               init_index : integer;
               init_value : bit_vector;
               latency    : integer);
      port (i   : in std_logic_vector(width-1 downto 0);
            ce  : in std_logic;
            clr : in std_logic;
            clk : in std_logic;
            o   : out std_logic_vector(width-1 downto 0));
   end component;
   -- synopsys translate_off
   signal real_d, real_q           : real;
   -- synopsys translate_on
   signal internal_clr             : std_logic;
   signal internal_ce              : std_logic;
begin
   internal_clr <= rst(0) and ce;
   internal_ce  <= en(0) and ce;
   synth_reg_inst : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d,
                ce  => internal_ce,
                clr => internal_clr,
                clk => clk,
                o   => q);
end architecture behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_6293007044 is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_6293007044;


architecture behavior of constant_6293007044 is
begin
  op <= "1";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_963ed6358a is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_963ed6358a;


architecture behavior of constant_963ed6358a is
begin
  op <= "0";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity logical_954ee29728 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    d2 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_954ee29728;


architecture behavior of logical_954ee29728 is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal d2_1_30: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  d2_1_30 <= d2(0);
  fully_2_1_bit <= d0_1_24 and d1_1_27 and d2_1_30;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_93f19f97e9 is
  port (
    a : in std_logic_vector((14 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_93f19f97e9;


architecture behavior of relational_93f19f97e9 is
  signal a_1_31: unsigned((14 - 1) downto 0);
  signal b_1_34: unsigned((1 - 1) downto 0);
  signal cast_14_17: unsigned((14 - 1) downto 0);
  signal result_14_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_14_17 <= u2u_cast(b_1_34, 0, 14, 0);
  result_14_3_rel <= a_1_31 /= cast_14_17;
  op <= boolean_to_vector(result_14_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_f52e6abf76 is
  port (
    a : in std_logic_vector((2 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_f52e6abf76;


architecture behavior of relational_f52e6abf76 is
  signal a_1_31: unsigned((2 - 1) downto 0);
  signal b_1_34: unsigned((1 - 1) downto 0);
  signal cast_12_17: unsigned((2 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_12_17 <= u2u_cast(b_1_34, 0, 2, 0);
  result_12_3_rel <= a_1_31 = cast_12_17;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_fe0d6a6e93 is
  port (
    a : in std_logic_vector((14 - 1) downto 0);
    b : in std_logic_vector((14 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_fe0d6a6e93;


architecture behavior of relational_fe0d6a6e93 is
  signal a_1_31: unsigned((14 - 1) downto 0);
  signal b_1_34: unsigned((14 - 1) downto 0);
  signal result_22_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_22_3_rel <= a_1_31 >= b_1_34;
  op <= boolean_to_vector(result_22_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity logical_6cb8f0ce02 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    d2 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_6cb8f0ce02;


architecture behavior of logical_6cb8f0ce02 is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal d2_1_30: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  d2_1_30 <= d2(0);
  fully_2_1_bit <= d0_1_24 or d1_1_27 or d2_1_30;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_e528f2ec9d is
  port (
    a : in std_logic_vector((16 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_e528f2ec9d;


architecture behavior of relational_e528f2ec9d is
  signal a_1_31: unsigned((16 - 1) downto 0);
  signal b_1_34: unsigned((1 - 1) downto 0);
  signal cast_18_16: unsigned((16 - 1) downto 0);
  signal result_18_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_18_16 <= u2u_cast(b_1_34, 0, 16, 0);
  result_18_3_rel <= a_1_31 > cast_18_16;
  op <= boolean_to_vector(result_18_3_rel);
end behavior;


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
use work.conv_pkg.all;
entity convert_func_call is
    generic (
        din_width    : integer := 16;
        din_bin_pt   : integer := 4;
        din_arith    : integer := xlUnsigned;
        dout_width   : integer := 8;
        dout_bin_pt  : integer := 2;
        dout_arith   : integer := xlUnsigned;
        quantization : integer := xlTruncate;
        overflow     : integer := xlWrap);
    port (
        din : in std_logic_vector (din_width-1 downto 0);
        result : out std_logic_vector (dout_width-1 downto 0));
end convert_func_call;
architecture behavior of convert_func_call is
begin
    result <= convert_type(din, din_width, din_bin_pt, din_arith,
                           dout_width, dout_bin_pt, dout_arith,
                           quantization, overflow);
end behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity xlconvert is
    generic (
        din_width    : integer := 16;
        din_bin_pt   : integer := 4;
        din_arith    : integer := xlUnsigned;
        dout_width   : integer := 8;
        dout_bin_pt  : integer := 2;
        dout_arith   : integer := xlUnsigned;
        en_width     : integer := 1;
        en_bin_pt    : integer := 0;
        en_arith     : integer := xlUnsigned;
        bool_conversion : integer :=0;
        latency      : integer := 0;
        quantization : integer := xlTruncate;
        overflow     : integer := xlWrap);
    port (
        din : in std_logic_vector (din_width-1 downto 0);
        en  : in std_logic_vector (en_width-1 downto 0);
        ce  : in std_logic;
        clr : in std_logic;
        clk : in std_logic;
        dout : out std_logic_vector (dout_width-1 downto 0));
end xlconvert;
architecture behavior of xlconvert is
    component synth_reg
        generic (width       : integer;
                 latency     : integer);
        port (i       : in std_logic_vector(width-1 downto 0);
              ce      : in std_logic;
              clr     : in std_logic;
              clk     : in std_logic;
              o       : out std_logic_vector(width-1 downto 0));
    end component;
    component convert_func_call
        generic (
            din_width    : integer := 16;
            din_bin_pt   : integer := 4;
            din_arith    : integer := xlUnsigned;
            dout_width   : integer := 8;
            dout_bin_pt  : integer := 2;
            dout_arith   : integer := xlUnsigned;
            quantization : integer := xlTruncate;
            overflow     : integer := xlWrap);
        port (
            din : in std_logic_vector (din_width-1 downto 0);
            result : out std_logic_vector (dout_width-1 downto 0));
    end component;
    -- synopsys translate_off
    -- synopsys translate_on
    signal result : std_logic_vector(dout_width-1 downto 0);
    signal internal_ce : std_logic;
begin
    -- synopsys translate_off
    -- synopsys translate_on
    internal_ce <= ce and en(0);

    bool_conversion_generate : if (bool_conversion = 1)
    generate
      result <= din;
    end generate;
    std_conversion_generate : if (bool_conversion = 0)
    generate
      convert : convert_func_call
        generic map (
          din_width   => din_width,
          din_bin_pt  => din_bin_pt,
          din_arith   => din_arith,
          dout_width  => dout_width,
          dout_bin_pt => dout_bin_pt,
          dout_arith  => dout_arith,
          quantization => quantization,
          overflow     => overflow)
        port map (
          din => din,
          result => result);
    end generate;
    latency_test : if (latency > 0) generate
        reg : synth_reg
            generic map (
              width => dout_width,
              latency => latency
            )
            port map (
              i => result,
              ce => internal_ce,
              clr => clr,
              clk => clk,
              o => dout
            );
    end generate;
    latency0 : if (latency = 0)
    generate
        dout <= result;
    end generate latency0;
end  behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_a54904b290 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((16 - 1) downto 0);
    d1 : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_a54904b290;


architecture behavior of mux_a54904b290 is
  signal sel_1_20: std_logic;
  signal d0_1_24: std_logic_vector((16 - 1) downto 0);
  signal d1_1_27: std_logic_vector((16 - 1) downto 0);
  signal sel_internal_2_1_convert: std_logic_vector((1 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((16 - 1) downto 0);
begin
  sel_1_20 <= sel(0);
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  sel_internal_2_1_convert <= cast(std_logic_to_vector(sel_1_20), 0, 1, 0, xlUnsigned);
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_53a2345101 is
  port (
    a : in std_logic_vector((16 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_53a2345101;


architecture behavior of relational_53a2345101 is
  signal a_1_31: unsigned((16 - 1) downto 0);
  signal b_1_34: unsigned((1 - 1) downto 0);
  signal cast_12_17: unsigned((16 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_12_17 <= u2u_cast(b_1_34, 0, 16, 0);
  result_12_3_rel <= a_1_31 = cast_12_17;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;


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

entity axi_sgiface is
    generic (
        -- AXI specific.
        -- TODO: need to figure out a way to pass these generics from outside
        C_S_AXI_SUPPORT_BURST   : integer := 0;
        -- TODO: fix the internal ID width to 8
        C_S_AXI_ID_WIDTH        : integer := 8;
        C_S_AXI_DATA_WIDTH      : integer := 32;
        C_S_AXI_ADDR_WIDTH      : integer := 32;
        C_S_AXI_TOTAL_ADDR_LEN  : integer := 12;
        C_S_AXI_LINEAR_ADDR_LEN : integer := 8;
        C_S_AXI_BANK_ADDR_LEN   : integer := 2;
        C_S_AXI_AWLEN_WIDTH     : integer := 8;
        C_S_AXI_ARLEN_WIDTH     : integer := 8
    );
    port (
        -- General.
        AXI_AClk      : in  std_logic;
        AXI_AResetN    : in  std_logic;
        -- not used
        AXI_Ce        : in  std_logic;
  
        -- AXI Port.
        S_AXI_AWADDR  : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_AWID    : in  std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
        S_AXI_AWLEN   : in  std_logic_vector(C_S_AXI_AWLEN_WIDTH-1 downto 0);
        S_AXI_AWSIZE  : in  std_logic_vector(2 downto 0);
        S_AXI_AWBURST : in  std_logic_vector(1 downto 0);
        S_AXI_AWLOCK  : in  std_logic_vector(1 downto 0);
        S_AXI_AWCACHE : in  std_logic_vector(3 downto 0);
        S_AXI_AWPROT  : in  std_logic_vector(2 downto 0);
        S_AXI_AWVALID : in  std_logic;
        S_AXI_AWREADY : out std_logic;
        
        S_AXI_WLAST   : in  std_logic;
        S_AXI_WDATA   : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_WSTRB   : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
        S_AXI_WVALID  : in  std_logic;
        S_AXI_WREADY  : out std_logic;
        
        S_AXI_BRESP   : out std_logic_vector(1 downto 0);
        S_AXI_BID     : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
        S_AXI_BVALID  : out std_logic;
        S_AXI_BREADY  : in  std_logic;
        
        S_AXI_ARADDR  : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_ARID    : in  std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
        S_AXI_ARLEN   : in  std_logic_vector(C_S_AXI_ARLEN_WIDTH-1 downto 0);
        S_AXI_ARSIZE  : in  std_logic_vector(2 downto 0);
        S_AXI_ARBURST : in  std_logic_vector(1 downto 0);
        S_AXI_ARLOCK  : in  std_logic_vector(1 downto 0);
        S_AXI_ARCACHE : in  std_logic_vector(3 downto 0);
        S_AXI_ARPROT  : in  std_logic_vector(2 downto 0);
        S_AXI_ARVALID : in  std_logic;
        S_AXI_ARREADY : out std_logic;
        
        -- 'From Register'
        -- 'TX_START_TIMESTAMP_MSB'
        sm_TX_START_TIMESTAMP_MSB_dout : in std_logic_vector(32-1 downto 0);
        -- 'TX_START_TIMESTAMP_LSB'
        sm_TX_START_TIMESTAMP_LSB_dout : in std_logic_vector(32-1 downto 0);
        -- 'NAV_VALUE'
        sm_NAV_VALUE_dout : in std_logic_vector(32-1 downto 0);
        -- 'RX_START_TIMESTAMP_MSB'
        sm_RX_START_TIMESTAMP_MSB_dout : in std_logic_vector(32-1 downto 0);
        -- 'RX_START_TIMESTAMP_LSB'
        sm_RX_START_TIMESTAMP_LSB_dout : in std_logic_vector(32-1 downto 0);
        -- 'RX_RATE_LENGTH'
        sm_RX_RATE_LENGTH_dout : in std_logic_vector(32-1 downto 0);
        -- 'TIMESTAMP_MSB'
        sm_TIMESTAMP_MSB_dout : in std_logic_vector(32-1 downto 0);
        -- 'TIMESTAMP_LSB'
        sm_TIMESTAMP_LSB_dout : in std_logic_vector(32-1 downto 0);
        -- 'LATEST_RX_BYTE'
        sm_LATEST_RX_BYTE_dout : in std_logic_vector(32-1 downto 0);
        -- 'Status'
        sm_Status_dout : in std_logic_vector(32-1 downto 0);
        -- 'To Register'
        -- 'AUTO_TX_PARAMS'
        sm_AUTO_TX_PARAMS_dout : in std_logic_vector(32-1 downto 0);
        sm_AUTO_TX_PARAMS_din  : out std_logic_vector(32-1 downto 0);
        sm_AUTO_TX_PARAMS_en   : out std_logic;
        -- 'CALIB_TIMES'
        sm_CALIB_TIMES_dout : in std_logic_vector(32-1 downto 0);
        sm_CALIB_TIMES_din  : out std_logic_vector(32-1 downto 0);
        sm_CALIB_TIMES_en   : out std_logic;
        -- 'IFS_INTERVALS2'
        sm_IFS_INTERVALS2_dout : in std_logic_vector(32-1 downto 0);
        sm_IFS_INTERVALS2_din  : out std_logic_vector(32-1 downto 0);
        sm_IFS_INTERVALS2_en   : out std_logic;
        -- 'IFS_INTERVALS1'
        sm_IFS_INTERVALS1_dout : in std_logic_vector(32-1 downto 0);
        sm_IFS_INTERVALS1_din  : out std_logic_vector(32-1 downto 0);
        sm_IFS_INTERVALS1_en   : out std_logic;
        -- 'TX_START'
        sm_TX_START_dout : in std_logic_vector(32-1 downto 0);
        sm_TX_START_din  : out std_logic_vector(32-1 downto 0);
        sm_TX_START_en   : out std_logic;
        -- 'MPDU_TX_PARAMS'
        sm_MPDU_TX_PARAMS_dout : in std_logic_vector(32-1 downto 0);
        sm_MPDU_TX_PARAMS_din  : out std_logic_vector(32-1 downto 0);
        sm_MPDU_TX_PARAMS_en   : out std_logic;
        -- 'Control'
        sm_Control_dout : in std_logic_vector(32-1 downto 0);
        sm_Control_din  : out std_logic_vector(32-1 downto 0);
        sm_Control_en   : out std_logic;
        -- 'TIMESTAMP_SET_LSB'
        sm_TIMESTAMP_SET_LSB_dout : in std_logic_vector(32-1 downto 0);
        sm_TIMESTAMP_SET_LSB_din  : out std_logic_vector(32-1 downto 0);
        sm_TIMESTAMP_SET_LSB_en   : out std_logic;
        -- 'TIMESTAMP_SET_MSB'
        sm_TIMESTAMP_SET_MSB_dout : in std_logic_vector(32-1 downto 0);
        sm_TIMESTAMP_SET_MSB_din  : out std_logic_vector(32-1 downto 0);
        sm_TIMESTAMP_SET_MSB_en   : out std_logic;
        -- 'BACKOFF_CTRL'
        sm_BACKOFF_CTRL_dout : in std_logic_vector(32-1 downto 0);
        sm_BACKOFF_CTRL_din  : out std_logic_vector(32-1 downto 0);
        sm_BACKOFF_CTRL_en   : out std_logic;
        -- 'MPDU_TX_GAINS'
        sm_MPDU_TX_GAINS_dout : in std_logic_vector(32-1 downto 0);
        sm_MPDU_TX_GAINS_din  : out std_logic_vector(32-1 downto 0);
        sm_MPDU_TX_GAINS_en   : out std_logic;
        -- 'AUTO_TX_GAINS'
        sm_AUTO_TX_GAINS_dout : in std_logic_vector(32-1 downto 0);
        sm_AUTO_TX_GAINS_din  : out std_logic_vector(32-1 downto 0);
        sm_AUTO_TX_GAINS_en   : out std_logic;
        -- 'TIMESTAMP_INSERT_OFFSET'
        sm_TIMESTAMP_INSERT_OFFSET_dout : in std_logic_vector(32-1 downto 0);
        sm_TIMESTAMP_INSERT_OFFSET_din  : out std_logic_vector(32-1 downto 0);
        sm_TIMESTAMP_INSERT_OFFSET_en   : out std_logic;
        -- 'From FIFO'
        -- 'To FIFO'
        -- 'Shared Memory'

        S_AXI_RLAST   : out std_logic;
        S_AXI_RID     : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
        S_AXI_RDATA   : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_RRESP   : out std_logic_vector(1 downto 0);
        S_AXI_RVALID  : out std_logic;
        S_AXI_RREADY  : in  std_logic
    );
end entity axi_sgiface;

architecture IMP of axi_sgiface is

-- Internal signals for write channel.
signal S_AXI_BVALID_i       : std_logic;
signal S_AXI_BID_i          : std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
signal S_AXI_WREADY_i       : std_logic;
  
-- Internal signals for read channels.
signal S_AXI_ARLEN_i        : std_logic_vector(C_S_AXI_ARLEN_WIDTH-1 downto 0);
signal S_AXI_RLAST_i        : std_logic;
signal S_AXI_RREADY_i       : std_logic;
signal S_AXI_RVALID_i       : std_logic;
signal S_AXI_RDATA_i        : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal S_AXI_RID_i          : std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);

-- for read channel
signal read_bank_addr_i     : std_logic_vector(C_S_AXI_BANK_ADDR_LEN-1 downto 0);
signal read_linear_addr_i   : std_logic_vector(C_S_AXI_LINEAR_ADDR_LEN-1 downto 0);
-- for write channel
signal write_bank_addr_i    : std_logic_vector(C_S_AXI_BANK_ADDR_LEN-1 downto 0);
signal write_linear_addr_i  : std_logic_vector(C_S_AXI_LINEAR_ADDR_LEN-1 downto 0);

signal reg_bank_out_i       : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal fifo_bank_out_i      : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal shmem_bank_out_i     : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    
-- 'From Register'
-- 'TX_START_TIMESTAMP_MSB'
signal sm_TX_START_TIMESTAMP_MSB_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'TX_START_TIMESTAMP_LSB'
signal sm_TX_START_TIMESTAMP_LSB_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'NAV_VALUE'
signal sm_NAV_VALUE_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'RX_START_TIMESTAMP_MSB'
signal sm_RX_START_TIMESTAMP_MSB_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'RX_START_TIMESTAMP_LSB'
signal sm_RX_START_TIMESTAMP_LSB_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'RX_RATE_LENGTH'
signal sm_RX_RATE_LENGTH_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'TIMESTAMP_MSB'
signal sm_TIMESTAMP_MSB_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'TIMESTAMP_LSB'
signal sm_TIMESTAMP_LSB_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'LATEST_RX_BYTE'
signal sm_LATEST_RX_BYTE_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'Status'
signal sm_Status_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'To Register'
-- 'AUTO_TX_PARAMS'
signal sm_AUTO_TX_PARAMS_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_AUTO_TX_PARAMS_en_i    : std_logic;
signal sm_AUTO_TX_PARAMS_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'CALIB_TIMES'
signal sm_CALIB_TIMES_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_CALIB_TIMES_en_i    : std_logic;
signal sm_CALIB_TIMES_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'IFS_INTERVALS2'
signal sm_IFS_INTERVALS2_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_IFS_INTERVALS2_en_i    : std_logic;
signal sm_IFS_INTERVALS2_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'IFS_INTERVALS1'
signal sm_IFS_INTERVALS1_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_IFS_INTERVALS1_en_i    : std_logic;
signal sm_IFS_INTERVALS1_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'TX_START'
signal sm_TX_START_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_TX_START_en_i    : std_logic;
signal sm_TX_START_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'MPDU_TX_PARAMS'
signal sm_MPDU_TX_PARAMS_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_MPDU_TX_PARAMS_en_i    : std_logic;
signal sm_MPDU_TX_PARAMS_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'Control'
signal sm_Control_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_Control_en_i    : std_logic;
signal sm_Control_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'TIMESTAMP_SET_LSB'
signal sm_TIMESTAMP_SET_LSB_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_TIMESTAMP_SET_LSB_en_i    : std_logic;
signal sm_TIMESTAMP_SET_LSB_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'TIMESTAMP_SET_MSB'
signal sm_TIMESTAMP_SET_MSB_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_TIMESTAMP_SET_MSB_en_i    : std_logic;
signal sm_TIMESTAMP_SET_MSB_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'BACKOFF_CTRL'
signal sm_BACKOFF_CTRL_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_BACKOFF_CTRL_en_i    : std_logic;
signal sm_BACKOFF_CTRL_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'MPDU_TX_GAINS'
signal sm_MPDU_TX_GAINS_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_MPDU_TX_GAINS_en_i    : std_logic;
signal sm_MPDU_TX_GAINS_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'AUTO_TX_GAINS'
signal sm_AUTO_TX_GAINS_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_AUTO_TX_GAINS_en_i    : std_logic;
signal sm_AUTO_TX_GAINS_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'TIMESTAMP_INSERT_OFFSET'
signal sm_TIMESTAMP_INSERT_OFFSET_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_TIMESTAMP_INSERT_OFFSET_en_i    : std_logic;
signal sm_TIMESTAMP_INSERT_OFFSET_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'From FIFO'
-- 'To FIFO'
-- 'Shared Memory'

type t_read_state is (IDLE, READ_PREP, READ_DATA);
signal read_state : t_read_state;

type t_write_state is (IDLE, WRITE_DATA, WRITE_RESPONSE);
signal write_state : t_write_state;

type t_memmap_state is (READ, WRITE);
signal memmap_state : t_memmap_state;

constant C_READ_PREP_DELAY : std_logic_vector(1 downto 0) := "11";

signal read_prep_counter : std_logic_vector(1 downto 0);
signal read_addr_counter : std_logic_vector(C_S_AXI_ARLEN_WIDTH-1 downto 0);
signal read_data_counter : std_logic_vector(C_S_AXI_ARLEN_WIDTH-1 downto 0);

-- enable of shared BRAMs
signal s_shram_en : std_logic;

signal write_addr_valid : std_logic;
signal write_ready : std_logic;

-- 're' of From/To FIFOs
signal s_fifo_re : std_logic;
-- 'we' of To FIFOs
signal s_fifo_we : std_logic;

begin

-- enable for 'Shared Memory' blocks

-- conversion to match with the data bus width
-- 'From Register'
-- 'TX_START_TIMESTAMP_MSB'
gen_sm_TX_START_TIMESTAMP_MSB_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_TX_START_TIMESTAMP_MSB_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_TX_START_TIMESTAMP_MSB_dout_i;
sm_TX_START_TIMESTAMP_MSB_dout_i(32-1 downto 0) <= sm_TX_START_TIMESTAMP_MSB_dout;
-- 'TX_START_TIMESTAMP_LSB'
gen_sm_TX_START_TIMESTAMP_LSB_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_TX_START_TIMESTAMP_LSB_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_TX_START_TIMESTAMP_LSB_dout_i;
sm_TX_START_TIMESTAMP_LSB_dout_i(32-1 downto 0) <= sm_TX_START_TIMESTAMP_LSB_dout;
-- 'NAV_VALUE'
gen_sm_NAV_VALUE_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_NAV_VALUE_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_NAV_VALUE_dout_i;
sm_NAV_VALUE_dout_i(32-1 downto 0) <= sm_NAV_VALUE_dout;
-- 'RX_START_TIMESTAMP_MSB'
gen_sm_RX_START_TIMESTAMP_MSB_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_RX_START_TIMESTAMP_MSB_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_RX_START_TIMESTAMP_MSB_dout_i;
sm_RX_START_TIMESTAMP_MSB_dout_i(32-1 downto 0) <= sm_RX_START_TIMESTAMP_MSB_dout;
-- 'RX_START_TIMESTAMP_LSB'
gen_sm_RX_START_TIMESTAMP_LSB_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_RX_START_TIMESTAMP_LSB_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_RX_START_TIMESTAMP_LSB_dout_i;
sm_RX_START_TIMESTAMP_LSB_dout_i(32-1 downto 0) <= sm_RX_START_TIMESTAMP_LSB_dout;
-- 'RX_RATE_LENGTH'
gen_sm_RX_RATE_LENGTH_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_RX_RATE_LENGTH_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_RX_RATE_LENGTH_dout_i;
sm_RX_RATE_LENGTH_dout_i(32-1 downto 0) <= sm_RX_RATE_LENGTH_dout;
-- 'TIMESTAMP_MSB'
gen_sm_TIMESTAMP_MSB_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_TIMESTAMP_MSB_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_TIMESTAMP_MSB_dout_i;
sm_TIMESTAMP_MSB_dout_i(32-1 downto 0) <= sm_TIMESTAMP_MSB_dout;
-- 'TIMESTAMP_LSB'
gen_sm_TIMESTAMP_LSB_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_TIMESTAMP_LSB_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_TIMESTAMP_LSB_dout_i;
sm_TIMESTAMP_LSB_dout_i(32-1 downto 0) <= sm_TIMESTAMP_LSB_dout;
-- 'LATEST_RX_BYTE'
gen_sm_LATEST_RX_BYTE_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_LATEST_RX_BYTE_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_LATEST_RX_BYTE_dout_i;
sm_LATEST_RX_BYTE_dout_i(32-1 downto 0) <= sm_LATEST_RX_BYTE_dout;
-- 'Status'
gen_sm_Status_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_Status_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_Status_dout_i;
sm_Status_dout_i(32-1 downto 0) <= sm_Status_dout;
-- 'To Register'
-- 'AUTO_TX_PARAMS'
sm_AUTO_TX_PARAMS_din     <= sm_AUTO_TX_PARAMS_din_i(32-1 downto 0);
sm_AUTO_TX_PARAMS_en      <= sm_AUTO_TX_PARAMS_en_i;
gen_sm_AUTO_TX_PARAMS_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_AUTO_TX_PARAMS_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_AUTO_TX_PARAMS_dout_i;
sm_AUTO_TX_PARAMS_dout_i(32-1 downto 0) <= sm_AUTO_TX_PARAMS_dout;
-- 'CALIB_TIMES'
sm_CALIB_TIMES_din     <= sm_CALIB_TIMES_din_i(32-1 downto 0);
sm_CALIB_TIMES_en      <= sm_CALIB_TIMES_en_i;
gen_sm_CALIB_TIMES_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_CALIB_TIMES_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_CALIB_TIMES_dout_i;
sm_CALIB_TIMES_dout_i(32-1 downto 0) <= sm_CALIB_TIMES_dout;
-- 'IFS_INTERVALS2'
sm_IFS_INTERVALS2_din     <= sm_IFS_INTERVALS2_din_i(32-1 downto 0);
sm_IFS_INTERVALS2_en      <= sm_IFS_INTERVALS2_en_i;
gen_sm_IFS_INTERVALS2_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_IFS_INTERVALS2_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_IFS_INTERVALS2_dout_i;
sm_IFS_INTERVALS2_dout_i(32-1 downto 0) <= sm_IFS_INTERVALS2_dout;
-- 'IFS_INTERVALS1'
sm_IFS_INTERVALS1_din     <= sm_IFS_INTERVALS1_din_i(32-1 downto 0);
sm_IFS_INTERVALS1_en      <= sm_IFS_INTERVALS1_en_i;
gen_sm_IFS_INTERVALS1_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_IFS_INTERVALS1_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_IFS_INTERVALS1_dout_i;
sm_IFS_INTERVALS1_dout_i(32-1 downto 0) <= sm_IFS_INTERVALS1_dout;
-- 'TX_START'
sm_TX_START_din     <= sm_TX_START_din_i(32-1 downto 0);
sm_TX_START_en      <= sm_TX_START_en_i;
gen_sm_TX_START_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_TX_START_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_TX_START_dout_i;
sm_TX_START_dout_i(32-1 downto 0) <= sm_TX_START_dout;
-- 'MPDU_TX_PARAMS'
sm_MPDU_TX_PARAMS_din     <= sm_MPDU_TX_PARAMS_din_i(32-1 downto 0);
sm_MPDU_TX_PARAMS_en      <= sm_MPDU_TX_PARAMS_en_i;
gen_sm_MPDU_TX_PARAMS_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_MPDU_TX_PARAMS_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_MPDU_TX_PARAMS_dout_i;
sm_MPDU_TX_PARAMS_dout_i(32-1 downto 0) <= sm_MPDU_TX_PARAMS_dout;
-- 'Control'
sm_Control_din     <= sm_Control_din_i(32-1 downto 0);
sm_Control_en      <= sm_Control_en_i;
gen_sm_Control_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_Control_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_Control_dout_i;
sm_Control_dout_i(32-1 downto 0) <= sm_Control_dout;
-- 'TIMESTAMP_SET_LSB'
sm_TIMESTAMP_SET_LSB_din     <= sm_TIMESTAMP_SET_LSB_din_i(32-1 downto 0);
sm_TIMESTAMP_SET_LSB_en      <= sm_TIMESTAMP_SET_LSB_en_i;
gen_sm_TIMESTAMP_SET_LSB_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_TIMESTAMP_SET_LSB_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_TIMESTAMP_SET_LSB_dout_i;
sm_TIMESTAMP_SET_LSB_dout_i(32-1 downto 0) <= sm_TIMESTAMP_SET_LSB_dout;
-- 'TIMESTAMP_SET_MSB'
sm_TIMESTAMP_SET_MSB_din     <= sm_TIMESTAMP_SET_MSB_din_i(32-1 downto 0);
sm_TIMESTAMP_SET_MSB_en      <= sm_TIMESTAMP_SET_MSB_en_i;
gen_sm_TIMESTAMP_SET_MSB_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_TIMESTAMP_SET_MSB_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_TIMESTAMP_SET_MSB_dout_i;
sm_TIMESTAMP_SET_MSB_dout_i(32-1 downto 0) <= sm_TIMESTAMP_SET_MSB_dout;
-- 'BACKOFF_CTRL'
sm_BACKOFF_CTRL_din     <= sm_BACKOFF_CTRL_din_i(32-1 downto 0);
sm_BACKOFF_CTRL_en      <= sm_BACKOFF_CTRL_en_i;
gen_sm_BACKOFF_CTRL_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_BACKOFF_CTRL_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_BACKOFF_CTRL_dout_i;
sm_BACKOFF_CTRL_dout_i(32-1 downto 0) <= sm_BACKOFF_CTRL_dout;
-- 'MPDU_TX_GAINS'
sm_MPDU_TX_GAINS_din     <= sm_MPDU_TX_GAINS_din_i(32-1 downto 0);
sm_MPDU_TX_GAINS_en      <= sm_MPDU_TX_GAINS_en_i;
gen_sm_MPDU_TX_GAINS_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_MPDU_TX_GAINS_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_MPDU_TX_GAINS_dout_i;
sm_MPDU_TX_GAINS_dout_i(32-1 downto 0) <= sm_MPDU_TX_GAINS_dout;
-- 'AUTO_TX_GAINS'
sm_AUTO_TX_GAINS_din     <= sm_AUTO_TX_GAINS_din_i(32-1 downto 0);
sm_AUTO_TX_GAINS_en      <= sm_AUTO_TX_GAINS_en_i;
gen_sm_AUTO_TX_GAINS_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_AUTO_TX_GAINS_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_AUTO_TX_GAINS_dout_i;
sm_AUTO_TX_GAINS_dout_i(32-1 downto 0) <= sm_AUTO_TX_GAINS_dout;
-- 'TIMESTAMP_INSERT_OFFSET'
sm_TIMESTAMP_INSERT_OFFSET_din     <= sm_TIMESTAMP_INSERT_OFFSET_din_i(32-1 downto 0);
sm_TIMESTAMP_INSERT_OFFSET_en      <= sm_TIMESTAMP_INSERT_OFFSET_en_i;
gen_sm_TIMESTAMP_INSERT_OFFSET_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_TIMESTAMP_INSERT_OFFSET_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_TIMESTAMP_INSERT_OFFSET_dout_i;
sm_TIMESTAMP_INSERT_OFFSET_dout_i(32-1 downto 0) <= sm_TIMESTAMP_INSERT_OFFSET_dout;
-- 'From FIFO'
-- 'To FIFO'
-- 'Shared Memory'

ReadWriteSelect: process(memmap_state) is begin
    if (memmap_state = READ) then
    else
    end if;
end process ReadWriteSelect;

-----------------------------------------------------------------------------
-- address for 'Shared Memory'
-----------------------------------------------------------------------------
SharedMemory_Addr_ResetN : process(AXI_AClk) is begin
    if (AXI_AClk'event and AXI_AClk = '1') then
        if (AXI_AResetN = '0') then
            memmap_state <= READ;
        else
            if (S_AXI_AWVALID = '1') then
                -- write operation
                memmap_state <= WRITE;
            elsif (S_AXI_ARVALID = '1') then
                -- read operation
                memmap_state <= READ;
            end if;
        end if;
    end if;
end process SharedMemory_Addr_ResetN;

-----------------------------------------------------------------------------
-- WRITE Command Control
-----------------------------------------------------------------------------
S_AXI_BID     <= S_AXI_BID_i;
S_AXI_BVALID  <= S_AXI_BVALID_i;
S_AXI_WREADY  <= S_AXI_WREADY_i;
-- No error checking
S_AXI_BRESP  <= (others=>'0');

PROC_AWREADY_ACK: process(read_state, write_state, S_AXI_ARVALID, S_AXI_AWVALID) is begin
    if (write_state = IDLE and S_AXI_AWVALID = '1' and read_state = IDLE) then
        S_AXI_AWREADY <= S_AXI_AWVALID;
    else
        S_AXI_AWREADY <= '0';
    end if;
end process PROC_AWREADY_ACK;

Cmd_Decode_Write: process(AXI_AClk) is begin
    if (AXI_AClk'event and AXI_AClk = '1') then
        if (AXI_AResetN = '0') then
            write_addr_valid    <= '0';
            write_ready         <= '0';
            s_fifo_we           <= '0';
            S_AXI_BVALID_i      <= '0';
            S_AXI_BID_i         <= (others => '0');
            write_bank_addr_i   <= (others => '0');
            write_linear_addr_i <= (others => '0');
        else
            if (write_state = IDLE) then
                if (S_AXI_AWVALID = '1' and read_state = IDLE) then
                    -- reflect awid
                    S_AXI_BID_i <= S_AXI_AWID;

                    -- latch bank and linear addresses
                    write_bank_addr_i   <= S_AXI_AWADDR(C_S_AXI_TOTAL_ADDR_LEN-1 downto C_S_AXI_LINEAR_ADDR_LEN+2);
                    write_linear_addr_i <= S_AXI_AWADDR(C_S_AXI_LINEAR_ADDR_LEN+1 downto 2);
                    write_addr_valid <= '1';
                    s_fifo_we <= '1';

                    -- write state transition
                    write_state <= WRITE_DATA;
                end if;
            elsif (write_state = WRITE_DATA) then
                write_ready <= '1';
                s_fifo_we <= '0';
                write_addr_valid <= S_AXI_WVALID;
                
                if (S_AXI_WVALID = '1' and write_ready = '1') then
                    write_linear_addr_i <= Std_Logic_Vector(unsigned(write_linear_addr_i) + 1);
                end if;

                if (S_AXI_WLAST = '1' and write_ready = '1') then
                    -- start responding through B channel upon the last write data sample
                    S_AXI_BVALID_i <= '1';
                    -- write data is over
                    write_addr_valid <= '0';
                    write_ready <= '0';
                    -- write state transition
                    write_state <= WRITE_RESPONSE;
                end if;
            elsif (write_state = WRITE_RESPONSE) then

                if (S_AXI_BREADY = '1') then
                    -- write respond is over
                    S_AXI_BVALID_i <= '0';
                    S_AXI_BID_i <= (others => '0');

                    -- write state transition
                    write_state <= IDLE;
                end if;
            end if;
        end if;
    end if;
end process Cmd_Decode_Write;

Write_Linear_Addr_Decode : process(AXI_AClk) is 

begin
    if (AXI_AClk'event and AXI_AClk = '1') then
        if (AXI_AResetN = '0') then
            -- 'To Register'
            -- AUTO_TX_PARAMS din/en
            sm_AUTO_TX_PARAMS_din_i <= (others => '0');
            sm_AUTO_TX_PARAMS_en_i <= '0';
            -- CALIB_TIMES din/en
            sm_CALIB_TIMES_din_i <= (others => '0');
            sm_CALIB_TIMES_en_i <= '0';
            -- IFS_INTERVALS2 din/en
            sm_IFS_INTERVALS2_din_i <= (others => '0');
            sm_IFS_INTERVALS2_en_i <= '0';
            -- IFS_INTERVALS1 din/en
            sm_IFS_INTERVALS1_din_i <= (others => '0');
            sm_IFS_INTERVALS1_en_i <= '0';
            -- TX_START din/en
            sm_TX_START_din_i <= (others => '0');
            sm_TX_START_en_i <= '0';
            -- MPDU_TX_PARAMS din/en
            sm_MPDU_TX_PARAMS_din_i <= (others => '0');
            sm_MPDU_TX_PARAMS_en_i <= '0';
            -- Control din/en
            sm_Control_din_i <= (others => '0');
            sm_Control_en_i <= '0';
            -- TIMESTAMP_SET_LSB din/en
            sm_TIMESTAMP_SET_LSB_din_i <= (others => '0');
            sm_TIMESTAMP_SET_LSB_en_i <= '0';
            -- TIMESTAMP_SET_MSB din/en
            sm_TIMESTAMP_SET_MSB_din_i <= (others => '0');
            sm_TIMESTAMP_SET_MSB_en_i <= '0';
            -- BACKOFF_CTRL din/en
            sm_BACKOFF_CTRL_din_i <= (others => '0');
            sm_BACKOFF_CTRL_en_i <= '0';
            -- MPDU_TX_GAINS din/en
            sm_MPDU_TX_GAINS_din_i <= (others => '0');
            sm_MPDU_TX_GAINS_en_i <= '0';
            -- AUTO_TX_GAINS din/en
            sm_AUTO_TX_GAINS_din_i <= (others => '0');
            sm_AUTO_TX_GAINS_en_i <= '0';
            -- TIMESTAMP_INSERT_OFFSET din/en
            sm_TIMESTAMP_INSERT_OFFSET_din_i <= (others => '0');
            sm_TIMESTAMP_INSERT_OFFSET_en_i <= '0';
            -- 'To FIFO'
            -- 'Shared Memory'
        else
            -- default assignments

            -- 'To Register'
            if (unsigned(write_bank_addr_i) = 2) then
                if (unsigned(write_linear_addr_i) = 0) then
                    -- AUTO_TX_PARAMS din/en
                    sm_AUTO_TX_PARAMS_din_i <= S_AXI_WDATA;
                    sm_AUTO_TX_PARAMS_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 1) then
                    -- CALIB_TIMES din/en
                    sm_CALIB_TIMES_din_i <= S_AXI_WDATA;
                    sm_CALIB_TIMES_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 2) then
                    -- IFS_INTERVALS2 din/en
                    sm_IFS_INTERVALS2_din_i <= S_AXI_WDATA;
                    sm_IFS_INTERVALS2_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 3) then
                    -- IFS_INTERVALS1 din/en
                    sm_IFS_INTERVALS1_din_i <= S_AXI_WDATA;
                    sm_IFS_INTERVALS1_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 4) then
                    -- TX_START din/en
                    sm_TX_START_din_i <= S_AXI_WDATA;
                    sm_TX_START_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 5) then
                    -- MPDU_TX_PARAMS din/en
                    sm_MPDU_TX_PARAMS_din_i <= S_AXI_WDATA;
                    sm_MPDU_TX_PARAMS_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 6) then
                    -- Control din/en
                    sm_Control_din_i <= S_AXI_WDATA;
                    sm_Control_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 7) then
                    -- TIMESTAMP_SET_LSB din/en
                    sm_TIMESTAMP_SET_LSB_din_i <= S_AXI_WDATA;
                    sm_TIMESTAMP_SET_LSB_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 8) then
                    -- TIMESTAMP_SET_MSB din/en
                    sm_TIMESTAMP_SET_MSB_din_i <= S_AXI_WDATA;
                    sm_TIMESTAMP_SET_MSB_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 9) then
                    -- BACKOFF_CTRL din/en
                    sm_BACKOFF_CTRL_din_i <= S_AXI_WDATA;
                    sm_BACKOFF_CTRL_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 10) then
                    -- MPDU_TX_GAINS din/en
                    sm_MPDU_TX_GAINS_din_i <= S_AXI_WDATA;
                    sm_MPDU_TX_GAINS_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 11) then
                    -- AUTO_TX_GAINS din/en
                    sm_AUTO_TX_GAINS_din_i <= S_AXI_WDATA;
                    sm_AUTO_TX_GAINS_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 12) then
                    -- TIMESTAMP_INSERT_OFFSET din/en
                    sm_TIMESTAMP_INSERT_OFFSET_din_i <= S_AXI_WDATA;
                    sm_TIMESTAMP_INSERT_OFFSET_en_i  <= write_addr_valid;
                end if;
            end if;        
        
        
        end if;
    end if;
end process Write_Linear_Addr_Decode;
 
-----------------------------------------------------------------------------
-- READ Control
-----------------------------------------------------------------------------

S_AXI_RDATA  <= S_AXI_RDATA_i;
S_AXI_RVALID  <= S_AXI_RVALID_i;
S_AXI_RLAST   <= S_AXI_RLAST_i;
S_AXI_RID     <= S_AXI_RID_i;
-- TODO: no error checking
S_AXI_RRESP <= (others=>'0');

PROC_ARREADY_ACK: process(read_state, S_AXI_ARVALID, write_state, S_AXI_AWVALID) is begin
    -- Note: WRITE has higher priority than READ
    if (read_state = IDLE and S_AXI_ARVALID = '1' and write_state = IDLE and S_AXI_AWVALID /= '1') then
        S_AXI_ARREADY <= S_AXI_ARVALID;
    else
        S_AXI_ARREADY <= '0';
    end if;
end process PROC_ARREADY_ACK;

S_AXI_WREADY_i <= write_ready;

Process_Sideband: process(write_state, read_state) is begin
    if (read_state = READ_PREP) then
        s_shram_en <= '1';
    elsif (read_state = READ_DATA) then
        s_shram_en <= S_AXI_RREADY;
    elsif (write_state = WRITE_DATA) then
        s_shram_en <= S_AXI_WVALID;
    else
        s_shram_en <= '0';
    end if;
end process Process_Sideband;

Cmd_Decode_Read: process(AXI_AClk) is begin
    if (AXI_AClk'event and AXI_AClk = '1') then
        if (AXI_AResetN = '0') then
            S_AXI_RVALID_i <= '0';
            read_bank_addr_i    <= (others => '0');
            read_linear_addr_i  <= (others => '0');
            S_AXI_ARLEN_i       <= (others => '0');
            S_AXI_RLAST_i       <= '0';
            S_AXI_RID_i         <= (others => '0');
            read_state          <= IDLE;
            read_prep_counter   <= (others => '0');
            read_addr_counter   <= (others => '0');
            read_data_counter   <= (others => '0');
        else
            -- default assignments
            s_fifo_re <= '0';

            if (read_state = IDLE) then
                -- Note WRITE has higher priority than READ
                if (S_AXI_ARVALID = '1' and write_state = IDLE and S_AXI_AWVALID /= '1') then
                    -- extract bank and linear addresses
                    read_bank_addr_i    <= S_AXI_ARADDR(C_S_AXI_TOTAL_ADDR_LEN-1 downto C_S_AXI_LINEAR_ADDR_LEN+2);
                    read_linear_addr_i  <= S_AXI_ARADDR(C_S_AXI_LINEAR_ADDR_LEN+1 downto 2);
                    s_fifo_re <= '1';

                    -- reflect arid
                    S_AXI_RID_i <= S_AXI_ARID;

                    -- load read liner address and data counter
                    read_addr_counter <= S_AXI_ARLEN;
                    read_data_counter <= S_AXI_ARLEN;

                    -- load read preparation counter
                    read_prep_counter <= C_READ_PREP_DELAY;
                    -- read state transition
                    read_state <= READ_PREP;
                end if;
            elsif (read_state = READ_PREP) then
                if (unsigned(read_prep_counter) = 0) then
                    if (unsigned(read_data_counter) = 0) then
                        -- tag the last data generated by the slave
                        S_AXI_RLAST_i <= '1';
                    end if;
                    -- valid data appears
                    S_AXI_RVALID_i <= '1';
                    -- read state transition
                    read_state <= READ_DATA;
                else
                    -- decrease read preparation counter
                    read_prep_counter <= Std_Logic_Vector(unsigned(read_prep_counter) - 1);
                end if;

                if (unsigned(read_prep_counter) /= 3 and unsigned(read_addr_counter) /= 0) then
                    -- decrease address counter
                    read_addr_counter <= Std_Logic_Vector(unsigned(read_addr_counter) - 1);
                    -- increase linear address (no band crossing)
                    read_linear_addr_i <= Std_Logic_Vector(unsigned(read_linear_addr_i) + 1);
                end if;
            elsif (read_state = READ_DATA) then
                if (S_AXI_RREADY = '1') then
                    if (unsigned(read_data_counter) = 1) then
                        -- tag the last data generated by the slave
                        S_AXI_RLAST_i <= '1';
                    end if;

                    if (unsigned(read_data_counter) = 0) then
                        -- arid
                        S_AXI_RID_i <= (others => '0');
                        -- rlast
                        S_AXI_RLAST_i <= '0';
                        -- no more valid data
                        S_AXI_RVALID_i <= '0';
                        -- read state transition
                        read_state <= IDLE;
                    else
                        -- decrease read preparation counter
                        read_data_counter <= Std_Logic_Vector(unsigned(read_data_counter) - 1);

                        if (unsigned(read_addr_counter) /= 0) then
                            -- decrease address counter
                            read_addr_counter <= Std_Logic_Vector(unsigned(read_addr_counter) - 1);
                            -- increase linear address (no band crossing)
                            read_linear_addr_i <= Std_Logic_Vector(unsigned(read_linear_addr_i) + 1);
                        end if;
                    end if;
                end if;
            end if;

        end if;
    end if;
end process Cmd_Decode_Read;

Read_Linear_Addr_Decode : process(AXI_AClk) is begin
    if (AXI_AClk'event and AXI_AClk = '1') then
        if (AXI_AResetN = '0') then
            reg_bank_out_i   <= (others => '0');
            fifo_bank_out_i  <= (others => '0');
            shmem_bank_out_i <= (others => '0');
            S_AXI_RDATA_i    <= (others => '0');
        else
            if (unsigned(read_bank_addr_i) = 2) then
                -- 'From Register'
                if (unsigned(read_linear_addr_i) = 13) then
                    -- 'TX_START_TIMESTAMP_MSB' dout
                    reg_bank_out_i <= sm_TX_START_TIMESTAMP_MSB_dout_i;
                elsif (unsigned(read_linear_addr_i) = 14) then
                    -- 'TX_START_TIMESTAMP_LSB' dout
                    reg_bank_out_i <= sm_TX_START_TIMESTAMP_LSB_dout_i;
                elsif (unsigned(read_linear_addr_i) = 15) then
                    -- 'NAV_VALUE' dout
                    reg_bank_out_i <= sm_NAV_VALUE_dout_i;
                elsif (unsigned(read_linear_addr_i) = 16) then
                    -- 'RX_START_TIMESTAMP_MSB' dout
                    reg_bank_out_i <= sm_RX_START_TIMESTAMP_MSB_dout_i;
                elsif (unsigned(read_linear_addr_i) = 17) then
                    -- 'RX_START_TIMESTAMP_LSB' dout
                    reg_bank_out_i <= sm_RX_START_TIMESTAMP_LSB_dout_i;
                elsif (unsigned(read_linear_addr_i) = 18) then
                    -- 'RX_RATE_LENGTH' dout
                    reg_bank_out_i <= sm_RX_RATE_LENGTH_dout_i;
                elsif (unsigned(read_linear_addr_i) = 19) then
                    -- 'TIMESTAMP_MSB' dout
                    reg_bank_out_i <= sm_TIMESTAMP_MSB_dout_i;
                elsif (unsigned(read_linear_addr_i) = 20) then
                    -- 'TIMESTAMP_LSB' dout
                    reg_bank_out_i <= sm_TIMESTAMP_LSB_dout_i;
                elsif (unsigned(read_linear_addr_i) = 21) then
                    -- 'LATEST_RX_BYTE' dout
                    reg_bank_out_i <= sm_LATEST_RX_BYTE_dout_i;
                elsif (unsigned(read_linear_addr_i) = 22) then
                    -- 'Status' dout
                    reg_bank_out_i <= sm_Status_dout_i;
                end if;
                -- 'To Register' (with register readback)
                if (unsigned(read_linear_addr_i) = 0) then
                    -- 'AUTO_TX_PARAMS' dout
                    reg_bank_out_i <= sm_AUTO_TX_PARAMS_dout_i;
                elsif (unsigned(read_linear_addr_i) = 1) then
                    -- 'CALIB_TIMES' dout
                    reg_bank_out_i <= sm_CALIB_TIMES_dout_i;
                elsif (unsigned(read_linear_addr_i) = 2) then
                    -- 'IFS_INTERVALS2' dout
                    reg_bank_out_i <= sm_IFS_INTERVALS2_dout_i;
                elsif (unsigned(read_linear_addr_i) = 3) then
                    -- 'IFS_INTERVALS1' dout
                    reg_bank_out_i <= sm_IFS_INTERVALS1_dout_i;
                elsif (unsigned(read_linear_addr_i) = 4) then
                    -- 'TX_START' dout
                    reg_bank_out_i <= sm_TX_START_dout_i;
                elsif (unsigned(read_linear_addr_i) = 5) then
                    -- 'MPDU_TX_PARAMS' dout
                    reg_bank_out_i <= sm_MPDU_TX_PARAMS_dout_i;
                elsif (unsigned(read_linear_addr_i) = 6) then
                    -- 'Control' dout
                    reg_bank_out_i <= sm_Control_dout_i;
                elsif (unsigned(read_linear_addr_i) = 7) then
                    -- 'TIMESTAMP_SET_LSB' dout
                    reg_bank_out_i <= sm_TIMESTAMP_SET_LSB_dout_i;
                elsif (unsigned(read_linear_addr_i) = 8) then
                    -- 'TIMESTAMP_SET_MSB' dout
                    reg_bank_out_i <= sm_TIMESTAMP_SET_MSB_dout_i;
                elsif (unsigned(read_linear_addr_i) = 9) then
                    -- 'BACKOFF_CTRL' dout
                    reg_bank_out_i <= sm_BACKOFF_CTRL_dout_i;
                elsif (unsigned(read_linear_addr_i) = 10) then
                    -- 'MPDU_TX_GAINS' dout
                    reg_bank_out_i <= sm_MPDU_TX_GAINS_dout_i;
                elsif (unsigned(read_linear_addr_i) = 11) then
                    -- 'AUTO_TX_GAINS' dout
                    reg_bank_out_i <= sm_AUTO_TX_GAINS_dout_i;
                elsif (unsigned(read_linear_addr_i) = 12) then
                    -- 'TIMESTAMP_INSERT_OFFSET' dout
                    reg_bank_out_i <= sm_TIMESTAMP_INSERT_OFFSET_dout_i;
                end if;

                S_AXI_RDATA_i <= reg_bank_out_i;
            elsif (unsigned(read_bank_addr_i) = 1) then
                -- 'From FIFO'
                -- 'To FIFO'

                S_AXI_RDATA_i <= fifo_bank_out_i;
            elsif (unsigned(read_bank_addr_i) = 0 and s_shram_en = '1') then
                -- 'Shared Memory'

                S_AXI_RDATA_i <= shmem_bank_out_i;
            end if;
        end if;
    end if;
end process Read_Linear_Addr_Decode;

end architecture IMP;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_2a3f3bef9d is
  port (
    a : in std_logic_vector((2 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_2a3f3bef9d;


architecture behavior of relational_2a3f3bef9d is
  signal a_1_31: unsigned((2 - 1) downto 0);
  signal b_1_34: unsigned((1 - 1) downto 0);
  signal cast_14_17: unsigned((2 - 1) downto 0);
  signal result_14_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_14_17 <= u2u_cast(b_1_34, 0, 2, 0);
  result_14_3_rel <= a_1_31 /= cast_14_17;
  op <= boolean_to_vector(result_14_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_3efa5ceb62 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((14 - 1) downto 0);
    d1 : in std_logic_vector((20 - 1) downto 0);
    y : out std_logic_vector((20 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_3efa5ceb62;


architecture behavior of mux_3efa5ceb62 is
  signal sel_1_20: std_logic;
  signal d0_1_24: std_logic_vector((14 - 1) downto 0);
  signal d1_1_27: std_logic_vector((20 - 1) downto 0);
  signal sel_internal_2_1_convert: std_logic_vector((1 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((20 - 1) downto 0);
begin
  sel_1_20 <= sel(0);
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  sel_internal_2_1_convert <= cast(std_logic_to_vector(sel_1_20), 0, 1, 0, xlUnsigned);
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_6_1 <= cast(d0_1_24, 0, 20, 0, xlUnsigned);
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_6fce5fc0e4 is
  port (
    a : in std_logic_vector((16 - 1) downto 0);
    b : in std_logic_vector((20 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_6fce5fc0e4;


architecture behavior of relational_6fce5fc0e4 is
  signal a_1_31: unsigned((16 - 1) downto 0);
  signal b_1_34: unsigned((20 - 1) downto 0);
  signal cast_22_12: unsigned((20 - 1) downto 0);
  signal result_22_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_22_12 <= u2u_cast(a_1_31, 0, 20, 0);
  result_22_3_rel <= cast_22_12 >= b_1_34;
  op <= boolean_to_vector(result_22_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mcode_block_6c697844b9 is
  port (
    reset : in std_logic_vector((1 - 1) downto 0);
    timeout_req : in std_logic_vector((1 - 1) downto 0);
    new_tx : in std_logic_vector((1 - 1) downto 0);
    idle_for_difs : in std_logic_vector((1 - 1) downto 0);
    backoff_done : in std_logic_vector((1 - 1) downto 0);
    phy_tx_done : in std_logic_vector((1 - 1) downto 0);
    phy_rx_start : in std_logic_vector((1 - 1) downto 0);
    timeout_done : in std_logic_vector((1 - 1) downto 0);
    backoff_start : out std_logic_vector((1 - 1) downto 0);
    phy_tx_start : out std_logic_vector((1 - 1) downto 0);
    timeout_start : out std_logic_vector((1 - 1) downto 0);
    tx_done : out std_logic_vector((1 - 1) downto 0);
    tx_result_out : out std_logic_vector((2 - 1) downto 0);
    fsm_state_out : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mcode_block_6c697844b9;


architecture behavior of mcode_block_6c697844b9 is
  signal reset_2_21: boolean;
  signal timeout_req_2_28: boolean;
  signal new_tx_2_41: boolean;
  signal idle_for_difs_2_49: boolean;
  signal backoff_done_2_64: boolean;
  signal phy_tx_done_2_78: boolean;
  signal phy_rx_start_2_91: boolean;
  signal timeout_done_2_105: boolean;
  signal fsm_state_4_23_next: unsigned((3 - 1) downto 0);
  signal fsm_state_4_23: unsigned((3 - 1) downto 0) := "000";
  signal fsm_state_4_23_rst: std_logic;
  signal tx_result_5_23_next: unsigned((2 - 1) downto 0);
  signal tx_result_5_23: unsigned((2 - 1) downto 0) := "00";
  signal tx_result_5_23_rst: std_logic;
  signal not_67_20: boolean;
  signal fsm_state_join_67_17: unsigned((2 - 1) downto 0);
  signal fsm_state_join_66_13: unsigned((2 - 1) downto 0);
  signal fsm_state_join_99_13: unsigned((2 - 1) downto 0);
  signal fsm_state_join_113_13: unsigned((3 - 1) downto 0);
  signal fsm_state_join_127_13: unsigned((3 - 1) downto 0);
  signal tx_result_join_139_13: unsigned((2 - 1) downto 0);
  signal fsm_state_join_139_13: unsigned((3 - 1) downto 0);
  signal tx_done_join_56_5: unsigned((1 - 1) downto 0);
  signal tx_result_join_56_5: unsigned((2 - 1) downto 0);
  signal phy_tx_start_join_56_5: unsigned((1 - 1) downto 0);
  signal timeout_start_join_56_5: unsigned((1 - 1) downto 0);
  signal fsm_state_join_56_5: unsigned((3 - 1) downto 0);
  signal backoff_start_join_56_5: unsigned((1 - 1) downto 0);
  signal tx_done_join_47_1: unsigned((1 - 1) downto 0);
  signal tx_result_join_47_1: unsigned((2 - 1) downto 0);
  signal tx_result_join_47_1_rst: std_logic;
  signal phy_tx_start_join_47_1: unsigned((1 - 1) downto 0);
  signal timeout_start_join_47_1: unsigned((1 - 1) downto 0);
  signal fsm_state_join_47_1: unsigned((3 - 1) downto 0);
  signal fsm_state_join_47_1_rst: std_logic;
  signal backoff_start_join_47_1: unsigned((1 - 1) downto 0);
begin
  reset_2_21 <= ((reset) = "1");
  timeout_req_2_28 <= ((timeout_req) = "1");
  new_tx_2_41 <= ((new_tx) = "1");
  idle_for_difs_2_49 <= ((idle_for_difs) = "1");
  backoff_done_2_64 <= ((backoff_done) = "1");
  phy_tx_done_2_78 <= ((phy_tx_done) = "1");
  phy_rx_start_2_91 <= ((phy_rx_start) = "1");
  timeout_done_2_105 <= ((timeout_done) = "1");
  proc_fsm_state_4_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (fsm_state_4_23_rst = '1')) then
        fsm_state_4_23 <= "000";
      elsif (ce = '1') then 
        fsm_state_4_23 <= fsm_state_4_23_next;
      end if;
    end if;
  end process proc_fsm_state_4_23;
  proc_tx_result_5_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (tx_result_5_23_rst = '1')) then
        tx_result_5_23 <= "00";
      elsif (ce = '1') then 
        tx_result_5_23 <= tx_result_5_23_next;
      end if;
    end if;
  end process proc_tx_result_5_23;
  not_67_20 <=  not backoff_done_2_64;
  proc_if_67_17: process (idle_for_difs_2_49, not_67_20)
  is
  begin
    if not_67_20 then
      fsm_state_join_67_17 <= std_logic_vector_to_unsigned("11");
    elsif idle_for_difs_2_49 then
      fsm_state_join_67_17 <= std_logic_vector_to_unsigned("01");
    else 
      fsm_state_join_67_17 <= std_logic_vector_to_unsigned("10");
    end if;
  end process proc_if_67_17;
  proc_if_66_13: process (fsm_state_join_67_17, new_tx_2_41)
  is
  begin
    if new_tx_2_41 then
      fsm_state_join_66_13 <= fsm_state_join_67_17;
    else 
      fsm_state_join_66_13 <= std_logic_vector_to_unsigned("00");
    end if;
  end process proc_if_66_13;
  proc_if_99_13: process (backoff_done_2_64)
  is
  begin
    if backoff_done_2_64 then
      fsm_state_join_99_13 <= std_logic_vector_to_unsigned("01");
    else 
      fsm_state_join_99_13 <= std_logic_vector_to_unsigned("11");
    end if;
  end process proc_if_99_13;
  proc_if_113_13: process (phy_tx_done_2_78)
  is
  begin
    if phy_tx_done_2_78 then
      fsm_state_join_113_13 <= std_logic_vector_to_unsigned("100");
    else 
      fsm_state_join_113_13 <= std_logic_vector_to_unsigned("001");
    end if;
  end process proc_if_113_13;
  proc_if_127_13: process (timeout_req_2_28)
  is
  begin
    if timeout_req_2_28 then
      fsm_state_join_127_13 <= std_logic_vector_to_unsigned("101");
    else 
      fsm_state_join_127_13 <= std_logic_vector_to_unsigned("110");
    end if;
  end process proc_if_127_13;
  proc_if_139_13: process (phy_rx_start_2_91, timeout_done_2_105)
  is
  begin
    if phy_rx_start_2_91 then
      tx_result_join_139_13 <= std_logic_vector_to_unsigned("10");
      fsm_state_join_139_13 <= std_logic_vector_to_unsigned("110");
    elsif timeout_done_2_105 then
      tx_result_join_139_13 <= std_logic_vector_to_unsigned("01");
      fsm_state_join_139_13 <= std_logic_vector_to_unsigned("110");
    else 
      tx_result_join_139_13 <= std_logic_vector_to_unsigned("00");
      fsm_state_join_139_13 <= std_logic_vector_to_unsigned("101");
    end if;
  end process proc_if_139_13;
  proc_switch_56_5: process (fsm_state_4_23, fsm_state_join_113_13, fsm_state_join_127_13, fsm_state_join_139_13, fsm_state_join_66_13, fsm_state_join_99_13, tx_result_5_23, tx_result_join_139_13)
  is
  begin
    case fsm_state_4_23 is 
      when "000" =>
        tx_done_join_56_5 <= std_logic_vector_to_unsigned("0");
        tx_result_join_56_5 <= std_logic_vector_to_unsigned("00");
        phy_tx_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        timeout_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        fsm_state_join_56_5 <= u2u_cast(fsm_state_join_66_13, 0, 3, 0);
        backoff_start_join_56_5 <= std_logic_vector_to_unsigned("0");
      when "010" =>
        tx_done_join_56_5 <= std_logic_vector_to_unsigned("0");
        tx_result_join_56_5 <= std_logic_vector_to_unsigned("00");
        phy_tx_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        timeout_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        fsm_state_join_56_5 <= std_logic_vector_to_unsigned("011");
        backoff_start_join_56_5 <= std_logic_vector_to_unsigned("1");
      when "011" =>
        tx_done_join_56_5 <= std_logic_vector_to_unsigned("0");
        tx_result_join_56_5 <= std_logic_vector_to_unsigned("00");
        phy_tx_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        timeout_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        fsm_state_join_56_5 <= u2u_cast(fsm_state_join_99_13, 0, 3, 0);
        backoff_start_join_56_5 <= std_logic_vector_to_unsigned("0");
      when "001" =>
        tx_done_join_56_5 <= std_logic_vector_to_unsigned("0");
        tx_result_join_56_5 <= std_logic_vector_to_unsigned("00");
        phy_tx_start_join_56_5 <= std_logic_vector_to_unsigned("1");
        timeout_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        fsm_state_join_56_5 <= fsm_state_join_113_13;
        backoff_start_join_56_5 <= std_logic_vector_to_unsigned("0");
      when "100" =>
        tx_done_join_56_5 <= std_logic_vector_to_unsigned("0");
        tx_result_join_56_5 <= std_logic_vector_to_unsigned("00");
        phy_tx_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        timeout_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        fsm_state_join_56_5 <= fsm_state_join_127_13;
        backoff_start_join_56_5 <= std_logic_vector_to_unsigned("0");
      when "101" =>
        tx_done_join_56_5 <= std_logic_vector_to_unsigned("0");
        tx_result_join_56_5 <= tx_result_join_139_13;
        phy_tx_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        timeout_start_join_56_5 <= std_logic_vector_to_unsigned("1");
        fsm_state_join_56_5 <= fsm_state_join_139_13;
        backoff_start_join_56_5 <= std_logic_vector_to_unsigned("0");
      when "110" =>
        tx_done_join_56_5 <= std_logic_vector_to_unsigned("1");
        tx_result_join_56_5 <= tx_result_5_23;
        phy_tx_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        timeout_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        fsm_state_join_56_5 <= std_logic_vector_to_unsigned("000");
        backoff_start_join_56_5 <= std_logic_vector_to_unsigned("0");
      when others =>
        tx_done_join_56_5 <= std_logic_vector_to_unsigned("0");
        tx_result_join_56_5 <= std_logic_vector_to_unsigned("00");
        phy_tx_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        timeout_start_join_56_5 <= std_logic_vector_to_unsigned("0");
        fsm_state_join_56_5 <= std_logic_vector_to_unsigned("000");
        backoff_start_join_56_5 <= std_logic_vector_to_unsigned("0");
    end case;
  end process proc_switch_56_5;
  proc_if_47_1: process (backoff_start_join_56_5, fsm_state_join_56_5, phy_tx_start_join_56_5, reset_2_21, timeout_start_join_56_5, tx_done_join_56_5, tx_result_join_56_5)
  is
  begin
    if reset_2_21 then
      tx_result_join_47_1_rst <= '1';
    else 
      tx_result_join_47_1_rst <= '0';
    end if;
    tx_result_join_47_1 <= tx_result_join_56_5;
    if reset_2_21 then
      fsm_state_join_47_1_rst <= '1';
    else 
      fsm_state_join_47_1_rst <= '0';
    end if;
    fsm_state_join_47_1 <= fsm_state_join_56_5;
    if reset_2_21 then
      tx_done_join_47_1 <= std_logic_vector_to_unsigned("0");
      phy_tx_start_join_47_1 <= std_logic_vector_to_unsigned("0");
      timeout_start_join_47_1 <= std_logic_vector_to_unsigned("0");
      backoff_start_join_47_1 <= std_logic_vector_to_unsigned("0");
    else 
      tx_done_join_47_1 <= tx_done_join_56_5;
      phy_tx_start_join_47_1 <= phy_tx_start_join_56_5;
      timeout_start_join_47_1 <= timeout_start_join_56_5;
      backoff_start_join_47_1 <= backoff_start_join_56_5;
    end if;
  end process proc_if_47_1;
  fsm_state_4_23_next <= fsm_state_join_56_5;
  fsm_state_4_23_rst <= fsm_state_join_47_1_rst;
  tx_result_5_23_next <= tx_result_join_56_5;
  tx_result_5_23_rst <= tx_result_join_47_1_rst;
  backoff_start <= unsigned_to_std_logic_vector(backoff_start_join_47_1);
  phy_tx_start <= unsigned_to_std_logic_vector(phy_tx_start_join_47_1);
  timeout_start <= unsigned_to_std_logic_vector(timeout_start_join_47_1);
  tx_done <= unsigned_to_std_logic_vector(tx_done_join_47_1);
  tx_result_out <= unsigned_to_std_logic_vector(tx_result_5_23);
  fsm_state_out <= unsigned_to_std_logic_vector(fsm_state_4_23);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_8e53793314 is
  port (
    in0 : in std_logic_vector((8 - 1) downto 0);
    in1 : in std_logic_vector((8 - 1) downto 0);
    y : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_8e53793314;


architecture behavior of concat_8e53793314 is
  signal in0_1_23: unsigned((8 - 1) downto 0);
  signal in1_1_27: unsigned((8 - 1) downto 0);
  signal y_2_1_concat: unsigned((16 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_e8ddc079e9 is
  port (
    op : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_e8ddc079e9;


architecture behavior of constant_e8ddc079e9 is
begin
  op <= "10";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_3a9a3daeb9 is
  port (
    op : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_3a9a3daeb9;


architecture behavior of constant_3a9a3daeb9 is
begin
  op <= "11";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_cda50df78a is
  port (
    op : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_cda50df78a;


architecture behavior of constant_cda50df78a is
begin
  op <= "00";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_03e37234da is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((16 - 1) downto 0);
    d1 : in std_logic_vector((2 - 1) downto 0);
    y : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_03e37234da;


architecture behavior of mux_03e37234da is
  signal sel_1_20: std_logic_vector((1 - 1) downto 0);
  signal d0_1_24: std_logic_vector((16 - 1) downto 0);
  signal d1_1_27: std_logic_vector((2 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((16 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= cast(d1_1_27, 0, 16, 0, xlUnsigned);
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_59b0d63655 is
  port (
    a : in std_logic_vector((14 - 1) downto 0);
    b : in std_logic_vector((2 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_59b0d63655;


architecture behavior of relational_59b0d63655 is
  signal a_1_31: unsigned((14 - 1) downto 0);
  signal b_1_34: unsigned((2 - 1) downto 0);
  signal cast_12_17: unsigned((14 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_12_17 <= u2u_cast(b_1_34, 0, 14, 0);
  result_12_3_rel <= a_1_31 = cast_12_17;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_22af082bf9 is
  port (
    in0 : in std_logic_vector((21 - 1) downto 0);
    in1 : in std_logic_vector((4 - 1) downto 0);
    y : out std_logic_vector((25 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_22af082bf9;


architecture behavior of concat_22af082bf9 is
  signal in0_1_23: unsigned((21 - 1) downto 0);
  signal in1_1_27: unsigned((4 - 1) downto 0);
  signal y_2_1_concat: unsigned((25 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_4c449dd556 is
  port (
    op : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_4c449dd556;


architecture behavior of constant_4c449dd556 is
begin
  op <= "0000";
end behavior;


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
-- synopsys translate_off
library XilinxCoreLib;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.conv_pkg.all;
entity xladdsub_wlan_mac_dcf_hw is
  generic (
    core_name0: string := "";
    a_width: integer := 16;
    a_bin_pt: integer := 4;
    a_arith: integer := xlUnsigned;
    c_in_width: integer := 16;
    c_in_bin_pt: integer := 4;
    c_in_arith: integer := xlUnsigned;
    c_out_width: integer := 16;
    c_out_bin_pt: integer := 4;
    c_out_arith: integer := xlUnsigned;
    b_width: integer := 8;
    b_bin_pt: integer := 2;
    b_arith: integer := xlUnsigned;
    s_width: integer := 17;
    s_bin_pt: integer := 4;
    s_arith: integer := xlUnsigned;
    rst_width: integer := 1;
    rst_bin_pt: integer := 0;
    rst_arith: integer := xlUnsigned;
    en_width: integer := 1;
    en_bin_pt: integer := 0;
    en_arith: integer := xlUnsigned;
    full_s_width: integer := 17;
    full_s_arith: integer := xlUnsigned;
    mode: integer := xlAddMode;
    extra_registers: integer := 0;
    latency: integer := 0;
    quantization: integer := xlTruncate;
    overflow: integer := xlWrap;
    c_latency: integer := 0;
    c_output_width: integer := 17;
    c_has_c_in : integer := 0;
    c_has_c_out : integer := 0
  );
  port (
    a: in std_logic_vector(a_width - 1 downto 0);
    b: in std_logic_vector(b_width - 1 downto 0);
    c_in : in std_logic_vector (0 downto 0) := "0";
    ce: in std_logic;
    clr: in std_logic := '0';
    clk: in std_logic;
    rst: in std_logic_vector(rst_width - 1 downto 0) := "0";
    en: in std_logic_vector(en_width - 1 downto 0) := "1";
    c_out : out std_logic_vector (0 downto 0);
    s: out std_logic_vector(s_width - 1 downto 0)
  );
end xladdsub_wlan_mac_dcf_hw;
architecture behavior of xladdsub_wlan_mac_dcf_hw is
  component synth_reg
    generic (
      width: integer := 16;
      latency: integer := 5
    );
    port (
      i: in std_logic_vector(width - 1 downto 0);
      ce: in std_logic;
      clr: in std_logic;
      clk: in std_logic;
      o: out std_logic_vector(width - 1 downto 0)
    );
  end component;
  function format_input(inp: std_logic_vector; old_width, delta, new_arith,
                        new_width: integer)
    return std_logic_vector
  is
    variable vec: std_logic_vector(old_width-1 downto 0);
    variable padded_inp: std_logic_vector((old_width + delta)-1  downto 0);
    variable result: std_logic_vector(new_width-1 downto 0);
  begin
    vec := inp;
    if (delta > 0) then
      padded_inp := pad_LSB(vec, old_width+delta);
      result := extend_MSB(padded_inp, new_width, new_arith);
    else
      result := extend_MSB(vec, new_width, new_arith);
    end if;
    return result;
  end;
  constant full_s_bin_pt: integer := fractional_bits(a_bin_pt, b_bin_pt);
  constant full_a_width: integer := full_s_width;
  constant full_b_width: integer := full_s_width;
  signal full_a: std_logic_vector(full_a_width - 1 downto 0);
  signal full_b: std_logic_vector(full_b_width - 1 downto 0);
  signal core_s: std_logic_vector(full_s_width - 1 downto 0);
  signal conv_s: std_logic_vector(s_width - 1 downto 0);
  signal temp_cout : std_logic;
  signal internal_clr: std_logic;
  signal internal_ce: std_logic;
  signal extra_reg_ce: std_logic;
  signal override: std_logic;
  signal logic1: std_logic_vector(0 downto 0);
  component addsb_11_0_38dd91dde0ab1a97
    port (
          a: in std_logic_vector(22 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(22 - 1 downto 0)
    );
  end component;
  component addsb_11_0_3c1d0ac9b6b8f403
    port (
          a: in std_logic_vector(66 - 1 downto 0);
    clk: in std_logic:= '0';
    ce: in std_logic:= '0';
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(66 - 1 downto 0)
    );
  end component;
begin
  internal_clr <= (clr or (rst(0))) and ce;
  internal_ce <= ce and en(0);
  logic1(0) <= '1';
  addsub_process: process (a, b, core_s)
  begin
    full_a <= format_input (a, a_width, b_bin_pt - a_bin_pt, a_arith,
                            full_a_width);
    full_b <= format_input (b, b_width, a_bin_pt - b_bin_pt, b_arith,
                            full_b_width);
    conv_s <= convert_type (core_s, full_s_width, full_s_bin_pt, full_s_arith,
                            s_width, s_bin_pt, s_arith, quantization, overflow);
  end process addsub_process;

  comp0: if ((core_name0 = "addsb_11_0_38dd91dde0ab1a97")) generate
    core_instance0: addsb_11_0_38dd91dde0ab1a97
      port map (
         a => full_a,
         s => core_s,
         b => full_b
      );
  end generate;
  comp1: if ((core_name0 = "addsb_11_0_3c1d0ac9b6b8f403")) generate
    core_instance1: addsb_11_0_3c1d0ac9b6b8f403
      port map (
         a => full_a,
         clk => clk,
         ce => internal_ce,
         s => core_s,
         b => full_b
      );
  end generate;
  latency_test: if (extra_registers > 0) generate
      override_test: if (c_latency > 1) generate
       override_pipe: synth_reg
          generic map (
            width => 1,
            latency => c_latency
          )
          port map (
            i => logic1,
            ce => internal_ce,
            clr => internal_clr,
            clk => clk,
            o(0) => override);
       extra_reg_ce <= ce and en(0) and override;
      end generate override_test;
      no_override: if ((c_latency = 0) or (c_latency = 1)) generate
       extra_reg_ce <= ce and en(0);
      end generate no_override;
      extra_reg: synth_reg
        generic map (
          width => s_width,
          latency => extra_registers
        )
        port map (
          i => conv_s,
          ce => extra_reg_ce,
          clr => internal_clr,
          clk => clk,
          o => s
        );
      cout_test: if (c_has_c_out = 1) generate
      c_out_extra_reg: synth_reg
        generic map (
          width => 1,
          latency => extra_registers
        )
        port map (
          i(0) => temp_cout,
          ce => extra_reg_ce,
          clr => internal_clr,
          clk => clk,
          o => c_out
        );
      end generate cout_test;
  end generate;
  latency_s: if ((latency = 0) or (extra_registers = 0)) generate
    s <= conv_s;
  end generate latency_s;
  latency0: if (((latency = 0) or (extra_registers = 0)) and
                 (c_has_c_out = 1)) generate
    c_out(0) <= temp_cout;
  end generate latency0;
  tie_dangling_cout: if (c_has_c_out = 0) generate
    c_out <= "0";
  end generate tie_dangling_cout;
end architecture behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_5c1626e05e is
  port (
    op : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_5c1626e05e;


architecture behavior of constant_5c1626e05e is
begin
  op <= "1010";
end behavior;


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
-- synopsys translate_off
library XilinxCoreLib;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.conv_pkg.all;
entity xlmult_wlan_mac_dcf_hw is
  generic (
    core_name0: string := "";
    a_width: integer := 4;
    a_bin_pt: integer := 2;
    a_arith: integer := xlSigned;
    b_width: integer := 4;
    b_bin_pt: integer := 1;
    b_arith: integer := xlSigned;
    p_width: integer := 8;
    p_bin_pt: integer := 2;
    p_arith: integer := xlSigned;
    rst_width: integer := 1;
    rst_bin_pt: integer := 0;
    rst_arith: integer := xlUnsigned;
    en_width: integer := 1;
    en_bin_pt: integer := 0;
    en_arith: integer := xlUnsigned;
    quantization: integer := xlTruncate;
    overflow: integer := xlWrap;
    extra_registers: integer := 0;
    c_a_width: integer := 7;
    c_b_width: integer := 7;
    c_type: integer := 0;
    c_a_type: integer := 0;
    c_b_type: integer := 0;
    c_pipelined: integer := 1;
    c_baat: integer := 4;
    multsign: integer := xlSigned;
    c_output_width: integer := 16
  );
  port (
    a: in std_logic_vector(a_width - 1 downto 0);
    b: in std_logic_vector(b_width - 1 downto 0);
    ce: in std_logic;
    clr: in std_logic;
    clk: in std_logic;
    core_ce: in std_logic := '0';
    core_clr: in std_logic := '0';
    core_clk: in std_logic := '0';
    rst: in std_logic_vector(rst_width - 1 downto 0);
    en: in std_logic_vector(en_width - 1 downto 0);
    p: out std_logic_vector(p_width - 1 downto 0)
  );
end xlmult_wlan_mac_dcf_hw;
architecture behavior of xlmult_wlan_mac_dcf_hw is
  component synth_reg
    generic (
      width: integer := 16;
      latency: integer := 5
    );
    port (
      i: in std_logic_vector(width - 1 downto 0);
      ce: in std_logic;
      clr: in std_logic;
      clk: in std_logic;
      o: out std_logic_vector(width - 1 downto 0)
    );
  end component;
  component mult_11_2_7def12de86dcdc6a
    port (
      b: in std_logic_vector(c_b_width - 1 downto 0);
      p: out std_logic_vector(c_output_width - 1 downto 0);
      clk: in std_logic;
      ce: in std_logic;
      sclr: in std_logic;
      a: in std_logic_vector(c_a_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of mult_11_2_7def12de86dcdc6a:
    component is true;
  attribute fpga_dont_touch of mult_11_2_7def12de86dcdc6a:
    component is "true";
  attribute box_type of mult_11_2_7def12de86dcdc6a:
    component  is "black_box";
  signal tmp_a: std_logic_vector(c_a_width - 1 downto 0);
  signal conv_a: std_logic_vector(c_a_width - 1 downto 0);
  signal tmp_b: std_logic_vector(c_b_width - 1 downto 0);
  signal conv_b: std_logic_vector(c_b_width - 1 downto 0);
  signal tmp_p: std_logic_vector(c_output_width - 1 downto 0);
  signal conv_p: std_logic_vector(p_width - 1 downto 0);
  -- synopsys translate_off
  signal real_a, real_b, real_p: real;
  -- synopsys translate_on
  signal rfd: std_logic;
  signal rdy: std_logic;
  signal nd: std_logic;
  signal internal_ce: std_logic;
  signal internal_clr: std_logic;
  signal internal_core_ce: std_logic;
begin
-- synopsys translate_off
-- synopsys translate_on
  internal_ce <= ce and en(0);
  internal_core_ce <= core_ce and en(0);
  internal_clr <= (clr or rst(0)) and ce;
  nd <= internal_ce;
  input_process:  process (a,b)
  begin
    tmp_a <= zero_ext(a, c_a_width);
    tmp_b <= zero_ext(b, c_b_width);
  end process;
  output_process: process (tmp_p)
  begin
    conv_p <= convert_type(tmp_p, c_output_width, a_bin_pt+b_bin_pt, multsign,
                           p_width, p_bin_pt, p_arith, quantization, overflow);
  end process;
  comp0: if ((core_name0 = "mult_11_2_7def12de86dcdc6a")) generate
    core_instance0: mult_11_2_7def12de86dcdc6a
      port map (
        a => tmp_a,
        clk => clk,
        ce => internal_ce,
        sclr => internal_clr,
        p => tmp_p,
        b => tmp_b
      );
  end generate;
  latency_gt_0: if (extra_registers > 0) generate
    reg: synth_reg
      generic map (
        width => p_width,
        latency => extra_registers
      )
      port map (
        i => conv_p,
        ce => internal_ce,
        clr => internal_clr,
        clk => clk,
        o => p
      );
  end generate;
  latency_eq_0: if (extra_registers = 0) generate
    p <= conv_p;
  end generate;
end architecture behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_bebc7e34dc is
  port (
    a : in std_logic_vector((20 - 1) downto 0);
    b : in std_logic_vector((25 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_bebc7e34dc;


architecture behavior of relational_bebc7e34dc is
  signal a_1_31: unsigned((20 - 1) downto 0);
  signal b_1_34: unsigned((25 - 1) downto 0);
  signal cast_16_12: unsigned((25 - 1) downto 0);
  signal result_16_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_16_12 <= u2u_cast(a_1_31, 0, 25, 0);
  result_16_3_rel <= cast_16_12 < b_1_34;
  op <= boolean_to_vector(result_16_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_77a58970b2 is
  port (
    a : in std_logic_vector((20 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_77a58970b2;


architecture behavior of relational_77a58970b2 is
  signal a_1_31: unsigned((20 - 1) downto 0);
  signal b_1_34: unsigned((1 - 1) downto 0);
  signal cast_18_16: unsigned((20 - 1) downto 0);
  signal result_18_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_18_16 <= u2u_cast(b_1_34, 0, 20, 0);
  result_18_3_rel <= a_1_31 > cast_18_16;
  op <= boolean_to_vector(result_18_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity logical_3640e86e6c is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    d2 : in std_logic_vector((1 - 1) downto 0);
    d3 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_3640e86e6c;


architecture behavior of logical_3640e86e6c is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal d2_1_30: std_logic;
  signal d3_1_33: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  d2_1_30 <= d2(0);
  d3_1_33 <= d3(0);
  fully_2_1_bit <= d0_1_24 and d1_1_27 and d2_1_30 and d3_1_33;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_f9c0f11a18 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((4 - 1) downto 0);
    d1 : in std_logic_vector((4 - 1) downto 0);
    y : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_f9c0f11a18;


architecture behavior of mux_f9c0f11a18 is
  signal sel_1_20: std_logic;
  signal d0_1_24: std_logic_vector((4 - 1) downto 0);
  signal d1_1_27: std_logic_vector((4 - 1) downto 0);
  signal sel_internal_2_1_convert: std_logic_vector((1 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((4 - 1) downto 0);
begin
  sel_1_20 <= sel(0);
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  sel_internal_2_1_convert <= cast(std_logic_to_vector(sel_1_20), 0, 1, 0, xlUnsigned);
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_ac2c510b5b is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((6 - 1) downto 0);
    d1 : in std_logic_vector((6 - 1) downto 0);
    y : out std_logic_vector((6 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_ac2c510b5b;


architecture behavior of mux_ac2c510b5b is
  signal sel_1_20: std_logic;
  signal d0_1_24: std_logic_vector((6 - 1) downto 0);
  signal d1_1_27: std_logic_vector((6 - 1) downto 0);
  signal sel_internal_2_1_convert: std_logic_vector((1 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((6 - 1) downto 0);
begin
  sel_1_20 <= sel(0);
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  sel_internal_2_1_convert <= cast(std_logic_to_vector(sel_1_20), 0, 1, 0, xlUnsigned);
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_4a94c27437 is
  port (
    in0 : in std_logic_vector((10 - 1) downto 0);
    in1 : in std_logic_vector((4 - 1) downto 0);
    y : out std_logic_vector((14 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_4a94c27437;


architecture behavior of concat_4a94c27437 is
  signal in0_1_23: unsigned((10 - 1) downto 0);
  signal in1_1_27: unsigned((4 - 1) downto 0);
  signal y_2_1_concat: unsigned((14 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_0a671b9443 is
  port (
    in0 : in std_logic_vector((16 - 1) downto 0);
    in1 : in std_logic_vector((4 - 1) downto 0);
    y : out std_logic_vector((20 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_0a671b9443;


architecture behavior of concat_0a671b9443 is
  signal in0_1_23: unsigned((16 - 1) downto 0);
  signal in1_1_27: unsigned((4 - 1) downto 0);
  signal y_2_1_concat: unsigned((20 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_2119b6f9e7 is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((1 - 1) downto 0);
    in2 : in std_logic_vector((1 - 1) downto 0);
    in3 : in std_logic_vector((1 - 1) downto 0);
    in4 : in std_logic_vector((1 - 1) downto 0);
    in5 : in std_logic_vector((1 - 1) downto 0);
    in6 : in std_logic_vector((3 - 1) downto 0);
    in7 : in std_logic_vector((2 - 1) downto 0);
    in8 : in std_logic_vector((1 - 1) downto 0);
    in9 : in std_logic_vector((1 - 1) downto 0);
    in10 : in std_logic_vector((1 - 1) downto 0);
    in11 : in std_logic_vector((1 - 1) downto 0);
    in12 : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((31 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_2119b6f9e7;


architecture behavior of concat_2119b6f9e7 is
  signal in0_1_23: boolean;
  signal in1_1_27: boolean;
  signal in2_1_31: boolean;
  signal in3_1_35: boolean;
  signal in4_1_39: boolean;
  signal in5_1_43: boolean;
  signal in6_1_47: unsigned((3 - 1) downto 0);
  signal in7_1_51: unsigned((2 - 1) downto 0);
  signal in8_1_55: boolean;
  signal in9_1_59: boolean;
  signal in10_1_63: boolean;
  signal in11_1_68: boolean;
  signal in12_1_73: unsigned((16 - 1) downto 0);
  signal y_2_1_concat: unsigned((31 - 1) downto 0);
begin
  in0_1_23 <= ((in0) = "1");
  in1_1_27 <= ((in1) = "1");
  in2_1_31 <= ((in2) = "1");
  in3_1_35 <= ((in3) = "1");
  in4_1_39 <= ((in4) = "1");
  in5_1_43 <= ((in5) = "1");
  in6_1_47 <= std_logic_vector_to_unsigned(in6);
  in7_1_51 <= std_logic_vector_to_unsigned(in7);
  in8_1_55 <= ((in8) = "1");
  in9_1_59 <= ((in9) = "1");
  in10_1_63 <= ((in10) = "1");
  in11_1_68 <= ((in11) = "1");
  in12_1_73 <= std_logic_vector_to_unsigned(in12);
  y_2_1_concat <= std_logic_vector_to_unsigned(boolean_to_vector(in0_1_23) & boolean_to_vector(in1_1_27) & boolean_to_vector(in2_1_31) & boolean_to_vector(in3_1_35) & boolean_to_vector(in4_1_39) & boolean_to_vector(in5_1_43) & unsigned_to_std_logic_vector(in6_1_47) & unsigned_to_std_logic_vector(in7_1_51) & boolean_to_vector(in8_1_55) & boolean_to_vector(in9_1_59) & boolean_to_vector(in10_1_63) & boolean_to_vector(in11_1_68) & unsigned_to_std_logic_vector(in12_1_73));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_d5964bfb65 is
  port (
    in0 : in std_logic_vector((8 - 1) downto 0);
    in1 : in std_logic_vector((14 - 1) downto 0);
    y : out std_logic_vector((22 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_d5964bfb65;


architecture behavior of concat_d5964bfb65 is
  signal in0_1_23: unsigned((8 - 1) downto 0);
  signal in1_1_27: unsigned((14 - 1) downto 0);
  signal y_2_1_concat: unsigned((22 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_ca4e0802c4 is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((8 - 1) downto 0);
    in2 : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((25 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_ca4e0802c4;


architecture behavior of concat_ca4e0802c4 is
  signal in0_1_23: boolean;
  signal in1_1_27: unsigned((8 - 1) downto 0);
  signal in2_1_31: unsigned((16 - 1) downto 0);
  signal y_2_1_concat: unsigned((25 - 1) downto 0);
begin
  in0_1_23 <= ((in0) = "1");
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  in2_1_31 <= std_logic_vector_to_unsigned(in2);
  y_2_1_concat <= std_logic_vector_to_unsigned(boolean_to_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27) & unsigned_to_std_logic_vector(in2_1_31));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity reinterpret_4389dc89bf is
  port (
    input_port : in std_logic_vector((8 - 1) downto 0);
    output_port : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_4389dc89bf;


architecture behavior of reinterpret_4389dc89bf is
  signal input_port_1_40: unsigned((8 - 1) downto 0);
  signal output_port_5_5_force: signed((8 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port_5_5_force <= unsigned_to_signed(input_port_1_40);
  output_port <= signed_to_std_logic_vector(output_port_5_5_force);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/64-bit usec  Counter/Posedge2"

entity posedge2_entity_3570911e8f is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    d: in std_logic; 
    q: out std_logic
  );
end posedge2_entity_3570911e8f;

architecture structural of posedge2_entity_3570911e8f is
  signal b_5_y_net: std_logic;
  signal ce_1_sg_x0: std_logic;
  signal clk_1_sg_x0: std_logic;
  signal delay_q_net: std_logic;
  signal inverter_op_net: std_logic;
  signal logical1_y_net_x0: std_logic;

begin
  ce_1_sg_x0 <= ce_1;
  clk_1_sg_x0 <= clk_1;
  b_5_y_net <= d;
  q <= logical1_y_net_x0;

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x0,
      clk => clk_1_sg_x0,
      d(0) => b_5_y_net,
      en => '1',
      rst => '1',
      q(0) => delay_q_net
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x0,
      clk => clk_1_sg_x0,
      clr => '0',
      ip(0) => delay_q_net,
      op(0) => inverter_op_net
    );

  logical1: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => inverter_op_net,
      d1(0) => b_5_y_net,
      y(0) => logical1_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/64-bit usec  Counter/usec Pulse"

entity usec_pulse_entity_60c9f0dffd is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    rst: in std_logic; 
    usec: out std_logic
  );
end usec_pulse_entity_60c9f0dffd;

architecture structural of usec_pulse_entity_60c9f0dffd is
  signal ce_1_sg_x1: std_logic;
  signal clk_1_sg_x1: std_logic;
  signal clk_usec_op_net: std_logic_vector(7 downto 0);
  signal constant1_op_net: std_logic_vector(7 downto 0);
  signal logical1_y_net_x1: std_logic;
  signal logical_y_net: std_logic;
  signal relational_op_net_x0: std_logic;

begin
  ce_1_sg_x1 <= ce_1;
  clk_1_sg_x1 <= clk_1;
  logical1_y_net_x1 <= rst;
  usec <= relational_op_net_x0;

  clk_usec: entity work.xlcounter_free_wlan_mac_dcf_hw
    generic map (
      core_name0 => "cntr_11_0_86806e294f737f4c",
      op_arith => xlUnsigned,
      op_width => 8
    )
    port map (
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      clr => '0',
      en => "1",
      rst(0) => logical_y_net,
      op => clk_usec_op_net
    );

  constant1: entity work.constant_5f4d695836
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant1_op_net
    );

  logical: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational_op_net_x0,
      d1(0) => logical1_y_net_x1,
      y(0) => logical_y_net
    );

  relational: entity work.relational_54048c8b02
    port map (
      a => clk_usec_op_net,
      b => constant1_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational_op_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/64-bit usec  Counter"

entity \x64_bit_usec__counter_entity_53a249f18e\ is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    reg_set_timestamp_lsb: in std_logic_vector(31 downto 0); 
    reg_set_timestamp_msb: in std_logic_vector(31 downto 0); 
    reg_update_timestamp: in std_logic; 
    microsecond_timestamp: out std_logic_vector(63 downto 0); 
    register3_x0: out std_logic_vector(31 downto 0); 
    register_x1: out std_logic_vector(31 downto 0)
  );
end \x64_bit_usec__counter_entity_53a249f18e\;

architecture structural of \x64_bit_usec__counter_entity_53a249f18e\ is
  signal b_5_y_net_x0: std_logic;
  signal ce_1_sg_x2: std_logic;
  signal clk_1_sg_x2: std_logic;
  signal concat_y_net: std_logic_vector(63 downto 0);
  signal logical1_y_net_x1: std_logic;
  signal logical_y_net: std_logic;
  signal microsecond_counter_op_net_x0: std_logic_vector(63 downto 0);
  signal register1_q_net: std_logic_vector(31 downto 0);
  signal register27_q_net_x0: std_logic_vector(31 downto 0);
  signal register28_q_net_x0: std_logic_vector(31 downto 0);
  signal register2_q_net: std_logic_vector(31 downto 0);
  signal register3_q_net_x0: std_logic_vector(31 downto 0);
  signal register_q_net_x0: std_logic_vector(31 downto 0);
  signal relational_op_net_x0: std_logic;
  signal x32lsb_y_net: std_logic_vector(31 downto 0);
  signal x32msb_y_net: std_logic_vector(31 downto 0);

begin
  ce_1_sg_x2 <= ce_1;
  clk_1_sg_x2 <= clk_1;
  register28_q_net_x0 <= reg_set_timestamp_lsb;
  register27_q_net_x0 <= reg_set_timestamp_msb;
  b_5_y_net_x0 <= reg_update_timestamp;
  microsecond_timestamp <= microsecond_counter_op_net_x0;
  register3_x0 <= register3_q_net_x0;
  register_x1 <= register_q_net_x0;

  concat: entity work.concat_62c4475a80
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => register27_q_net_x0,
      in1 => register28_q_net_x0,
      y => concat_y_net
    );

  logical: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical1_y_net_x1,
      d1(0) => relational_op_net_x0,
      y(0) => logical_y_net
    );

  microsecond_counter: entity work.xlcounter_free_wlan_mac_dcf_hw
    generic map (
      core_name0 => "cntr_11_0_5e62871cb125c52e",
      op_arith => xlUnsigned,
      op_width => 64
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      clr => '0',
      din => concat_y_net,
      en(0) => logical_y_net,
      load(0) => logical1_y_net_x1,
      rst => "0",
      op => microsecond_counter_op_net_x0
    );

  posedge2_3570911e8f: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x2,
      clk_1 => clk_1_sg_x2,
      d => b_5_y_net_x0,
      q => logical1_y_net_x1
    );

  register1: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      d => x32msb_y_net,
      en => "1",
      rst => "0",
      q => register1_q_net
    );

  register2: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      d => x32lsb_y_net,
      en => "1",
      rst => "0",
      q => register2_q_net
    );

  register3: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      d => register2_q_net,
      en => "1",
      rst => "0",
      q => register3_q_net_x0
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      d => register1_q_net,
      en => "1",
      rst => "0",
      q => register_q_net_x0
    );

  usec_pulse_60c9f0dffd: entity work.usec_pulse_entity_60c9f0dffd
    port map (
      ce_1 => ce_1_sg_x2,
      clk_1 => clk_1_sg_x2,
      rst => logical1_y_net_x1,
      usec => relational_op_net_x0
    );

  x32lsb: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 31,
      x_width => 64,
      y_width => 32
    )
    port map (
      x => microsecond_counter_op_net_x0,
      y => x32lsb_y_net
    );

  x32msb: entity work.xlslice
    generic map (
      new_lsb => 32,
      new_msb => 63,
      x_width => 64,
      y_width => 32
    )
    port map (
      x => microsecond_counter_op_net_x0,
      y => x32msb_y_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Auto Tx Control/S-R Latch1"

entity s_r_latch1_entity_370a153267 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    r: in std_logic; 
    s: in std_logic; 
    q: out std_logic
  );
end s_r_latch1_entity_370a153267;

architecture structural of s_r_latch1_entity_370a153267 is
  signal ce_1_sg_x5: std_logic;
  signal clk_1_sg_x5: std_logic;
  signal constant1_op_net: std_logic;
  signal logical1_y_net_x0: std_logic;
  signal logical4_y_net_x0: std_logic;
  signal register2_q_net_x0: std_logic;

begin
  ce_1_sg_x5 <= ce_1;
  clk_1_sg_x5 <= clk_1;
  logical1_y_net_x0 <= r;
  logical4_y_net_x0 <= s;
  q <= register2_q_net_x0;

  constant1: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant1_op_net
    );

  register2: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x5,
      clk => clk_1_sg_x5,
      d(0) => constant1_op_net,
      en(0) => logical4_y_net_x0,
      rst(0) => logical1_y_net_x0,
      q(0) => register2_q_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Auto Tx Control/negedge"

entity negedge_entity_3bed854ca2 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    d: in std_logic; 
    q: out std_logic
  );
end negedge_entity_3bed854ca2;

architecture structural of negedge_entity_3bed854ca2 is
  signal ce_1_sg_x7: std_logic;
  signal clk_1_sg_x7: std_logic;
  signal delay_q_net: std_logic;
  signal inverter_op_net: std_logic;
  signal logical1_y_net_x0: std_logic;
  signal register24_q_net_x1: std_logic;

begin
  ce_1_sg_x7 <= ce_1;
  clk_1_sg_x7 <= clk_1;
  register24_q_net_x1 <= d;
  q <= logical1_y_net_x0;

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => register24_q_net_x1,
      en => '1',
      rst => '1',
      q(0) => delay_q_net
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      clr => '0',
      ip(0) => register24_q_net_x1,
      op(0) => inverter_op_net
    );

  logical1: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => delay_q_net,
      d1(0) => inverter_op_net,
      y(0) => logical1_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Auto Tx Control"

entity auto_tx_control_entity_a58b23c486 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    global_reset: in std_logic; 
    phy_rx_end_ind: in std_logic; 
    phy_rx_end_rxerror: in std_logic_vector(1 downto 0); 
    phy_rx_fcs_good_ind: in std_logic; 
    reg_autotx_dly: in std_logic_vector(13 downto 0); 
    reg_autotx_param_en: in std_logic; 
    reg_autotx_param_pktbuf: in std_logic_vector(3 downto 0); 
    reg_autotx_param_txantmask: in std_logic_vector(3 downto 0); 
    reg_autotx_param_txgain_a: in std_logic_vector(5 downto 0); 
    reg_autotx_param_txgain_b: in std_logic_vector(5 downto 0); 
    reg_autotx_param_txgain_c: in std_logic_vector(5 downto 0); 
    reg_autotx_param_txgain_d: in std_logic_vector(5 downto 0); 
    auto_tx_antmask: out std_logic_vector(3 downto 0); 
    auto_tx_gain_a: out std_logic_vector(5 downto 0); 
    auto_tx_gain_b: out std_logic_vector(5 downto 0); 
    auto_tx_gain_c: out std_logic_vector(5 downto 0); 
    auto_tx_gain_d: out std_logic_vector(5 downto 0); 
    auto_tx_phy_start: out std_logic; 
    auto_tx_pktbuf: out std_logic_vector(3 downto 0); 
    status_autotx_pending: out std_logic
  );
end auto_tx_control_entity_a58b23c486;

architecture structural of auto_tx_control_entity_a58b23c486 is
  signal b_23_20_y_net: std_logic_vector(3 downto 0);
  signal ce_1_sg_x8: std_logic;
  signal clk_1_sg_x8: std_logic;
  signal concat1_y_net_x0: std_logic_vector(13 downto 0);
  signal constant1_op_net: std_logic;
  signal constant_op_net: std_logic;
  signal convert1_dout_net_x0: std_logic;
  signal inverter_op_net: std_logic;
  signal logical1_y_net_x0: std_logic;
  signal logical1_y_net_x1: std_logic;
  signal logical1_y_net_x2: std_logic;
  signal logical1_y_net_x3: std_logic;
  signal logical2_y_net_x0: std_logic;
  signal logical3_y_net: std_logic;
  signal logical4_y_net_x0: std_logic;
  signal logical5_y_net_x0: std_logic;
  signal logical6_y_net_x0: std_logic;
  signal phy_rx_end_ind_net_x0: std_logic;
  signal phy_rx_end_rxerror_net_x0: std_logic_vector(1 downto 0);
  signal phy_rx_fcs_good_ind_net_x0: std_logic;
  signal register1_q_net_x0: std_logic;
  signal register22_q_net_x0: std_logic_vector(3 downto 0);
  signal register24_q_net_x2: std_logic;
  signal register2_q_net_x0: std_logic;
  signal register2_q_net_x1: std_logic;
  signal register2_q_net_x2: std_logic_vector(3 downto 0);
  signal register3_q_net_x0: std_logic_vector(5 downto 0);
  signal register4_q_net_x0: std_logic_vector(3 downto 0);
  signal register58_q_net_x0: std_logic_vector(5 downto 0);
  signal register59_q_net_x0: std_logic_vector(5 downto 0);
  signal register5_q_net_x0: std_logic_vector(5 downto 0);
  signal register60_q_net_x0: std_logic_vector(5 downto 0);
  signal register61_q_net_x0: std_logic_vector(5 downto 0);
  signal register6_q_net_x0: std_logic_vector(5 downto 0);
  signal register7_q_net_x0: std_logic_vector(5 downto 0);
  signal relational1_op_net: std_logic;
  signal relational2_op_net: std_logic;
  signal relational3_op_net: std_logic;
  signal txsifs_op_net: std_logic_vector(13 downto 0);

begin
  ce_1_sg_x8 <= ce_1;
  clk_1_sg_x8 <= clk_1;
  convert1_dout_net_x0 <= global_reset;
  phy_rx_end_ind_net_x0 <= phy_rx_end_ind;
  phy_rx_end_rxerror_net_x0 <= phy_rx_end_rxerror;
  phy_rx_fcs_good_ind_net_x0 <= phy_rx_fcs_good_ind;
  concat1_y_net_x0 <= reg_autotx_dly;
  register24_q_net_x2 <= reg_autotx_param_en;
  register22_q_net_x0 <= reg_autotx_param_pktbuf;
  b_23_20_y_net <= reg_autotx_param_txantmask;
  register58_q_net_x0 <= reg_autotx_param_txgain_a;
  register59_q_net_x0 <= reg_autotx_param_txgain_b;
  register60_q_net_x0 <= reg_autotx_param_txgain_c;
  register61_q_net_x0 <= reg_autotx_param_txgain_d;
  auto_tx_antmask <= register4_q_net_x0;
  auto_tx_gain_a <= register3_q_net_x0;
  auto_tx_gain_b <= register5_q_net_x0;
  auto_tx_gain_c <= register6_q_net_x0;
  auto_tx_gain_d <= register7_q_net_x0;
  auto_tx_phy_start <= register1_q_net_x0;
  auto_tx_pktbuf <= register2_q_net_x2;
  status_autotx_pending <= logical5_y_net_x0;

  constant1: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant1_op_net
    );

  constant_x0: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant_op_net
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      clr => '0',
      ip(0) => register2_q_net_x0,
      op(0) => inverter_op_net
    );

  logical1: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational3_op_net,
      d1(0) => convert1_dout_net_x0,
      y(0) => logical1_y_net_x0
    );

  logical2: entity work.logical_954ee29728
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => phy_rx_fcs_good_ind_net_x0,
      d1(0) => phy_rx_end_ind_net_x0,
      d2(0) => relational2_op_net,
      y(0) => logical2_y_net_x0
    );

  logical3: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => register2_q_net_x1,
      d1(0) => relational3_op_net,
      y(0) => logical3_y_net
    );

  logical4: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical1_y_net_x1,
      d1(0) => relational1_op_net,
      y(0) => logical4_y_net_x0
    );

  logical5: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => register2_q_net_x1,
      d1(0) => register2_q_net_x0,
      y(0) => logical5_y_net_x0
    );

  logical6: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical1_y_net_x3,
      d1(0) => logical1_y_net_x0,
      y(0) => logical6_y_net_x0
    );

  negedge_3bed854ca2: entity work.negedge_entity_3bed854ca2
    port map (
      ce_1 => ce_1_sg_x8,
      clk_1 => clk_1_sg_x8,
      d => register24_q_net_x2,
      q => logical1_y_net_x3
    );

  posedge1_c59dcf4861: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x8,
      clk_1 => clk_1_sg_x8,
      d => logical2_y_net_x0,
      q => logical1_y_net_x1
    );

  posedge2_57fad4d83a: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x8,
      clk_1 => clk_1_sg_x8,
      d => register24_q_net_x2,
      q => logical1_y_net_x2
    );

  register1: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      d(0) => logical3_y_net,
      en => "1",
      rst => "0",
      q(0) => register1_q_net_x0
    );

  register2: entity work.xlregister
    generic map (
      d_width => 4,
      init_value => b"0000"
    )
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      d => register22_q_net_x0,
      en(0) => logical3_y_net,
      rst => "0",
      q => register2_q_net_x2
    );

  register3: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      d => register58_q_net_x0,
      en(0) => logical3_y_net,
      rst => "0",
      q => register3_q_net_x0
    );

  register4: entity work.xlregister
    generic map (
      d_width => 4,
      init_value => b"0000"
    )
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      d => b_23_20_y_net,
      en(0) => logical3_y_net,
      rst => "0",
      q => register4_q_net_x0
    );

  register5: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      d => register59_q_net_x0,
      en(0) => logical3_y_net,
      rst => "0",
      q => register5_q_net_x0
    );

  register6: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      d => register60_q_net_x0,
      en(0) => logical3_y_net,
      rst => "0",
      q => register6_q_net_x0
    );

  register7: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      d => register61_q_net_x0,
      en(0) => logical3_y_net,
      rst => "0",
      q => register7_q_net_x0
    );

  relational1: entity work.relational_93f19f97e9
    port map (
      a => concat1_y_net_x0,
      b(0) => constant1_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net
    );

  relational2: entity work.relational_f52e6abf76
    port map (
      a => phy_rx_end_rxerror_net_x0,
      b(0) => constant_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational2_op_net
    );

  relational3: entity work.relational_fe0d6a6e93
    port map (
      a => txsifs_op_net,
      b => concat1_y_net_x0,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational3_op_net
    );

  s_r_latch1_370a153267: entity work.s_r_latch1_entity_370a153267
    port map (
      ce_1 => ce_1_sg_x8,
      clk_1 => clk_1_sg_x8,
      r => logical1_y_net_x0,
      s => logical4_y_net_x0,
      q => register2_q_net_x0
    );

  s_r_latch2_b368601b7c: entity work.s_r_latch1_entity_370a153267
    port map (
      ce_1 => ce_1_sg_x8,
      clk_1 => clk_1_sg_x8,
      r => logical6_y_net_x0,
      s => logical1_y_net_x2,
      q => register2_q_net_x1
    );

  txsifs: entity work.xlcounter_free_wlan_mac_dcf_hw
    generic map (
      core_name0 => "cntr_11_0_66919a0f29965143",
      op_arith => xlUnsigned,
      op_width => 14
    )
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      clr => '0',
      en(0) => register2_q_net_x0,
      rst(0) => inverter_op_net,
      op => txsifs_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Backoff/Ctrl"

entity ctrl_entity_6855c6de88 is
  port (
    bo_start: in std_logic; 
    bo_zero: in std_logic; 
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    global_reset: in std_logic; 
    idle_for_difs: in std_logic; 
    num_slots: in std_logic_vector(15 downto 0); 
    bo_done: out std_logic; 
    bo_run: out std_logic; 
    num_slots_load: out std_logic
  );
end ctrl_entity_6855c6de88;

architecture structural of ctrl_entity_6855c6de88 is
  signal ce_1_sg_x14: std_logic;
  signal clk_1_sg_x14: std_logic;
  signal constant_op_net: std_logic;
  signal convert1_dout_net_x1: std_logic;
  signal delay_q_net_x1: std_logic;
  signal inverter_op_net: std_logic;
  signal logical1_y_net_x0: std_logic;
  signal logical1_y_net_x1: std_logic;
  signal logical1_y_net_x2: std_logic;
  signal logical1_y_net_x3: std_logic;
  signal logical2_y_net_x0: std_logic;
  signal logical3_y_net: std_logic;
  signal logical4_y_net_x0: std_logic;
  signal logical5_y_net_x0: std_logic;
  signal logical6_y_net_x1: std_logic;
  signal logical7_y_net_x0: std_logic;
  signal mux_y_net_x0: std_logic_vector(15 downto 0);
  signal register2_q_net_x1: std_logic;
  signal register2_q_net_x2: std_logic;
  signal relational1_op_net: std_logic;
  signal relational1_op_net_x2: std_logic;
  signal relational1_op_net_x3: std_logic;

begin
  logical6_y_net_x1 <= bo_start;
  relational1_op_net_x2 <= bo_zero;
  ce_1_sg_x14 <= ce_1;
  clk_1_sg_x14 <= clk_1;
  convert1_dout_net_x1 <= global_reset;
  relational1_op_net_x3 <= idle_for_difs;
  mux_y_net_x0 <= num_slots;
  bo_done <= logical5_y_net_x0;
  bo_run <= register2_q_net_x2;
  num_slots_load <= delay_q_net_x1;

  constant_x0: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant_op_net
    );

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x14,
      clk => clk_1_sg_x14,
      d(0) => logical1_y_net_x2,
      en => '1',
      rst => '1',
      q(0) => delay_q_net_x1
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x14,
      clk => clk_1_sg_x14,
      clr => '0',
      ip(0) => delay_q_net_x1,
      op(0) => inverter_op_net
    );

  logical1: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical1_y_net_x3,
      d1(0) => convert1_dout_net_x1,
      y(0) => logical1_y_net_x0
    );

  logical2: entity work.logical_6cb8f0ce02
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical1_y_net_x3,
      d1(0) => logical3_y_net,
      d2(0) => convert1_dout_net_x1,
      y(0) => logical2_y_net_x0
    );

  logical3: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational1_op_net_x2,
      d1(0) => relational1_op_net_x3,
      y(0) => logical3_y_net
    );

  logical4: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational1_op_net,
      d1(0) => logical1_y_net_x2,
      y(0) => logical4_y_net_x0
    );

  logical5: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => inverter_op_net,
      d1(0) => register2_q_net_x1,
      y(0) => logical5_y_net_x0
    );

  logical7: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical1_y_net_x1,
      d1(0) => relational1_op_net_x2,
      y(0) => logical7_y_net_x0
    );

  posedge1_95c5f13306: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x14,
      clk_1 => clk_1_sg_x14,
      d => logical6_y_net_x1,
      q => logical1_y_net_x1
    );

  posedge2_4daedb4412: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x14,
      clk_1 => clk_1_sg_x14,
      d => logical7_y_net_x0,
      q => logical1_y_net_x2
    );

  posedge3_5c5ecc2d01: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x14,
      clk_1 => clk_1_sg_x14,
      d => relational1_op_net_x2,
      q => logical1_y_net_x3
    );

  relational1: entity work.relational_e528f2ec9d
    port map (
      a => mux_y_net_x0,
      b(0) => constant_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net
    );

  s_r_latch1_a6f0200bde: entity work.s_r_latch1_entity_370a153267
    port map (
      ce_1 => ce_1_sg_x14,
      clk_1 => clk_1_sg_x14,
      r => logical1_y_net_x0,
      s => logical4_y_net_x0,
      q => register2_q_net_x2
    );

  s_r_latch2_3842f46d13: entity work.s_r_latch1_entity_370a153267
    port map (
      ce_1 => ce_1_sg_x14,
      clk_1 => clk_1_sg_x14,
      r => delay_q_net_x1,
      s => logical2_y_net_x0,
      q => register2_q_net_x1
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Backoff/Slot Time"

entity slot_time_entity_216be7b5c2 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    en: in std_logic; 
    reg_interval_slot: in std_logic_vector(13 downto 0); 
    slot_done: out std_logic
  );
end slot_time_entity_216be7b5c2;

architecture structural of slot_time_entity_216be7b5c2 is
  signal ce_1_sg_x16: std_logic;
  signal clk_1_sg_x16: std_logic;
  signal concat1_y_net_x0: std_logic_vector(13 downto 0);
  signal inverter_op_net: std_logic;
  signal logical1_y_net: std_logic;
  signal logical1_y_net_x1: std_logic;
  signal logical4_y_net_x0: std_logic;
  signal relational2_op_net_x0: std_logic;
  signal slot_time_op_net: std_logic_vector(13 downto 0);

begin
  ce_1_sg_x16 <= ce_1;
  clk_1_sg_x16 <= clk_1;
  logical4_y_net_x0 <= en;
  concat1_y_net_x0 <= reg_interval_slot;
  slot_done <= logical1_y_net_x1;

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x16,
      clk => clk_1_sg_x16,
      clr => '0',
      ip(0) => logical4_y_net_x0,
      op(0) => inverter_op_net
    );

  logical1: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational2_op_net_x0,
      d1(0) => inverter_op_net,
      y(0) => logical1_y_net
    );

  posedge2_1b61e9d9d1: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x16,
      clk_1 => clk_1_sg_x16,
      d => relational2_op_net_x0,
      q => logical1_y_net_x1
    );

  relational2: entity work.relational_fe0d6a6e93
    port map (
      a => slot_time_op_net,
      b => concat1_y_net_x0,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational2_op_net_x0
    );

  slot_time: entity work.xlcounter_free_wlan_mac_dcf_hw
    generic map (
      core_name0 => "cntr_11_0_23bc6491dc8a06da",
      op_arith => xlUnsigned,
      op_width => 14
    )
    port map (
      ce => ce_1_sg_x16,
      clk => clk_1_sg_x16,
      clr => '0',
      en(0) => logical4_y_net_x0,
      rst(0) => logical1_y_net,
      op => slot_time_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Backoff"

entity backoff_entity_41de546108 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    concat1: in std_logic_vector(13 downto 0); 
    global_reset: in std_logic; 
    idle_for_txdifs: in std_logic; 
    pre_tx_num_bo_slots: in std_logic_vector(15 downto 0); 
    reg_backoff_sw_numslots: in std_logic_vector(15 downto 0); 
    reg_backoff_sw_start: in std_logic; 
    reg_force_reset_backoff: in std_logic; 
    tx_ctrl_backoff_start: in std_logic; 
    backoff_done: out std_logic; 
    register1_x0: out std_logic; 
    status_current_backoff_count: out std_logic_vector(15 downto 0)
  );
end backoff_entity_41de546108;

architecture structural of backoff_entity_41de546108 is
  signal b_11_y_net: std_logic;
  signal ce_1_sg_x17: std_logic;
  signal clk_1_sg_x17: std_logic;
  signal concat1_y_net_x1: std_logic_vector(13 downto 0);
  signal constant_op_net: std_logic;
  signal convert1_dout_net_x2: std_logic;
  signal convert_dout_net: std_logic_vector(15 downto 0);
  signal convert_dout_net_x1: std_logic;
  signal delay_q_net_x1: std_logic;
  signal inverter_op_net: std_logic;
  signal logical1_y_net: std_logic;
  signal logical1_y_net_x1: std_logic;
  signal logical2_y_net: std_logic;
  signal logical3_y_net: std_logic;
  signal logical4_y_net_x0: std_logic;
  signal logical5_y_net_x1: std_logic;
  signal logical6_y_net_x1: std_logic;
  signal mux_y_net_x0: std_logic_vector(15 downto 0);
  signal num_slots_op_net_x0: std_logic_vector(15 downto 0);
  signal register1_q_net_x0: std_logic;
  signal register20_q_net_x0: std_logic_vector(15 downto 0);
  signal register21_q_net_x0: std_logic;
  signal register2_q_net: std_logic_vector(15 downto 0);
  signal register2_q_net_x2: std_logic;
  signal register3_q_net_x0: std_logic_vector(15 downto 0);
  signal register_q_net: std_logic;
  signal relational1_op_net_x2: std_logic;
  signal relational1_op_net_x4: std_logic;

begin
  ce_1_sg_x17 <= ce_1;
  clk_1_sg_x17 <= clk_1;
  concat1_y_net_x1 <= concat1;
  convert1_dout_net_x2 <= global_reset;
  relational1_op_net_x4 <= idle_for_txdifs;
  register3_q_net_x0 <= pre_tx_num_bo_slots;
  register20_q_net_x0 <= reg_backoff_sw_numslots;
  register21_q_net_x0 <= reg_backoff_sw_start;
  b_11_y_net <= reg_force_reset_backoff;
  convert_dout_net_x1 <= tx_ctrl_backoff_start;
  backoff_done <= logical5_y_net_x1;
  register1_x0 <= register1_q_net_x0;
  status_current_backoff_count <= num_slots_op_net_x0;

  constant_x0: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant_op_net
    );

  convert: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 16,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 16,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      clr => '0',
      din => register2_q_net,
      en => "1",
      dout => convert_dout_net
    );

  ctrl_6855c6de88: entity work.ctrl_entity_6855c6de88
    port map (
      bo_start => logical6_y_net_x1,
      bo_zero => relational1_op_net_x2,
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      global_reset => convert1_dout_net_x2,
      idle_for_difs => relational1_op_net_x4,
      num_slots => mux_y_net_x0,
      bo_done => logical5_y_net_x1,
      bo_run => register2_q_net_x2,
      num_slots_load => delay_q_net_x1
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      clr => '0',
      ip(0) => relational1_op_net_x2,
      op(0) => inverter_op_net
    );

  logical1: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical1_y_net_x1,
      d1(0) => inverter_op_net,
      y(0) => logical1_y_net
    );

  logical2: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert1_dout_net_x2,
      d1(0) => b_11_y_net,
      y(0) => logical2_y_net
    );

  logical3: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => delay_q_net_x1,
      d1(0) => logical1_y_net,
      y(0) => logical3_y_net
    );

  logical4: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => register2_q_net_x2,
      d1(0) => relational1_op_net_x4,
      y(0) => logical4_y_net_x0
    );

  logical6: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert_dout_net_x1,
      d1(0) => register21_q_net_x0,
      y(0) => logical6_y_net_x1
    );

  mux: entity work.mux_a54904b290
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => register3_q_net_x0,
      d1 => register20_q_net_x0,
      sel(0) => register21_q_net_x0,
      y => mux_y_net_x0
    );

  num_slots: entity work.xlcounter_free_wlan_mac_dcf_hw
    generic map (
      core_name0 => "cntr_11_0_bc4e334678893d0e",
      op_arith => xlUnsigned,
      op_width => 16
    )
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      clr => '0',
      din => convert_dout_net,
      en(0) => logical3_y_net,
      load(0) => delay_q_net_x1,
      rst(0) => logical2_y_net,
      op => num_slots_op_net_x0
    );

  register1: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      d(0) => register_q_net,
      en => "1",
      rst => "0",
      q(0) => register1_q_net_x0
    );

  register2: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      d => mux_y_net_x0,
      en(0) => logical6_y_net_x1,
      rst => "0",
      q => register2_q_net
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      d(0) => inverter_op_net,
      en => "1",
      rst => "0",
      q(0) => register_q_net
    );

  relational1: entity work.relational_53a2345101
    port map (
      a => num_slots_op_net_x0,
      b(0) => constant_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net_x2
    );

  slot_time_216be7b5c2: entity work.slot_time_entity_216be7b5c2
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      en => logical4_y_net_x0,
      reg_interval_slot => concat1_y_net_x1,
      slot_done => logical1_y_net_x1
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/CCA"

entity cca_entity_7905b301dd is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    mac_nav_busy: in std_logic; 
    phy_cca_ind_busy: in std_logic; 
    reg_cca_ignore_nav: in std_logic; 
    reg_cca_ignore_phy_cs: in std_logic; 
    reg_cca_ignore_txbusy: in std_logic; 
    status_tx_phy_active: in std_logic; 
    cs_busy: out std_logic; 
    cs_idle: out std_logic
  );
end cca_entity_7905b301dd;

architecture structural of cca_entity_7905b301dd is
  signal b_7_y_net: std_logic;
  signal b_8_y_net: std_logic;
  signal b_9_y_net: std_logic;
  signal ce_1_sg_x18: std_logic;
  signal clk_1_sg_x18: std_logic;
  signal inverter1_op_net_x0: std_logic;
  signal inverter2_op_net: std_logic;
  signal inverter3_op_net: std_logic;
  signal inverter4_op_net: std_logic;
  signal logical1_y_net: std_logic;
  signal logical2_y_net: std_logic;
  signal logical3_y_net_x1: std_logic;
  signal logical3_y_net_x2: std_logic;
  signal logical4_y_net: std_logic;
  signal phy_cca_ind_busy_net_x0: std_logic;
  signal register2_q_net_x0: std_logic;

begin
  ce_1_sg_x18 <= ce_1;
  clk_1_sg_x18 <= clk_1;
  logical3_y_net_x1 <= mac_nav_busy;
  phy_cca_ind_busy_net_x0 <= phy_cca_ind_busy;
  b_9_y_net <= reg_cca_ignore_nav;
  b_7_y_net <= reg_cca_ignore_phy_cs;
  b_8_y_net <= reg_cca_ignore_txbusy;
  register2_q_net_x0 <= status_tx_phy_active;
  cs_busy <= logical3_y_net_x2;
  cs_idle <= inverter1_op_net_x0;

  inverter1: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x18,
      clk => clk_1_sg_x18,
      clr => '0',
      ip(0) => logical3_y_net_x2,
      op(0) => inverter1_op_net_x0
    );

  inverter2: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x18,
      clk => clk_1_sg_x18,
      clr => '0',
      ip(0) => b_8_y_net,
      op(0) => inverter2_op_net
    );

  inverter3: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x18,
      clk => clk_1_sg_x18,
      clr => '0',
      ip(0) => b_7_y_net,
      op(0) => inverter3_op_net
    );

  inverter4: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x18,
      clk => clk_1_sg_x18,
      clr => '0',
      ip(0) => b_9_y_net,
      op(0) => inverter4_op_net
    );

  logical1: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical3_y_net_x1,
      d1(0) => inverter4_op_net,
      y(0) => logical1_y_net
    );

  logical2: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => phy_cca_ind_busy_net_x0,
      d1(0) => inverter3_op_net,
      y(0) => logical2_y_net
    );

  logical3: entity work.logical_6cb8f0ce02
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical4_y_net,
      d1(0) => logical2_y_net,
      d2(0) => logical1_y_net,
      y(0) => logical3_y_net_x2
    );

  logical4: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => register2_q_net_x0,
      d1(0) => inverter2_op_net,
      y(0) => logical4_y_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/EDK Processor"

entity edk_processor_entity_0a2b1c2e20 is
  port (
    axi_aresetn: in std_logic; 
    from_register: in std_logic_vector(31 downto 0); 
    from_register1: in std_logic_vector(31 downto 0); 
    from_register2: in std_logic_vector(31 downto 0); 
    from_register3: in std_logic_vector(31 downto 0); 
    from_register4: in std_logic_vector(31 downto 0); 
    from_register5: in std_logic_vector(31 downto 0); 
    from_register6: in std_logic_vector(31 downto 0); 
    from_register7: in std_logic_vector(31 downto 0); 
    from_register8: in std_logic_vector(31 downto 0); 
    from_register9: in std_logic_vector(31 downto 0); 
    plb_ce_1: in std_logic; 
    plb_clk_1: in std_logic; 
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
    to_register: in std_logic_vector(31 downto 0); 
    to_register1: in std_logic_vector(31 downto 0); 
    to_register10: in std_logic_vector(31 downto 0); 
    to_register11: in std_logic_vector(31 downto 0); 
    to_register12: in std_logic_vector(31 downto 0); 
    to_register2: in std_logic_vector(31 downto 0); 
    to_register3: in std_logic_vector(31 downto 0); 
    to_register4: in std_logic_vector(31 downto 0); 
    to_register5: in std_logic_vector(31 downto 0); 
    to_register6: in std_logic_vector(31 downto 0); 
    to_register7: in std_logic_vector(31 downto 0); 
    to_register8: in std_logic_vector(31 downto 0); 
    to_register9: in std_logic_vector(31 downto 0); 
    memmap_x0: out std_logic; 
    memmap_x1: out std_logic; 
    memmap_x10: out std_logic; 
    memmap_x11: out std_logic_vector(31 downto 0); 
    memmap_x12: out std_logic; 
    memmap_x13: out std_logic_vector(31 downto 0); 
    memmap_x14: out std_logic; 
    memmap_x15: out std_logic_vector(31 downto 0); 
    memmap_x16: out std_logic; 
    memmap_x17: out std_logic_vector(31 downto 0); 
    memmap_x18: out std_logic; 
    memmap_x19: out std_logic_vector(31 downto 0); 
    memmap_x2: out std_logic_vector(7 downto 0); 
    memmap_x20: out std_logic; 
    memmap_x21: out std_logic_vector(31 downto 0); 
    memmap_x22: out std_logic; 
    memmap_x23: out std_logic_vector(31 downto 0); 
    memmap_x24: out std_logic; 
    memmap_x25: out std_logic_vector(31 downto 0); 
    memmap_x26: out std_logic; 
    memmap_x27: out std_logic_vector(31 downto 0); 
    memmap_x28: out std_logic; 
    memmap_x29: out std_logic_vector(31 downto 0); 
    memmap_x3: out std_logic_vector(1 downto 0); 
    memmap_x30: out std_logic; 
    memmap_x31: out std_logic_vector(31 downto 0); 
    memmap_x32: out std_logic; 
    memmap_x33: out std_logic_vector(31 downto 0); 
    memmap_x34: out std_logic; 
    memmap_x35: out std_logic_vector(31 downto 0); 
    memmap_x36: out std_logic; 
    memmap_x4: out std_logic; 
    memmap_x5: out std_logic_vector(31 downto 0); 
    memmap_x6: out std_logic_vector(7 downto 0); 
    memmap_x7: out std_logic; 
    memmap_x8: out std_logic_vector(1 downto 0); 
    memmap_x9: out std_logic
  );
end edk_processor_entity_0a2b1c2e20;

architecture structural of edk_processor_entity_0a2b1c2e20 is
  signal axi_aresetn_net_x0: std_logic;
  signal from_register1_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register2_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register3_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register4_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register5_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register6_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register7_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register8_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register9_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register_data_out_net_x0: std_logic_vector(31 downto 0);
  signal memmap_s_axi_arready_net_x0: std_logic;
  signal memmap_s_axi_awready_net_x0: std_logic;
  signal memmap_s_axi_bid_net_x0: std_logic_vector(7 downto 0);
  signal memmap_s_axi_bresp_net_x0: std_logic_vector(1 downto 0);
  signal memmap_s_axi_bvalid_net_x0: std_logic;
  signal memmap_s_axi_rdata_net_x0: std_logic_vector(31 downto 0);
  signal memmap_s_axi_rid_net_x0: std_logic_vector(7 downto 0);
  signal memmap_s_axi_rlast_net_x0: std_logic;
  signal memmap_s_axi_rresp_net_x0: std_logic_vector(1 downto 0);
  signal memmap_s_axi_rvalid_net_x0: std_logic;
  signal memmap_s_axi_wready_net_x0: std_logic;
  signal memmap_sm_auto_tx_gains_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_auto_tx_gains_en_net_x0: std_logic;
  signal memmap_sm_auto_tx_params_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_auto_tx_params_en_net_x0: std_logic;
  signal memmap_sm_backoff_ctrl_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_backoff_ctrl_en_net_x0: std_logic;
  signal memmap_sm_calib_times_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_calib_times_en_net_x0: std_logic;
  signal memmap_sm_control_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_control_en_net_x0: std_logic;
  signal memmap_sm_ifs_intervals1_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_ifs_intervals1_en_net_x0: std_logic;
  signal memmap_sm_ifs_intervals2_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_ifs_intervals2_en_net_x0: std_logic;
  signal memmap_sm_mpdu_tx_gains_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_mpdu_tx_gains_en_net_x0: std_logic;
  signal memmap_sm_mpdu_tx_params_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_mpdu_tx_params_en_net_x0: std_logic;
  signal memmap_sm_timestamp_insert_offset_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_timestamp_insert_offset_en_net_x0: std_logic;
  signal memmap_sm_timestamp_set_lsb_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_timestamp_set_lsb_en_net_x0: std_logic;
  signal memmap_sm_timestamp_set_msb_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_timestamp_set_msb_en_net_x0: std_logic;
  signal memmap_sm_tx_start_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_tx_start_en_net_x0: std_logic;
  signal plb_ce_1_sg_x0: std_logic;
  signal plb_clk_1_sg_x0: std_logic;
  signal s_axi_araddr_net_x0: std_logic_vector(31 downto 0);
  signal s_axi_arburst_net_x0: std_logic_vector(1 downto 0);
  signal s_axi_arcache_net_x0: std_logic_vector(3 downto 0);
  signal s_axi_arid_net_x0: std_logic_vector(7 downto 0);
  signal s_axi_arlen_net_x0: std_logic_vector(7 downto 0);
  signal s_axi_arlock_net_x0: std_logic_vector(1 downto 0);
  signal s_axi_arprot_net_x0: std_logic_vector(2 downto 0);
  signal s_axi_arsize_net_x0: std_logic_vector(2 downto 0);
  signal s_axi_arvalid_net_x0: std_logic;
  signal s_axi_awaddr_net_x0: std_logic_vector(31 downto 0);
  signal s_axi_awburst_net_x0: std_logic_vector(1 downto 0);
  signal s_axi_awcache_net_x0: std_logic_vector(3 downto 0);
  signal s_axi_awid_net_x0: std_logic_vector(7 downto 0);
  signal s_axi_awlen_net_x0: std_logic_vector(7 downto 0);
  signal s_axi_awlock_net_x0: std_logic_vector(1 downto 0);
  signal s_axi_awprot_net_x0: std_logic_vector(2 downto 0);
  signal s_axi_awsize_net_x0: std_logic_vector(2 downto 0);
  signal s_axi_awvalid_net_x0: std_logic;
  signal s_axi_bready_net_x0: std_logic;
  signal s_axi_rready_net_x0: std_logic;
  signal s_axi_wdata_net_x0: std_logic_vector(31 downto 0);
  signal s_axi_wlast_net_x0: std_logic;
  signal s_axi_wstrb_net_x0: std_logic_vector(3 downto 0);
  signal s_axi_wvalid_net_x0: std_logic;
  signal to_register10_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register11_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register12_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register1_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register2_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register3_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register4_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register5_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register6_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register7_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register8_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register9_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register_dout_net_x0: std_logic_vector(31 downto 0);

begin
  axi_aresetn_net_x0 <= axi_aresetn;
  from_register_data_out_net_x0 <= from_register;
  from_register1_data_out_net_x0 <= from_register1;
  from_register2_data_out_net_x0 <= from_register2;
  from_register3_data_out_net_x0 <= from_register3;
  from_register4_data_out_net_x0 <= from_register4;
  from_register5_data_out_net_x0 <= from_register5;
  from_register6_data_out_net_x0 <= from_register6;
  from_register7_data_out_net_x0 <= from_register7;
  from_register8_data_out_net_x0 <= from_register8;
  from_register9_data_out_net_x0 <= from_register9;
  plb_ce_1_sg_x0 <= plb_ce_1;
  plb_clk_1_sg_x0 <= plb_clk_1;
  s_axi_araddr_net_x0 <= s_axi_araddr;
  s_axi_arburst_net_x0 <= s_axi_arburst;
  s_axi_arcache_net_x0 <= s_axi_arcache;
  s_axi_arid_net_x0 <= s_axi_arid;
  s_axi_arlen_net_x0 <= s_axi_arlen;
  s_axi_arlock_net_x0 <= s_axi_arlock;
  s_axi_arprot_net_x0 <= s_axi_arprot;
  s_axi_arsize_net_x0 <= s_axi_arsize;
  s_axi_arvalid_net_x0 <= s_axi_arvalid;
  s_axi_awaddr_net_x0 <= s_axi_awaddr;
  s_axi_awburst_net_x0 <= s_axi_awburst;
  s_axi_awcache_net_x0 <= s_axi_awcache;
  s_axi_awid_net_x0 <= s_axi_awid;
  s_axi_awlen_net_x0 <= s_axi_awlen;
  s_axi_awlock_net_x0 <= s_axi_awlock;
  s_axi_awprot_net_x0 <= s_axi_awprot;
  s_axi_awsize_net_x0 <= s_axi_awsize;
  s_axi_awvalid_net_x0 <= s_axi_awvalid;
  s_axi_bready_net_x0 <= s_axi_bready;
  s_axi_rready_net_x0 <= s_axi_rready;
  s_axi_wdata_net_x0 <= s_axi_wdata;
  s_axi_wlast_net_x0 <= s_axi_wlast;
  s_axi_wstrb_net_x0 <= s_axi_wstrb;
  s_axi_wvalid_net_x0 <= s_axi_wvalid;
  to_register_dout_net_x0 <= to_register;
  to_register1_dout_net_x0 <= to_register1;
  to_register10_dout_net_x0 <= to_register10;
  to_register11_dout_net_x0 <= to_register11;
  to_register12_dout_net_x0 <= to_register12;
  to_register2_dout_net_x0 <= to_register2;
  to_register3_dout_net_x0 <= to_register3;
  to_register4_dout_net_x0 <= to_register4;
  to_register5_dout_net_x0 <= to_register5;
  to_register6_dout_net_x0 <= to_register6;
  to_register7_dout_net_x0 <= to_register7;
  to_register8_dout_net_x0 <= to_register8;
  to_register9_dout_net_x0 <= to_register9;
  memmap_x0 <= memmap_s_axi_arready_net_x0;
  memmap_x1 <= memmap_s_axi_awready_net_x0;
  memmap_x10 <= memmap_s_axi_wready_net_x0;
  memmap_x11 <= memmap_sm_auto_tx_params_din_net_x0;
  memmap_x12 <= memmap_sm_auto_tx_params_en_net_x0;
  memmap_x13 <= memmap_sm_calib_times_din_net_x0;
  memmap_x14 <= memmap_sm_calib_times_en_net_x0;
  memmap_x15 <= memmap_sm_ifs_intervals2_din_net_x0;
  memmap_x16 <= memmap_sm_ifs_intervals2_en_net_x0;
  memmap_x17 <= memmap_sm_ifs_intervals1_din_net_x0;
  memmap_x18 <= memmap_sm_ifs_intervals1_en_net_x0;
  memmap_x19 <= memmap_sm_tx_start_din_net_x0;
  memmap_x2 <= memmap_s_axi_bid_net_x0;
  memmap_x20 <= memmap_sm_tx_start_en_net_x0;
  memmap_x21 <= memmap_sm_mpdu_tx_params_din_net_x0;
  memmap_x22 <= memmap_sm_mpdu_tx_params_en_net_x0;
  memmap_x23 <= memmap_sm_control_din_net_x0;
  memmap_x24 <= memmap_sm_control_en_net_x0;
  memmap_x25 <= memmap_sm_timestamp_set_lsb_din_net_x0;
  memmap_x26 <= memmap_sm_timestamp_set_lsb_en_net_x0;
  memmap_x27 <= memmap_sm_timestamp_set_msb_din_net_x0;
  memmap_x28 <= memmap_sm_timestamp_set_msb_en_net_x0;
  memmap_x29 <= memmap_sm_backoff_ctrl_din_net_x0;
  memmap_x3 <= memmap_s_axi_bresp_net_x0;
  memmap_x30 <= memmap_sm_backoff_ctrl_en_net_x0;
  memmap_x31 <= memmap_sm_mpdu_tx_gains_din_net_x0;
  memmap_x32 <= memmap_sm_mpdu_tx_gains_en_net_x0;
  memmap_x33 <= memmap_sm_auto_tx_gains_din_net_x0;
  memmap_x34 <= memmap_sm_auto_tx_gains_en_net_x0;
  memmap_x35 <= memmap_sm_timestamp_insert_offset_din_net_x0;
  memmap_x36 <= memmap_sm_timestamp_insert_offset_en_net_x0;
  memmap_x4 <= memmap_s_axi_bvalid_net_x0;
  memmap_x5 <= memmap_s_axi_rdata_net_x0;
  memmap_x6 <= memmap_s_axi_rid_net_x0;
  memmap_x7 <= memmap_s_axi_rlast_net_x0;
  memmap_x8 <= memmap_s_axi_rresp_net_x0;
  memmap_x9 <= memmap_s_axi_rvalid_net_x0;

  memmap: entity work.axi_sgiface
    port map (
      axi_aclk => plb_clk_1_sg_x0,
      axi_aresetn => axi_aresetn_net_x0,
      axi_ce => plb_ce_1_sg_x0,
      s_axi_araddr => s_axi_araddr_net_x0,
      s_axi_arburst => s_axi_arburst_net_x0,
      s_axi_arcache => s_axi_arcache_net_x0,
      s_axi_arid => s_axi_arid_net_x0,
      s_axi_arlen => s_axi_arlen_net_x0,
      s_axi_arlock => s_axi_arlock_net_x0,
      s_axi_arprot => s_axi_arprot_net_x0,
      s_axi_arsize => s_axi_arsize_net_x0,
      s_axi_arvalid => s_axi_arvalid_net_x0,
      s_axi_awaddr => s_axi_awaddr_net_x0,
      s_axi_awburst => s_axi_awburst_net_x0,
      s_axi_awcache => s_axi_awcache_net_x0,
      s_axi_awid => s_axi_awid_net_x0,
      s_axi_awlen => s_axi_awlen_net_x0,
      s_axi_awlock => s_axi_awlock_net_x0,
      s_axi_awprot => s_axi_awprot_net_x0,
      s_axi_awsize => s_axi_awsize_net_x0,
      s_axi_awvalid => s_axi_awvalid_net_x0,
      s_axi_bready => s_axi_bready_net_x0,
      s_axi_rready => s_axi_rready_net_x0,
      s_axi_wdata => s_axi_wdata_net_x0,
      s_axi_wlast => s_axi_wlast_net_x0,
      s_axi_wstrb => s_axi_wstrb_net_x0,
      s_axi_wvalid => s_axi_wvalid_net_x0,
      sm_auto_tx_gains_dout => to_register11_dout_net_x0,
      sm_auto_tx_params_dout => to_register_dout_net_x0,
      sm_backoff_ctrl_dout => to_register9_dout_net_x0,
      sm_calib_times_dout => to_register1_dout_net_x0,
      sm_control_dout => to_register6_dout_net_x0,
      sm_ifs_intervals1_dout => to_register3_dout_net_x0,
      sm_ifs_intervals2_dout => to_register2_dout_net_x0,
      sm_latest_rx_byte_dout => from_register8_data_out_net_x0,
      sm_mpdu_tx_gains_dout => to_register10_dout_net_x0,
      sm_mpdu_tx_params_dout => to_register5_dout_net_x0,
      sm_nav_value_dout => from_register2_data_out_net_x0,
      sm_rx_rate_length_dout => from_register5_data_out_net_x0,
      sm_rx_start_timestamp_lsb_dout => from_register4_data_out_net_x0,
      sm_rx_start_timestamp_msb_dout => from_register3_data_out_net_x0,
      sm_status_dout => from_register9_data_out_net_x0,
      sm_timestamp_insert_offset_dout => to_register12_dout_net_x0,
      sm_timestamp_lsb_dout => from_register7_data_out_net_x0,
      sm_timestamp_msb_dout => from_register6_data_out_net_x0,
      sm_timestamp_set_lsb_dout => to_register7_dout_net_x0,
      sm_timestamp_set_msb_dout => to_register8_dout_net_x0,
      sm_tx_start_dout => to_register4_dout_net_x0,
      sm_tx_start_timestamp_lsb_dout => from_register1_data_out_net_x0,
      sm_tx_start_timestamp_msb_dout => from_register_data_out_net_x0,
      s_axi_arready => memmap_s_axi_arready_net_x0,
      s_axi_awready => memmap_s_axi_awready_net_x0,
      s_axi_bid => memmap_s_axi_bid_net_x0,
      s_axi_bresp => memmap_s_axi_bresp_net_x0,
      s_axi_bvalid => memmap_s_axi_bvalid_net_x0,
      s_axi_rdata => memmap_s_axi_rdata_net_x0,
      s_axi_rid => memmap_s_axi_rid_net_x0,
      s_axi_rlast => memmap_s_axi_rlast_net_x0,
      s_axi_rresp => memmap_s_axi_rresp_net_x0,
      s_axi_rvalid => memmap_s_axi_rvalid_net_x0,
      s_axi_wready => memmap_s_axi_wready_net_x0,
      sm_auto_tx_gains_din => memmap_sm_auto_tx_gains_din_net_x0,
      sm_auto_tx_gains_en => memmap_sm_auto_tx_gains_en_net_x0,
      sm_auto_tx_params_din => memmap_sm_auto_tx_params_din_net_x0,
      sm_auto_tx_params_en => memmap_sm_auto_tx_params_en_net_x0,
      sm_backoff_ctrl_din => memmap_sm_backoff_ctrl_din_net_x0,
      sm_backoff_ctrl_en => memmap_sm_backoff_ctrl_en_net_x0,
      sm_calib_times_din => memmap_sm_calib_times_din_net_x0,
      sm_calib_times_en => memmap_sm_calib_times_en_net_x0,
      sm_control_din => memmap_sm_control_din_net_x0,
      sm_control_en => memmap_sm_control_en_net_x0,
      sm_ifs_intervals1_din => memmap_sm_ifs_intervals1_din_net_x0,
      sm_ifs_intervals1_en => memmap_sm_ifs_intervals1_en_net_x0,
      sm_ifs_intervals2_din => memmap_sm_ifs_intervals2_din_net_x0,
      sm_ifs_intervals2_en => memmap_sm_ifs_intervals2_en_net_x0,
      sm_mpdu_tx_gains_din => memmap_sm_mpdu_tx_gains_din_net_x0,
      sm_mpdu_tx_gains_en => memmap_sm_mpdu_tx_gains_en_net_x0,
      sm_mpdu_tx_params_din => memmap_sm_mpdu_tx_params_din_net_x0,
      sm_mpdu_tx_params_en => memmap_sm_mpdu_tx_params_en_net_x0,
      sm_timestamp_insert_offset_din => memmap_sm_timestamp_insert_offset_din_net_x0,
      sm_timestamp_insert_offset_en => memmap_sm_timestamp_insert_offset_en_net_x0,
      sm_timestamp_set_lsb_din => memmap_sm_timestamp_set_lsb_din_net_x0,
      sm_timestamp_set_lsb_en => memmap_sm_timestamp_set_lsb_en_net_x0,
      sm_timestamp_set_msb_din => memmap_sm_timestamp_set_msb_din_net_x0,
      sm_timestamp_set_msb_en => memmap_sm_timestamp_set_msb_en_net_x0,
      sm_tx_start_din => memmap_sm_tx_start_din_net_x0,
      sm_tx_start_en => memmap_sm_tx_start_en_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Idle for DIFS-EIFS/Bad Rx"

entity bad_rx_entity_d07f6a70d7 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    phy_rx_end_ind: in std_logic; 
    phy_rx_end_rxerror: in std_logic_vector(1 downto 0); 
    phy_rx_fcs_good_ind: in std_logic; 
    rx: out std_logic
  );
end bad_rx_entity_d07f6a70d7;

architecture structural of bad_rx_entity_d07f6a70d7 is
  signal ce_1_sg_x20: std_logic;
  signal clk_1_sg_x20: std_logic;
  signal constant1_op_net: std_logic;
  signal inverter1_op_net: std_logic;
  signal logical1_y_net_x1: std_logic;
  signal logical3_y_net_x0: std_logic;
  signal logical4_y_net: std_logic;
  signal phy_rx_end_ind_net_x1: std_logic;
  signal phy_rx_end_rxerror_net_x1: std_logic_vector(1 downto 0);
  signal phy_rx_fcs_good_ind_net_x1: std_logic;
  signal relational1_op_net: std_logic;

begin
  ce_1_sg_x20 <= ce_1;
  clk_1_sg_x20 <= clk_1;
  phy_rx_end_ind_net_x1 <= phy_rx_end_ind;
  phy_rx_end_rxerror_net_x1 <= phy_rx_end_rxerror;
  phy_rx_fcs_good_ind_net_x1 <= phy_rx_fcs_good_ind;
  rx <= logical1_y_net_x1;

  constant1: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant1_op_net
    );

  inverter1: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x20,
      clk => clk_1_sg_x20,
      clr => '0',
      ip(0) => phy_rx_fcs_good_ind_net_x1,
      op(0) => inverter1_op_net
    );

  logical3: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => phy_rx_end_ind_net_x1,
      d1(0) => logical4_y_net,
      y(0) => logical3_y_net_x0
    );

  logical4: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => inverter1_op_net,
      d1(0) => relational1_op_net,
      y(0) => logical4_y_net
    );

  posedge1_ff3b01599a: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x20,
      clk_1 => clk_1_sg_x20,
      d => logical3_y_net_x0,
      q => logical1_y_net_x1
    );

  relational1: entity work.relational_2a3f3bef9d
    port map (
      a => phy_rx_end_rxerror_net_x1,
      b(0) => constant1_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Idle for DIFS-EIFS"

entity idle_for_difs_eifs_entity_dda54731cc is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    global_reset: in std_logic; 
    medium_busy: in std_logic; 
    medium_idle: in std_logic; 
    phy_rx_end_ind: in std_logic; 
    phy_rx_end_rxerror: in std_logic_vector(1 downto 0); 
    phy_rx_fcs_good_ind: in std_logic; 
    reg_calibtime_txdifs: in std_logic_vector(13 downto 0); 
    reg_interval_difs: in std_logic_vector(13 downto 0); 
    reg_interval_eifs: in std_logic_vector(19 downto 0); 
    idle_for_difs: out std_logic; 
    idle_for_txdifs: out std_logic; 
    register1_x0: out std_logic; 
    register3_x0: out std_logic
  );
end idle_for_difs_eifs_entity_dda54731cc;

architecture structural of idle_for_difs_eifs_entity_dda54731cc is
  signal ce_1_sg_x22: std_logic;
  signal clk_1_sg_x22: std_logic;
  signal concat1_y_net_x2: std_logic_vector(13 downto 0);
  signal concat1_y_net_x3: std_logic_vector(19 downto 0);
  signal concat1_y_net_x4: std_logic_vector(13 downto 0);
  signal convert1_dout_net_x3: std_logic;
  signal difs_op_net: std_logic_vector(15 downto 0);
  signal inverter1_op_net_x1: std_logic;
  signal inverter_op_net: std_logic;
  signal logical1_y_net: std_logic;
  signal logical1_y_net_x2: std_logic;
  signal logical2_y_net: std_logic;
  signal logical3_y_net_x3: std_logic;
  signal logical5_y_net_x0: std_logic;
  signal mux1_y_net: std_logic_vector(19 downto 0);
  signal mux_y_net: std_logic_vector(19 downto 0);
  signal phy_rx_end_ind_net_x2: std_logic;
  signal phy_rx_end_rxerror_net_x2: std_logic_vector(1 downto 0);
  signal phy_rx_fcs_good_ind_net_x2: std_logic;
  signal register1_q_net_x0: std_logic;
  signal register2_q_net: std_logic;
  signal register2_q_net_x0: std_logic;
  signal register3_q_net_x0: std_logic;
  signal register_q_net: std_logic;
  signal relational1_op_net_x5: std_logic;
  signal relational3_op_net_x0: std_logic;

begin
  ce_1_sg_x22 <= ce_1;
  clk_1_sg_x22 <= clk_1;
  convert1_dout_net_x3 <= global_reset;
  logical3_y_net_x3 <= medium_busy;
  inverter1_op_net_x1 <= medium_idle;
  phy_rx_end_ind_net_x2 <= phy_rx_end_ind;
  phy_rx_end_rxerror_net_x2 <= phy_rx_end_rxerror;
  phy_rx_fcs_good_ind_net_x2 <= phy_rx_fcs_good_ind;
  concat1_y_net_x4 <= reg_calibtime_txdifs;
  concat1_y_net_x2 <= reg_interval_difs;
  concat1_y_net_x3 <= reg_interval_eifs;
  idle_for_difs <= relational3_op_net_x0;
  idle_for_txdifs <= relational1_op_net_x5;
  register1_x0 <= register1_q_net_x0;
  register3_x0 <= register3_q_net_x0;

  bad_rx_d07f6a70d7: entity work.bad_rx_entity_d07f6a70d7
    port map (
      ce_1 => ce_1_sg_x22,
      clk_1 => clk_1_sg_x22,
      phy_rx_end_ind => phy_rx_end_ind_net_x2,
      phy_rx_end_rxerror => phy_rx_end_rxerror_net_x2,
      phy_rx_fcs_good_ind => phy_rx_fcs_good_ind_net_x2,
      rx => logical1_y_net_x2
    );

  difs: entity work.xlcounter_free_wlan_mac_dcf_hw
    generic map (
      core_name0 => "cntr_11_0_5b0a1653ddb23333",
      op_arith => xlUnsigned,
      op_width => 16
    )
    port map (
      ce => ce_1_sg_x22,
      clk => clk_1_sg_x22,
      clr => '0',
      en(0) => logical1_y_net,
      rst(0) => logical2_y_net,
      op => difs_op_net
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x22,
      clk => clk_1_sg_x22,
      clr => '0',
      ip(0) => relational3_op_net_x0,
      op(0) => inverter_op_net
    );

  logical1: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => inverter1_op_net_x1,
      d1(0) => inverter_op_net,
      y(0) => logical1_y_net
    );

  logical2: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert1_dout_net_x3,
      d1(0) => logical3_y_net_x3,
      y(0) => logical2_y_net
    );

  logical5: entity work.logical_6cb8f0ce02
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational3_op_net_x0,
      d1(0) => logical3_y_net_x3,
      d2(0) => convert1_dout_net_x3,
      y(0) => logical5_y_net_x0
    );

  mux: entity work.mux_3efa5ceb62
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => concat1_y_net_x2,
      d1 => concat1_y_net_x3,
      sel(0) => register2_q_net_x0,
      y => mux_y_net
    );

  mux1: entity work.mux_3efa5ceb62
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => concat1_y_net_x4,
      d1 => concat1_y_net_x3,
      sel(0) => register2_q_net_x0,
      y => mux1_y_net
    );

  register1: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x22,
      clk => clk_1_sg_x22,
      d(0) => register_q_net,
      en => "1",
      rst => "0",
      q(0) => register1_q_net_x0
    );

  register2: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x22,
      clk => clk_1_sg_x22,
      d(0) => register2_q_net_x0,
      en => "1",
      rst => "0",
      q(0) => register2_q_net
    );

  register3: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x22,
      clk => clk_1_sg_x22,
      d(0) => register2_q_net,
      en => "1",
      rst => "0",
      q(0) => register3_q_net_x0
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x22,
      clk => clk_1_sg_x22,
      d(0) => relational1_op_net_x5,
      en => "1",
      rst => "0",
      q(0) => register_q_net
    );

  relational1: entity work.relational_6fce5fc0e4
    port map (
      a => difs_op_net,
      b => mux1_y_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net_x5
    );

  relational3: entity work.relational_6fce5fc0e4
    port map (
      a => difs_op_net,
      b => mux_y_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational3_op_net_x0
    );

  s_r_latch1_58163e5c01: entity work.s_r_latch1_entity_370a153267
    port map (
      ce_1 => ce_1_sg_x22,
      clk_1 => clk_1_sg_x22,
      r => logical5_y_net_x0,
      s => logical1_y_net_x2,
      q => register2_q_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/MPDU Tx Control"

entity mpdu_tx_control_entity_dc4ada287c is
  port (
    backoff_done: in std_logic; 
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    global_reset: in std_logic; 
    idle_for_difs: in std_logic; 
    phy_rx_start_ind: in std_logic; 
    phy_tx_end_confirm: in std_logic; 
    reg_tx_param_bo_slots: in std_logic_vector(15 downto 0); 
    reg_tx_param_pktbuf: in std_logic_vector(3 downto 0); 
    reg_tx_param_start_timeout: in std_logic; 
    reg_tx_param_txantmask: in std_logic_vector(3 downto 0); 
    reg_tx_param_txgain_a: in std_logic_vector(5 downto 0); 
    reg_tx_param_txgain_b: in std_logic_vector(5 downto 0); 
    reg_tx_param_txgain_c: in std_logic_vector(5 downto 0); 
    reg_tx_param_txgain_d: in std_logic_vector(5 downto 0); 
    reg_tx_start: in std_logic; 
    timeout_done: in std_logic; 
    mpdu_tx_param_txantmask: out std_logic_vector(3 downto 0); 
    mpdu_tx_param_txgain_a: out std_logic_vector(5 downto 0); 
    mpdu_tx_param_txgain_b: out std_logic_vector(5 downto 0); 
    mpdu_tx_param_txgain_c: out std_logic_vector(5 downto 0); 
    mpdu_tx_param_txgain_d: out std_logic_vector(5 downto 0); 
    mpdu_tx_pktbuf: out std_logic_vector(3 downto 0); 
    pre_tx_num_bo_slots: out std_logic_vector(15 downto 0); 
    register4_x0: out std_logic; 
    status_mpdu_txdone: out std_logic; 
    status_mpdu_txpending: out std_logic; 
    status_mpdu_txresult: out std_logic_vector(1 downto 0); 
    status_mpdu_txstate: out std_logic_vector(2 downto 0); 
    tx_ctrl_backoff_start: out std_logic; 
    tx_ctrl_phy_start: out std_logic; 
    tx_ctrl_timeout_start: out std_logic
  );
end mpdu_tx_control_entity_dc4ada287c;

architecture structural of mpdu_tx_control_entity_dc4ada287c is
  signal ce_1_sg_x27: std_logic;
  signal clk_1_sg_x27: std_logic;
  signal convert1_dout_net_x0: std_logic;
  signal convert1_dout_net_x4: std_logic;
  signal convert2_dout_net_x0: std_logic;
  signal convert3_dout_net_x0: std_logic;
  signal convert_dout_net_x2: std_logic;
  signal delay_q_net: std_logic;
  signal logical1_y_net_x0: std_logic;
  signal logical1_y_net_x1: std_logic;
  signal logical1_y_net_x2: std_logic;
  signal logical1_y_net_x3: std_logic;
  signal logical2_y_net_x0: std_logic;
  signal logical5_y_net_x2: std_logic;
  signal mcode_backoff_start_net: std_logic;
  signal mcode_fsm_state_out_net_x0: std_logic_vector(2 downto 0);
  signal mcode_phy_tx_start_net: std_logic;
  signal mcode_timeout_start_net: std_logic;
  signal mcode_tx_done_net: std_logic;
  signal mcode_tx_result_out_net: std_logic_vector(1 downto 0);
  signal phy_rx_start_ind_net_x0: std_logic;
  signal phy_tx_done_net_x0: std_logic;
  signal register10_q_net_x0: std_logic_vector(5 downto 0);
  signal register16_q_net_x0: std_logic_vector(3 downto 0);
  signal register17_q_net_x0: std_logic_vector(15 downto 0);
  signal register18_q_net_x0: std_logic;
  signal register19_q_net_x0: std_logic_vector(5 downto 0);
  signal register1_q_net_x0: std_logic_vector(1 downto 0);
  signal register25_q_net_x0: std_logic_vector(3 downto 0);
  signal register2_q_net_x2: std_logic_vector(3 downto 0);
  signal register2_q_net_x3: std_logic;
  signal register2_q_net_x4: std_logic;
  signal register35_q_net_x1: std_logic;
  signal register3_q_net_x1: std_logic_vector(15 downto 0);
  signal register4_q_net_x0: std_logic;
  signal register53_q_net_x0: std_logic_vector(5 downto 0);
  signal register56_q_net_x0: std_logic_vector(5 downto 0);
  signal register57_q_net_x0: std_logic_vector(5 downto 0);
  signal register5_q_net: std_logic;
  signal register6_q_net_x0: std_logic_vector(5 downto 0);
  signal register7_q_net_x0: std_logic_vector(3 downto 0);
  signal register8_q_net_x0: std_logic_vector(5 downto 0);
  signal register9_q_net_x0: std_logic_vector(5 downto 0);
  signal register_q_net: std_logic;
  signal relational3_op_net_x1: std_logic;

begin
  logical5_y_net_x2 <= backoff_done;
  ce_1_sg_x27 <= ce_1;
  clk_1_sg_x27 <= clk_1;
  convert1_dout_net_x4 <= global_reset;
  relational3_op_net_x1 <= idle_for_difs;
  phy_rx_start_ind_net_x0 <= phy_rx_start_ind;
  phy_tx_done_net_x0 <= phy_tx_end_confirm;
  register17_q_net_x0 <= reg_tx_param_bo_slots;
  register16_q_net_x0 <= reg_tx_param_pktbuf;
  register18_q_net_x0 <= reg_tx_param_start_timeout;
  register25_q_net_x0 <= reg_tx_param_txantmask;
  register19_q_net_x0 <= reg_tx_param_txgain_a;
  register53_q_net_x0 <= reg_tx_param_txgain_b;
  register56_q_net_x0 <= reg_tx_param_txgain_c;
  register57_q_net_x0 <= reg_tx_param_txgain_d;
  register35_q_net_x1 <= reg_tx_start;
  logical1_y_net_x3 <= timeout_done;
  mpdu_tx_param_txantmask <= register7_q_net_x0;
  mpdu_tx_param_txgain_a <= register6_q_net_x0;
  mpdu_tx_param_txgain_b <= register8_q_net_x0;
  mpdu_tx_param_txgain_c <= register9_q_net_x0;
  mpdu_tx_param_txgain_d <= register10_q_net_x0;
  mpdu_tx_pktbuf <= register2_q_net_x2;
  pre_tx_num_bo_slots <= register3_q_net_x1;
  register4_x0 <= register4_q_net_x0;
  status_mpdu_txdone <= register2_q_net_x4;
  status_mpdu_txpending <= register2_q_net_x3;
  status_mpdu_txresult <= register1_q_net_x0;
  status_mpdu_txstate <= mcode_fsm_state_out_net_x0;
  tx_ctrl_backoff_start <= convert_dout_net_x2;
  tx_ctrl_phy_start <= convert1_dout_net_x0;
  tx_ctrl_timeout_start <= convert2_dout_net_x0;

  convert: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      din(0) => mcode_backoff_start_net,
      en => "1",
      dout(0) => convert_dout_net_x2
    );

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      din(0) => mcode_phy_tx_start_net,
      en => "1",
      dout(0) => convert1_dout_net_x0
    );

  convert2: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      din(0) => mcode_timeout_start_net,
      en => "1",
      dout(0) => convert2_dout_net_x0
    );

  convert3: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      din(0) => mcode_tx_done_net,
      en => "1",
      dout(0) => convert3_dout_net_x0
    );

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d(0) => logical1_y_net_x0,
      en => '1',
      rst => '1',
      q(0) => delay_q_net
    );

  logical1: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert1_dout_net_x4,
      d1(0) => convert3_dout_net_x0,
      y(0) => logical1_y_net_x1
    );

  logical2: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical1_y_net_x0,
      d1(0) => convert1_dout_net_x4,
      y(0) => logical2_y_net_x0
    );

  mcode: entity work.mcode_block_6c697844b9
    port map (
      backoff_done(0) => logical5_y_net_x2,
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      idle_for_difs(0) => relational3_op_net_x1,
      new_tx(0) => delay_q_net,
      phy_rx_start(0) => phy_rx_start_ind_net_x0,
      phy_tx_done(0) => phy_tx_done_net_x0,
      reset(0) => convert1_dout_net_x4,
      timeout_done(0) => logical1_y_net_x3,
      timeout_req(0) => register5_q_net,
      backoff_start(0) => mcode_backoff_start_net,
      fsm_state_out => mcode_fsm_state_out_net_x0,
      phy_tx_start(0) => mcode_phy_tx_start_net,
      timeout_start(0) => mcode_timeout_start_net,
      tx_done(0) => mcode_tx_done_net,
      tx_result_out => mcode_tx_result_out_net
    );

  posedge1_badf67c617: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x27,
      clk_1 => clk_1_sg_x27,
      d => register35_q_net_x1,
      q => logical1_y_net_x2
    );

  posedge2_2d38abaa78: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x27,
      clk_1 => clk_1_sg_x27,
      d => register2_q_net_x3,
      q => logical1_y_net_x0
    );

  register1: entity work.xlregister
    generic map (
      d_width => 2,
      init_value => b"00"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d => mcode_tx_result_out_net,
      en(0) => convert3_dout_net_x0,
      rst => "0",
      q => register1_q_net_x0
    );

  register10: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d => register57_q_net_x0,
      en(0) => logical1_y_net_x0,
      rst => "0",
      q => register10_q_net_x0
    );

  register2: entity work.xlregister
    generic map (
      d_width => 4,
      init_value => b"0000"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d => register16_q_net_x0,
      en(0) => logical1_y_net_x0,
      rst => "0",
      q => register2_q_net_x2
    );

  register3: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d => register17_q_net_x0,
      en(0) => logical1_y_net_x0,
      rst => "0",
      q => register3_q_net_x1
    );

  register4: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d(0) => register_q_net,
      en => "1",
      rst => "0",
      q(0) => register4_q_net_x0
    );

  register5: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d(0) => register18_q_net_x0,
      en(0) => logical1_y_net_x0,
      rst => "0",
      q(0) => register5_q_net
    );

  register6: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d => register19_q_net_x0,
      en(0) => logical1_y_net_x0,
      rst => "0",
      q => register6_q_net_x0
    );

  register7: entity work.xlregister
    generic map (
      d_width => 4,
      init_value => b"0000"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d => register25_q_net_x0,
      en(0) => logical1_y_net_x0,
      rst => "0",
      q => register7_q_net_x0
    );

  register8: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d => register53_q_net_x0,
      en(0) => logical1_y_net_x0,
      rst => "0",
      q => register8_q_net_x0
    );

  register9: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d => register56_q_net_x0,
      en(0) => logical1_y_net_x0,
      rst => "0",
      q => register9_q_net_x0
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d(0) => register2_q_net_x3,
      en => "1",
      rst => "0",
      q(0) => register_q_net
    );

  s_r_latch1_09ba55d408: entity work.s_r_latch1_entity_370a153267
    port map (
      ce_1 => ce_1_sg_x27,
      clk_1 => clk_1_sg_x27,
      r => logical1_y_net_x1,
      s => logical1_y_net_x2,
      q => register2_q_net_x3
    );

  s_r_latch2_fda77b307d: entity work.s_r_latch1_entity_370a153267
    port map (
      ce_1 => ce_1_sg_x27,
      clk_1 => clk_1_sg_x27,
      r => logical2_y_net_x0,
      s => convert3_dout_net_x0,
      q => register2_q_net_x4
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/NAV/New Duration/Capture Rx Pkt Duration Field"

entity capture_rx_pkt_duration_field_entity_c6b3c20cf0 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    phy_rx_byte: in std_logic_vector(7 downto 0); 
    phy_rx_byte_valid: in std_logic; 
    phy_rx_bytenum: in std_logic_vector(13 downto 0); 
    phy_rx_start_ind: in std_logic; 
    duration: out std_logic_vector(15 downto 0)
  );
end capture_rx_pkt_duration_field_entity_c6b3c20cf0;

architecture structural of capture_rx_pkt_duration_field_entity_c6b3c20cf0 is
  signal ce_1_sg_x28: std_logic;
  signal clk_1_sg_x28: std_logic;
  signal concat_y_net: std_logic_vector(15 downto 0);
  signal constant1_op_net: std_logic_vector(1 downto 0);
  signal constant2_op_net: std_logic_vector(1 downto 0);
  signal constant_op_net: std_logic_vector(1 downto 0);
  signal logical1_y_net: std_logic;
  signal logical_y_net: std_logic;
  signal msb_y_net: std_logic;
  signal mux_y_net_x0: std_logic_vector(15 downto 0);
  signal phy_rx_data_byte_net_x0: std_logic_vector(7 downto 0);
  signal phy_rx_data_bytenum_net_x0: std_logic_vector(13 downto 0);
  signal phy_rx_data_ind_net_x0: std_logic;
  signal phy_rx_start_ind_net_x1: std_logic;
  signal register1_q_net: std_logic_vector(7 downto 0);
  signal register_q_net: std_logic_vector(7 downto 0);
  signal relational1_op_net: std_logic;
  signal relational2_op_net: std_logic;

begin
  ce_1_sg_x28 <= ce_1;
  clk_1_sg_x28 <= clk_1;
  phy_rx_data_byte_net_x0 <= phy_rx_byte;
  phy_rx_data_ind_net_x0 <= phy_rx_byte_valid;
  phy_rx_data_bytenum_net_x0 <= phy_rx_bytenum;
  phy_rx_start_ind_net_x1 <= phy_rx_start_ind;
  duration <= mux_y_net_x0;

  concat: entity work.concat_8e53793314
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => register1_q_net,
      in1 => register_q_net,
      y => concat_y_net
    );

  constant1: entity work.constant_3a9a3daeb9
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant1_op_net
    );

  constant2: entity work.constant_cda50df78a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant2_op_net
    );

  constant_x0: entity work.constant_e8ddc079e9
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant_op_net
    );

  logical: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => phy_rx_data_ind_net_x0,
      d1(0) => relational1_op_net,
      y(0) => logical_y_net
    );

  logical1: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => phy_rx_data_ind_net_x0,
      d1(0) => relational2_op_net,
      y(0) => logical1_y_net
    );

  msb: entity work.xlslice
    generic map (
      new_lsb => 15,
      new_msb => 15,
      x_width => 16,
      y_width => 1
    )
    port map (
      x => concat_y_net,
      y(0) => msb_y_net
    );

  mux: entity work.mux_03e37234da
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => concat_y_net,
      d1 => constant2_op_net,
      sel(0) => msb_y_net,
      y => mux_y_net_x0
    );

  register1: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      d => phy_rx_data_byte_net_x0,
      en(0) => logical1_y_net,
      rst(0) => phy_rx_start_ind_net_x1,
      q => register1_q_net
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      d => phy_rx_data_byte_net_x0,
      en(0) => logical_y_net,
      rst(0) => phy_rx_start_ind_net_x1,
      q => register_q_net
    );

  relational1: entity work.relational_59b0d63655
    port map (
      a => phy_rx_data_bytenum_net_x0,
      b => constant_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net
    );

  relational2: entity work.relational_59b0d63655
    port map (
      a => phy_rx_data_bytenum_net_x0,
      b => constant1_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational2_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/NAV/New Duration/x16"

entity x16_entity_3605bcbae4 is
  port (
    a: in std_logic_vector(20 downto 0); 
    ax16: out std_logic_vector(24 downto 0)
  );
end x16_entity_3605bcbae4;

architecture structural of x16_entity_3605bcbae4 is
  signal addsub_s_net_x0: std_logic_vector(20 downto 0);
  signal concat1_y_net_x0: std_logic_vector(24 downto 0);
  signal constant9_op_net: std_logic_vector(3 downto 0);

begin
  addsub_s_net_x0 <= a;
  ax16 <= concat1_y_net_x0;

  concat1: entity work.concat_22af082bf9
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => addsub_s_net_x0,
      in1 => constant9_op_net,
      y => concat1_y_net_x0
    );

  constant9: entity work.constant_4c449dd556
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant9_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/NAV/New Duration"

entity new_duration_entity_9c43dc60c3 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    phy_rx_data_byte: in std_logic_vector(7 downto 0); 
    phy_rx_data_bytenum: in std_logic_vector(13 downto 0); 
    phy_rx_data_ind: in std_logic; 
    phy_rx_end_ind: in std_logic; 
    phy_rx_end_rxerror: in std_logic_vector(1 downto 0); 
    phy_rx_start_ind: in std_logic; 
    reg_nav_time_adj: in std_logic_vector(7 downto 0); 
    status_rx_fcs_good: in std_logic; 
    duration: out std_logic_vector(24 downto 0); 
    valid: out std_logic
  );
end new_duration_entity_9c43dc60c3;

architecture structural of new_duration_entity_9c43dc60c3 is
  signal addsub_s_net_x0: std_logic_vector(20 downto 0);
  signal ce_1_sg_x30: std_logic;
  signal clk_1_sg_x30: std_logic;
  signal concat1_y_net_x1: std_logic_vector(24 downto 0);
  signal constant1_op_net: std_logic_vector(3 downto 0);
  signal constant3_op_net: std_logic;
  signal delay1_q_net_x0: std_logic;
  signal delay_q_net: std_logic;
  signal logical1_y_net_x1: std_logic;
  signal logical2_y_net: std_logic;
  signal mult_p_net: std_logic_vector(19 downto 0);
  signal mux_y_net_x0: std_logic_vector(15 downto 0);
  signal phy_rx_data_byte_net_x1: std_logic_vector(7 downto 0);
  signal phy_rx_data_bytenum_net_x1: std_logic_vector(13 downto 0);
  signal phy_rx_data_ind_net_x1: std_logic;
  signal phy_rx_end_ind_net_x3: std_logic;
  signal phy_rx_end_rxerror_net_x3: std_logic_vector(1 downto 0);
  signal phy_rx_start_ind_net_x2: std_logic;
  signal register2_q_net: std_logic_vector(15 downto 0);
  signal register3_q_net_x0: std_logic;
  signal reinterpret_output_port_net_x0: std_logic_vector(7 downto 0);
  signal relational3_op_net: std_logic;

begin
  ce_1_sg_x30 <= ce_1;
  clk_1_sg_x30 <= clk_1;
  phy_rx_data_byte_net_x1 <= phy_rx_data_byte;
  phy_rx_data_bytenum_net_x1 <= phy_rx_data_bytenum;
  phy_rx_data_ind_net_x1 <= phy_rx_data_ind;
  phy_rx_end_ind_net_x3 <= phy_rx_end_ind;
  phy_rx_end_rxerror_net_x3 <= phy_rx_end_rxerror;
  phy_rx_start_ind_net_x2 <= phy_rx_start_ind;
  reinterpret_output_port_net_x0 <= reg_nav_time_adj;
  register3_q_net_x0 <= status_rx_fcs_good;
  duration <= concat1_y_net_x1;
  valid <= logical1_y_net_x1;

  addsub: entity work.xladdsub_wlan_mac_dcf_hw
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 0,
      a_width => 20,
      b_arith => xlSigned,
      b_bin_pt => 0,
      b_width => 8,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 22,
      core_name0 => "addsb_11_0_38dd91dde0ab1a97",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 22,
      latency => 0,
      overflow => 1,
      quantization => 1,
      s_arith => xlUnsigned,
      s_bin_pt => 0,
      s_width => 21
    )
    port map (
      a => mult_p_net,
      b => reinterpret_output_port_net_x0,
      ce => ce_1_sg_x30,
      clk => clk_1_sg_x30,
      clr => '0',
      en => "1",
      s => addsub_s_net_x0
    );

  capture_rx_pkt_duration_field_c6b3c20cf0: entity work.capture_rx_pkt_duration_field_entity_c6b3c20cf0
    port map (
      ce_1 => ce_1_sg_x30,
      clk_1 => clk_1_sg_x30,
      phy_rx_byte => phy_rx_data_byte_net_x1,
      phy_rx_byte_valid => phy_rx_data_ind_net_x1,
      phy_rx_bytenum => phy_rx_data_bytenum_net_x1,
      phy_rx_start_ind => phy_rx_start_ind_net_x2,
      duration => mux_y_net_x0
    );

  constant1: entity work.constant_5c1626e05e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant1_op_net
    );

  constant3: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant3_op_net
    );

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x30,
      clk => clk_1_sg_x30,
      d(0) => logical2_y_net,
      en => '1',
      rst => '1',
      q(0) => delay_q_net
    );

  delay1: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x30,
      clk => clk_1_sg_x30,
      d(0) => delay_q_net,
      en => '1',
      rst => '1',
      q(0) => delay1_q_net_x0
    );

  logical2: entity work.logical_954ee29728
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => register3_q_net_x0,
      d1(0) => phy_rx_end_ind_net_x3,
      d2(0) => relational3_op_net,
      y(0) => logical2_y_net
    );

  mult: entity work.xlmult_wlan_mac_dcf_hw
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 0,
      a_width => 4,
      b_arith => xlUnsigned,
      b_bin_pt => 0,
      b_width => 16,
      c_a_type => 1,
      c_a_width => 4,
      c_b_type => 1,
      c_b_width => 16,
      c_baat => 4,
      c_output_width => 20,
      c_type => 1,
      core_name0 => "mult_11_2_7def12de86dcdc6a",
      extra_registers => 0,
      multsign => 1,
      overflow => 1,
      p_arith => xlUnsigned,
      p_bin_pt => 0,
      p_width => 20,
      quantization => 1
    )
    port map (
      a => constant1_op_net,
      b => register2_q_net,
      ce => ce_1_sg_x30,
      clk => clk_1_sg_x30,
      clr => '0',
      core_ce => ce_1_sg_x30,
      core_clk => clk_1_sg_x30,
      core_clr => '1',
      en => "1",
      rst => "0",
      p => mult_p_net
    );

  posedge1_ea7aab8f9a: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x30,
      clk_1 => clk_1_sg_x30,
      d => delay1_q_net_x0,
      q => logical1_y_net_x1
    );

  register2: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x30,
      clk => clk_1_sg_x30,
      d => mux_y_net_x0,
      en(0) => logical2_y_net,
      rst(0) => phy_rx_start_ind_net_x2,
      q => register2_q_net
    );

  relational3: entity work.relational_f52e6abf76
    port map (
      a => phy_rx_end_rxerror_net_x3,
      b(0) => constant3_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational3_op_net
    );

  x16_3605bcbae4: entity work.x16_entity_3605bcbae4
    port map (
      a => addsub_s_net_x0,
      ax16 => concat1_y_net_x1
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/NAV"

entity nav_entity_e7185c267b is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    global_reset: in std_logic; 
    phy_rx_data_byte: in std_logic_vector(7 downto 0); 
    phy_rx_data_bytenum: in std_logic_vector(13 downto 0); 
    phy_rx_data_ind: in std_logic; 
    phy_rx_end_ind: in std_logic; 
    phy_rx_end_rxerror: in std_logic_vector(1 downto 0); 
    phy_rx_start_ind: in std_logic; 
    reg_disable_nav: in std_logic; 
    reg_force_reset_nav: in std_logic; 
    register3: in std_logic; 
    reinterpret: in std_logic_vector(7 downto 0); 
    nav_busy: out std_logic; 
    nav_value_100nsec: out std_logic_vector(15 downto 0); 
    register1_x0: out std_logic
  );
end nav_entity_e7185c267b;

architecture structural of nav_entity_e7185c267b is
  signal b_10_y_net: std_logic;
  signal b_3_y_net: std_logic;
  signal bitsm_4_y_net_x0: std_logic_vector(15 downto 0);
  signal ce_1_sg_x31: std_logic;
  signal clk_1_sg_x31: std_logic;
  signal concat1_y_net_x1: std_logic_vector(24 downto 0);
  signal constant_op_net: std_logic;
  signal convert1_dout_net_x5: std_logic;
  signal convert_dout_net: std_logic_vector(19 downto 0);
  signal inverter_op_net: std_logic;
  signal logical1_y_net: std_logic;
  signal logical1_y_net_x1: std_logic;
  signal logical2_y_net: std_logic;
  signal logical3_y_net_x2: std_logic;
  signal logical4_y_net: std_logic;
  signal nav_counter_op_net: std_logic_vector(19 downto 0);
  signal phy_rx_data_byte_net_x2: std_logic_vector(7 downto 0);
  signal phy_rx_data_bytenum_net_x2: std_logic_vector(13 downto 0);
  signal phy_rx_data_ind_net_x2: std_logic;
  signal phy_rx_end_ind_net_x4: std_logic;
  signal phy_rx_end_rxerror_net_x4: std_logic_vector(1 downto 0);
  signal phy_rx_start_ind_net_x3: std_logic;
  signal register1_q_net_x0: std_logic;
  signal register3_q_net_x1: std_logic;
  signal register_q_net: std_logic;
  signal reinterpret_output_port_net_x1: std_logic_vector(7 downto 0);
  signal relational1_op_net: std_logic;
  signal relational2_op_net: std_logic;

begin
  ce_1_sg_x31 <= ce_1;
  clk_1_sg_x31 <= clk_1;
  convert1_dout_net_x5 <= global_reset;
  phy_rx_data_byte_net_x2 <= phy_rx_data_byte;
  phy_rx_data_bytenum_net_x2 <= phy_rx_data_bytenum;
  phy_rx_data_ind_net_x2 <= phy_rx_data_ind;
  phy_rx_end_ind_net_x4 <= phy_rx_end_ind;
  phy_rx_end_rxerror_net_x4 <= phy_rx_end_rxerror;
  phy_rx_start_ind_net_x3 <= phy_rx_start_ind;
  b_3_y_net <= reg_disable_nav;
  b_10_y_net <= reg_force_reset_nav;
  register3_q_net_x1 <= register3;
  reinterpret_output_port_net_x1 <= reinterpret;
  nav_busy <= logical3_y_net_x2;
  nav_value_100nsec <= bitsm_4_y_net_x0;
  register1_x0 <= register1_q_net_x0;

  bitsm_4: entity work.xlslice
    generic map (
      new_lsb => 4,
      new_msb => 19,
      x_width => 20,
      y_width => 16
    )
    port map (
      x => nav_counter_op_net,
      y => bitsm_4_y_net_x0
    );

  constant_x0: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant_op_net
    );

  convert: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 25,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 20,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      clr => '0',
      din => concat1_y_net_x1,
      en => "1",
      dout => convert_dout_net
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      clr => '0',
      ip(0) => b_3_y_net,
      op(0) => inverter_op_net
    );

  logical1: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational1_op_net,
      d1(0) => logical1_y_net_x1,
      y(0) => logical1_y_net
    );

  logical2: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical1_y_net,
      d1(0) => relational2_op_net,
      y(0) => logical2_y_net
    );

  logical3: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => inverter_op_net,
      d1(0) => relational2_op_net,
      y(0) => logical3_y_net_x2
    );

  logical4: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert1_dout_net_x5,
      d1(0) => b_10_y_net,
      y(0) => logical4_y_net
    );

  nav_counter: entity work.xlcounter_free_wlan_mac_dcf_hw
    generic map (
      core_name0 => "cntr_11_0_33b670dfb2dd60f1",
      op_arith => xlUnsigned,
      op_width => 20
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      clr => '0',
      din => convert_dout_net,
      en(0) => logical2_y_net,
      load(0) => logical1_y_net,
      rst(0) => logical4_y_net,
      op => nav_counter_op_net
    );

  new_duration_9c43dc60c3: entity work.new_duration_entity_9c43dc60c3
    port map (
      ce_1 => ce_1_sg_x31,
      clk_1 => clk_1_sg_x31,
      phy_rx_data_byte => phy_rx_data_byte_net_x2,
      phy_rx_data_bytenum => phy_rx_data_bytenum_net_x2,
      phy_rx_data_ind => phy_rx_data_ind_net_x2,
      phy_rx_end_ind => phy_rx_end_ind_net_x4,
      phy_rx_end_rxerror => phy_rx_end_rxerror_net_x4,
      phy_rx_start_ind => phy_rx_start_ind_net_x3,
      reg_nav_time_adj => reinterpret_output_port_net_x1,
      status_rx_fcs_good => register3_q_net_x1,
      duration => concat1_y_net_x1,
      valid => logical1_y_net_x1
    );

  register1: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d(0) => register_q_net,
      en => "1",
      rst => "0",
      q(0) => register1_q_net_x0
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d(0) => logical3_y_net_x2,
      en => "1",
      rst => "0",
      q(0) => register_q_net
    );

  relational1: entity work.relational_bebc7e34dc
    port map (
      a => nav_counter_op_net,
      b => concat1_y_net_x1,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net
    );

  relational2: entity work.relational_77a58970b2
    port map (
      a => nav_counter_op_net,
      b(0) => constant_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational2_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/PHY I/O/PHY Rx Blocking"

entity phy_rx_blocking_entity_668fa85615 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    global_reset: in std_logic; 
    phy_rx_end_ind: in std_logic; 
    phy_rx_end_rxerror: in std_logic_vector(1 downto 0); 
    phy_rx_fcs_good_ind: in std_logic; 
    reg_block_rx_clear: in std_logic; 
    reg_block_rx_on_fcs_good: in std_logic; 
    reg_block_rx_on_tx: in std_logic; 
    reg_block_rx_on_valid_rxend: in std_logic; 
    status_tx_phy_active: in std_logic; 
    register2_x0: out std_logic; 
    status_blocked_on_good_fcs: out std_logic; 
    status_blocked_on_rxend: out std_logic
  );
end phy_rx_blocking_entity_668fa85615;

architecture structural of phy_rx_blocking_entity_668fa85615 is
  signal b_1_y_net_x0: std_logic;
  signal b_4_y_net: std_logic;
  signal b_6_y_net: std_logic;
  signal ce_1_sg_x34: std_logic;
  signal clk_1_sg_x34: std_logic;
  signal constant_op_net: std_logic;
  signal convert1_dout_net_x6: std_logic;
  signal logical1_y_net_x0: std_logic;
  signal logical2_y_net_x0: std_logic;
  signal logical5_y_net: std_logic;
  signal logical6_y_net: std_logic;
  signal logical7_y_net_x0: std_logic;
  signal logical8_y_net_x1: std_logic;
  signal phy_rx_end_ind_net_x5: std_logic;
  signal phy_rx_end_rxerror_net_x5: std_logic_vector(1 downto 0);
  signal phy_rx_fcs_good_ind_net_x3: std_logic;
  signal register2_q_net_x3: std_logic;
  signal register2_q_net_x4: std_logic;
  signal register2_q_net_x5: std_logic;
  signal register2_q_net_x6: std_logic;
  signal relational2_op_net: std_logic;

begin
  ce_1_sg_x34 <= ce_1;
  clk_1_sg_x34 <= clk_1;
  convert1_dout_net_x6 <= global_reset;
  phy_rx_end_ind_net_x5 <= phy_rx_end_ind;
  phy_rx_end_rxerror_net_x5 <= phy_rx_end_rxerror;
  phy_rx_fcs_good_ind_net_x3 <= phy_rx_fcs_good_ind;
  logical1_y_net_x0 <= reg_block_rx_clear;
  b_1_y_net_x0 <= reg_block_rx_on_fcs_good;
  b_4_y_net <= reg_block_rx_on_tx;
  b_6_y_net <= reg_block_rx_on_valid_rxend;
  register2_q_net_x3 <= status_tx_phy_active;
  register2_x0 <= register2_q_net_x4;
  status_blocked_on_good_fcs <= register2_q_net_x5;
  status_blocked_on_rxend <= register2_q_net_x6;

  constant_x0: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant_op_net
    );

  logical2: entity work.logical_3640e86e6c
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => phy_rx_end_ind_net_x5,
      d1(0) => phy_rx_fcs_good_ind_net_x3,
      d2(0) => b_1_y_net_x0,
      d3(0) => relational2_op_net,
      y(0) => logical2_y_net_x0
    );

  logical5: entity work.logical_6cb8f0ce02
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical6_y_net,
      d1(0) => register2_q_net_x5,
      d2(0) => register2_q_net_x6,
      y(0) => logical5_y_net
    );

  logical6: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => register2_q_net_x3,
      d1(0) => b_4_y_net,
      y(0) => logical6_y_net
    );

  logical7: entity work.logical_954ee29728
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => phy_rx_end_ind_net_x5,
      d1(0) => b_6_y_net,
      d2(0) => relational2_op_net,
      y(0) => logical7_y_net_x0
    );

  logical8: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical1_y_net_x0,
      d1(0) => convert1_dout_net_x6,
      y(0) => logical8_y_net_x1
    );

  register2: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x34,
      clk => clk_1_sg_x34,
      d(0) => logical5_y_net,
      en => "1",
      rst => "0",
      q(0) => register2_q_net_x4
    );

  relational2: entity work.relational_f52e6abf76
    port map (
      a => phy_rx_end_rxerror_net_x5,
      b(0) => constant_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational2_op_net
    );

  s_r_latch1_e477f14519: entity work.s_r_latch1_entity_370a153267
    port map (
      ce_1 => ce_1_sg_x34,
      clk_1 => clk_1_sg_x34,
      r => logical8_y_net_x1,
      s => logical2_y_net_x0,
      q => register2_q_net_x5
    );

  s_r_latch4_40a2cbc0fa: entity work.s_r_latch1_entity_370a153267
    port map (
      ce_1 => ce_1_sg_x34,
      clk_1 => clk_1_sg_x34,
      r => logical8_y_net_x1,
      s => logical7_y_net_x0,
      q => register2_q_net_x6
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/PHY I/O"

entity o_entity_0ef2366690 is
  port (
    auto_tx_antmask: in std_logic_vector(3 downto 0); 
    auto_tx_gain_a: in std_logic_vector(5 downto 0); 
    auto_tx_gain_b: in std_logic_vector(5 downto 0); 
    auto_tx_gain_c: in std_logic_vector(5 downto 0); 
    auto_tx_gain_d: in std_logic_vector(5 downto 0); 
    auto_tx_phy_start: in std_logic; 
    auto_tx_pktbuf: in std_logic_vector(3 downto 0); 
    b_1: in std_logic; 
    b_4: in std_logic; 
    b_6: in std_logic; 
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    global_reset: in std_logic; 
    logical1_x0: in std_logic; 
    mpdu_tx_param_txantmask: in std_logic_vector(3 downto 0); 
    mpdu_tx_param_txgain_a: in std_logic_vector(5 downto 0); 
    mpdu_tx_param_txgain_b: in std_logic_vector(5 downto 0); 
    mpdu_tx_param_txgain_c: in std_logic_vector(5 downto 0); 
    mpdu_tx_param_txgain_d: in std_logic_vector(5 downto 0); 
    mpdu_tx_pktbuf: in std_logic_vector(3 downto 0); 
    phy_rx_data_done_ind: in std_logic; 
    phy_rx_end_ind: in std_logic; 
    phy_rx_end_rxerror: in std_logic_vector(1 downto 0); 
    phy_rx_fcs_good_ind: in std_logic; 
    phy_rx_start_ind: in std_logic; 
    phy_tx_end_confirm: in std_logic; 
    phy_tx_start_confirm: in std_logic; 
    tx_ctrl_phy_start: in std_logic; 
    phy_rx_blocking: out std_logic; 
    phy_rx_blocking_x0: out std_logic; 
    phy_rx_blocking_x1: out std_logic; 
    register1_x0: out std_logic_vector(3 downto 0); 
    register2_x0: out std_logic_vector(5 downto 0); 
    register4_x0: out std_logic_vector(3 downto 0); 
    register5_x0: out std_logic_vector(5 downto 0); 
    register6_x0: out std_logic_vector(5 downto 0); 
    register7_x0: out std_logic_vector(5 downto 0); 
    register_x1: out std_logic; 
    status_rx_fcs_good: out std_logic; 
    status_rx_phy_active: out std_logic; 
    status_tx_phy_active: out std_logic
  );
end o_entity_0ef2366690;

architecture structural of o_entity_0ef2366690 is
  signal b_1_y_net_x1: std_logic;
  signal b_4_y_net_x0: std_logic;
  signal b_6_y_net_x0: std_logic;
  signal ce_1_sg_x37: std_logic;
  signal clk_1_sg_x37: std_logic;
  signal convert1_dout_net_x1: std_logic;
  signal convert1_dout_net_x7: std_logic;
  signal delay_q_net_x0: std_logic;
  signal logical1_y_net_x0: std_logic;
  signal logical1_y_net_x2: std_logic;
  signal logical3_y_net: std_logic;
  signal logical4_y_net_x0: std_logic;
  signal mux1_y_net: std_logic_vector(5 downto 0);
  signal mux2_y_net: std_logic_vector(3 downto 0);
  signal mux3_y_net: std_logic_vector(5 downto 0);
  signal mux4_y_net: std_logic_vector(5 downto 0);
  signal mux5_y_net: std_logic_vector(5 downto 0);
  signal mux_y_net: std_logic_vector(3 downto 0);
  signal phy_rx_data_done_ind_net_x0: std_logic;
  signal phy_rx_end_ind_net_x6: std_logic;
  signal phy_rx_end_rxerror_net_x6: std_logic_vector(1 downto 0);
  signal phy_rx_fcs_good_ind_net_x4: std_logic;
  signal phy_rx_start_ind_net_x5: std_logic;
  signal phy_tx_done_net_x1: std_logic;
  signal phy_tx_started_net_x1: std_logic;
  signal register10_q_net_x1: std_logic_vector(5 downto 0);
  signal register1_q_net_x1: std_logic;
  signal register1_q_net_x2: std_logic_vector(3 downto 0);
  signal register2_q_net_x0: std_logic;
  signal register2_q_net_x10: std_logic;
  signal register2_q_net_x11: std_logic;
  signal register2_q_net_x12: std_logic;
  signal register2_q_net_x13: std_logic_vector(5 downto 0);
  signal register2_q_net_x14: std_logic;
  signal register2_q_net_x8: std_logic_vector(3 downto 0);
  signal register2_q_net_x9: std_logic_vector(3 downto 0);
  signal register3_q_net_x2: std_logic_vector(5 downto 0);
  signal register3_q_net_x3: std_logic;
  signal register4_q_net_x1: std_logic_vector(3 downto 0);
  signal register4_q_net_x2: std_logic_vector(3 downto 0);
  signal register5_q_net_x1: std_logic_vector(5 downto 0);
  signal register5_q_net_x2: std_logic_vector(5 downto 0);
  signal register6_q_net_x2: std_logic_vector(5 downto 0);
  signal register6_q_net_x3: std_logic_vector(5 downto 0);
  signal register6_q_net_x4: std_logic_vector(5 downto 0);
  signal register7_q_net_x2: std_logic_vector(5 downto 0);
  signal register7_q_net_x3: std_logic_vector(3 downto 0);
  signal register7_q_net_x4: std_logic_vector(5 downto 0);
  signal register8_q_net_x1: std_logic_vector(5 downto 0);
  signal register9_q_net_x1: std_logic_vector(5 downto 0);
  signal register_q_net_x0: std_logic;

begin
  register4_q_net_x1 <= auto_tx_antmask;
  register3_q_net_x2 <= auto_tx_gain_a;
  register5_q_net_x1 <= auto_tx_gain_b;
  register6_q_net_x2 <= auto_tx_gain_c;
  register7_q_net_x2 <= auto_tx_gain_d;
  register1_q_net_x1 <= auto_tx_phy_start;
  register2_q_net_x8 <= auto_tx_pktbuf;
  b_1_y_net_x1 <= b_1;
  b_4_y_net_x0 <= b_4;
  b_6_y_net_x0 <= b_6;
  ce_1_sg_x37 <= ce_1;
  clk_1_sg_x37 <= clk_1;
  convert1_dout_net_x7 <= global_reset;
  logical1_y_net_x2 <= logical1_x0;
  register7_q_net_x3 <= mpdu_tx_param_txantmask;
  register6_q_net_x3 <= mpdu_tx_param_txgain_a;
  register8_q_net_x1 <= mpdu_tx_param_txgain_b;
  register9_q_net_x1 <= mpdu_tx_param_txgain_c;
  register10_q_net_x1 <= mpdu_tx_param_txgain_d;
  register2_q_net_x9 <= mpdu_tx_pktbuf;
  phy_rx_data_done_ind_net_x0 <= phy_rx_data_done_ind;
  phy_rx_end_ind_net_x6 <= phy_rx_end_ind;
  phy_rx_end_rxerror_net_x6 <= phy_rx_end_rxerror;
  phy_rx_fcs_good_ind_net_x4 <= phy_rx_fcs_good_ind;
  phy_rx_start_ind_net_x5 <= phy_rx_start_ind;
  phy_tx_done_net_x1 <= phy_tx_end_confirm;
  phy_tx_started_net_x1 <= phy_tx_start_confirm;
  convert1_dout_net_x1 <= tx_ctrl_phy_start;
  phy_rx_blocking <= register2_q_net_x10;
  phy_rx_blocking_x0 <= register2_q_net_x11;
  phy_rx_blocking_x1 <= register2_q_net_x12;
  register1_x0 <= register1_q_net_x2;
  register2_x0 <= register2_q_net_x13;
  register4_x0 <= register4_q_net_x2;
  register5_x0 <= register5_q_net_x2;
  register6_x0 <= register6_q_net_x4;
  register7_x0 <= register7_q_net_x4;
  register_x1 <= register_q_net_x0;
  status_rx_fcs_good <= register3_q_net_x3;
  status_rx_phy_active <= delay_q_net_x0;
  status_tx_phy_active <= register2_q_net_x14;

  delay: entity work.xldelay
    generic map (
      latency => 3,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x37,
      clk => clk_1_sg_x37,
      d(0) => register2_q_net_x0,
      en => '1',
      rst => '1',
      q(0) => delay_q_net_x0
    );

  logical1: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => phy_tx_done_net_x1,
      d1(0) => convert1_dout_net_x7,
      y(0) => logical1_y_net_x0
    );

  logical3: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert1_dout_net_x1,
      d1(0) => register1_q_net_x1,
      y(0) => logical3_y_net
    );

  logical4: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => phy_rx_end_ind_net_x6,
      d1(0) => convert1_dout_net_x7,
      y(0) => logical4_y_net_x0
    );

  mux: entity work.mux_f9c0f11a18
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => register2_q_net_x9,
      d1 => register2_q_net_x8,
      sel(0) => register1_q_net_x1,
      y => mux_y_net
    );

  mux1: entity work.mux_ac2c510b5b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => register6_q_net_x3,
      d1 => register3_q_net_x2,
      sel(0) => register1_q_net_x1,
      y => mux1_y_net
    );

  mux2: entity work.mux_f9c0f11a18
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => register7_q_net_x3,
      d1 => register4_q_net_x1,
      sel(0) => register1_q_net_x1,
      y => mux2_y_net
    );

  mux3: entity work.mux_ac2c510b5b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => register8_q_net_x1,
      d1 => register5_q_net_x1,
      sel(0) => register1_q_net_x1,
      y => mux3_y_net
    );

  mux4: entity work.mux_ac2c510b5b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => register9_q_net_x1,
      d1 => register6_q_net_x2,
      sel(0) => register1_q_net_x1,
      y => mux4_y_net
    );

  mux5: entity work.mux_ac2c510b5b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => register10_q_net_x1,
      d1 => register7_q_net_x2,
      sel(0) => register1_q_net_x1,
      y => mux5_y_net
    );

  phy_rx_blocking_668fa85615: entity work.phy_rx_blocking_entity_668fa85615
    port map (
      ce_1 => ce_1_sg_x37,
      clk_1 => clk_1_sg_x37,
      global_reset => convert1_dout_net_x7,
      phy_rx_end_ind => phy_rx_end_ind_net_x6,
      phy_rx_end_rxerror => phy_rx_end_rxerror_net_x6,
      phy_rx_fcs_good_ind => phy_rx_fcs_good_ind_net_x4,
      reg_block_rx_clear => logical1_y_net_x2,
      reg_block_rx_on_fcs_good => b_1_y_net_x1,
      reg_block_rx_on_tx => b_4_y_net_x0,
      reg_block_rx_on_valid_rxend => b_6_y_net_x0,
      status_tx_phy_active => register2_q_net_x14,
      register2_x0 => register2_q_net_x10,
      status_blocked_on_good_fcs => register2_q_net_x11,
      status_blocked_on_rxend => register2_q_net_x12
    );

  register1: entity work.xlregister
    generic map (
      d_width => 4,
      init_value => b"0000"
    )
    port map (
      ce => ce_1_sg_x37,
      clk => clk_1_sg_x37,
      d => mux_y_net,
      en => "1",
      rst => "0",
      q => register1_q_net_x2
    );

  register2: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x37,
      clk => clk_1_sg_x37,
      d => mux1_y_net,
      en => "1",
      rst => "0",
      q => register2_q_net_x13
    );

  register3: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x37,
      clk => clk_1_sg_x37,
      d(0) => phy_rx_fcs_good_ind_net_x4,
      en(0) => phy_rx_data_done_ind_net_x0,
      rst(0) => phy_rx_start_ind_net_x5,
      q(0) => register3_q_net_x3
    );

  register4: entity work.xlregister
    generic map (
      d_width => 4,
      init_value => b"0000"
    )
    port map (
      ce => ce_1_sg_x37,
      clk => clk_1_sg_x37,
      d => mux2_y_net,
      en => "1",
      rst => "0",
      q => register4_q_net_x2
    );

  register5: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x37,
      clk => clk_1_sg_x37,
      d => mux3_y_net,
      en => "1",
      rst => "0",
      q => register5_q_net_x2
    );

  register6: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x37,
      clk => clk_1_sg_x37,
      d => mux4_y_net,
      en => "1",
      rst => "0",
      q => register6_q_net_x4
    );

  register7: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x37,
      clk => clk_1_sg_x37,
      d => mux5_y_net,
      en => "1",
      rst => "0",
      q => register7_q_net_x4
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x37,
      clk => clk_1_sg_x37,
      d(0) => logical3_y_net,
      en => "1",
      rst => "0",
      q(0) => register_q_net_x0
    );

  s_r_latch2_87ac7e2783: entity work.s_r_latch1_entity_370a153267
    port map (
      ce_1 => ce_1_sg_x37,
      clk_1 => clk_1_sg_x37,
      r => logical1_y_net_x0,
      s => phy_tx_started_net_x1,
      q => register2_q_net_x14
    );

  s_r_latch3_bd74a95dd8: entity work.s_r_latch1_entity_370a153267
    port map (
      ce_1 => ce_1_sg_x37,
      clk_1 => clk_1_sg_x37,
      r => logical4_y_net_x0,
      s => phy_rx_start_ind_net_x5,
      q => register2_q_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Registers/Ctrl Bits"

entity ctrl_bits_entity_9618005c67 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    x32b: in std_logic_vector(31 downto 0); 
    reg_block_rx_clear: out std_logic; 
    reg_block_rx_on_fcs_good: out std_logic; 
    reg_block_rx_on_tx: out std_logic; 
    reg_block_rx_on_valid_rxend: out std_logic; 
    reg_cca_ignore_nav: out std_logic; 
    reg_cca_ignore_phy_cs: out std_logic; 
    reg_cca_ignore_txbusy: out std_logic; 
    reg_disable_nav: out std_logic; 
    reg_force_reset_backoff: out std_logic; 
    reg_force_reset_nav: out std_logic; 
    reg_global_reset: out std_logic; 
    reg_update_timestamp: out std_logic
  );
end ctrl_bits_entity_9618005c67;

architecture structural of ctrl_bits_entity_9618005c67 is
  signal b_0_y_net: std_logic;
  signal b_10_y_net_x0: std_logic;
  signal b_11_y_net_x0: std_logic;
  signal b_1_y_net_x2: std_logic;
  signal b_2_y_net: std_logic;
  signal b_3_y_net_x0: std_logic;
  signal b_4_y_net_x1: std_logic;
  signal b_5_y_net_x1: std_logic;
  signal b_6_y_net_x1: std_logic;
  signal b_7_y_net_x0: std_logic;
  signal b_8_y_net_x0: std_logic;
  signal b_9_y_net_x0: std_logic;
  signal ce_1_sg_x39: std_logic;
  signal clk_1_sg_x39: std_logic;
  signal logical1_y_net_x4: std_logic;
  signal register36_q_net_x0: std_logic_vector(31 downto 0);

begin
  ce_1_sg_x39 <= ce_1;
  clk_1_sg_x39 <= clk_1;
  register36_q_net_x0 <= x32b;
  reg_block_rx_clear <= logical1_y_net_x4;
  reg_block_rx_on_fcs_good <= b_1_y_net_x2;
  reg_block_rx_on_tx <= b_4_y_net_x1;
  reg_block_rx_on_valid_rxend <= b_6_y_net_x1;
  reg_cca_ignore_nav <= b_9_y_net_x0;
  reg_cca_ignore_phy_cs <= b_7_y_net_x0;
  reg_cca_ignore_txbusy <= b_8_y_net_x0;
  reg_disable_nav <= b_3_y_net_x0;
  reg_force_reset_backoff <= b_11_y_net_x0;
  reg_force_reset_nav <= b_10_y_net_x0;
  reg_global_reset <= b_0_y_net;
  reg_update_timestamp <= b_5_y_net_x1;

  b_0: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 0,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => register36_q_net_x0,
      y(0) => b_0_y_net
    );

  b_1: entity work.xlslice
    generic map (
      new_lsb => 1,
      new_msb => 1,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => register36_q_net_x0,
      y(0) => b_1_y_net_x2
    );

  b_10: entity work.xlslice
    generic map (
      new_lsb => 10,
      new_msb => 10,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => register36_q_net_x0,
      y(0) => b_10_y_net_x0
    );

  b_11: entity work.xlslice
    generic map (
      new_lsb => 11,
      new_msb => 11,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => register36_q_net_x0,
      y(0) => b_11_y_net_x0
    );

  b_2: entity work.xlslice
    generic map (
      new_lsb => 2,
      new_msb => 2,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => register36_q_net_x0,
      y(0) => b_2_y_net
    );

  b_3: entity work.xlslice
    generic map (
      new_lsb => 3,
      new_msb => 3,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => register36_q_net_x0,
      y(0) => b_3_y_net_x0
    );

  b_4: entity work.xlslice
    generic map (
      new_lsb => 4,
      new_msb => 4,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => register36_q_net_x0,
      y(0) => b_4_y_net_x1
    );

  b_5: entity work.xlslice
    generic map (
      new_lsb => 5,
      new_msb => 5,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => register36_q_net_x0,
      y(0) => b_5_y_net_x1
    );

  b_6: entity work.xlslice
    generic map (
      new_lsb => 6,
      new_msb => 6,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => register36_q_net_x0,
      y(0) => b_6_y_net_x1
    );

  b_7: entity work.xlslice
    generic map (
      new_lsb => 7,
      new_msb => 7,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => register36_q_net_x0,
      y(0) => b_7_y_net_x0
    );

  b_8: entity work.xlslice
    generic map (
      new_lsb => 8,
      new_msb => 8,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => register36_q_net_x0,
      y(0) => b_8_y_net_x0
    );

  b_9: entity work.xlslice
    generic map (
      new_lsb => 9,
      new_msb => 9,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => register36_q_net_x0,
      y(0) => b_9_y_net_x0
    );

  posedge1_e3831b67ae: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x39,
      clk_1 => clk_1_sg_x39,
      d => b_2_y_net,
      q => logical1_y_net_x4
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Registers/x1"

entity x1_entity_588dcb8437 is
  port (
    a: in std_logic_vector(9 downto 0); 
    ax16: out std_logic_vector(13 downto 0)
  );
end x1_entity_588dcb8437;

architecture structural of x1_entity_588dcb8437 is
  signal concat1_y_net_x3: std_logic_vector(13 downto 0);
  signal constant9_op_net: std_logic_vector(3 downto 0);
  signal register33_q_net_x0: std_logic_vector(9 downto 0);

begin
  register33_q_net_x0 <= a;
  ax16 <= concat1_y_net_x3;

  concat1: entity work.concat_4a94c27437
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => register33_q_net_x0,
      in1 => constant9_op_net,
      y => concat1_y_net_x3
    );

  constant9: entity work.constant_4c449dd556
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant9_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Registers/x16"

entity x16_entity_444d47662b is
  port (
    a: in std_logic_vector(15 downto 0); 
    ax16: out std_logic_vector(19 downto 0)
  );
end x16_entity_444d47662b;

architecture structural of x16_entity_444d47662b is
  signal concat1_y_net_x0: std_logic_vector(19 downto 0);
  signal constant9_op_net: std_logic_vector(3 downto 0);
  signal register31_q_net_x0: std_logic_vector(15 downto 0);

begin
  register31_q_net_x0 <= a;
  ax16 <= concat1_y_net_x0;

  concat1: entity work.concat_0a671b9443
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => register31_q_net_x0,
      in1 => constant9_op_net,
      y => concat1_y_net_x0
    );

  constant9: entity work.constant_4c449dd556
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant9_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Registers"

entity registers_entity_f21f4f09d9 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    from_register1: in std_logic_vector(31 downto 0); 
    from_register10: in std_logic_vector(31 downto 0); 
    from_register11: in std_logic_vector(31 downto 0); 
    from_register12: in std_logic_vector(31 downto 0); 
    from_register13: in std_logic_vector(31 downto 0); 
    from_register2: in std_logic_vector(31 downto 0); 
    from_register3: in std_logic_vector(31 downto 0); 
    from_register4: in std_logic_vector(31 downto 0); 
    from_register5: in std_logic_vector(31 downto 0); 
    from_register6: in std_logic_vector(31 downto 0); 
    from_register7: in std_logic_vector(31 downto 0); 
    from_register8: in std_logic_vector(31 downto 0); 
    from_register9: in std_logic_vector(31 downto 0); 
    mac_nav_busy: in std_logic; 
    microsecond_timestamp: in std_logic_vector(63 downto 0); 
    nav_value_100nsec: in std_logic_vector(15 downto 0); 
    phy_cca_ind_busy: in std_logic; 
    phy_rx_byte: in std_logic_vector(7 downto 0); 
    phy_rx_byte_valid: in std_logic; 
    phy_rx_bytenum: in std_logic_vector(13 downto 0); 
    phy_rx_start_ind: in std_logic; 
    phy_rx_start_phy_sel: in std_logic; 
    phy_rx_start_sig_length: in std_logic_vector(11 downto 0); 
    phy_rx_start_sig_rate: in std_logic_vector(3 downto 0); 
    status_autotx_pending: in std_logic; 
    status_blocked_on_good_fcs: in std_logic; 
    status_blocked_on_rxend: in std_logic; 
    status_current_backoff_count: in std_logic_vector(15 downto 0); 
    status_mpdu_txdone: in std_logic; 
    status_mpdu_txpending: in std_logic; 
    status_mpdu_txresult: in std_logic_vector(1 downto 0); 
    status_mpdu_txstate: in std_logic_vector(2 downto 0); 
    status_rx_fcs_good: in std_logic; 
    status_rx_phy_active: in std_logic; 
    status_tx_phy_active: in std_logic; 
    tx_ctrl_phy_start: in std_logic; 
    constant1_x0: out std_logic; 
    constant2_x0: out std_logic; 
    constant3_x0: out std_logic; 
    constant5_x0: out std_logic; 
    constant6_x0: out std_logic; 
    convert1_x0: out std_logic_vector(31 downto 0); 
    convert2_x0: out std_logic_vector(31 downto 0); 
    convert5_x0: out std_logic; 
    convert6_x0: out std_logic_vector(31 downto 0); 
    convert_x0: out std_logic_vector(31 downto 0); 
    ctrl_bits: out std_logic; 
    ctrl_bits_x0: out std_logic; 
    ctrl_bits_x1: out std_logic; 
    ctrl_bits_x10: out std_logic; 
    ctrl_bits_x2: out std_logic; 
    ctrl_bits_x3: out std_logic; 
    ctrl_bits_x4: out std_logic; 
    ctrl_bits_x5: out std_logic; 
    ctrl_bits_x6: out std_logic; 
    ctrl_bits_x7: out std_logic; 
    ctrl_bits_x8: out std_logic; 
    ctrl_bits_x9: out std_logic; 
    posedge3: out std_logic; 
    reg_autotx_dly: out std_logic_vector(13 downto 0); 
    reg_autotx_param_en: out std_logic; 
    reg_autotx_param_pktbuf: out std_logic_vector(3 downto 0); 
    reg_autotx_param_txantmask: out std_logic_vector(3 downto 0); 
    reg_autotx_param_txgain_a: out std_logic_vector(5 downto 0); 
    reg_autotx_param_txgain_b: out std_logic_vector(5 downto 0); 
    reg_autotx_param_txgain_c: out std_logic_vector(5 downto 0); 
    reg_autotx_param_txgain_d: out std_logic_vector(5 downto 0); 
    reg_backoff_sw_numslots: out std_logic_vector(15 downto 0); 
    reg_backoff_sw_start: out std_logic; 
    reg_calibtime_txdifs: out std_logic_vector(13 downto 0); 
    reg_interval_ack_timeout: out std_logic_vector(19 downto 0); 
    reg_interval_difs: out std_logic_vector(13 downto 0); 
    reg_interval_eifs: out std_logic_vector(19 downto 0); 
    reg_interval_slot: out std_logic_vector(13 downto 0); 
    reg_nav_time_adj: out std_logic_vector(7 downto 0); 
    reg_set_timestamp_lsb: out std_logic_vector(31 downto 0); 
    reg_set_timestamp_msb: out std_logic_vector(31 downto 0); 
    reg_tx_param_bo_slots: out std_logic_vector(15 downto 0); 
    reg_tx_param_pktbuf: out std_logic_vector(3 downto 0); 
    reg_tx_param_start_timeout: out std_logic; 
    reg_tx_param_txantmask: out std_logic_vector(3 downto 0); 
    reg_tx_param_txgain_a: out std_logic_vector(5 downto 0); 
    reg_tx_param_txgain_b: out std_logic_vector(5 downto 0); 
    reg_tx_param_txgain_c: out std_logic_vector(5 downto 0); 
    reg_tx_param_txgain_d: out std_logic_vector(5 downto 0); 
    reg_tx_start: out std_logic; 
    register15_x0: out std_logic; 
    register26_x0: out std_logic_vector(31 downto 0); 
    register55_x0: out std_logic_vector(31 downto 0); 
    x32lsb1_x0: out std_logic_vector(31 downto 0); 
    x32lsb2_x0: out std_logic_vector(31 downto 0); 
    x32lsb_x1: out std_logic_vector(31 downto 0); 
    x32msb1_x0: out std_logic_vector(31 downto 0); 
    x32msb2_x0: out std_logic_vector(31 downto 0); 
    x32msb_x1: out std_logic_vector(31 downto 0)
  );
end registers_entity_f21f4f09d9;

architecture structural of registers_entity_f21f4f09d9 is
  signal addsub_s_net: std_logic_vector(63 downto 0);
  signal b_0_2_y_net: std_logic;
  signal b_0_y_net_x0: std_logic;
  signal b_10_y_net_x1: std_logic;
  signal b_11_6_1_y_net: std_logic_vector(5 downto 0);
  signal b_11_6_y_net: std_logic_vector(5 downto 0);
  signal b_11_y_net_x1: std_logic;
  signal b_13_4_y_net: std_logic_vector(9 downto 0);
  signal b_15_0_2_y_net: std_logic_vector(15 downto 0);
  signal b_15_0_y_net: std_logic_vector(15 downto 0);
  signal b_17_12_1_y_net: std_logic_vector(5 downto 0);
  signal b_17_12_y_net: std_logic_vector(5 downto 0);
  signal b_1_y_net_x3: std_logic;
  signal b_23_18_1_y_net: std_logic_vector(5 downto 0);
  signal b_23_18_y_net: std_logic_vector(5 downto 0);
  signal b_23_20_y_net_x0: std_logic_vector(3 downto 0);
  signal b_23_8_y_net: std_logic_vector(15 downto 0);
  signal b_24_y_net: std_logic;
  signal b_29_20_y_net: std_logic_vector(9 downto 0);
  signal b_31_16_y_net: std_logic_vector(15 downto 0);
  signal b_31_1_y_net: std_logic;
  signal b_31_24_y_net: std_logic_vector(7 downto 0);
  signal b_31_y_net: std_logic;
  signal b_3_0_1_y_net: std_logic_vector(3 downto 0);
  signal b_3_0_y_net: std_logic_vector(3 downto 0);
  signal b_3_y_net_x1: std_logic;
  signal b_4_y_net_x2: std_logic;
  signal b_5_0_1_y_net: std_logic_vector(5 downto 0);
  signal b_5_0_y_net: std_logic_vector(5 downto 0);
  signal b_5_y_net_x2: std_logic;
  signal b_6_y_net_x2: std_logic;
  signal b_7_4_y_net: std_logic_vector(3 downto 0);
  signal b_7_y_net_x1: std_logic;
  signal b_8_y_net_x1: std_logic;
  signal b_9_0_1_y_net: std_logic_vector(9 downto 0);
  signal b_9_0_y_net: std_logic_vector(9 downto 0);
  signal b_9_y_net_x1: std_logic;
  signal bitsm_4_y_net_x1: std_logic_vector(15 downto 0);
  signal ce_1_sg_x43: std_logic;
  signal clk_1_sg_x43: std_logic;
  signal concat1_y_net: std_logic_vector(21 downto 0);
  signal concat1_y_net_x10: std_logic_vector(19 downto 0);
  signal concat1_y_net_x11: std_logic_vector(13 downto 0);
  signal concat1_y_net_x6: std_logic_vector(13 downto 0);
  signal concat1_y_net_x7: std_logic_vector(19 downto 0);
  signal concat1_y_net_x8: std_logic_vector(13 downto 0);
  signal concat1_y_net_x9: std_logic_vector(13 downto 0);
  signal concat2_y_net: std_logic_vector(24 downto 0);
  signal concat_y_net: std_logic_vector(30 downto 0);
  signal constant1_op_net_x0: std_logic;
  signal constant2_op_net_x0: std_logic;
  signal constant3_op_net_x0: std_logic;
  signal constant5_op_net_x0: std_logic;
  signal constant6_op_net_x0: std_logic;
  signal convert1_dout_net_x0: std_logic_vector(31 downto 0);
  signal convert1_dout_net_x2: std_logic;
  signal convert2_dout_net_x0: std_logic_vector(31 downto 0);
  signal convert3_dout_net: std_logic_vector(15 downto 0);
  signal convert4_dout_net: std_logic_vector(7 downto 0);
  signal convert5_dout_net_x0: std_logic;
  signal convert6_dout_net_x0: std_logic_vector(31 downto 0);
  signal convert7_dout_net_x0: std_logic;
  signal convert_dout_net_x0: std_logic_vector(31 downto 0);
  signal delay_q_net: std_logic;
  signal delay_q_net_x1: std_logic;
  signal from_register10_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register11_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register12_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register13_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register1_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register2_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register3_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register4_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register5_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register6_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register7_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register8_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register9_data_out_net_x0: std_logic_vector(31 downto 0);
  signal logical1_y_net_x0: std_logic;
  signal logical1_y_net_x1: std_logic;
  signal logical1_y_net_x5: std_logic;
  signal logical1_y_net_x6: std_logic;
  signal logical3_y_net_x3: std_logic;
  signal logical5_y_net_x1: std_logic;
  signal mcode_fsm_state_out_net_x1: std_logic_vector(2 downto 0);
  signal microsecond_counter_op_net_x1: std_logic_vector(63 downto 0);
  signal num_slots_op_net_x1: std_logic_vector(15 downto 0);
  signal phy_cca_ind_busy_net_x1: std_logic;
  signal phy_rx_data_byte_net_x3: std_logic_vector(7 downto 0);
  signal phy_rx_data_bytenum_net_x3: std_logic_vector(13 downto 0);
  signal phy_rx_data_ind_net_x3: std_logic;
  signal phy_rx_start_ind_net_x7: std_logic;
  signal phy_rx_start_phy_sel_net_x0: std_logic;
  signal phy_rx_start_sig_length_net_x0: std_logic_vector(11 downto 0);
  signal phy_rx_start_sig_rate_net_x0: std_logic_vector(3 downto 0);
  signal register10_q_net: std_logic_vector(21 downto 0);
  signal register11_q_net: std_logic_vector(63 downto 0);
  signal register12_q_net: std_logic_vector(15 downto 0);
  signal register13_q_net: std_logic_vector(15 downto 0);
  signal register14_q_net: std_logic_vector(63 downto 0);
  signal register15_q_net_x0: std_logic;
  signal register16_q_net_x1: std_logic_vector(3 downto 0);
  signal register17_q_net_x1: std_logic_vector(15 downto 0);
  signal register18_q_net_x1: std_logic;
  signal register19_q_net_x1: std_logic_vector(5 downto 0);
  signal register1_q_net: std_logic_vector(63 downto 0);
  signal register1_q_net_x1: std_logic_vector(1 downto 0);
  signal register20_q_net_x1: std_logic_vector(15 downto 0);
  signal register21_q_net_x1: std_logic;
  signal register22_q_net_x1: std_logic_vector(3 downto 0);
  signal register23_q_net_x0: std_logic_vector(9 downto 0);
  signal register24_q_net_x3: std_logic;
  signal register25_q_net_x1: std_logic_vector(3 downto 0);
  signal register26_q_net_x0: std_logic_vector(31 downto 0);
  signal register27_q_net_x1: std_logic_vector(31 downto 0);
  signal register28_q_net_x1: std_logic_vector(31 downto 0);
  signal register29_q_net_x0: std_logic_vector(9 downto 0);
  signal register2_q_net: std_logic_vector(13 downto 0);
  signal register2_q_net_x13: std_logic;
  signal register2_q_net_x15: std_logic;
  signal register2_q_net_x16: std_logic;
  signal register2_q_net_x17: std_logic;
  signal register2_q_net_x5: std_logic;
  signal register30_q_net: std_logic_vector(7 downto 0);
  signal register31_q_net_x0: std_logic_vector(15 downto 0);
  signal register32_q_net_x0: std_logic_vector(15 downto 0);
  signal register33_q_net_x0: std_logic_vector(9 downto 0);
  signal register34_q_net_x0: std_logic_vector(9 downto 0);
  signal register35_q_net_x2: std_logic;
  signal register36_q_net_x0: std_logic_vector(31 downto 0);
  signal register37_q_net: std_logic;
  signal register38_q_net: std_logic;
  signal register39_q_net: std_logic;
  signal register3_q_net_x4: std_logic;
  signal register40_q_net: std_logic;
  signal register41_q_net: std_logic;
  signal register42_q_net: std_logic;
  signal register43_q_net: std_logic_vector(2 downto 0);
  signal register44_q_net: std_logic_vector(1 downto 0);
  signal register45_q_net: std_logic;
  signal register46_q_net: std_logic;
  signal register47_q_net: std_logic;
  signal register48_q_net: std_logic;
  signal register49_q_net: std_logic_vector(15 downto 0);
  signal register4_q_net: std_logic_vector(7 downto 0);
  signal register50_q_net: std_logic_vector(63 downto 0);
  signal register51_q_net: std_logic_vector(63 downto 0);
  signal register52_q_net: std_logic_vector(63 downto 0);
  signal register53_q_net_x1: std_logic_vector(5 downto 0);
  signal register54_q_net: std_logic_vector(63 downto 0);
  signal register55_q_net_x0: std_logic_vector(31 downto 0);
  signal register56_q_net_x1: std_logic_vector(5 downto 0);
  signal register57_q_net_x1: std_logic_vector(5 downto 0);
  signal register58_q_net_x1: std_logic_vector(5 downto 0);
  signal register59_q_net_x1: std_logic_vector(5 downto 0);
  signal register5_q_net: std_logic;
  signal register60_q_net_x1: std_logic_vector(5 downto 0);
  signal register61_q_net_x1: std_logic_vector(5 downto 0);
  signal register62_q_net: std_logic_vector(31 downto 0);
  signal register63_q_net: std_logic_vector(31 downto 0);
  signal register6_q_net: std_logic_vector(11 downto 0);
  signal register7_q_net: std_logic_vector(3 downto 0);
  signal register8_q_net_x0: std_logic;
  signal register9_q_net: std_logic;
  signal register_q_net: std_logic_vector(30 downto 0);
  signal reinterpret_output_port_net_x2: std_logic_vector(7 downto 0);
  signal x32lsb1_y_net_x0: std_logic_vector(31 downto 0);
  signal x32lsb2_y_net_x0: std_logic_vector(31 downto 0);
  signal x32lsb_y_net_x0: std_logic_vector(31 downto 0);
  signal x32lsb_y_net_x1: std_logic_vector(31 downto 0);
  signal x32msb1_y_net_x0: std_logic_vector(31 downto 0);
  signal x32msb2_y_net_x0: std_logic_vector(31 downto 0);
  signal x32msb_y_net_x0: std_logic_vector(31 downto 0);
  signal x32msb_y_net_x1: std_logic_vector(31 downto 0);

begin
  ce_1_sg_x43 <= ce_1;
  clk_1_sg_x43 <= clk_1;
  from_register1_data_out_net_x0 <= from_register1;
  from_register10_data_out_net_x0 <= from_register10;
  from_register11_data_out_net_x0 <= from_register11;
  from_register12_data_out_net_x0 <= from_register12;
  from_register13_data_out_net_x0 <= from_register13;
  from_register2_data_out_net_x0 <= from_register2;
  from_register3_data_out_net_x0 <= from_register3;
  from_register4_data_out_net_x0 <= from_register4;
  from_register5_data_out_net_x0 <= from_register5;
  from_register6_data_out_net_x0 <= from_register6;
  from_register7_data_out_net_x0 <= from_register7;
  from_register8_data_out_net_x0 <= from_register8;
  from_register9_data_out_net_x0 <= from_register9;
  logical3_y_net_x3 <= mac_nav_busy;
  microsecond_counter_op_net_x1 <= microsecond_timestamp;
  bitsm_4_y_net_x1 <= nav_value_100nsec;
  phy_cca_ind_busy_net_x1 <= phy_cca_ind_busy;
  phy_rx_data_byte_net_x3 <= phy_rx_byte;
  phy_rx_data_ind_net_x3 <= phy_rx_byte_valid;
  phy_rx_data_bytenum_net_x3 <= phy_rx_bytenum;
  phy_rx_start_ind_net_x7 <= phy_rx_start_ind;
  phy_rx_start_phy_sel_net_x0 <= phy_rx_start_phy_sel;
  phy_rx_start_sig_length_net_x0 <= phy_rx_start_sig_length;
  phy_rx_start_sig_rate_net_x0 <= phy_rx_start_sig_rate;
  logical5_y_net_x1 <= status_autotx_pending;
  register2_q_net_x15 <= status_blocked_on_good_fcs;
  register2_q_net_x16 <= status_blocked_on_rxend;
  num_slots_op_net_x1 <= status_current_backoff_count;
  register2_q_net_x13 <= status_mpdu_txdone;
  register2_q_net_x5 <= status_mpdu_txpending;
  register1_q_net_x1 <= status_mpdu_txresult;
  mcode_fsm_state_out_net_x1 <= status_mpdu_txstate;
  register3_q_net_x4 <= status_rx_fcs_good;
  delay_q_net_x1 <= status_rx_phy_active;
  register2_q_net_x17 <= status_tx_phy_active;
  convert1_dout_net_x2 <= tx_ctrl_phy_start;
  constant1_x0 <= constant1_op_net_x0;
  constant2_x0 <= constant2_op_net_x0;
  constant3_x0 <= constant3_op_net_x0;
  constant5_x0 <= constant5_op_net_x0;
  constant6_x0 <= constant6_op_net_x0;
  convert1_x0 <= convert1_dout_net_x0;
  convert2_x0 <= convert2_dout_net_x0;
  convert5_x0 <= convert5_dout_net_x0;
  convert6_x0 <= convert6_dout_net_x0;
  convert_x0 <= convert_dout_net_x0;
  ctrl_bits <= logical1_y_net_x5;
  ctrl_bits_x0 <= b_0_y_net_x0;
  ctrl_bits_x1 <= b_10_y_net_x1;
  ctrl_bits_x10 <= b_9_y_net_x1;
  ctrl_bits_x2 <= b_11_y_net_x1;
  ctrl_bits_x3 <= b_1_y_net_x3;
  ctrl_bits_x4 <= b_3_y_net_x1;
  ctrl_bits_x5 <= b_4_y_net_x2;
  ctrl_bits_x6 <= b_5_y_net_x2;
  ctrl_bits_x7 <= b_6_y_net_x2;
  ctrl_bits_x8 <= b_7_y_net_x1;
  ctrl_bits_x9 <= b_8_y_net_x1;
  posedge3 <= logical1_y_net_x6;
  reg_autotx_dly <= concat1_y_net_x9;
  reg_autotx_param_en <= register24_q_net_x3;
  reg_autotx_param_pktbuf <= register22_q_net_x1;
  reg_autotx_param_txantmask <= b_23_20_y_net_x0;
  reg_autotx_param_txgain_a <= register58_q_net_x1;
  reg_autotx_param_txgain_b <= register59_q_net_x1;
  reg_autotx_param_txgain_c <= register60_q_net_x1;
  reg_autotx_param_txgain_d <= register61_q_net_x1;
  reg_backoff_sw_numslots <= register20_q_net_x1;
  reg_backoff_sw_start <= register21_q_net_x1;
  reg_calibtime_txdifs <= concat1_y_net_x11;
  reg_interval_ack_timeout <= concat1_y_net_x7;
  reg_interval_difs <= concat1_y_net_x6;
  reg_interval_eifs <= concat1_y_net_x10;
  reg_interval_slot <= concat1_y_net_x8;
  reg_nav_time_adj <= reinterpret_output_port_net_x2;
  reg_set_timestamp_lsb <= register28_q_net_x1;
  reg_set_timestamp_msb <= register27_q_net_x1;
  reg_tx_param_bo_slots <= register17_q_net_x1;
  reg_tx_param_pktbuf <= register16_q_net_x1;
  reg_tx_param_start_timeout <= register18_q_net_x1;
  reg_tx_param_txantmask <= register25_q_net_x1;
  reg_tx_param_txgain_a <= register19_q_net_x1;
  reg_tx_param_txgain_b <= register53_q_net_x1;
  reg_tx_param_txgain_c <= register56_q_net_x1;
  reg_tx_param_txgain_d <= register57_q_net_x1;
  reg_tx_start <= register35_q_net_x2;
  register15_x0 <= register15_q_net_x0;
  register26_x0 <= register26_q_net_x0;
  register55_x0 <= register55_q_net_x0;
  x32lsb1_x0 <= x32lsb1_y_net_x0;
  x32lsb2_x0 <= x32lsb2_y_net_x0;
  x32lsb_x1 <= x32lsb_y_net_x1;
  x32msb1_x0 <= x32msb1_y_net_x0;
  x32msb2_x0 <= x32msb2_y_net_x0;
  x32msb_x1 <= x32msb_y_net_x1;

  addsub: entity work.xladdsub_wlan_mac_dcf_hw
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 0,
      a_width => 64,
      b_arith => xlSigned,
      b_bin_pt => 0,
      b_width => 32,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 66,
      core_name0 => "addsb_11_0_3c1d0ac9b6b8f403",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 66,
      latency => 1,
      overflow => 1,
      quantization => 1,
      s_arith => xlUnsigned,
      s_bin_pt => 0,
      s_width => 64
    )
    port map (
      a => register52_q_net,
      b => register63_q_net,
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      clr => '0',
      en => "1",
      s => addsub_s_net
    );

  b_0_2: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 0,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => from_register4_data_out_net_x0,
      y(0) => b_0_2_y_net
    );

  b_11_6: entity work.xlslice
    generic map (
      new_lsb => 6,
      new_msb => 11,
      x_width => 32,
      y_width => 6
    )
    port map (
      x => from_register7_data_out_net_x0,
      y => b_11_6_y_net
    );

  b_11_6_1: entity work.xlslice
    generic map (
      new_lsb => 6,
      new_msb => 11,
      x_width => 32,
      y_width => 6
    )
    port map (
      x => from_register12_data_out_net_x0,
      y => b_11_6_1_y_net
    );

  b_13_4: entity work.xlslice
    generic map (
      new_lsb => 4,
      new_msb => 13,
      x_width => 32,
      y_width => 10
    )
    port map (
      x => from_register9_data_out_net_x0,
      y => b_13_4_y_net
    );

  b_15_0: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 15,
      x_width => 32,
      y_width => 16
    )
    port map (
      x => from_register6_data_out_net_x0,
      y => b_15_0_y_net
    );

  b_15_0_2: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 15,
      x_width => 32,
      y_width => 16
    )
    port map (
      x => from_register1_data_out_net_x0,
      y => b_15_0_2_y_net
    );

  b_17_12: entity work.xlslice
    generic map (
      new_lsb => 12,
      new_msb => 17,
      x_width => 32,
      y_width => 6
    )
    port map (
      x => from_register7_data_out_net_x0,
      y => b_17_12_y_net
    );

  b_17_12_1: entity work.xlslice
    generic map (
      new_lsb => 12,
      new_msb => 17,
      x_width => 32,
      y_width => 6
    )
    port map (
      x => from_register12_data_out_net_x0,
      y => b_17_12_1_y_net
    );

  b_23_18: entity work.xlslice
    generic map (
      new_lsb => 18,
      new_msb => 23,
      x_width => 32,
      y_width => 6
    )
    port map (
      x => from_register7_data_out_net_x0,
      y => b_23_18_y_net
    );

  b_23_18_1: entity work.xlslice
    generic map (
      new_lsb => 18,
      new_msb => 23,
      x_width => 32,
      y_width => 6
    )
    port map (
      x => from_register12_data_out_net_x0,
      y => b_23_18_1_y_net
    );

  b_23_20: entity work.xlslice
    generic map (
      new_lsb => 20,
      new_msb => 23,
      x_width => 32,
      y_width => 4
    )
    port map (
      x => from_register9_data_out_net_x0,
      y => b_23_20_y_net_x0
    );

  b_23_8: entity work.xlslice
    generic map (
      new_lsb => 8,
      new_msb => 23,
      x_width => 32,
      y_width => 16
    )
    port map (
      x => from_register3_data_out_net_x0,
      y => b_23_8_y_net
    );

  b_24: entity work.xlslice
    generic map (
      new_lsb => 24,
      new_msb => 24,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => from_register3_data_out_net_x0,
      y(0) => b_24_y_net
    );

  b_29_20: entity work.xlslice
    generic map (
      new_lsb => 20,
      new_msb => 29,
      x_width => 32,
      y_width => 10
    )
    port map (
      x => from_register5_data_out_net_x0,
      y => b_29_20_y_net
    );

  b_31: entity work.xlslice
    generic map (
      new_lsb => 31,
      new_msb => 31,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => from_register1_data_out_net_x0,
      y(0) => b_31_y_net
    );

  b_31_1: entity work.xlslice
    generic map (
      new_lsb => 31,
      new_msb => 31,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => from_register9_data_out_net_x0,
      y(0) => b_31_1_y_net
    );

  b_31_16: entity work.xlslice
    generic map (
      new_lsb => 16,
      new_msb => 31,
      x_width => 32,
      y_width => 16
    )
    port map (
      x => from_register6_data_out_net_x0,
      y => b_31_16_y_net
    );

  b_31_24: entity work.xlslice
    generic map (
      new_lsb => 24,
      new_msb => 31,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register8_data_out_net_x0,
      y => b_31_24_y_net
    );

  b_3_0: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 3,
      x_width => 32,
      y_width => 4
    )
    port map (
      x => from_register9_data_out_net_x0,
      y => b_3_0_y_net
    );

  b_3_0_1: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 3,
      x_width => 32,
      y_width => 4
    )
    port map (
      x => from_register3_data_out_net_x0,
      y => b_3_0_1_y_net
    );

  b_5_0: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 5,
      x_width => 32,
      y_width => 6
    )
    port map (
      x => from_register7_data_out_net_x0,
      y => b_5_0_y_net
    );

  b_5_0_1: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 5,
      x_width => 32,
      y_width => 6
    )
    port map (
      x => from_register12_data_out_net_x0,
      y => b_5_0_1_y_net
    );

  b_7_4: entity work.xlslice
    generic map (
      new_lsb => 4,
      new_msb => 7,
      x_width => 32,
      y_width => 4
    )
    port map (
      x => from_register3_data_out_net_x0,
      y => b_7_4_y_net
    );

  b_9_0: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 9,
      x_width => 32,
      y_width => 10
    )
    port map (
      x => from_register5_data_out_net_x0,
      y => b_9_0_y_net
    );

  b_9_0_1: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 9,
      x_width => 32,
      y_width => 10
    )
    port map (
      x => from_register8_data_out_net_x0,
      y => b_9_0_1_y_net
    );

  concat: entity work.concat_2119b6f9e7
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => register37_q_net,
      in1(0) => register38_q_net,
      in10(0) => register47_q_net,
      in11(0) => register48_q_net,
      in12 => register49_q_net,
      in2(0) => register39_q_net,
      in3(0) => register40_q_net,
      in4(0) => register41_q_net,
      in5(0) => register42_q_net,
      in6 => register43_q_net,
      in7 => register44_q_net,
      in8(0) => register45_q_net,
      in9(0) => register46_q_net,
      y => concat_y_net
    );

  concat1: entity work.concat_d5964bfb65
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => register4_q_net,
      in1 => register2_q_net,
      y => concat1_y_net
    );

  concat2: entity work.concat_ca4e0802c4
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => register9_q_net,
      in1 => convert4_dout_net,
      in2 => convert3_dout_net,
      y => concat2_y_net
    );

  constant1: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant1_op_net_x0
    );

  constant2: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant2_op_net_x0
    );

  constant3: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant3_op_net_x0
    );

  constant5: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant5_op_net_x0
    );

  constant6: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant6_op_net_x0
    );

  convert: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 22,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      clr => '0',
      din => register10_q_net,
      en => "1",
      dout => convert_dout_net_x0
    );

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 31,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      clr => '0',
      din => register_q_net,
      en => "1",
      dout => convert1_dout_net_x0
    );

  convert2: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 25,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      clr => '0',
      din => concat2_y_net,
      en => "1",
      dout => convert2_dout_net_x0
    );

  convert3: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 12,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 16,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      clr => '0',
      din => register6_q_net,
      en => "1",
      dout => convert3_dout_net
    );

  convert4: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 4,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 8,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      clr => '0',
      din => register7_q_net,
      en => "1",
      dout => convert4_dout_net
    );

  convert5: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      clr => '0',
      din(0) => logical1_y_net_x1,
      en => "1",
      dout(0) => convert5_dout_net_x0
    );

  convert6: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 16,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      clr => '0',
      din => register12_q_net,
      en => "1",
      dout => convert6_dout_net_x0
    );

  convert7: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      clr => '0',
      din(0) => convert1_dout_net_x2,
      en => "1",
      dout(0) => convert7_dout_net_x0
    );

  ctrl_bits_9618005c67: entity work.ctrl_bits_entity_9618005c67
    port map (
      ce_1 => ce_1_sg_x43,
      clk_1 => clk_1_sg_x43,
      x32b => register36_q_net_x0,
      reg_block_rx_clear => logical1_y_net_x5,
      reg_block_rx_on_fcs_good => b_1_y_net_x3,
      reg_block_rx_on_tx => b_4_y_net_x2,
      reg_block_rx_on_valid_rxend => b_6_y_net_x2,
      reg_cca_ignore_nav => b_9_y_net_x1,
      reg_cca_ignore_phy_cs => b_7_y_net_x1,
      reg_cca_ignore_txbusy => b_8_y_net_x1,
      reg_disable_nav => b_3_y_net_x1,
      reg_force_reset_backoff => b_11_y_net_x1,
      reg_force_reset_nav => b_10_y_net_x1,
      reg_global_reset => b_0_y_net_x0,
      reg_update_timestamp => b_5_y_net_x2
    );

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => register15_q_net_x0,
      en => '1',
      rst => '1',
      q(0) => delay_q_net
    );

  posedge1_148ea59f6d: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x43,
      clk_1 => clk_1_sg_x43,
      d => convert7_dout_net_x0,
      q => logical1_y_net_x0
    );

  posedge2_d04626c357: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x43,
      clk_1 => clk_1_sg_x43,
      d => phy_rx_start_ind_net_x7,
      q => logical1_y_net_x1
    );

  posedge3_1a30b43e99: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x43,
      clk_1 => clk_1_sg_x43,
      d => register8_q_net_x0,
      q => logical1_y_net_x6
    );

  register1: entity work.xlregister
    generic map (
      d_width => 64,
      init_value => b"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => register50_q_net,
      en => "1",
      rst => "0",
      q => register1_q_net
    );

  register10: entity work.xlregister
    generic map (
      d_width => 22,
      init_value => b"0000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => concat1_y_net,
      en(0) => register5_q_net,
      rst(0) => phy_rx_start_ind_net_x7,
      q => register10_q_net
    );

  register11: entity work.xlregister
    generic map (
      d_width => 64,
      init_value => b"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => register51_q_net,
      en => "1",
      rst => "0",
      q => register11_q_net
    );

  register12: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => register13_q_net,
      en => "1",
      rst => "0",
      q => register12_q_net
    );

  register13: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => bitsm_4_y_net_x1,
      en => "1",
      rst => "0",
      q => register13_q_net
    );

  register14: entity work.xlregister
    generic map (
      d_width => 64,
      init_value => b"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => register52_q_net,
      en => "1",
      rst => "0",
      q => register14_q_net
    );

  register15: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => logical1_y_net_x0,
      en => "1",
      rst => "0",
      q(0) => register15_q_net_x0
    );

  register16: entity work.xlregister
    generic map (
      d_width => 4,
      init_value => b"0000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_3_0_1_y_net,
      en => "1",
      rst => "0",
      q => register16_q_net_x1
    );

  register17: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_23_8_y_net,
      en => "1",
      rst => "0",
      q => register17_q_net_x1
    );

  register18: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => b_24_y_net,
      en => "1",
      rst => "0",
      q(0) => register18_q_net_x1
    );

  register19: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_5_0_y_net,
      en => "1",
      rst => "0",
      q => register19_q_net_x1
    );

  register2: entity work.xlregister
    generic map (
      d_width => 14,
      init_value => b"00000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => phy_rx_data_bytenum_net_x3,
      en => "1",
      rst => "0",
      q => register2_q_net
    );

  register20: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_15_0_2_y_net,
      en => "1",
      rst => "0",
      q => register20_q_net_x1
    );

  register21: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => b_31_y_net,
      en => "1",
      rst => "0",
      q(0) => register21_q_net_x1
    );

  register22: entity work.xlregister
    generic map (
      d_width => 4,
      init_value => b"0000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_3_0_y_net,
      en => "1",
      rst => "0",
      q => register22_q_net_x1
    );

  register23: entity work.xlregister
    generic map (
      d_width => 10,
      init_value => b"0000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_13_4_y_net,
      en => "1",
      rst => "0",
      q => register23_q_net_x0
    );

  register24: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => b_31_1_y_net,
      en => "1",
      rst => "0",
      q(0) => register24_q_net_x3
    );

  register25: entity work.xlregister
    generic map (
      d_width => 4,
      init_value => b"0000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_7_4_y_net,
      en => "1",
      rst => "0",
      q => register25_q_net_x1
    );

  register26: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => x32msb_y_net_x0,
      en => "1",
      rst => "0",
      q => register26_q_net_x0
    );

  register27: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => from_register10_data_out_net_x0,
      en => "1",
      rst => "0",
      q => register27_q_net_x1
    );

  register28: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => from_register11_data_out_net_x0,
      en => "1",
      rst => "0",
      q => register28_q_net_x1
    );

  register29: entity work.xlregister
    generic map (
      d_width => 10,
      init_value => b"0000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_9_0_1_y_net,
      en => "1",
      rst => "0",
      q => register29_q_net_x0
    );

  register30: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_31_24_y_net,
      en => "1",
      rst => "0",
      q => register30_q_net
    );

  register31: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_31_16_y_net,
      en => "1",
      rst => "0",
      q => register31_q_net_x0
    );

  register32: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_15_0_y_net,
      en => "1",
      rst => "0",
      q => register32_q_net_x0
    );

  register33: entity work.xlregister
    generic map (
      d_width => 10,
      init_value => b"0000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_29_20_y_net,
      en => "1",
      rst => "0",
      q => register33_q_net_x0
    );

  register34: entity work.xlregister
    generic map (
      d_width => 10,
      init_value => b"0000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_9_0_y_net,
      en => "1",
      rst => "0",
      q => register34_q_net_x0
    );

  register35: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => b_0_2_y_net,
      en => "1",
      rst => "0",
      q(0) => register35_q_net_x2
    );

  register36: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => from_register2_data_out_net_x0,
      en => "1",
      rst => "0",
      q => register36_q_net_x0
    );

  register37: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => register2_q_net_x16,
      en => "1",
      rst => "0",
      q(0) => register37_q_net
    );

  register38: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => register2_q_net_x15,
      en => "1",
      rst => "0",
      q(0) => register38_q_net
    );

  register39: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => register3_q_net_x4,
      en => "1",
      rst => "0",
      q(0) => register39_q_net
    );

  register4: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => phy_rx_data_byte_net_x3,
      en => "1",
      rst => "0",
      q => register4_q_net
    );

  register40: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => logical5_y_net_x1,
      en => "1",
      rst => "0",
      q(0) => register40_q_net
    );

  register41: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => phy_cca_ind_busy_net_x1,
      en => "1",
      rst => "0",
      q(0) => register41_q_net
    );

  register42: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => logical3_y_net_x3,
      en => "1",
      rst => "0",
      q(0) => register42_q_net
    );

  register43: entity work.xlregister
    generic map (
      d_width => 3,
      init_value => b"000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => mcode_fsm_state_out_net_x1,
      en => "1",
      rst => "0",
      q => register43_q_net
    );

  register44: entity work.xlregister
    generic map (
      d_width => 2,
      init_value => b"00"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => register1_q_net_x1,
      en => "1",
      rst => "0",
      q => register44_q_net
    );

  register45: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => delay_q_net_x1,
      en => "1",
      rst => "0",
      q(0) => register45_q_net
    );

  register46: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => register2_q_net_x17,
      en => "1",
      rst => "0",
      q(0) => register46_q_net
    );

  register47: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => register2_q_net_x13,
      en => "1",
      rst => "0",
      q(0) => register47_q_net
    );

  register48: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => register2_q_net_x5,
      en => "1",
      rst => "0",
      q(0) => register48_q_net
    );

  register49: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => num_slots_op_net_x1,
      en => "1",
      rst => "0",
      q => register49_q_net
    );

  register5: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => phy_rx_data_ind_net_x3,
      en => "1",
      rst => "0",
      q(0) => register5_q_net
    );

  register50: entity work.xlregister
    generic map (
      d_width => 64,
      init_value => b"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => microsecond_counter_op_net_x1,
      en => "1",
      rst => "0",
      q => register50_q_net
    );

  register51: entity work.xlregister
    generic map (
      d_width => 64,
      init_value => b"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => microsecond_counter_op_net_x1,
      en => "1",
      rst => "0",
      q => register51_q_net
    );

  register52: entity work.xlregister
    generic map (
      d_width => 64,
      init_value => b"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => microsecond_counter_op_net_x1,
      en => "1",
      rst => "0",
      q => register52_q_net
    );

  register53: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_11_6_y_net,
      en => "1",
      rst => "0",
      q => register53_q_net_x1
    );

  register54: entity work.xlregister
    generic map (
      d_width => 64,
      init_value => b"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => addsub_s_net,
      en(0) => delay_q_net,
      rst => "0",
      q => register54_q_net
    );

  register55: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => x32lsb_y_net_x0,
      en => "1",
      rst => "0",
      q => register55_q_net_x0
    );

  register56: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_17_12_y_net,
      en => "1",
      rst => "0",
      q => register56_q_net_x1
    );

  register57: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_23_18_y_net,
      en => "1",
      rst => "0",
      q => register57_q_net_x1
    );

  register58: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_5_0_1_y_net,
      en => "1",
      rst => "0",
      q => register58_q_net_x1
    );

  register59: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_11_6_1_y_net,
      en => "1",
      rst => "0",
      q => register59_q_net_x1
    );

  register6: entity work.xlregister
    generic map (
      d_width => 12,
      init_value => b"000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => phy_rx_start_sig_length_net_x0,
      en => "1",
      rst => "0",
      q => register6_q_net
    );

  register60: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_17_12_1_y_net,
      en => "1",
      rst => "0",
      q => register60_q_net_x1
    );

  register61: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => b_23_18_1_y_net,
      en => "1",
      rst => "0",
      q => register61_q_net_x1
    );

  register62: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => from_register13_data_out_net_x0,
      en => "1",
      rst => "0",
      q => register62_q_net
    );

  register63: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => register62_q_net,
      en => "1",
      rst => "0",
      q => register63_q_net
    );

  register7: entity work.xlregister
    generic map (
      d_width => 4,
      init_value => b"0000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => phy_rx_start_sig_rate_net_x0,
      en => "1",
      rst => "0",
      q => register7_q_net
    );

  register8: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => phy_rx_start_ind_net_x7,
      en => "1",
      rst => "0",
      q(0) => register8_q_net_x0
    );

  register9: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d(0) => phy_rx_start_phy_sel_net_x0,
      en => "1",
      rst => "0",
      q(0) => register9_q_net
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 31,
      init_value => b"0000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x43,
      clk => clk_1_sg_x43,
      d => concat_y_net,
      en => "1",
      rst => "0",
      q => register_q_net
    );

  reinterpret: entity work.reinterpret_4389dc89bf
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register30_q_net,
      output_port => reinterpret_output_port_net_x2
    );

  x16_444d47662b: entity work.x16_entity_444d47662b
    port map (
      a => register31_q_net_x0,
      ax16 => concat1_y_net_x7
    );

  x1_588dcb8437: entity work.x1_entity_588dcb8437
    port map (
      a => register33_q_net_x0,
      ax16 => concat1_y_net_x6
    );

  x32lsb: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 31,
      x_width => 64,
      y_width => 32
    )
    port map (
      x => register1_q_net,
      y => x32lsb_y_net_x1
    );

  x32lsb1: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 31,
      x_width => 64,
      y_width => 32
    )
    port map (
      x => register11_q_net,
      y => x32lsb1_y_net_x0
    );

  x32lsb2: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 31,
      x_width => 64,
      y_width => 32
    )
    port map (
      x => register14_q_net,
      y => x32lsb2_y_net_x0
    );

  x32lsb_x0: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 31,
      x_width => 64,
      y_width => 32
    )
    port map (
      x => register54_q_net,
      y => x32lsb_y_net_x0
    );

  x32msb: entity work.xlslice
    generic map (
      new_lsb => 32,
      new_msb => 63,
      x_width => 64,
      y_width => 32
    )
    port map (
      x => register1_q_net,
      y => x32msb_y_net_x1
    );

  x32msb1: entity work.xlslice
    generic map (
      new_lsb => 32,
      new_msb => 63,
      x_width => 64,
      y_width => 32
    )
    port map (
      x => register11_q_net,
      y => x32msb1_y_net_x0
    );

  x32msb2: entity work.xlslice
    generic map (
      new_lsb => 32,
      new_msb => 63,
      x_width => 64,
      y_width => 32
    )
    port map (
      x => register14_q_net,
      y => x32msb2_y_net_x0
    );

  x32msb_x0: entity work.xlslice
    generic map (
      new_lsb => 32,
      new_msb => 63,
      x_width => 64,
      y_width => 32
    )
    port map (
      x => register54_q_net,
      y => x32msb_y_net_x0
    );

  x3_49f0bfee6c: entity work.x1_entity_588dcb8437
    port map (
      a => register34_q_net_x0,
      ax16 => concat1_y_net_x8
    );

  x4_74e1e33602: entity work.x1_entity_588dcb8437
    port map (
      a => register23_q_net_x0,
      ax16 => concat1_y_net_x9
    );

  x5_341916d868: entity work.x16_entity_444d47662b
    port map (
      a => register32_q_net_x0,
      ax16 => concat1_y_net_x10
    );

  x8_1c5c6d984c: entity work.x1_entity_588dcb8437
    port map (
      a => register29_q_net_x0,
      ax16 => concat1_y_net_x11
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Resets"

entity resets_entity_b44a1b9d26 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    reg_global_reset: in std_logic; 
    global_reset: out std_logic
  );
end resets_entity_b44a1b9d26;

architecture structural of resets_entity_b44a1b9d26 is
  signal b_0_y_net_x1: std_logic;
  signal ce_1_sg_x44: std_logic;
  signal clk_1_sg_x44: std_logic;
  signal convert1_dout_net_x8: std_logic;

begin
  ce_1_sg_x44 <= ce_1;
  clk_1_sg_x44 <= clk_1;
  b_0_y_net_x1 <= reg_global_reset;
  global_reset <= convert1_dout_net_x8;

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x44,
      clk => clk_1_sg_x44,
      clr => '0',
      din(0) => b_0_y_net_x1,
      en => "1",
      dout(0) => convert1_dout_net_x8
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw/Timeout"

entity timeout_entity_9c73eec893 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    global_reset: in std_logic; 
    phy_rx_start_ind: in std_logic; 
    reg_interval_ack_timeout: in std_logic_vector(19 downto 0); 
    tx_ctrl_timeout_start: in std_logic; 
    timeout_done: out std_logic
  );
end timeout_entity_9c73eec893;

architecture structural of timeout_entity_9c73eec893 is
  signal ce_1_sg_x48: std_logic;
  signal clk_1_sg_x48: std_logic;
  signal concat1_y_net_x8: std_logic_vector(19 downto 0);
  signal convert1_dout_net_x9: std_logic;
  signal convert2_dout_net_x2: std_logic;
  signal inverter_op_net: std_logic;
  signal logical1_y_net_x1: std_logic;
  signal logical1_y_net_x5: std_logic;
  signal logical2_y_net: std_logic;
  signal logical3_y_net_x0: std_logic;
  signal phy_rx_start_ind_net_x8: std_logic;
  signal register2_q_net_x0: std_logic;
  signal relational2_op_net_x0: std_logic;
  signal timeout_counter_op_net: std_logic_vector(15 downto 0);

begin
  ce_1_sg_x48 <= ce_1;
  clk_1_sg_x48 <= clk_1;
  convert1_dout_net_x9 <= global_reset;
  phy_rx_start_ind_net_x8 <= phy_rx_start_ind;
  concat1_y_net_x8 <= reg_interval_ack_timeout;
  convert2_dout_net_x2 <= tx_ctrl_timeout_start;
  timeout_done <= logical1_y_net_x5;

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x48,
      clk => clk_1_sg_x48,
      clr => '0',
      ip(0) => register2_q_net_x0,
      op(0) => inverter_op_net
    );

  logical2: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational2_op_net_x0,
      d1(0) => inverter_op_net,
      y(0) => logical2_y_net
    );

  logical3: entity work.logical_6cb8f0ce02
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => phy_rx_start_ind_net_x8,
      d1(0) => convert1_dout_net_x9,
      d2(0) => relational2_op_net_x0,
      y(0) => logical3_y_net_x0
    );

  posedge1_e58a591441: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x48,
      clk_1 => clk_1_sg_x48,
      d => relational2_op_net_x0,
      q => logical1_y_net_x5
    );

  posedge2_8d9d0e443e: entity work.posedge2_entity_3570911e8f
    port map (
      ce_1 => ce_1_sg_x48,
      clk_1 => clk_1_sg_x48,
      d => convert2_dout_net_x2,
      q => logical1_y_net_x1
    );

  relational2: entity work.relational_6fce5fc0e4
    port map (
      a => timeout_counter_op_net,
      b => concat1_y_net_x8,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational2_op_net_x0
    );

  s_r_latch1_8229caa728: entity work.s_r_latch1_entity_370a153267
    port map (
      ce_1 => ce_1_sg_x48,
      clk_1 => clk_1_sg_x48,
      r => logical3_y_net_x0,
      s => logical1_y_net_x1,
      q => register2_q_net_x0
    );

  timeout_counter: entity work.xlcounter_free_wlan_mac_dcf_hw
    generic map (
      core_name0 => "cntr_11_0_6b6e5f4ca8671604",
      op_arith => xlUnsigned,
      op_width => 16
    )
    port map (
      ce => ce_1_sg_x48,
      clk => clk_1_sg_x48,
      clr => '0',
      en(0) => register2_q_net_x0,
      rst(0) => logical2_y_net,
      op => timeout_counter_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_mac_dcf_hw"

entity wlan_mac_dcf_hw is
  port (
    axi_aresetn: in std_logic; 
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    data_out: in std_logic_vector(31 downto 0); 
    data_out_x0: in std_logic_vector(31 downto 0); 
    data_out_x1: in std_logic_vector(31 downto 0); 
    data_out_x10: in std_logic_vector(31 downto 0); 
    data_out_x11: in std_logic_vector(31 downto 0); 
    data_out_x12: in std_logic_vector(31 downto 0); 
    data_out_x13: in std_logic_vector(31 downto 0); 
    data_out_x14: in std_logic_vector(31 downto 0); 
    data_out_x15: in std_logic_vector(31 downto 0); 
    data_out_x16: in std_logic_vector(31 downto 0); 
    data_out_x17: in std_logic_vector(31 downto 0); 
    data_out_x18: in std_logic_vector(31 downto 0); 
    data_out_x19: in std_logic_vector(31 downto 0); 
    data_out_x2: in std_logic_vector(31 downto 0); 
    data_out_x20: in std_logic_vector(31 downto 0); 
    data_out_x21: in std_logic_vector(31 downto 0); 
    data_out_x3: in std_logic_vector(31 downto 0); 
    data_out_x4: in std_logic_vector(31 downto 0); 
    data_out_x5: in std_logic_vector(31 downto 0); 
    data_out_x6: in std_logic_vector(31 downto 0); 
    data_out_x7: in std_logic_vector(31 downto 0); 
    data_out_x8: in std_logic_vector(31 downto 0); 
    data_out_x9: in std_logic_vector(31 downto 0); 
    dout: in std_logic_vector(31 downto 0); 
    dout_x0: in std_logic_vector(31 downto 0); 
    dout_x1: in std_logic_vector(31 downto 0); 
    dout_x10: in std_logic_vector(31 downto 0); 
    dout_x11: in std_logic_vector(31 downto 0); 
    dout_x2: in std_logic_vector(31 downto 0); 
    dout_x3: in std_logic_vector(31 downto 0); 
    dout_x4: in std_logic_vector(31 downto 0); 
    dout_x5: in std_logic_vector(31 downto 0); 
    dout_x6: in std_logic_vector(31 downto 0); 
    dout_x7: in std_logic_vector(31 downto 0); 
    dout_x8: in std_logic_vector(31 downto 0); 
    dout_x9: in std_logic_vector(31 downto 0); 
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
    plb_ce_1: in std_logic; 
    plb_clk_1: in std_logic; 
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
    data_in: out std_logic_vector(31 downto 0); 
    data_in_x0: out std_logic_vector(31 downto 0); 
    data_in_x1: out std_logic_vector(31 downto 0); 
    data_in_x10: out std_logic_vector(31 downto 0); 
    data_in_x11: out std_logic_vector(31 downto 0); 
    data_in_x12: out std_logic_vector(31 downto 0); 
    data_in_x13: out std_logic_vector(31 downto 0); 
    data_in_x14: out std_logic_vector(31 downto 0); 
    data_in_x15: out std_logic_vector(31 downto 0); 
    data_in_x16: out std_logic_vector(31 downto 0); 
    data_in_x17: out std_logic_vector(31 downto 0); 
    data_in_x18: out std_logic_vector(31 downto 0); 
    data_in_x19: out std_logic_vector(31 downto 0); 
    data_in_x2: out std_logic_vector(31 downto 0); 
    data_in_x20: out std_logic_vector(31 downto 0); 
    data_in_x21: out std_logic_vector(31 downto 0); 
    data_in_x3: out std_logic_vector(31 downto 0); 
    data_in_x4: out std_logic_vector(31 downto 0); 
    data_in_x5: out std_logic_vector(31 downto 0); 
    data_in_x6: out std_logic_vector(31 downto 0); 
    data_in_x7: out std_logic_vector(31 downto 0); 
    data_in_x8: out std_logic_vector(31 downto 0); 
    data_in_x9: out std_logic_vector(31 downto 0); 
    dbg_backoff_active: out std_logic; 
    dbg_eifs_sel: out std_logic; 
    dbg_idle_for_difs: out std_logic; 
    dbg_mpdu_tx_pending: out std_logic; 
    dbg_nav_active: out std_logic; 
    en: out std_logic; 
    en_x0: out std_logic; 
    en_x1: out std_logic; 
    en_x10: out std_logic; 
    en_x11: out std_logic; 
    en_x12: out std_logic; 
    en_x13: out std_logic; 
    en_x14: out std_logic; 
    en_x15: out std_logic; 
    en_x16: out std_logic; 
    en_x17: out std_logic; 
    en_x18: out std_logic; 
    en_x19: out std_logic; 
    en_x2: out std_logic; 
    en_x20: out std_logic; 
    en_x21: out std_logic; 
    en_x3: out std_logic; 
    en_x4: out std_logic; 
    en_x5: out std_logic; 
    en_x6: out std_logic; 
    en_x7: out std_logic; 
    en_x8: out std_logic; 
    en_x9: out std_logic; 
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
end wlan_mac_dcf_hw;

architecture structural of wlan_mac_dcf_hw is
  attribute core_generation_info: string;
  attribute core_generation_info of structural : architecture is "wlan_mac_dcf_hw,sysgen_core,{clock_period=10.00000000,clocking=Clock_Enables,sample_periods=1.00000000000 1.00000000000,testbench=0,total_blocks=1037,xilinx_adder_subtracter_block=2,xilinx_arithmetic_relational_operator_block=17,xilinx_bit_slice_extractor_block=49,xilinx_bus_concatenator_block=12,xilinx_bus_multiplexer_block=10,xilinx_chipscope_block=1,xilinx_constant_block_block=37,xilinx_counter_block=9,xilinx_delay_block=24,xilinx_disregard_subsystem_for_generation_block=3,xilinx_edk_core_block=1,xilinx_edk_processor_block=1,xilinx_gateway_in_block=41,xilinx_gateway_out_block=54,xilinx_inverter_block=30,xilinx_logical_block_block=66,xilinx_mcode_block_block=1,xilinx_multiplier_block=1,xilinx_register_block=133,xilinx_shared_memory_based_from_register_block=23,xilinx_shared_memory_based_to_register_block=23,xilinx_system_generator_block=1,xilinx_type_converter_block=15,xilinx_type_reinterpreter_block=1,}";

  signal axi_aresetn_net: std_logic;
  signal b_0_y_net_x1: std_logic;
  signal b_10_y_net_x1: std_logic;
  signal b_11_y_net_x1: std_logic;
  signal b_1_y_net_x3: std_logic;
  signal b_23_20_y_net_x0: std_logic_vector(3 downto 0);
  signal b_3_y_net_x1: std_logic;
  signal b_4_y_net_x2: std_logic;
  signal b_5_y_net_x2: std_logic;
  signal b_6_y_net_x2: std_logic;
  signal b_7_y_net_x1: std_logic;
  signal b_8_y_net_x1: std_logic;
  signal b_9_y_net_x1: std_logic;
  signal bitsm_4_y_net_x1: std_logic_vector(15 downto 0);
  signal ce_1_sg_x49: std_logic;
  signal clk_1_sg_x49: std_logic;
  signal concat1_y_net_x10: std_logic_vector(13 downto 0);
  signal concat1_y_net_x11: std_logic_vector(19 downto 0);
  signal concat1_y_net_x12: std_logic_vector(13 downto 0);
  signal concat1_y_net_x6: std_logic_vector(13 downto 0);
  signal concat1_y_net_x8: std_logic_vector(19 downto 0);
  signal concat1_y_net_x9: std_logic_vector(13 downto 0);
  signal convert1_dout_net_x2: std_logic;
  signal convert1_dout_net_x9: std_logic;
  signal convert2_dout_net_x2: std_logic;
  signal convert5_dout_net_x1: std_logic;
  signal convert_dout_net_x2: std_logic;
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
  signal delay_q_net_x1: std_logic;
  signal dout_net: std_logic_vector(31 downto 0);
  signal dout_x0_net: std_logic_vector(31 downto 0);
  signal dout_x10_net: std_logic_vector(31 downto 0);
  signal dout_x11_net: std_logic_vector(31 downto 0);
  signal dout_x1_net: std_logic_vector(31 downto 0);
  signal dout_x2_net: std_logic_vector(31 downto 0);
  signal dout_x3_net: std_logic_vector(31 downto 0);
  signal dout_x4_net: std_logic_vector(31 downto 0);
  signal dout_x5_net: std_logic_vector(31 downto 0);
  signal dout_x6_net: std_logic_vector(31 downto 0);
  signal dout_x7_net: std_logic_vector(31 downto 0);
  signal dout_x8_net: std_logic_vector(31 downto 0);
  signal dout_x9_net: std_logic_vector(31 downto 0);
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
  signal inverter1_op_net_x1: std_logic;
  signal logical1_y_net_x5: std_logic;
  signal logical1_y_net_x7: std_logic;
  signal logical3_y_net_x3: std_logic;
  signal logical3_y_net_x4: std_logic;
  signal logical5_y_net_x1: std_logic;
  signal logical5_y_net_x2: std_logic;
  signal mcode_fsm_state_out_net_x1: std_logic_vector(2 downto 0);
  signal microsecond_counter_op_net_x1: std_logic_vector(63 downto 0);
  signal num_slots_op_net_x1: std_logic_vector(15 downto 0);
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
  signal plb_clk_1_sg_x1: std_logic;
  signal register10_q_net_x1: std_logic_vector(5 downto 0);
  signal register15_q_net_x1: std_logic;
  signal register16_q_net_x1: std_logic_vector(3 downto 0);
  signal register17_q_net_x1: std_logic_vector(15 downto 0);
  signal register18_q_net_x1: std_logic;
  signal register19_q_net_x1: std_logic_vector(5 downto 0);
  signal register1_q_net_x1: std_logic;
  signal register1_q_net_x3: std_logic_vector(1 downto 0);
  signal register20_q_net_x1: std_logic_vector(15 downto 0);
  signal register21_q_net_x1: std_logic;
  signal register22_q_net_x1: std_logic_vector(3 downto 0);
  signal register24_q_net_x3: std_logic;
  signal register25_q_net_x1: std_logic_vector(3 downto 0);
  signal register27_q_net_x1: std_logic_vector(31 downto 0);
  signal register28_q_net_x1: std_logic_vector(31 downto 0);
  signal register2_q_net_x13: std_logic;
  signal register2_q_net_x15: std_logic;
  signal register2_q_net_x16: std_logic;
  signal register2_q_net_x18: std_logic;
  signal register2_q_net_x5: std_logic;
  signal register2_q_net_x8: std_logic_vector(3 downto 0);
  signal register2_q_net_x9: std_logic_vector(3 downto 0);
  signal register35_q_net_x2: std_logic;
  signal register3_q_net_x2: std_logic_vector(5 downto 0);
  signal register3_q_net_x3: std_logic_vector(15 downto 0);
  signal register3_q_net_x4: std_logic;
  signal register4_q_net_x1: std_logic_vector(3 downto 0);
  signal register53_q_net_x1: std_logic_vector(5 downto 0);
  signal register56_q_net_x1: std_logic_vector(5 downto 0);
  signal register57_q_net_x1: std_logic_vector(5 downto 0);
  signal register58_q_net_x1: std_logic_vector(5 downto 0);
  signal register59_q_net_x1: std_logic_vector(5 downto 0);
  signal register5_q_net_x1: std_logic_vector(5 downto 0);
  signal register60_q_net_x1: std_logic_vector(5 downto 0);
  signal register61_q_net_x1: std_logic_vector(5 downto 0);
  signal register6_q_net_x2: std_logic_vector(5 downto 0);
  signal register6_q_net_x3: std_logic_vector(5 downto 0);
  signal register7_q_net_x2: std_logic_vector(5 downto 0);
  signal register7_q_net_x3: std_logic_vector(3 downto 0);
  signal register8_q_net_x1: std_logic_vector(5 downto 0);
  signal register9_q_net_x1: std_logic_vector(5 downto 0);
  signal reinterpret_output_port_net_x2: std_logic_vector(7 downto 0);
  signal relational1_op_net_x5: std_logic;
  signal relational3_op_net_x1: std_logic;
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
  ce_1_sg_x49 <= ce_1;
  clk_1_sg_x49 <= clk_1;
  data_out_net <= data_out;
  data_out_x0_net <= data_out_x0;
  data_out_x1_net <= data_out_x1;
  data_out_x10_net <= data_out_x10;
  data_out_x11_net <= data_out_x11;
  data_out_x12_net <= data_out_x12;
  data_out_x13_net <= data_out_x13;
  data_out_x14_net <= data_out_x14;
  data_out_x15_net <= data_out_x15;
  data_out_x16_net <= data_out_x16;
  data_out_x17_net <= data_out_x17;
  data_out_x18_net <= data_out_x18;
  data_out_x19_net <= data_out_x19;
  data_out_x2_net <= data_out_x2;
  data_out_x20_net <= data_out_x20;
  data_out_x21_net <= data_out_x21;
  data_out_x3_net <= data_out_x3;
  data_out_x4_net <= data_out_x4;
  data_out_x5_net <= data_out_x5;
  data_out_x6_net <= data_out_x6;
  data_out_x7_net <= data_out_x7;
  data_out_x8_net <= data_out_x8;
  data_out_x9_net <= data_out_x9;
  dout_net <= dout;
  dout_x0_net <= dout_x0;
  dout_x1_net <= dout_x1;
  dout_x10_net <= dout_x10;
  dout_x11_net <= dout_x11;
  dout_x2_net <= dout_x2;
  dout_x3_net <= dout_x3;
  dout_x4_net <= dout_x4;
  dout_x5_net <= dout_x5;
  dout_x6_net <= dout_x6;
  dout_x7_net <= dout_x7;
  dout_x8_net <= dout_x8;
  dout_x9_net <= dout_x9;
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
  plb_ce_1_sg_x1 <= plb_ce_1;
  plb_clk_1_sg_x1 <= plb_clk_1;
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
  data_in <= data_in_net;
  data_in_x0 <= data_in_x0_net;
  data_in_x1 <= data_in_x1_net;
  data_in_x10 <= data_in_x10_net;
  data_in_x11 <= data_in_x11_net;
  data_in_x12 <= data_in_x12_net;
  data_in_x13 <= data_in_x13_net;
  data_in_x14 <= data_in_x14_net;
  data_in_x15 <= data_in_x15_net;
  data_in_x16 <= data_in_x16_net;
  data_in_x17 <= data_in_x17_net;
  data_in_x18 <= data_in_x18_net;
  data_in_x19 <= data_in_x19_net;
  data_in_x2 <= data_in_x2_net;
  data_in_x20 <= data_in_x20_net;
  data_in_x21 <= data_in_x21_net;
  data_in_x3 <= data_in_x3_net;
  data_in_x4 <= data_in_x4_net;
  data_in_x5 <= data_in_x5_net;
  data_in_x6 <= data_in_x6_net;
  data_in_x7 <= data_in_x7_net;
  data_in_x8 <= data_in_x8_net;
  data_in_x9 <= data_in_x9_net;
  dbg_backoff_active <= dbg_backoff_active_net;
  dbg_eifs_sel <= dbg_eifs_sel_net;
  dbg_idle_for_difs <= dbg_idle_for_difs_net;
  dbg_mpdu_tx_pending <= dbg_mpdu_tx_pending_net;
  dbg_nav_active <= dbg_nav_active_net;
  en <= en_net;
  en_x0 <= en_x0_net;
  en_x1 <= en_x1_net;
  en_x10 <= en_x10_net;
  en_x11 <= en_x11_net;
  en_x12 <= en_x12_net;
  en_x13 <= en_x13_net;
  en_x14 <= en_x14_net;
  en_x15 <= en_x15_net;
  en_x16 <= en_x16_net;
  en_x17 <= convert5_dout_net_x1;
  en_x18 <= convert5_dout_net_x1;
  en_x19 <= en_x19_net;
  en_x2 <= en_x2_net;
  en_x20 <= register15_q_net_x1;
  en_x21 <= register15_q_net_x1;
  en_x3 <= en_x3_net;
  en_x4 <= en_x4_net;
  en_x5 <= en_x5_net;
  en_x6 <= en_x6_net;
  en_x7 <= en_x7_net;
  en_x8 <= en_x8_net;
  en_x9 <= en_x9_net;
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

  auto_tx_control_a58b23c486: entity work.auto_tx_control_entity_a58b23c486
    port map (
      ce_1 => ce_1_sg_x49,
      clk_1 => clk_1_sg_x49,
      global_reset => convert1_dout_net_x9,
      phy_rx_end_ind => phy_rx_end_ind_net,
      phy_rx_end_rxerror => phy_rx_end_rxerror_net,
      phy_rx_fcs_good_ind => phy_rx_fcs_good_ind_net,
      reg_autotx_dly => concat1_y_net_x10,
      reg_autotx_param_en => register24_q_net_x3,
      reg_autotx_param_pktbuf => register22_q_net_x1,
      reg_autotx_param_txantmask => b_23_20_y_net_x0,
      reg_autotx_param_txgain_a => register58_q_net_x1,
      reg_autotx_param_txgain_b => register59_q_net_x1,
      reg_autotx_param_txgain_c => register60_q_net_x1,
      reg_autotx_param_txgain_d => register61_q_net_x1,
      auto_tx_antmask => register4_q_net_x1,
      auto_tx_gain_a => register3_q_net_x2,
      auto_tx_gain_b => register5_q_net_x1,
      auto_tx_gain_c => register6_q_net_x2,
      auto_tx_gain_d => register7_q_net_x2,
      auto_tx_phy_start => register1_q_net_x1,
      auto_tx_pktbuf => register2_q_net_x8,
      status_autotx_pending => logical5_y_net_x1
    );

  backoff_41de546108: entity work.backoff_entity_41de546108
    port map (
      ce_1 => ce_1_sg_x49,
      clk_1 => clk_1_sg_x49,
      concat1 => concat1_y_net_x9,
      global_reset => convert1_dout_net_x9,
      idle_for_txdifs => relational1_op_net_x5,
      pre_tx_num_bo_slots => register3_q_net_x3,
      reg_backoff_sw_numslots => register20_q_net_x1,
      reg_backoff_sw_start => register21_q_net_x1,
      reg_force_reset_backoff => b_11_y_net_x1,
      tx_ctrl_backoff_start => convert_dout_net_x2,
      backoff_done => logical5_y_net_x2,
      register1_x0 => dbg_backoff_active_net,
      status_current_backoff_count => num_slots_op_net_x1
    );

  cca_7905b301dd: entity work.cca_entity_7905b301dd
    port map (
      ce_1 => ce_1_sg_x49,
      clk_1 => clk_1_sg_x49,
      mac_nav_busy => logical3_y_net_x4,
      phy_cca_ind_busy => phy_cca_ind_busy_net,
      reg_cca_ignore_nav => b_9_y_net_x1,
      reg_cca_ignore_phy_cs => b_7_y_net_x1,
      reg_cca_ignore_txbusy => b_8_y_net_x1,
      status_tx_phy_active => register2_q_net_x18,
      cs_busy => logical3_y_net_x3,
      cs_idle => inverter1_op_net_x1
    );

  edk_processor_0a2b1c2e20: entity work.edk_processor_entity_0a2b1c2e20
    port map (
      axi_aresetn => axi_aresetn_net,
      from_register => data_out_net,
      from_register1 => data_out_x0_net,
      from_register2 => data_out_x1_net,
      from_register3 => data_out_x2_net,
      from_register4 => data_out_x3_net,
      from_register5 => data_out_x4_net,
      from_register6 => data_out_x5_net,
      from_register7 => data_out_x6_net,
      from_register8 => data_out_x7_net,
      from_register9 => data_out_x8_net,
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
      to_register => dout_net,
      to_register1 => dout_x0_net,
      to_register10 => dout_x1_net,
      to_register11 => dout_x2_net,
      to_register12 => dout_x3_net,
      to_register2 => dout_x4_net,
      to_register3 => dout_x5_net,
      to_register4 => dout_x6_net,
      to_register5 => dout_x7_net,
      to_register6 => dout_x8_net,
      to_register7 => dout_x9_net,
      to_register8 => dout_x10_net,
      to_register9 => dout_x11_net,
      memmap_x0 => s_axi_arready_net,
      memmap_x1 => s_axi_awready_net,
      memmap_x10 => s_axi_wready_net,
      memmap_x11 => data_in_net,
      memmap_x12 => en_net,
      memmap_x13 => data_in_x0_net,
      memmap_x14 => en_x0_net,
      memmap_x15 => data_in_x4_net,
      memmap_x16 => en_x4_net,
      memmap_x17 => data_in_x5_net,
      memmap_x18 => en_x5_net,
      memmap_x19 => data_in_x6_net,
      memmap_x2 => s_axi_bid_net,
      memmap_x20 => en_x6_net,
      memmap_x21 => data_in_x7_net,
      memmap_x22 => en_x7_net,
      memmap_x23 => data_in_x8_net,
      memmap_x24 => en_x8_net,
      memmap_x25 => data_in_x9_net,
      memmap_x26 => en_x9_net,
      memmap_x27 => data_in_x10_net,
      memmap_x28 => en_x10_net,
      memmap_x29 => data_in_x11_net,
      memmap_x3 => s_axi_bresp_net,
      memmap_x30 => en_x11_net,
      memmap_x31 => data_in_x1_net,
      memmap_x32 => en_x1_net,
      memmap_x33 => data_in_x2_net,
      memmap_x34 => en_x2_net,
      memmap_x35 => data_in_x3_net,
      memmap_x36 => en_x3_net,
      memmap_x4 => s_axi_bvalid_net,
      memmap_x5 => s_axi_rdata_net,
      memmap_x6 => s_axi_rid_net,
      memmap_x7 => s_axi_rlast_net,
      memmap_x8 => s_axi_rresp_net,
      memmap_x9 => s_axi_rvalid_net
    );

  idle_for_difs_eifs_dda54731cc: entity work.idle_for_difs_eifs_entity_dda54731cc
    port map (
      ce_1 => ce_1_sg_x49,
      clk_1 => clk_1_sg_x49,
      global_reset => convert1_dout_net_x9,
      medium_busy => logical3_y_net_x3,
      medium_idle => inverter1_op_net_x1,
      phy_rx_end_ind => phy_rx_end_ind_net,
      phy_rx_end_rxerror => phy_rx_end_rxerror_net,
      phy_rx_fcs_good_ind => phy_rx_fcs_good_ind_net,
      reg_calibtime_txdifs => concat1_y_net_x12,
      reg_interval_difs => concat1_y_net_x6,
      reg_interval_eifs => concat1_y_net_x11,
      idle_for_difs => relational3_op_net_x1,
      idle_for_txdifs => relational1_op_net_x5,
      register1_x0 => dbg_idle_for_difs_net,
      register3_x0 => dbg_eifs_sel_net
    );

  mpdu_tx_control_dc4ada287c: entity work.mpdu_tx_control_entity_dc4ada287c
    port map (
      backoff_done => logical5_y_net_x2,
      ce_1 => ce_1_sg_x49,
      clk_1 => clk_1_sg_x49,
      global_reset => convert1_dout_net_x9,
      idle_for_difs => relational3_op_net_x1,
      phy_rx_start_ind => phy_rx_start_ind_net,
      phy_tx_end_confirm => phy_tx_done_net,
      reg_tx_param_bo_slots => register17_q_net_x1,
      reg_tx_param_pktbuf => register16_q_net_x1,
      reg_tx_param_start_timeout => register18_q_net_x1,
      reg_tx_param_txantmask => register25_q_net_x1,
      reg_tx_param_txgain_a => register19_q_net_x1,
      reg_tx_param_txgain_b => register53_q_net_x1,
      reg_tx_param_txgain_c => register56_q_net_x1,
      reg_tx_param_txgain_d => register57_q_net_x1,
      reg_tx_start => register35_q_net_x2,
      timeout_done => logical1_y_net_x7,
      mpdu_tx_param_txantmask => register7_q_net_x3,
      mpdu_tx_param_txgain_a => register6_q_net_x3,
      mpdu_tx_param_txgain_b => register8_q_net_x1,
      mpdu_tx_param_txgain_c => register9_q_net_x1,
      mpdu_tx_param_txgain_d => register10_q_net_x1,
      mpdu_tx_pktbuf => register2_q_net_x9,
      pre_tx_num_bo_slots => register3_q_net_x3,
      register4_x0 => dbg_mpdu_tx_pending_net,
      status_mpdu_txdone => register2_q_net_x13,
      status_mpdu_txpending => register2_q_net_x5,
      status_mpdu_txresult => register1_q_net_x3,
      status_mpdu_txstate => mcode_fsm_state_out_net_x1,
      tx_ctrl_backoff_start => convert_dout_net_x2,
      tx_ctrl_phy_start => convert1_dout_net_x2,
      tx_ctrl_timeout_start => convert2_dout_net_x2
    );

  nav_e7185c267b: entity work.nav_entity_e7185c267b
    port map (
      ce_1 => ce_1_sg_x49,
      clk_1 => clk_1_sg_x49,
      global_reset => convert1_dout_net_x9,
      phy_rx_data_byte => phy_rx_data_byte_net,
      phy_rx_data_bytenum => phy_rx_data_bytenum_net,
      phy_rx_data_ind => phy_rx_data_ind_net,
      phy_rx_end_ind => phy_rx_end_ind_net,
      phy_rx_end_rxerror => phy_rx_end_rxerror_net,
      phy_rx_start_ind => phy_rx_start_ind_net,
      reg_disable_nav => b_3_y_net_x1,
      reg_force_reset_nav => b_10_y_net_x1,
      register3 => register3_q_net_x4,
      reinterpret => reinterpret_output_port_net_x2,
      nav_busy => logical3_y_net_x4,
      nav_value_100nsec => bitsm_4_y_net_x1,
      register1_x0 => dbg_nav_active_net
    );

  o_0ef2366690: entity work.o_entity_0ef2366690
    port map (
      auto_tx_antmask => register4_q_net_x1,
      auto_tx_gain_a => register3_q_net_x2,
      auto_tx_gain_b => register5_q_net_x1,
      auto_tx_gain_c => register6_q_net_x2,
      auto_tx_gain_d => register7_q_net_x2,
      auto_tx_phy_start => register1_q_net_x1,
      auto_tx_pktbuf => register2_q_net_x8,
      b_1 => b_1_y_net_x3,
      b_4 => b_4_y_net_x2,
      b_6 => b_6_y_net_x2,
      ce_1 => ce_1_sg_x49,
      clk_1 => clk_1_sg_x49,
      global_reset => convert1_dout_net_x9,
      logical1_x0 => logical1_y_net_x5,
      mpdu_tx_param_txantmask => register7_q_net_x3,
      mpdu_tx_param_txgain_a => register6_q_net_x3,
      mpdu_tx_param_txgain_b => register8_q_net_x1,
      mpdu_tx_param_txgain_c => register9_q_net_x1,
      mpdu_tx_param_txgain_d => register10_q_net_x1,
      mpdu_tx_pktbuf => register2_q_net_x9,
      phy_rx_data_done_ind => phy_rx_data_done_ind_net,
      phy_rx_end_ind => phy_rx_end_ind_net,
      phy_rx_end_rxerror => phy_rx_end_rxerror_net,
      phy_rx_fcs_good_ind => phy_rx_fcs_good_ind_net,
      phy_rx_start_ind => phy_rx_start_ind_net,
      phy_tx_end_confirm => phy_tx_done_net,
      phy_tx_start_confirm => phy_tx_started_net,
      tx_ctrl_phy_start => convert1_dout_net_x2,
      phy_rx_blocking => phy_rx_block_pktdet_net,
      phy_rx_blocking_x0 => register2_q_net_x15,
      phy_rx_blocking_x1 => register2_q_net_x16,
      register1_x0 => phy_tx_pkt_buf_net,
      register2_x0 => phy_tx_gain_a_net,
      register4_x0 => phy_tx_ant_mask_net,
      register5_x0 => phy_tx_gain_b_net,
      register6_x0 => phy_tx_gain_c_net,
      register7_x0 => phy_tx_gain_d_net,
      register_x1 => phy_tx_start_net,
      status_rx_fcs_good => register3_q_net_x4,
      status_rx_phy_active => delay_q_net_x1,
      status_tx_phy_active => register2_q_net_x18
    );

  registers_f21f4f09d9: entity work.registers_entity_f21f4f09d9
    port map (
      ce_1 => ce_1_sg_x49,
      clk_1 => clk_1_sg_x49,
      from_register1 => data_out_x9_net,
      from_register10 => data_out_x10_net,
      from_register11 => data_out_x11_net,
      from_register12 => data_out_x12_net,
      from_register13 => data_out_x13_net,
      from_register2 => data_out_x14_net,
      from_register3 => data_out_x15_net,
      from_register4 => data_out_x16_net,
      from_register5 => data_out_x17_net,
      from_register6 => data_out_x18_net,
      from_register7 => data_out_x19_net,
      from_register8 => data_out_x20_net,
      from_register9 => data_out_x21_net,
      mac_nav_busy => logical3_y_net_x4,
      microsecond_timestamp => microsecond_counter_op_net_x1,
      nav_value_100nsec => bitsm_4_y_net_x1,
      phy_cca_ind_busy => phy_cca_ind_busy_net,
      phy_rx_byte => phy_rx_data_byte_net,
      phy_rx_byte_valid => phy_rx_data_ind_net,
      phy_rx_bytenum => phy_rx_data_bytenum_net,
      phy_rx_start_ind => phy_rx_start_ind_net,
      phy_rx_start_phy_sel => phy_rx_start_phy_sel_net,
      phy_rx_start_sig_length => phy_rx_start_sig_length_net,
      phy_rx_start_sig_rate => phy_rx_start_sig_rate_net,
      status_autotx_pending => logical5_y_net_x1,
      status_blocked_on_good_fcs => register2_q_net_x15,
      status_blocked_on_rxend => register2_q_net_x16,
      status_current_backoff_count => num_slots_op_net_x1,
      status_mpdu_txdone => register2_q_net_x13,
      status_mpdu_txpending => register2_q_net_x5,
      status_mpdu_txresult => register1_q_net_x3,
      status_mpdu_txstate => mcode_fsm_state_out_net_x1,
      status_rx_fcs_good => register3_q_net_x4,
      status_rx_phy_active => delay_q_net_x1,
      status_tx_phy_active => register2_q_net_x18,
      tx_ctrl_phy_start => convert1_dout_net_x2,
      constant1_x0 => en_x12_net,
      constant2_x0 => en_x13_net,
      constant3_x0 => en_x19_net,
      constant5_x0 => en_x14_net,
      constant6_x0 => en_x15_net,
      convert1_x0 => data_in_x12_net,
      convert2_x0 => data_in_x16_net,
      convert5_x0 => convert5_dout_net_x1,
      convert6_x0 => data_in_x19_net,
      convert_x0 => data_in_x13_net,
      ctrl_bits => logical1_y_net_x5,
      ctrl_bits_x0 => b_0_y_net_x1,
      ctrl_bits_x1 => b_10_y_net_x1,
      ctrl_bits_x10 => b_9_y_net_x1,
      ctrl_bits_x2 => b_11_y_net_x1,
      ctrl_bits_x3 => b_1_y_net_x3,
      ctrl_bits_x4 => b_3_y_net_x1,
      ctrl_bits_x5 => b_4_y_net_x2,
      ctrl_bits_x6 => b_5_y_net_x2,
      ctrl_bits_x7 => b_6_y_net_x2,
      ctrl_bits_x8 => b_7_y_net_x1,
      ctrl_bits_x9 => b_8_y_net_x1,
      posedge3 => en_x16_net,
      reg_autotx_dly => concat1_y_net_x10,
      reg_autotx_param_en => register24_q_net_x3,
      reg_autotx_param_pktbuf => register22_q_net_x1,
      reg_autotx_param_txantmask => b_23_20_y_net_x0,
      reg_autotx_param_txgain_a => register58_q_net_x1,
      reg_autotx_param_txgain_b => register59_q_net_x1,
      reg_autotx_param_txgain_c => register60_q_net_x1,
      reg_autotx_param_txgain_d => register61_q_net_x1,
      reg_backoff_sw_numslots => register20_q_net_x1,
      reg_backoff_sw_start => register21_q_net_x1,
      reg_calibtime_txdifs => concat1_y_net_x12,
      reg_interval_ack_timeout => concat1_y_net_x8,
      reg_interval_difs => concat1_y_net_x6,
      reg_interval_eifs => concat1_y_net_x11,
      reg_interval_slot => concat1_y_net_x9,
      reg_nav_time_adj => reinterpret_output_port_net_x2,
      reg_set_timestamp_lsb => register28_q_net_x1,
      reg_set_timestamp_msb => register27_q_net_x1,
      reg_tx_param_bo_slots => register17_q_net_x1,
      reg_tx_param_pktbuf => register16_q_net_x1,
      reg_tx_param_start_timeout => register18_q_net_x1,
      reg_tx_param_txantmask => register25_q_net_x1,
      reg_tx_param_txgain_a => register19_q_net_x1,
      reg_tx_param_txgain_b => register53_q_net_x1,
      reg_tx_param_txgain_c => register56_q_net_x1,
      reg_tx_param_txgain_d => register57_q_net_x1,
      reg_tx_start => register35_q_net_x2,
      register15_x0 => register15_q_net_x1,
      register26_x0 => tx_start_timestamp_msb_net,
      register55_x0 => tx_start_timestamp_lsb_net,
      x32lsb1_x0 => data_in_x17_net,
      x32lsb2_x0 => data_in_x20_net,
      x32lsb_x1 => data_in_x14_net,
      x32msb1_x0 => data_in_x18_net,
      x32msb2_x0 => data_in_x21_net,
      x32msb_x1 => data_in_x15_net
    );

  resets_b44a1b9d26: entity work.resets_entity_b44a1b9d26
    port map (
      ce_1 => ce_1_sg_x49,
      clk_1 => clk_1_sg_x49,
      reg_global_reset => b_0_y_net_x1,
      global_reset => convert1_dout_net_x9
    );

  timeout_9c73eec893: entity work.timeout_entity_9c73eec893
    port map (
      ce_1 => ce_1_sg_x49,
      clk_1 => clk_1_sg_x49,
      global_reset => convert1_dout_net_x9,
      phy_rx_start_ind => phy_rx_start_ind_net,
      reg_interval_ack_timeout => concat1_y_net_x8,
      tx_ctrl_timeout_start => convert2_dout_net_x2,
      timeout_done => logical1_y_net_x7
    );

  x64_bit_usec_counter_53a249f18e: entity work.\x64_bit_usec__counter_entity_53a249f18e\
    port map (
      ce_1 => ce_1_sg_x49,
      clk_1 => clk_1_sg_x49,
      reg_set_timestamp_lsb => register28_q_net_x1,
      reg_set_timestamp_msb => register27_q_net_x1,
      reg_update_timestamp => b_5_y_net_x2,
      microsecond_timestamp => microsecond_counter_op_net_x1,
      register3_x0 => timestamp_lsb_net,
      register_x1 => timestamp_msb_net
    );

end structural;
