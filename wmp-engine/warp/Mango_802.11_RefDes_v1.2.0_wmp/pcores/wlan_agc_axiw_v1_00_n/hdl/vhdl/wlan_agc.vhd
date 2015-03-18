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
-- You must compile the wrapper file addsb_11_0_3e2164f3961f5928.vhd when simulating
-- the core, addsb_11_0_3e2164f3961f5928. When compiling the wrapper file, be sure to
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
ENTITY addsb_11_0_3e2164f3961f5928 IS
  PORT (
    a : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
    s : OUT STD_LOGIC_VECTOR(20 DOWNTO 0)
  );
END addsb_11_0_3e2164f3961f5928;

ARCHITECTURE addsb_11_0_3e2164f3961f5928_a OF addsb_11_0_3e2164f3961f5928 IS
-- synthesis translate_off
COMPONENT wrapped_addsb_11_0_3e2164f3961f5928
  PORT (
    a : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
    s : OUT STD_LOGIC_VECTOR(20 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_addsb_11_0_3e2164f3961f5928 USE ENTITY XilinxCoreLib.c_addsub_v11_0(behavioral)
    GENERIC MAP (
      c_a_type => 1,
      c_a_width => 21,
      c_add_mode => 0,
      c_ainit_val => "0",
      c_b_constant => 0,
      c_b_type => 1,
      c_b_value => "000000000000000000000",
      c_b_width => 21,
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
      c_out_width => 21,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_addsb_11_0_3e2164f3961f5928
  PORT MAP (
    a => a,
    b => b,
    s => s
  );
-- synthesis translate_on

END addsb_11_0_3e2164f3961f5928_a;
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
-- You must compile the wrapper file addsb_11_0_4ed1308cac188ac9.vhd when simulating
-- the core, addsb_11_0_4ed1308cac188ac9. When compiling the wrapper file, be sure to
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
ENTITY addsb_11_0_4ed1308cac188ac9 IS
  PORT (
    a : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
  );
END addsb_11_0_4ed1308cac188ac9;

ARCHITECTURE addsb_11_0_4ed1308cac188ac9_a OF addsb_11_0_4ed1308cac188ac9 IS
-- synthesis translate_off
COMPONENT wrapped_addsb_11_0_4ed1308cac188ac9
  PORT (
    a : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_addsb_11_0_4ed1308cac188ac9 USE ENTITY XilinxCoreLib.c_addsub_v11_0(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 9,
      c_add_mode => 0,
      c_ainit_val => "0",
      c_b_constant => 0,
      c_b_type => 0,
      c_b_value => "000000000",
      c_b_width => 9,
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
      c_out_width => 9,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_addsb_11_0_4ed1308cac188ac9
  PORT MAP (
    a => a,
    b => b,
    clk => clk,
    ce => ce,
    s => s
  );
-- synthesis translate_on

END addsb_11_0_4ed1308cac188ac9_a;
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
-- You must compile the wrapper file addsb_11_0_6695c8a33176d3c2.vhd when simulating
-- the core, addsb_11_0_6695c8a33176d3c2. When compiling the wrapper file, be sure to
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
ENTITY addsb_11_0_6695c8a33176d3c2 IS
  PORT (
    a : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
END addsb_11_0_6695c8a33176d3c2;

ARCHITECTURE addsb_11_0_6695c8a33176d3c2_a OF addsb_11_0_6695c8a33176d3c2 IS
-- synthesis translate_off
COMPONENT wrapped_addsb_11_0_6695c8a33176d3c2
  PORT (
    a : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_addsb_11_0_6695c8a33176d3c2 USE ENTITY XilinxCoreLib.c_addsub_v11_0(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 18,
      c_add_mode => 1,
      c_ainit_val => "0",
      c_b_constant => 0,
      c_b_type => 0,
      c_b_value => "000000000000000000",
      c_b_width => 18,
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
      c_out_width => 18,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_addsb_11_0_6695c8a33176d3c2
  PORT MAP (
    a => a,
    b => b,
    clk => clk,
    ce => ce,
    s => s
  );
-- synthesis translate_on

END addsb_11_0_6695c8a33176d3c2_a;
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
-- You must compile the wrapper file addsb_11_0_76821d30ce8a19fb.vhd when simulating
-- the core, addsb_11_0_76821d30ce8a19fb. When compiling the wrapper file, be sure to
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
ENTITY addsb_11_0_76821d30ce8a19fb IS
  PORT (
    a : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    s : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
  );
END addsb_11_0_76821d30ce8a19fb;

ARCHITECTURE addsb_11_0_76821d30ce8a19fb_a OF addsb_11_0_76821d30ce8a19fb IS
-- synthesis translate_off
COMPONENT wrapped_addsb_11_0_76821d30ce8a19fb
  PORT (
    a : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    s : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_addsb_11_0_76821d30ce8a19fb USE ENTITY XilinxCoreLib.c_addsub_v11_0(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 11,
      c_add_mode => 1,
      c_ainit_val => "0",
      c_b_constant => 0,
      c_b_type => 0,
      c_b_value => "00000000000",
      c_b_width => 11,
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
      c_out_width => 11,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_addsb_11_0_76821d30ce8a19fb
  PORT MAP (
    a => a,
    b => b,
    s => s
  );
-- synthesis translate_on

END addsb_11_0_76821d30ce8a19fb_a;
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
-- You must compile the wrapper file addsb_11_0_8942e2ad5d8d4897.vhd when simulating
-- the core, addsb_11_0_8942e2ad5d8d4897. When compiling the wrapper file, be sure to
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
ENTITY addsb_11_0_8942e2ad5d8d4897 IS
  PORT (
    a : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
  );
END addsb_11_0_8942e2ad5d8d4897;

ARCHITECTURE addsb_11_0_8942e2ad5d8d4897_a OF addsb_11_0_8942e2ad5d8d4897 IS
-- synthesis translate_off
COMPONENT wrapped_addsb_11_0_8942e2ad5d8d4897
  PORT (
    a : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_addsb_11_0_8942e2ad5d8d4897 USE ENTITY XilinxCoreLib.c_addsub_v11_0(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 9,
      c_add_mode => 1,
      c_ainit_val => "0",
      c_b_constant => 0,
      c_b_type => 0,
      c_b_value => "000000000",
      c_b_width => 9,
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
      c_out_width => 9,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_addsb_11_0_8942e2ad5d8d4897
  PORT MAP (
    a => a,
    b => b,
    clk => clk,
    ce => ce,
    s => s
  );
-- synthesis translate_on

END addsb_11_0_8942e2ad5d8d4897_a;
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
-- You must compile the wrapper file addsb_11_0_97a86f347ff88c59.vhd when simulating
-- the core, addsb_11_0_97a86f347ff88c59. When compiling the wrapper file, be sure to
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
ENTITY addsb_11_0_97a86f347ff88c59 IS
  PORT (
    a : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(18 DOWNTO 0)
  );
END addsb_11_0_97a86f347ff88c59;

ARCHITECTURE addsb_11_0_97a86f347ff88c59_a OF addsb_11_0_97a86f347ff88c59 IS
-- synthesis translate_off
COMPONENT wrapped_addsb_11_0_97a86f347ff88c59
  PORT (
    a : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(18 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_addsb_11_0_97a86f347ff88c59 USE ENTITY XilinxCoreLib.c_addsub_v11_0(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 19,
      c_add_mode => 1,
      c_ainit_val => "0",
      c_b_constant => 0,
      c_b_type => 0,
      c_b_value => "0000000000000000000",
      c_b_width => 19,
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
      c_out_width => 19,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_addsb_11_0_97a86f347ff88c59
  PORT MAP (
    a => a,
    b => b,
    clk => clk,
    ce => ce,
    s => s
  );
-- synthesis translate_on

END addsb_11_0_97a86f347ff88c59_a;
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
-- You must compile the wrapper file addsb_11_0_a52ead9b8a3c1e76.vhd when simulating
-- the core, addsb_11_0_a52ead9b8a3c1e76. When compiling the wrapper file, be sure to
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
ENTITY addsb_11_0_a52ead9b8a3c1e76 IS
  PORT (
    a : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    s : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
  );
END addsb_11_0_a52ead9b8a3c1e76;

ARCHITECTURE addsb_11_0_a52ead9b8a3c1e76_a OF addsb_11_0_a52ead9b8a3c1e76 IS
-- synthesis translate_off
COMPONENT wrapped_addsb_11_0_a52ead9b8a3c1e76
  PORT (
    a : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    s : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_addsb_11_0_a52ead9b8a3c1e76 USE ENTITY XilinxCoreLib.c_addsub_v11_0(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 9,
      c_add_mode => 1,
      c_ainit_val => "0",
      c_b_constant => 0,
      c_b_type => 0,
      c_b_value => "000000000",
      c_b_width => 9,
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
      c_out_width => 9,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_addsb_11_0_a52ead9b8a3c1e76
  PORT MAP (
    a => a,
    b => b,
    s => s
  );
-- synthesis translate_on

END addsb_11_0_a52ead9b8a3c1e76_a;
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
-- You must compile the wrapper file addsb_11_0_b48032ce427ab995.vhd when simulating
-- the core, addsb_11_0_b48032ce427ab995. When compiling the wrapper file, be sure to
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
ENTITY addsb_11_0_b48032ce427ab995 IS
  PORT (
    a : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(12 DOWNTO 0)
  );
END addsb_11_0_b48032ce427ab995;

ARCHITECTURE addsb_11_0_b48032ce427ab995_a OF addsb_11_0_b48032ce427ab995 IS
-- synthesis translate_off
COMPONENT wrapped_addsb_11_0_b48032ce427ab995
  PORT (
    a : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(12 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_addsb_11_0_b48032ce427ab995 USE ENTITY XilinxCoreLib.c_addsub_v11_0(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 13,
      c_add_mode => 1,
      c_ainit_val => "0",
      c_b_constant => 0,
      c_b_type => 0,
      c_b_value => "0000000000000",
      c_b_width => 13,
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
      c_out_width => 13,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_addsb_11_0_b48032ce427ab995
  PORT MAP (
    a => a,
    b => b,
    clk => clk,
    ce => ce,
    s => s
  );
-- synthesis translate_on

END addsb_11_0_b48032ce427ab995_a;
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
-- You must compile the wrapper file addsb_11_0_c62d62064f685a8c.vhd when simulating
-- the core, addsb_11_0_c62d62064f685a8c. When compiling the wrapper file, be sure to
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
ENTITY addsb_11_0_c62d62064f685a8c IS
  PORT (
    a : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    s : OUT STD_LOGIC_VECTOR(14 DOWNTO 0)
  );
END addsb_11_0_c62d62064f685a8c;

ARCHITECTURE addsb_11_0_c62d62064f685a8c_a OF addsb_11_0_c62d62064f685a8c IS
-- synthesis translate_off
COMPONENT wrapped_addsb_11_0_c62d62064f685a8c
  PORT (
    a : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    s : OUT STD_LOGIC_VECTOR(14 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_addsb_11_0_c62d62064f685a8c USE ENTITY XilinxCoreLib.c_addsub_v11_0(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 15,
      c_add_mode => 1,
      c_ainit_val => "0",
      c_b_constant => 0,
      c_b_type => 0,
      c_b_value => "000000000000000",
      c_b_width => 15,
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
      c_out_width => 15,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_addsb_11_0_c62d62064f685a8c
  PORT MAP (
    a => a,
    b => b,
    s => s
  );
-- synthesis translate_on

END addsb_11_0_c62d62064f685a8c_a;
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
-- You must compile the wrapper file addsb_11_0_e14d732e56290152.vhd when simulating
-- the core, addsb_11_0_e14d732e56290152. When compiling the wrapper file, be sure to
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
ENTITY addsb_11_0_e14d732e56290152 IS
  PORT (
    a : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    s : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
  );
END addsb_11_0_e14d732e56290152;

ARCHITECTURE addsb_11_0_e14d732e56290152_a OF addsb_11_0_e14d732e56290152 IS
-- synthesis translate_off
COMPONENT wrapped_addsb_11_0_e14d732e56290152
  PORT (
    a : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    s : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_addsb_11_0_e14d732e56290152 USE ENTITY XilinxCoreLib.c_addsub_v11_0(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 20,
      c_add_mode => 1,
      c_ainit_val => "0",
      c_b_constant => 0,
      c_b_type => 0,
      c_b_value => "00000000000000000000",
      c_b_width => 20,
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
      c_out_width => 20,
      c_sclr_overrides_sset => 1,
      c_sinit_val => "0",
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_addsb_11_0_e14d732e56290152
  PORT MAP (
    a => a,
    b => b,
    s => s
  );
-- synthesis translate_on

END addsb_11_0_e14d732e56290152_a;
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
-- You must compile the wrapper file asr_11_0_5c9c6a297ef30376.vhd when simulating
-- the core, asr_11_0_5c9c6a297ef30376. When compiling the wrapper file, be sure to
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
ENTITY asr_11_0_5c9c6a297ef30376 IS
  PORT (
    a : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    d : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
  );
END asr_11_0_5c9c6a297ef30376;

ARCHITECTURE asr_11_0_5c9c6a297ef30376_a OF asr_11_0_5c9c6a297ef30376 IS
-- synthesis translate_off
COMPONENT wrapped_asr_11_0_5c9c6a297ef30376
  PORT (
    a : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    d : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_asr_11_0_5c9c6a297ef30376 USE ENTITY XilinxCoreLib.c_shift_ram_v11_0(behavioral)
    GENERIC MAP (
      c_addr_width => 3,
      c_ainit_val => "0000000000",
      c_default_data => "0000000000",
      c_depth => 8,
      c_has_a => 1,
      c_has_ce => 1,
      c_has_sclr => 0,
      c_has_sinit => 0,
      c_has_sset => 0,
      c_mem_init_file => "asr_11_0_5c9c6a297ef30376.mif",
      c_opt_goal => 0,
      c_parser_type => 0,
      c_read_mif => 1,
      c_reg_last_bit => 0,
      c_shift_type => 1,
      c_sinit_val => "0000000000",
      c_sync_enable => 0,
      c_sync_priority => 1,
      c_verbosity => 0,
      c_width => 10,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_asr_11_0_5c9c6a297ef30376
  PORT MAP (
    a => a,
    d => d,
    clk => clk,
    ce => ce,
    q => q
  );
-- synthesis translate_on

END asr_11_0_5c9c6a297ef30376_a;
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
-- You must compile the wrapper file bmg_72_3c8cb899503da0de.vhd when simulating
-- the core, bmg_72_3c8cb899503da0de. When compiling the wrapper file, be sure to
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
ENTITY bmg_72_3c8cb899503da0de IS
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
  );
END bmg_72_3c8cb899503da0de;

ARCHITECTURE bmg_72_3c8cb899503da0de_a OF bmg_72_3c8cb899503da0de IS
-- synthesis translate_off
COMPONENT wrapped_bmg_72_3c8cb899503da0de
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_bmg_72_3c8cb899503da0de USE ENTITY XilinxCoreLib.blk_mem_gen_v7_2(behavioral)
    GENERIC MAP (
      c_addra_width => 11,
      c_addrb_width => 11,
      c_algorithm => 1,
      c_axi_id_width => 4,
      c_axi_slave_type => 0,
      c_axi_type => 1,
      c_byte_size => 9,
      c_common_clk => 0,
      c_default_data => "0",
      c_disable_warn_bhv_coll => 0,
      c_disable_warn_bhv_range => 0,
      c_enable_32bit_address => 0,
      c_family => "virtex6",
      c_has_axi_id => 0,
      c_has_ena => 1,
      c_has_enb => 0,
      c_has_injecterr => 0,
      c_has_mem_output_regs_a => 0,
      c_has_mem_output_regs_b => 0,
      c_has_mux_output_regs_a => 0,
      c_has_mux_output_regs_b => 0,
      c_has_regcea => 0,
      c_has_regceb => 0,
      c_has_rsta => 0,
      c_has_rstb => 0,
      c_has_softecc_input_regs_a => 0,
      c_has_softecc_output_regs_b => 0,
      c_init_file_name => "bmg_72_3c8cb899503da0de.mif",
      c_inita_val => "0",
      c_initb_val => "0",
      c_interface_type => 0,
      c_load_init_file => 1,
      c_mem_type => 3,
      c_mux_pipeline_stages => 0,
      c_prim_type => 1,
      c_read_depth_a => 2048,
      c_read_depth_b => 2048,
      c_read_width_a => 14,
      c_read_width_b => 14,
      c_rst_priority_a => "CE",
      c_rst_priority_b => "CE",
      c_rst_type => "SYNC",
      c_rstram_a => 0,
      c_rstram_b => 0,
      c_sim_collision_check => "ALL",
      c_use_byte_wea => 0,
      c_use_byte_web => 0,
      c_use_default_data => 0,
      c_use_ecc => 0,
      c_use_softecc => 0,
      c_wea_width => 1,
      c_web_width => 1,
      c_write_depth_a => 2048,
      c_write_depth_b => 2048,
      c_write_mode_a => "WRITE_FIRST",
      c_write_mode_b => "WRITE_FIRST",
      c_write_width_a => 14,
      c_write_width_b => 14,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_bmg_72_3c8cb899503da0de
  PORT MAP (
    clka => clka,
    ena => ena,
    addra => addra,
    douta => douta
  );
-- synthesis translate_on

END bmg_72_3c8cb899503da0de_a;
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
-- You must compile the wrapper file cntr_11_0_6454489cfe866515.vhd when simulating
-- the core, cntr_11_0_6454489cfe866515. When compiling the wrapper file, be sure to
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
ENTITY cntr_11_0_6454489cfe866515 IS
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
  );
END cntr_11_0_6454489cfe866515;

ARCHITECTURE cntr_11_0_6454489cfe866515_a OF cntr_11_0_6454489cfe866515 IS
-- synthesis translate_off
COMPONENT wrapped_cntr_11_0_6454489cfe866515
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_cntr_11_0_6454489cfe866515 USE ENTITY XilinxCoreLib.c_counter_binary_v11_0(behavioral)
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
      c_width => 2,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_cntr_11_0_6454489cfe866515
  PORT MAP (
    clk => clk,
    ce => ce,
    sinit => sinit,
    q => q
  );
-- synthesis translate_on

END cntr_11_0_6454489cfe866515_a;
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
--    (c) Copyright 1995-2013 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- You must compile the wrapper file cntr_11_0_87d991c7bcfe987f.vhd when simulating
-- the core, cntr_11_0_87d991c7bcfe987f. When compiling the wrapper file, be sure to
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
ENTITY cntr_11_0_87d991c7bcfe987f IS
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
  );
END cntr_11_0_87d991c7bcfe987f;

ARCHITECTURE cntr_11_0_87d991c7bcfe987f_a OF cntr_11_0_87d991c7bcfe987f IS
-- synthesis translate_off
COMPONENT wrapped_cntr_11_0_87d991c7bcfe987f
  PORT (
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sinit : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_cntr_11_0_87d991c7bcfe987f USE ENTITY XilinxCoreLib.c_counter_binary_v11_0(behavioral)
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
      c_width => 5,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_cntr_11_0_87d991c7bcfe987f
  PORT MAP (
    clk => clk,
    ce => ce,
    sinit => sinit,
    q => q
  );
-- synthesis translate_on

END cntr_11_0_87d991c7bcfe987f_a;
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
-- You must compile the wrapper file mult_11_2_30380bd5df9eb5a0.vhd when simulating
-- the core, mult_11_2_30380bd5df9eb5a0. When compiling the wrapper file, be sure to
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
ENTITY mult_11_2_30380bd5df9eb5a0 IS
  PORT (
    clk : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    p : OUT STD_LOGIC_VECTOR(21 DOWNTO 0)
  );
END mult_11_2_30380bd5df9eb5a0;

ARCHITECTURE mult_11_2_30380bd5df9eb5a0_a OF mult_11_2_30380bd5df9eb5a0 IS
-- synthesis translate_off
COMPONENT wrapped_mult_11_2_30380bd5df9eb5a0
  PORT (
    clk : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    p : OUT STD_LOGIC_VECTOR(21 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_mult_11_2_30380bd5df9eb5a0 USE ENTITY XilinxCoreLib.mult_gen_v11_2(behavioral)
    GENERIC MAP (
      c_a_type => 1,
      c_a_width => 10,
      c_b_type => 1,
      c_b_value => "10000001",
      c_b_width => 12,
      c_ccm_imp => 0,
      c_ce_overrides_sclr => 1,
      c_has_ce => 1,
      c_has_sclr => 1,
      c_has_zero_detect => 0,
      c_latency => 1,
      c_model_type => 0,
      c_mult_type => 1,
      c_optimize_goal => 1,
      c_out_high => 21,
      c_out_low => 0,
      c_round_output => 0,
      c_round_pt => 0,
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_mult_11_2_30380bd5df9eb5a0
  PORT MAP (
    clk => clk,
    a => a,
    b => b,
    ce => ce,
    sclr => sclr,
    p => p
  );
-- synthesis translate_on

END mult_11_2_30380bd5df9eb5a0_a;
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
-- You must compile the wrapper file mult_11_2_3b49a62273275732.vhd when simulating
-- the core, mult_11_2_3b49a62273275732. When compiling the wrapper file, be sure to
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
ENTITY mult_11_2_3b49a62273275732 IS
  PORT (
    a : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    p : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
END mult_11_2_3b49a62273275732;

ARCHITECTURE mult_11_2_3b49a62273275732_a OF mult_11_2_3b49a62273275732 IS
-- synthesis translate_off
COMPONENT wrapped_mult_11_2_3b49a62273275732
  PORT (
    a : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    p : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_mult_11_2_3b49a62273275732 USE ENTITY XilinxCoreLib.mult_gen_v11_2(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 12,
      c_b_type => 0,
      c_b_value => "10000001",
      c_b_width => 12,
      c_ccm_imp => 0,
      c_ce_overrides_sclr => 0,
      c_has_ce => 0,
      c_has_sclr => 0,
      c_has_zero_detect => 0,
      c_latency => 0,
      c_model_type => 0,
      c_mult_type => 1,
      c_optimize_goal => 1,
      c_out_high => 23,
      c_out_low => 0,
      c_round_output => 0,
      c_round_pt => 0,
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_mult_11_2_3b49a62273275732
  PORT MAP (
    a => a,
    b => b,
    p => p
  );
-- synthesis translate_on

END mult_11_2_3b49a62273275732_a;
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
-- You must compile the wrapper file mult_11_2_956d7358e78b2265.vhd when simulating
-- the core, mult_11_2_956d7358e78b2265. When compiling the wrapper file, be sure to
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
ENTITY mult_11_2_956d7358e78b2265 IS
  PORT (
    clk : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    p : OUT STD_LOGIC_VECTOR(33 DOWNTO 0)
  );
END mult_11_2_956d7358e78b2265;

ARCHITECTURE mult_11_2_956d7358e78b2265_a OF mult_11_2_956d7358e78b2265 IS
-- synthesis translate_off
COMPONENT wrapped_mult_11_2_956d7358e78b2265
  PORT (
    clk : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    p : OUT STD_LOGIC_VECTOR(33 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_mult_11_2_956d7358e78b2265 USE ENTITY XilinxCoreLib.mult_gen_v11_2(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 16,
      c_b_type => 1,
      c_b_value => "10000001",
      c_b_width => 18,
      c_ccm_imp => 0,
      c_ce_overrides_sclr => 1,
      c_has_ce => 1,
      c_has_sclr => 1,
      c_has_zero_detect => 0,
      c_latency => 1,
      c_model_type => 0,
      c_mult_type => 1,
      c_optimize_goal => 1,
      c_out_high => 33,
      c_out_low => 0,
      c_round_output => 0,
      c_round_pt => 0,
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_mult_11_2_956d7358e78b2265
  PORT MAP (
    clk => clk,
    a => a,
    b => b,
    ce => ce,
    sclr => sclr,
    p => p
  );
-- synthesis translate_on

END mult_11_2_956d7358e78b2265_a;
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
-- You must compile the wrapper file mult_11_2_dd4c66afbde2a675.vhd when simulating
-- the core, mult_11_2_dd4c66afbde2a675. When compiling the wrapper file, be sure to
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
ENTITY mult_11_2_dd4c66afbde2a675 IS
  PORT (
    clk : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    p : OUT STD_LOGIC_VECTOR(37 DOWNTO 0)
  );
END mult_11_2_dd4c66afbde2a675;

ARCHITECTURE mult_11_2_dd4c66afbde2a675_a OF mult_11_2_dd4c66afbde2a675 IS
-- synthesis translate_off
COMPONENT wrapped_mult_11_2_dd4c66afbde2a675
  PORT (
    clk : IN STD_LOGIC;
    a : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    p : OUT STD_LOGIC_VECTOR(37 DOWNTO 0)
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_mult_11_2_dd4c66afbde2a675 USE ENTITY XilinxCoreLib.mult_gen_v11_2(behavioral)
    GENERIC MAP (
      c_a_type => 0,
      c_a_width => 20,
      c_b_type => 0,
      c_b_value => "10000001",
      c_b_width => 18,
      c_ccm_imp => 0,
      c_ce_overrides_sclr => 1,
      c_has_ce => 1,
      c_has_sclr => 1,
      c_has_zero_detect => 0,
      c_latency => 1,
      c_model_type => 0,
      c_mult_type => 1,
      c_optimize_goal => 1,
      c_out_high => 37,
      c_out_low => 0,
      c_round_output => 0,
      c_round_pt => 0,
      c_verbosity => 0,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_mult_11_2_dd4c66afbde2a675
  PORT MAP (
    clk => clk,
    a => a,
    b => b,
    ce => ce,
    sclr => sclr,
    p => p
  );
-- synthesis translate_on

END mult_11_2_dd4c66afbde2a675_a;

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
use IEEE.numeric_std.all;
use work.conv_pkg.all;
-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on
entity xlclockenablegenerator is
  generic (
    period: integer := 2;
    log_2_period: integer := 0;
    pipeline_regs: integer := 5
  );
  port (
    clk: in std_logic;
    clr: in std_logic;
    ce: out std_logic
  );
end xlclockenablegenerator;
architecture behavior of xlclockenablegenerator is
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
  signal internal_ce: std_logic_vector(0 downto 0);
  signal cnt_clr, cnt_clr_dly: std_logic_vector (0 downto 0);
begin
  cntr_gen: process(clk)
  begin
    if clk'event and clk = '1'  then
        if ((cnt_clr_dly(0) = '1') or (clr = '1')) then
          clk_num <= (others => '0');
        else
          clk_num <= clk_num + 1;
        end if;
    end if;
  end process;
  clr_gen: process(clk_num, clr)
  begin
    if power_of_2_counter then
      cnt_clr(0) <= clr;
    else
      if (unsigned_to_std_logic_vector(clk_num) = clk_for_ce_pulse_minus1
          or clr = '1') then
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
      ce => '1',
      clr => clr,
      clk => clk,
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
                  ce => '1',
                  clr => clr,
                  clk => clk,
                  o => ce_vec(index-1 downto index-1)
                  );
      end generate;
      internal_ce <= ce_vec(0 downto 0);
  end generate;
  generate_clock_enable: if period > 1 generate
    ce <= internal_ce(0);
  end generate;
  generate_clock_enable_constant: if period = 1 generate
    ce <= '1';
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
-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on
entity xlusamp is
    generic (
             d_width      : integer := 5;
             d_bin_pt     : integer := 2;
             d_arith      : integer := xlUnsigned;
             q_width      : integer := 5;
             q_bin_pt     : integer := 2;
             q_arith      : integer := xlUnsigned;
             en_width     : integer := 1;
             en_bin_pt    : integer := 0;
             en_arith     : integer := xlUnsigned;
             sampling_ratio     : integer := 2;
             latency      : integer := 1;
             copy_samples : integer := 0);
    port (
          d        : in std_logic_vector (d_width-1 downto 0);
          src_clk  : in std_logic;
          src_ce   : in std_logic;
          src_clr  : in std_logic;
          dest_clk : in std_logic;
          dest_ce  : in std_logic;
          dest_clr : in std_logic;
          en       : in std_logic_vector(en_width-1 downto 0);
          q        : out std_logic_vector (q_width-1 downto 0)
         );
end xlusamp;
architecture struct of xlusamp is
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
    component FDSE
        port (q  : out   std_ulogic;
              d  : in    std_ulogic;
              c  : in    std_ulogic;
              s  : in    std_ulogic;
              ce : in    std_ulogic);
    end component;
    attribute syn_black_box of FDSE : component is true;
    attribute fpga_dont_touch of FDSE : component is "true";
    signal zero    : std_logic_vector (d_width-1 downto 0);
    signal mux_sel : std_logic;
    signal sampled_d  : std_logic_vector (d_width-1 downto 0);
    signal internal_ce : std_logic;
begin
   sel_gen : FDSE
                port map (q  => mux_sel,
                        d  => src_ce,
            c  => src_clk,
            s  => src_clr,
            ce => dest_ce);
  internal_ce <= src_ce and en(0);
  copy_samples_false : if (copy_samples = 0) generate
      zero <= (others => '0');
      gen_q_cp_smpls_0_and_lat_0: if (latency = 0) generate
        cp_smpls_0_and_lat_0: process (mux_sel, d, zero)
        begin
          if (mux_sel = '1') then
            q <= d;
          else
            q <= zero;
          end if;
        end process cp_smpls_0_and_lat_0;
      end generate;
      gen_q_cp_smpls_0_and_lat_gt_0: if (latency > 0) generate
        sampled_d_reg: synth_reg
          generic map (
            width => d_width,
            latency => latency
          )
          port map (
            i => d,
            ce => internal_ce,
            clr => src_clr,
            clk => src_clk,
            o => sampled_d
          );

        gen_q_check_mux_sel: process (mux_sel, sampled_d, zero)
        begin
          if (mux_sel = '1') then
            q <= sampled_d;
          else
            q <= zero;
          end if;
        end process gen_q_check_mux_sel;
      end generate;
   end generate;
   copy_samples_true : if (copy_samples = 1) generate
     gen_q_cp_smpls_1_and_lat_0: if (latency = 0) generate
       q <= d;
     end generate;
     gen_q_cp_smpls_1_and_lat_gt_0: if (latency > 0) generate
       q <= sampled_d;
       sampled_d_reg2: synth_reg
         generic map (
           width => d_width,
           latency => latency
         )
         port map (
           i => d,
           ce => internal_ce,
           clr => src_clr,
           clk => src_clk,
           o => sampled_d
         );
     end generate;
   end generate;
end architecture struct;

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

entity constant_1993116bef is
  port (
    op : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_1993116bef;


architecture behavior of constant_1993116bef is
begin
  op <= "11111101";
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
entity xlcounter_free_wlan_agc is
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
end xlcounter_free_wlan_agc ;
architecture behavior of xlcounter_free_wlan_agc is
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
  component cntr_11_0_6454489cfe866515
    port (
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of cntr_11_0_6454489cfe866515:
    component is true;
  attribute fpga_dont_touch of cntr_11_0_6454489cfe866515:
    component is "true";
  attribute box_type of cntr_11_0_6454489cfe866515:
    component  is "black_box";
  component cntr_11_0_87d991c7bcfe987f
    port (
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of cntr_11_0_87d991c7bcfe987f:
    component is true;
  attribute fpga_dont_touch of cntr_11_0_87d991c7bcfe987f:
    component is "true";
  attribute box_type of cntr_11_0_87d991c7bcfe987f:
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
  comp1: if ((core_name0 = "cntr_11_0_6454489cfe866515")) generate
    core_instance1: cntr_11_0_6454489cfe866515
      port map (
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        q => op_net
      );
  end generate;
  comp2: if ((core_name0 = "cntr_11_0_87d991c7bcfe987f")) generate
    core_instance2: cntr_11_0_87d991c7bcfe987f
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

entity relational_5a9c998b07 is
  port (
    a : in std_logic_vector((8 - 1) downto 0);
    b : in std_logic_vector((8 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_5a9c998b07;


architecture behavior of relational_5a9c998b07 is
  signal a_1_31: unsigned((8 - 1) downto 0);
  signal b_1_34: unsigned((8 - 1) downto 0);
  signal result_16_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_16_3_rel <= a_1_31 < b_1_34;
  op <= boolean_to_vector(result_16_3_rel);
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

entity relational_62f7926e41 is
  port (
    a : in std_logic_vector((8 - 1) downto 0);
    b : in std_logic_vector((8 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_62f7926e41;


architecture behavior of relational_62f7926e41 is
  signal a_1_31: unsigned((8 - 1) downto 0);
  signal b_1_34: unsigned((8 - 1) downto 0);
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

entity accum_41fb841d92 is
  port (
    b : in std_logic_vector((12 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((17 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end accum_41fb841d92;


architecture behavior of accum_41fb841d92 is
  signal b_17_24: signed((12 - 1) downto 0);
  signal rst_17_27: boolean;
  signal en_17_32: boolean;
  signal accum_reg_41_23: signed((17 - 1) downto 0) := "00000000000000000";
  signal accum_reg_41_23_rst: std_logic;
  signal accum_reg_41_23_en: std_logic;
  signal cast_51_42: signed((17 - 1) downto 0);
  signal accum_reg_join_47_1: signed((18 - 1) downto 0);
  signal accum_reg_join_47_1_en: std_logic;
  signal accum_reg_join_47_1_rst: std_logic;
begin
  b_17_24 <= std_logic_vector_to_signed(b);
  rst_17_27 <= ((rst) = "1");
  en_17_32 <= ((en) = "1");
  proc_accum_reg_41_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (accum_reg_41_23_rst = '1')) then
        accum_reg_41_23 <= "00000000000000000";
      elsif ((ce = '1') and (accum_reg_41_23_en = '1')) then 
        accum_reg_41_23 <= accum_reg_41_23 + cast_51_42;
      end if;
    end if;
  end process proc_accum_reg_41_23;
  cast_51_42 <= s2s_cast(b_17_24, 11, 17, 11);
  proc_if_47_1: process (accum_reg_41_23, cast_51_42, en_17_32, rst_17_27)
  is
  begin
    if rst_17_27 then
      accum_reg_join_47_1_rst <= '1';
    elsif en_17_32 then
      accum_reg_join_47_1_rst <= '0';
    else 
      accum_reg_join_47_1_rst <= '0';
    end if;
    if en_17_32 then
      accum_reg_join_47_1_en <= '1';
    else 
      accum_reg_join_47_1_en <= '0';
    end if;
  end process proc_if_47_1;
  accum_reg_41_23_rst <= accum_reg_join_47_1_rst;
  accum_reg_41_23_en <= accum_reg_join_47_1_en;
  q <= signed_to_std_logic_vector(accum_reg_41_23);
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
entity xladdsub_wlan_agc is
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
end xladdsub_wlan_agc;
architecture behavior of xladdsub_wlan_agc is
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
  component addsb_11_0_6695c8a33176d3c2
    port (
          a: in std_logic_vector(18 - 1 downto 0);
    clk: in std_logic:= '0';
    ce: in std_logic:= '0';
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(18 - 1 downto 0)
    );
  end component;
  component addsb_11_0_97a86f347ff88c59
    port (
          a: in std_logic_vector(19 - 1 downto 0);
    clk: in std_logic:= '0';
    ce: in std_logic:= '0';
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(19 - 1 downto 0)
    );
  end component;
  component addsb_11_0_e14d732e56290152
    port (
          a: in std_logic_vector(20 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(20 - 1 downto 0)
    );
  end component;
  component addsb_11_0_8942e2ad5d8d4897
    port (
          a: in std_logic_vector(9 - 1 downto 0);
    clk: in std_logic:= '0';
    ce: in std_logic:= '0';
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(9 - 1 downto 0)
    );
  end component;
  component addsb_11_0_a52ead9b8a3c1e76
    port (
          a: in std_logic_vector(9 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(9 - 1 downto 0)
    );
  end component;
  component addsb_11_0_4ed1308cac188ac9
    port (
          a: in std_logic_vector(9 - 1 downto 0);
    clk: in std_logic:= '0';
    ce: in std_logic:= '0';
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(9 - 1 downto 0)
    );
  end component;
  component addsb_11_0_c62d62064f685a8c
    port (
          a: in std_logic_vector(15 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(15 - 1 downto 0)
    );
  end component;
  component addsb_11_0_b48032ce427ab995
    port (
          a: in std_logic_vector(13 - 1 downto 0);
    clk: in std_logic:= '0';
    ce: in std_logic:= '0';
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(13 - 1 downto 0)
    );
  end component;
  component addsb_11_0_3e2164f3961f5928
    port (
          a: in std_logic_vector(21 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(21 - 1 downto 0)
    );
  end component;
  component addsb_11_0_76821d30ce8a19fb
    port (
          a: in std_logic_vector(11 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(11 - 1 downto 0)
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

  comp0: if ((core_name0 = "addsb_11_0_6695c8a33176d3c2")) generate
    core_instance0: addsb_11_0_6695c8a33176d3c2
      port map (
         a => full_a,
         clk => clk,
         ce => internal_ce,
         s => core_s,
         b => full_b
      );
  end generate;
  comp1: if ((core_name0 = "addsb_11_0_97a86f347ff88c59")) generate
    core_instance1: addsb_11_0_97a86f347ff88c59
      port map (
         a => full_a,
         clk => clk,
         ce => internal_ce,
         s => core_s,
         b => full_b
      );
  end generate;
  comp2: if ((core_name0 = "addsb_11_0_e14d732e56290152")) generate
    core_instance2: addsb_11_0_e14d732e56290152
      port map (
         a => full_a,
         s => core_s,
         b => full_b
      );
  end generate;
  comp3: if ((core_name0 = "addsb_11_0_8942e2ad5d8d4897")) generate
    core_instance3: addsb_11_0_8942e2ad5d8d4897
      port map (
         a => full_a,
         clk => clk,
         ce => internal_ce,
         s => core_s,
         b => full_b
      );
  end generate;
  comp5: if ((core_name0 = "addsb_11_0_a52ead9b8a3c1e76")) generate
    core_instance5: addsb_11_0_a52ead9b8a3c1e76
      port map (
         a => full_a,
         s => core_s,
         b => full_b
      );
  end generate;
  comp6: if ((core_name0 = "addsb_11_0_4ed1308cac188ac9")) generate
    core_instance6: addsb_11_0_4ed1308cac188ac9
      port map (
         a => full_a,
         clk => clk,
         ce => internal_ce,
         s => core_s,
         b => full_b
      );
  end generate;
  comp7: if ((core_name0 = "addsb_11_0_c62d62064f685a8c")) generate
    core_instance7: addsb_11_0_c62d62064f685a8c
      port map (
         a => full_a,
         s => core_s,
         b => full_b
      );
  end generate;
  comp8: if ((core_name0 = "addsb_11_0_b48032ce427ab995")) generate
    core_instance8: addsb_11_0_b48032ce427ab995
      port map (
         a => full_a,
         clk => clk,
         ce => internal_ce,
         s => core_s,
         b => full_b
      );
  end generate;
  comp9: if ((core_name0 = "addsb_11_0_3e2164f3961f5928")) generate
    core_instance9: addsb_11_0_3e2164f3961f5928
      port map (
         a => full_a,
         s => core_s,
         b => full_b
      );
  end generate;
  comp10: if ((core_name0 = "addsb_11_0_76821d30ce8a19fb")) generate
    core_instance10: addsb_11_0_76821d30ce8a19fb
      port map (
         a => full_a,
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

entity constant_578dda96c6 is
  port (
    op : out std_logic_vector((5 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_578dda96c6;


architecture behavior of constant_578dda96c6 is
begin
  op <= "11111";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_9ece3c8c4e is
  port (
    a : in std_logic_vector((5 - 1) downto 0);
    b : in std_logic_vector((5 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_9ece3c8c4e;


architecture behavior of relational_9ece3c8c4e is
  signal a_1_31: unsigned((5 - 1) downto 0);
  signal b_1_34: unsigned((5 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity scale_b42effccbc is
  port (
    ip : in std_logic_vector((17 - 1) downto 0);
    op : out std_logic_vector((17 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end scale_b42effccbc;


architecture behavior of scale_b42effccbc is
  signal ip_17_23: signed((17 - 1) downto 0);
begin
  ip_17_23 <= std_logic_vector_to_signed(ip);
  op <= signed_to_std_logic_vector(ip_17_23);
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
entity xlmult_wlan_agc is
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
end xlmult_wlan_agc;
architecture behavior of xlmult_wlan_agc is
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
  component mult_11_2_956d7358e78b2265
    port (
      b: in std_logic_vector(c_b_width - 1 downto 0);
      p: out std_logic_vector(c_output_width - 1 downto 0);
      clk: in std_logic;
      ce: in std_logic;
      sclr: in std_logic;
      a: in std_logic_vector(c_a_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of mult_11_2_956d7358e78b2265:
    component is true;
  attribute fpga_dont_touch of mult_11_2_956d7358e78b2265:
    component is "true";
  attribute box_type of mult_11_2_956d7358e78b2265:
    component  is "black_box";
  component mult_11_2_dd4c66afbde2a675
    port (
      b: in std_logic_vector(c_b_width - 1 downto 0);
      p: out std_logic_vector(c_output_width - 1 downto 0);
      clk: in std_logic;
      ce: in std_logic;
      sclr: in std_logic;
      a: in std_logic_vector(c_a_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of mult_11_2_dd4c66afbde2a675:
    component is true;
  attribute fpga_dont_touch of mult_11_2_dd4c66afbde2a675:
    component is "true";
  attribute box_type of mult_11_2_dd4c66afbde2a675:
    component  is "black_box";
  component mult_11_2_30380bd5df9eb5a0
    port (
      b: in std_logic_vector(c_b_width - 1 downto 0);
      p: out std_logic_vector(c_output_width - 1 downto 0);
      clk: in std_logic;
      ce: in std_logic;
      sclr: in std_logic;
      a: in std_logic_vector(c_a_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of mult_11_2_30380bd5df9eb5a0:
    component is true;
  attribute fpga_dont_touch of mult_11_2_30380bd5df9eb5a0:
    component is "true";
  attribute box_type of mult_11_2_30380bd5df9eb5a0:
    component  is "black_box";
  component mult_11_2_3b49a62273275732
    port (
      b: in std_logic_vector(c_b_width - 1 downto 0);
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of mult_11_2_3b49a62273275732:
    component is true;
  attribute fpga_dont_touch of mult_11_2_3b49a62273275732:
    component is "true";
  attribute box_type of mult_11_2_3b49a62273275732:
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
  comp0: if ((core_name0 = "mult_11_2_956d7358e78b2265")) generate
    core_instance0: mult_11_2_956d7358e78b2265
      port map (
        a => tmp_a,
        clk => clk,
        ce => internal_ce,
        sclr => internal_clr,
        p => tmp_p,
        b => tmp_b
      );
  end generate;
  comp1: if ((core_name0 = "mult_11_2_dd4c66afbde2a675")) generate
    core_instance1: mult_11_2_dd4c66afbde2a675
      port map (
        a => tmp_a,
        clk => clk,
        ce => internal_ce,
        sclr => internal_clr,
        p => tmp_p,
        b => tmp_b
      );
  end generate;
  comp2: if ((core_name0 = "mult_11_2_30380bd5df9eb5a0")) generate
    core_instance2: mult_11_2_30380bd5df9eb5a0
      port map (
        a => tmp_a,
        clk => clk,
        ce => internal_ce,
        sclr => internal_clr,
        p => tmp_p,
        b => tmp_b
      );
  end generate;
  comp3: if ((core_name0 = "mult_11_2_3b49a62273275732")) generate
    core_instance3: mult_11_2_3b49a62273275732
      port map (
        a => tmp_a,
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
        -- 'To Register'
        -- 'TIMING_RESET'
        sm_TIMING_RESET_dout : in std_logic_vector(32-1 downto 0);
        sm_TIMING_RESET_din  : out std_logic_vector(32-1 downto 0);
        sm_TIMING_RESET_en   : out std_logic;
        -- 'RSSI_PWR_CALIB'
        sm_RSSI_PWR_CALIB_dout : in std_logic_vector(32-1 downto 0);
        sm_RSSI_PWR_CALIB_din  : out std_logic_vector(32-1 downto 0);
        sm_RSSI_PWR_CALIB_en   : out std_logic;
        -- 'IIR_COEF_B0'
        sm_IIR_COEF_B0_dout : in std_logic_vector(18-1 downto 0);
        sm_IIR_COEF_B0_din  : out std_logic_vector(18-1 downto 0);
        sm_IIR_COEF_B0_en   : out std_logic;
        -- 'IIR_COEF_A1'
        sm_IIR_COEF_A1_dout : in std_logic_vector(18-1 downto 0);
        sm_IIR_COEF_A1_din  : out std_logic_vector(18-1 downto 0);
        sm_IIR_COEF_A1_en   : out std_logic;
        -- 'RESET'
        sm_RESET_dout : in std_logic_vector(32-1 downto 0);
        sm_RESET_din  : out std_logic_vector(32-1 downto 0);
        sm_RESET_en   : out std_logic;
        -- 'TIMING_AGC'
        sm_TIMING_AGC_dout : in std_logic_vector(32-1 downto 0);
        sm_TIMING_AGC_din  : out std_logic_vector(32-1 downto 0);
        sm_TIMING_AGC_en   : out std_logic;
        -- 'TARGET'
        sm_TARGET_dout : in std_logic_vector(32-1 downto 0);
        sm_TARGET_din  : out std_logic_vector(32-1 downto 0);
        sm_TARGET_en   : out std_logic;
        -- 'CONFIG'
        sm_CONFIG_dout : in std_logic_vector(32-1 downto 0);
        sm_CONFIG_din  : out std_logic_vector(32-1 downto 0);
        sm_CONFIG_en   : out std_logic;
        -- 'TIMING_DCO'
        sm_TIMING_DCO_dout : in std_logic_vector(32-1 downto 0);
        sm_TIMING_DCO_din  : out std_logic_vector(32-1 downto 0);
        sm_TIMING_DCO_en   : out std_logic;
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
-- 'To Register'
-- 'TIMING_RESET'
signal sm_TIMING_RESET_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_TIMING_RESET_en_i    : std_logic;
signal sm_TIMING_RESET_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'RSSI_PWR_CALIB'
signal sm_RSSI_PWR_CALIB_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_RSSI_PWR_CALIB_en_i    : std_logic;
signal sm_RSSI_PWR_CALIB_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'IIR_COEF_B0'
signal sm_IIR_COEF_B0_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_IIR_COEF_B0_en_i    : std_logic;
signal sm_IIR_COEF_B0_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'IIR_COEF_A1'
signal sm_IIR_COEF_A1_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_IIR_COEF_A1_en_i    : std_logic;
signal sm_IIR_COEF_A1_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'RESET'
signal sm_RESET_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_RESET_en_i    : std_logic;
signal sm_RESET_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'TIMING_AGC'
signal sm_TIMING_AGC_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_TIMING_AGC_en_i    : std_logic;
signal sm_TIMING_AGC_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'TARGET'
signal sm_TARGET_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_TARGET_en_i    : std_logic;
signal sm_TARGET_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'CONFIG'
signal sm_CONFIG_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_CONFIG_en_i    : std_logic;
signal sm_CONFIG_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
-- 'TIMING_DCO'
signal sm_TIMING_DCO_din_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal sm_TIMING_DCO_en_i    : std_logic;
signal sm_TIMING_DCO_dout_i  : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
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
-- 'To Register'
-- 'TIMING_RESET'
sm_TIMING_RESET_din     <= sm_TIMING_RESET_din_i(32-1 downto 0);
sm_TIMING_RESET_en      <= sm_TIMING_RESET_en_i;
gen_sm_TIMING_RESET_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_TIMING_RESET_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_TIMING_RESET_dout_i;
sm_TIMING_RESET_dout_i(32-1 downto 0) <= sm_TIMING_RESET_dout;
-- 'RSSI_PWR_CALIB'
sm_RSSI_PWR_CALIB_din     <= sm_RSSI_PWR_CALIB_din_i(32-1 downto 0);
sm_RSSI_PWR_CALIB_en      <= sm_RSSI_PWR_CALIB_en_i;
gen_sm_RSSI_PWR_CALIB_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_RSSI_PWR_CALIB_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_RSSI_PWR_CALIB_dout_i;
sm_RSSI_PWR_CALIB_dout_i(32-1 downto 0) <= sm_RSSI_PWR_CALIB_dout;
-- 'IIR_COEF_B0'
sm_IIR_COEF_B0_din     <= sm_IIR_COEF_B0_din_i(18-1 downto 0);
sm_IIR_COEF_B0_en      <= sm_IIR_COEF_B0_en_i;
gen_sm_IIR_COEF_B0_dout_i: if (18 < C_S_AXI_DATA_WIDTH) generate
    sm_IIR_COEF_B0_dout_i(C_S_AXI_DATA_WIDTH-1 downto 18) <= (others => '0');
end generate gen_sm_IIR_COEF_B0_dout_i;
sm_IIR_COEF_B0_dout_i(18-1 downto 0) <= sm_IIR_COEF_B0_dout;
-- 'IIR_COEF_A1'
sm_IIR_COEF_A1_din     <= sm_IIR_COEF_A1_din_i(18-1 downto 0);
sm_IIR_COEF_A1_en      <= sm_IIR_COEF_A1_en_i;
gen_sm_IIR_COEF_A1_dout_i: if (18 < C_S_AXI_DATA_WIDTH) generate
    sm_IIR_COEF_A1_dout_i(C_S_AXI_DATA_WIDTH-1 downto 18) <= (others => '0');
end generate gen_sm_IIR_COEF_A1_dout_i;
sm_IIR_COEF_A1_dout_i(18-1 downto 0) <= sm_IIR_COEF_A1_dout;
-- 'RESET'
sm_RESET_din     <= sm_RESET_din_i(32-1 downto 0);
sm_RESET_en      <= sm_RESET_en_i;
gen_sm_RESET_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_RESET_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_RESET_dout_i;
sm_RESET_dout_i(32-1 downto 0) <= sm_RESET_dout;
-- 'TIMING_AGC'
sm_TIMING_AGC_din     <= sm_TIMING_AGC_din_i(32-1 downto 0);
sm_TIMING_AGC_en      <= sm_TIMING_AGC_en_i;
gen_sm_TIMING_AGC_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_TIMING_AGC_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_TIMING_AGC_dout_i;
sm_TIMING_AGC_dout_i(32-1 downto 0) <= sm_TIMING_AGC_dout;
-- 'TARGET'
sm_TARGET_din     <= sm_TARGET_din_i(32-1 downto 0);
sm_TARGET_en      <= sm_TARGET_en_i;
gen_sm_TARGET_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_TARGET_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_TARGET_dout_i;
sm_TARGET_dout_i(32-1 downto 0) <= sm_TARGET_dout;
-- 'CONFIG'
sm_CONFIG_din     <= sm_CONFIG_din_i(32-1 downto 0);
sm_CONFIG_en      <= sm_CONFIG_en_i;
gen_sm_CONFIG_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_CONFIG_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_CONFIG_dout_i;
sm_CONFIG_dout_i(32-1 downto 0) <= sm_CONFIG_dout;
-- 'TIMING_DCO'
sm_TIMING_DCO_din     <= sm_TIMING_DCO_din_i(32-1 downto 0);
sm_TIMING_DCO_en      <= sm_TIMING_DCO_en_i;
gen_sm_TIMING_DCO_dout_i: if (32 < C_S_AXI_DATA_WIDTH) generate
    sm_TIMING_DCO_dout_i(C_S_AXI_DATA_WIDTH-1 downto 32) <= (others => '0');
end generate gen_sm_TIMING_DCO_dout_i;
sm_TIMING_DCO_dout_i(32-1 downto 0) <= sm_TIMING_DCO_dout;
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
            -- TIMING_RESET din/en
            sm_TIMING_RESET_din_i <= (others => '0');
            sm_TIMING_RESET_en_i <= '0';
            -- RSSI_PWR_CALIB din/en
            sm_RSSI_PWR_CALIB_din_i <= (others => '0');
            sm_RSSI_PWR_CALIB_en_i <= '0';
            -- IIR_COEF_B0 din/en
            sm_IIR_COEF_B0_din_i <= (others => '0');
            sm_IIR_COEF_B0_en_i <= '0';
            -- IIR_COEF_A1 din/en
            sm_IIR_COEF_A1_din_i <= (others => '0');
            sm_IIR_COEF_A1_en_i <= '0';
            -- RESET din/en
            sm_RESET_din_i <= (others => '0');
            sm_RESET_en_i <= '0';
            -- TIMING_AGC din/en
            sm_TIMING_AGC_din_i <= (others => '0');
            sm_TIMING_AGC_en_i <= '0';
            -- TARGET din/en
            sm_TARGET_din_i <= (others => '0');
            sm_TARGET_en_i <= '0';
            -- CONFIG din/en
            sm_CONFIG_din_i <= (others => '0');
            sm_CONFIG_en_i <= '0';
            -- TIMING_DCO din/en
            sm_TIMING_DCO_din_i <= (others => '0');
            sm_TIMING_DCO_en_i <= '0';
            -- 'To FIFO'
            -- 'Shared Memory'
        else
            -- default assignments

            -- 'To Register'
            if (unsigned(write_bank_addr_i) = 2) then
                if (unsigned(write_linear_addr_i) = 0) then
                    -- TIMING_RESET din/en
                    sm_TIMING_RESET_din_i <= S_AXI_WDATA;
                    sm_TIMING_RESET_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 1) then
                    -- RSSI_PWR_CALIB din/en
                    sm_RSSI_PWR_CALIB_din_i <= S_AXI_WDATA;
                    sm_RSSI_PWR_CALIB_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 2) then
                    -- IIR_COEF_B0 din/en
                    sm_IIR_COEF_B0_din_i <= S_AXI_WDATA;
                    sm_IIR_COEF_B0_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 3) then
                    -- IIR_COEF_A1 din/en
                    sm_IIR_COEF_A1_din_i <= S_AXI_WDATA;
                    sm_IIR_COEF_A1_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 4) then
                    -- RESET din/en
                    sm_RESET_din_i <= S_AXI_WDATA;
                    sm_RESET_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 5) then
                    -- TIMING_AGC din/en
                    sm_TIMING_AGC_din_i <= S_AXI_WDATA;
                    sm_TIMING_AGC_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 6) then
                    -- TARGET din/en
                    sm_TARGET_din_i <= S_AXI_WDATA;
                    sm_TARGET_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 7) then
                    -- CONFIG din/en
                    sm_CONFIG_din_i <= S_AXI_WDATA;
                    sm_CONFIG_en_i  <= write_addr_valid;
                elsif (unsigned(write_linear_addr_i) = 8) then
                    -- TIMING_DCO din/en
                    sm_TIMING_DCO_din_i <= S_AXI_WDATA;
                    sm_TIMING_DCO_en_i  <= write_addr_valid;
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
                -- 'To Register' (with register readback)
                if (unsigned(read_linear_addr_i) = 0) then
                    -- 'TIMING_RESET' dout
                    reg_bank_out_i <= sm_TIMING_RESET_dout_i;
                elsif (unsigned(read_linear_addr_i) = 1) then
                    -- 'RSSI_PWR_CALIB' dout
                    reg_bank_out_i <= sm_RSSI_PWR_CALIB_dout_i;
                elsif (unsigned(read_linear_addr_i) = 2) then
                    -- 'IIR_COEF_B0' dout
                    reg_bank_out_i <= sm_IIR_COEF_B0_dout_i;
                elsif (unsigned(read_linear_addr_i) = 3) then
                    -- 'IIR_COEF_A1' dout
                    reg_bank_out_i <= sm_IIR_COEF_A1_dout_i;
                elsif (unsigned(read_linear_addr_i) = 4) then
                    -- 'RESET' dout
                    reg_bank_out_i <= sm_RESET_dout_i;
                elsif (unsigned(read_linear_addr_i) = 5) then
                    -- 'TIMING_AGC' dout
                    reg_bank_out_i <= sm_TIMING_AGC_dout_i;
                elsif (unsigned(read_linear_addr_i) = 6) then
                    -- 'TARGET' dout
                    reg_bank_out_i <= sm_TARGET_dout_i;
                elsif (unsigned(read_linear_addr_i) = 7) then
                    -- 'CONFIG' dout
                    reg_bank_out_i <= sm_CONFIG_dout_i;
                elsif (unsigned(read_linear_addr_i) = 8) then
                    -- 'TIMING_DCO' dout
                    reg_bank_out_i <= sm_TIMING_DCO_dout_i;
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

entity mux_71afdb0de4 is
  port (
    sel : in std_logic_vector((2 - 1) downto 0);
    d0 : in std_logic_vector((5 - 1) downto 0);
    d1 : in std_logic_vector((5 - 1) downto 0);
    d2 : in std_logic_vector((5 - 1) downto 0);
    y : out std_logic_vector((5 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_71afdb0de4;


architecture behavior of mux_71afdb0de4 is
  signal sel_1_20: std_logic_vector((2 - 1) downto 0);
  signal d0_1_24: std_logic_vector((5 - 1) downto 0);
  signal d1_1_27: std_logic_vector((5 - 1) downto 0);
  signal d2_1_30: std_logic_vector((5 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((5 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  proc_switch_6_1: process (d0_1_24, d1_1_27, d2_1_30, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "00" =>
        unregy_join_6_1 <= d0_1_24;
      when "01" =>
        unregy_join_6_1 <= d1_1_27;
      when others =>
        unregy_join_6_1 <= d2_1_30;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity shift_c7000d680d is
  port (
    ip : in std_logic_vector((8 - 1) downto 0);
    op : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end shift_c7000d680d;


architecture behavior of shift_c7000d680d is
  signal ip_1_23: signed((8 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((8 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "00000000");
  signal op_mem_46_20_front_din: signed((8 - 1) downto 0);
  signal op_mem_46_20_back: signed((8 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_36_3_convert: signed((8 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_36_3_convert <= s2s_cast(ip_1_23, 1, 8, 0);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_36_3_convert);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_357f42eab8 is
  port (
    op : out std_logic_vector((12 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_357f42eab8;


architecture behavior of constant_357f42eab8 is
begin
  op <= "000100010001";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_998e20a1ca is
  port (
    sel : in std_logic_vector((2 - 1) downto 0);
    d0 : in std_logic_vector((8 - 1) downto 0);
    d1 : in std_logic_vector((8 - 1) downto 0);
    d2 : in std_logic_vector((8 - 1) downto 0);
    d3 : in std_logic_vector((8 - 1) downto 0);
    y : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_998e20a1ca;


architecture behavior of mux_998e20a1ca is
  signal sel_1_20: std_logic_vector((2 - 1) downto 0);
  signal d0_1_24: std_logic_vector((8 - 1) downto 0);
  signal d1_1_27: std_logic_vector((8 - 1) downto 0);
  signal d2_1_30: std_logic_vector((8 - 1) downto 0);
  signal d3_1_33: std_logic_vector((8 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((8 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  d3_1_33 <= d3;
  proc_switch_6_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "00" =>
        unregy_join_6_1 <= d0_1_24;
      when "01" =>
        unregy_join_6_1 <= d1_1_27;
      when "10" =>
        unregy_join_6_1 <= d2_1_30;
      when others =>
        unregy_join_6_1 <= d3_1_33;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity accum_4212bee193 is
  port (
    b : in std_logic_vector((21 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((26 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end accum_4212bee193;


architecture behavior of accum_4212bee193 is
  signal b_17_24: signed((21 - 1) downto 0);
  signal en_17_32: boolean;
  signal accum_reg_41_23: signed((26 - 1) downto 0) := "00000000000000000000000000";
  signal accum_reg_41_23_en: std_logic;
  signal cast_51_42: signed((26 - 1) downto 0);
  signal accum_reg_join_47_1: signed((27 - 1) downto 0);
  signal accum_reg_join_47_1_en: std_logic;
begin
  b_17_24 <= std_logic_vector_to_signed(b);
  en_17_32 <= ((en) = "1");
  proc_accum_reg_41_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (accum_reg_41_23_en = '1')) then
        accum_reg_41_23 <= accum_reg_41_23 + cast_51_42;
      end if;
    end if;
  end process proc_accum_reg_41_23;
  cast_51_42 <= s2s_cast(b_17_24, 19, 26, 19);
  proc_if_47_1: process (accum_reg_41_23, cast_51_42, en_17_32)
  is
  begin
    if en_17_32 then
      accum_reg_join_47_1_en <= '1';
    else 
      accum_reg_join_47_1_en <= '0';
    end if;
  end process proc_if_47_1;
  accum_reg_41_23_en <= accum_reg_join_47_1_en;
  q <= signed_to_std_logic_vector(accum_reg_41_23);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity addsub_a89167bf37 is
  port (
    a : in std_logic_vector((20 - 1) downto 0);
    b : in std_logic_vector((20 - 1) downto 0);
    s : out std_logic_vector((21 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end addsub_a89167bf37;


architecture behavior of addsub_a89167bf37 is
  signal a_17_32: unsigned((20 - 1) downto 0);
  signal b_17_35: unsigned((20 - 1) downto 0);
  type array_type_op_mem_91_20 is array (0 to (1 - 1)) of signed((21 - 1) downto 0);
  signal op_mem_91_20: array_type_op_mem_91_20 := (
    0 => "000000000000000000000");
  signal op_mem_91_20_front_din: signed((21 - 1) downto 0);
  signal op_mem_91_20_back: signed((21 - 1) downto 0);
  signal op_mem_91_20_push_front_pop_back_en: std_logic;
  type array_type_cout_mem_92_22 is array (0 to (1 - 1)) of unsigned((1 - 1) downto 0);
  signal cout_mem_92_22: array_type_cout_mem_92_22 := (
    0 => "0");
  signal cout_mem_92_22_front_din: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_back: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_push_front_pop_back_en: std_logic;
  signal prev_mode_93_22_next: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22_reg_i: std_logic_vector((3 - 1) downto 0);
  signal prev_mode_93_22_reg_o: std_logic_vector((3 - 1) downto 0);
  signal cast_71_18: signed((22 - 1) downto 0);
  signal cast_71_22: signed((22 - 1) downto 0);
  signal internal_s_71_5_addsub: signed((22 - 1) downto 0);
  signal internal_s_83_3_convert: signed((21 - 1) downto 0);
begin
  a_17_32 <= std_logic_vector_to_unsigned(a);
  b_17_35 <= std_logic_vector_to_unsigned(b);
  op_mem_91_20_back <= op_mem_91_20(0);
  proc_op_mem_91_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_91_20_push_front_pop_back_en = '1')) then
        op_mem_91_20(0) <= op_mem_91_20_front_din;
      end if;
    end if;
  end process proc_op_mem_91_20;
  cout_mem_92_22_back <= cout_mem_92_22(0);
  proc_cout_mem_92_22: process (clk)
  is
    variable i_x_000000: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (cout_mem_92_22_push_front_pop_back_en = '1')) then
        cout_mem_92_22(0) <= cout_mem_92_22_front_din;
      end if;
    end if;
  end process proc_cout_mem_92_22;
  prev_mode_93_22_reg_i <= unsigned_to_std_logic_vector(prev_mode_93_22_next);
  prev_mode_93_22 <= std_logic_vector_to_unsigned(prev_mode_93_22_reg_o);
  prev_mode_93_22_reg_inst: entity work.synth_reg_w_init
    generic map (
      init_index => 2, 
      init_value => b"010", 
      latency => 1, 
      width => 3)
    port map (
      ce => ce, 
      clk => clk, 
      clr => clr, 
      i => prev_mode_93_22_reg_i, 
      o => prev_mode_93_22_reg_o);
  cast_71_18 <= u2s_cast(a_17_32, 19, 22, 19);
  cast_71_22 <= u2s_cast(b_17_35, 19, 22, 19);
  internal_s_71_5_addsub <= cast_71_18 - cast_71_22;
  internal_s_83_3_convert <= std_logic_vector_to_signed(convert_type(signed_to_std_logic_vector(internal_s_71_5_addsub), 22, 19, xlSigned, 21, 19, xlSigned, xlTruncate, xlSaturate));
  op_mem_91_20_front_din <= internal_s_83_3_convert;
  op_mem_91_20_push_front_pop_back_en <= '1';
  cout_mem_92_22_front_din <= std_logic_vector_to_unsigned("0");
  cout_mem_92_22_push_front_pop_back_en <= '1';
  prev_mode_93_22_next <= std_logic_vector_to_unsigned("000");
  s <= signed_to_std_logic_vector(op_mem_91_20_back);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity shift_ae71adf6a0 is
  port (
    ip : in std_logic_vector((26 - 1) downto 0);
    op : out std_logic_vector((26 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end shift_ae71adf6a0;


architecture behavior of shift_ae71adf6a0 is
  signal ip_1_23: unsigned((26 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of unsigned((26 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "00000000000000000000000000");
  signal op_mem_46_20_front_din: unsigned((26 - 1) downto 0);
  signal op_mem_46_20_back: unsigned((26 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_36_3_convert: unsigned((26 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_unsigned(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_36_3_convert <= u2u_cast(ip_1_23, 23, 26, 19);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= unsigned_to_std_logic_vector(cast_internal_ip_36_3_convert);
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
entity xlsprom_wlan_agc is
  generic (
    core_name0: string := "";
    c_width: integer := 12;
    c_address_width: integer := 4;
    latency: integer := 1
  );
  port (
    addr: in std_logic_vector(c_address_width - 1 downto 0);
    en: in std_logic_vector(0 downto 0);
    rst: in std_logic_vector(0 downto 0);
    ce: in std_logic;
    clk: in std_logic;
    data: out std_logic_vector(c_width - 1 downto 0)
  );
end xlsprom_wlan_agc ;
architecture behavior of xlsprom_wlan_agc is
  component synth_reg
    generic (
      width: integer;
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
  signal core_addr: std_logic_vector(c_address_width - 1 downto 0);
  signal core_data_out: std_logic_vector(c_width - 1 downto 0);
  signal core_ce, sinit: std_logic;
  component bmg_72_3c8cb899503da0de
    port (
                              addra: in std_logic_vector(c_address_width - 1 downto 0);
      clka: in std_logic;
      ena: in std_logic;
      douta: out std_logic_vector(c_width - 1 downto 0)
    );
  end component;

  attribute syn_black_box of bmg_72_3c8cb899503da0de:
    component is true;
  attribute fpga_dont_touch of bmg_72_3c8cb899503da0de:
    component is "true";
  attribute box_type of bmg_72_3c8cb899503da0de:
    component  is "black_box";
begin
  core_addr <= addr;
  core_ce <= ce and en(0);
  sinit <= rst(0) and ce;
  comp0: if ((core_name0 = "bmg_72_3c8cb899503da0de")) generate
    core_instance0: bmg_72_3c8cb899503da0de
      port map (
        addra => core_addr,
        clka => clk,
        ena => core_ce,
        douta => core_data_out
                        );
  end generate;
  latency_test: if (latency > 1) generate
    reg: synth_reg
      generic map (
        width => c_width,
        latency => latency - 1
      )
      port map (
        i => core_data_out,
        ce => core_ce,
        clr => '0',
        clk => clk,
        o => data
      );
  end generate;
  latency_1: if (latency <= 1) generate
    data <= core_data_out;
  end generate;
end  behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity reinterpret_6b1adb5d55 is
  port (
    input_port : in std_logic_vector((11 - 1) downto 0);
    output_port : out std_logic_vector((11 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_6b1adb5d55;


architecture behavior of reinterpret_6b1adb5d55 is
  signal input_port_1_40: unsigned((11 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_32afb77cd2 is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_32afb77cd2;


architecture behavior of concat_32afb77cd2 is
  signal in0_1_23: boolean;
  signal in1_1_27: boolean;
  signal y_2_1_concat: unsigned((2 - 1) downto 0);
begin
  in0_1_23 <= ((in0) = "1");
  in1_1_27 <= ((in1) = "1");
  y_2_1_concat <= std_logic_vector_to_unsigned(boolean_to_vector(in0_1_23) & boolean_to_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
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

entity constant_a7e2bb9e12 is
  port (
    op : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_a7e2bb9e12;


architecture behavior of constant_a7e2bb9e12 is
begin
  op <= "01";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_7ea0f2fff7 is
  port (
    op : out std_logic_vector((6 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_7ea0f2fff7;


architecture behavior of constant_7ea0f2fff7 is
begin
  op <= "000000";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_c11beaf011 is
  port (
    op : out std_logic_vector((6 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_c11beaf011;


architecture behavior of constant_c11beaf011 is
begin
  op <= "001111";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_b8537696ec is
  port (
    op : out std_logic_vector((6 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_b8537696ec;


architecture behavior of constant_b8537696ec is
begin
  op <= "100010";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_1a0db76efe is
  port (
    sel : in std_logic_vector((2 - 1) downto 0);
    d0 : in std_logic_vector((2 - 1) downto 0);
    d1 : in std_logic_vector((2 - 1) downto 0);
    d2 : in std_logic_vector((2 - 1) downto 0);
    d3 : in std_logic_vector((2 - 1) downto 0);
    y : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_1a0db76efe;


architecture behavior of mux_1a0db76efe is
  signal sel_1_20: std_logic_vector((2 - 1) downto 0);
  signal d0_1_24: std_logic_vector((2 - 1) downto 0);
  signal d1_1_27: std_logic_vector((2 - 1) downto 0);
  signal d2_1_30: std_logic_vector((2 - 1) downto 0);
  signal d3_1_33: std_logic_vector((2 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((2 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  d3_1_33 <= d3;
  proc_switch_6_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "00" =>
        unregy_join_6_1 <= d0_1_24;
      when "01" =>
        unregy_join_6_1 <= d1_1_27;
      when "10" =>
        unregy_join_6_1 <= d2_1_30;
      when others =>
        unregy_join_6_1 <= d3_1_33;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_593ae85213 is
  port (
    sel : in std_logic_vector((2 - 1) downto 0);
    d0 : in std_logic_vector((6 - 1) downto 0);
    d1 : in std_logic_vector((6 - 1) downto 0);
    d2 : in std_logic_vector((6 - 1) downto 0);
    d3 : in std_logic_vector((6 - 1) downto 0);
    y : out std_logic_vector((6 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_593ae85213;


architecture behavior of mux_593ae85213 is
  signal sel_1_20: std_logic_vector((2 - 1) downto 0);
  signal d0_1_24: std_logic_vector((6 - 1) downto 0);
  signal d1_1_27: std_logic_vector((6 - 1) downto 0);
  signal d2_1_30: std_logic_vector((6 - 1) downto 0);
  signal d3_1_33: std_logic_vector((6 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((6 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  d3_1_33 <= d3;
  proc_switch_6_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "00" =>
        unregy_join_6_1 <= d0_1_24;
      when "01" =>
        unregy_join_6_1 <= d1_1_27;
      when "10" =>
        unregy_join_6_1 <= d2_1_30;
      when others =>
        unregy_join_6_1 <= d3_1_33;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_3e2cefc69d is
  port (
    a : in std_logic_vector((8 - 1) downto 0);
    b : in std_logic_vector((8 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_3e2cefc69d;


architecture behavior of relational_3e2cefc69d is
  signal a_1_31: signed((8 - 1) downto 0);
  signal b_1_34: signed((8 - 1) downto 0);
  signal result_22_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_signed(a);
  b_1_34 <= std_logic_vector_to_signed(b);
  result_22_3_rel <= a_1_31 >= b_1_34;
  op <= boolean_to_vector(result_22_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_f9928864ea is
  port (
    a : in std_logic_vector((2 - 1) downto 0);
    b : in std_logic_vector((2 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_f9928864ea;


architecture behavior of relational_f9928864ea is
  signal a_1_31: unsigned((2 - 1) downto 0);
  signal b_1_34: unsigned((2 - 1) downto 0);
  signal result_14_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_14_3_rel <= a_1_31 /= b_1_34;
  op <= boolean_to_vector(result_14_3_rel);
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
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity xladdrsr_wlan_agc is
  generic (
    core_name0: string := "";
    addr_arith: integer := xlSigned;
    addr_bin_pt: integer := 7;
    addr_width: integer := 12;
    core_addr_width: integer := 0;
    d_arith: integer := xlSigned;
    d_bin_pt: integer := 7;
    d_width: integer := 12;
    en_width: integer := 5;
    en_bin_pt: integer := 2;
    en_arith: integer := xlUnsigned;
    q_arith: integer := xlSigned;
    q_bin_pt: integer := 7;
    q_width: integer := xlSigned
  );
  port (
    d: in std_logic_vector(d_width - 1 downto 0);
    addr: in std_logic_vector(addr_width - 1 downto 0);
    ce: in std_logic;
    clr: in std_logic;
    clk: in std_logic;
    en: in std_logic_vector(0 downto 0) := (others => '1');
    q: out std_logic_vector(d_width - 1 downto 0)
  );
end xladdrsr_wlan_agc;
architecture behavior of xladdrsr_wlan_agc is
  signal internal_ce: std_logic;
  signal padded_addr: std_logic_vector(core_addr_width-1 downto 0) := (others => '0');
  component asr_11_0_5c9c6a297ef30376
    port (
      clk: in std_logic;
      d: in std_logic_vector(d_width - 1 downto 0);
      q: out std_logic_vector(d_width - 1 downto 0);
      a: in std_logic_vector(core_addr_width - 1 downto 0);
      ce: in std_logic
    );
  end component;

  attribute syn_black_box of asr_11_0_5c9c6a297ef30376:
    component is true;
  attribute fpga_dont_touch of asr_11_0_5c9c6a297ef30376:
    component is "true";
  attribute box_type of asr_11_0_5c9c6a297ef30376:
    component  is "black_box";
begin
  internal_ce <= ce and en(0);
  padded_addr(addr_width-1 downto 0) <= addr(addr_width-1 downto 0);
  comp0: if ((core_name0 = "asr_11_0_5c9c6a297ef30376")) generate
    core_instance0: asr_11_0_5c9c6a297ef30376
      port map (
        clk => clk,
        d => d,
        q => q,
        a => padded_addr,
        ce => internal_ce
      );
  end generate;
end architecture behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity accum_a47f50b4df is
  port (
    b : in std_logic_vector((11 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end accum_a47f50b4df;


architecture behavior of accum_a47f50b4df is
  signal b_17_24: signed((11 - 1) downto 0);
  signal rst_17_27: boolean;
  signal accum_reg_41_23: signed((16 - 1) downto 0) := "0000000000000000";
  signal accum_reg_41_23_rst: std_logic;
  signal cast_51_42: signed((16 - 1) downto 0);
  signal accum_reg_join_47_1: signed((17 - 1) downto 0);
  signal accum_reg_join_47_1_rst: std_logic;
begin
  b_17_24 <= std_logic_vector_to_signed(b);
  rst_17_27 <= ((rst) = "1");
  proc_accum_reg_41_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (accum_reg_41_23_rst = '1')) then
        accum_reg_41_23 <= "0000000000000000";
      elsif (ce = '1') then 
        accum_reg_41_23 <= accum_reg_41_23 + cast_51_42;
      end if;
    end if;
  end process proc_accum_reg_41_23;
  cast_51_42 <= s2s_cast(b_17_24, 0, 16, 0);
  proc_if_47_1: process (accum_reg_41_23, cast_51_42, rst_17_27)
  is
  begin
    if rst_17_27 then
      accum_reg_join_47_1_rst <= '1';
    else 
      accum_reg_join_47_1_rst <= '0';
    end if;
  end process proc_if_47_1;
  accum_reg_41_23_rst <= accum_reg_join_47_1_rst;
  q <= signed_to_std_logic_vector(accum_reg_41_23);
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

entity constant_0f59f02ba5 is
  port (
    op : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_0f59f02ba5;


architecture behavior of constant_0f59f02ba5 is
begin
  op <= "011";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_1d6ad1c713 is
  port (
    op : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_1d6ad1c713;


architecture behavior of constant_1d6ad1c713 is
begin
  op <= "111";
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
-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on
entity xldsamp is
  generic (
    d_width: integer := 12;
    d_bin_pt: integer := 0;
    d_arith: integer := xlUnsigned;
    q_width: integer := 12;
    q_bin_pt: integer := 0;
    q_arith: integer := xlUnsigned;
    en_width: integer := 1;
    en_bin_pt: integer := 0;
    en_arith: integer := xlUnsigned;
    ds_ratio: integer := 2;
    phase: integer := 0;
    latency: integer := 1
  );
  port (
    d: in std_logic_vector(d_width - 1 downto 0);
    src_clk: in std_logic;
    src_ce: in std_logic;
    src_clr: in std_logic;
    dest_clk: in std_logic;
    dest_ce: in std_logic;
    dest_clr: in std_logic;
    en: in std_logic_vector(en_width - 1 downto 0);
    q: out std_logic_vector(q_width - 1 downto 0)
  );
end xldsamp;
architecture struct of xldsamp is
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
  component fdse
    port (
      q: out   std_ulogic;
      d: in    std_ulogic;
      c: in    std_ulogic;
      s: in    std_ulogic;
      ce: in    std_ulogic
    );
  end component;
  attribute syn_black_box of fdse: component is true;
  attribute fpga_dont_touch of fdse: component is "true";
  signal adjusted_dest_ce: std_logic;
  signal adjusted_dest_ce_w_en: std_logic;
  signal dest_ce_w_en: std_logic;
  signal smpld_d: std_logic_vector(d_width-1 downto 0);
begin
  adjusted_ce_needed: if ((latency = 0) or (phase /= (ds_ratio - 1))) generate
    dest_ce_reg: fdse
      port map (
        q => adjusted_dest_ce,
        d => dest_ce,
        c => src_clk,
        s => src_clr,
        ce => src_ce
      );
  end generate;
  latency_eq_0: if (latency = 0) generate
    shutter_d_reg: synth_reg
      generic map (
        width => d_width,
        latency => 1
      )
      port map (
        i => d,
        ce => adjusted_dest_ce,
        clr => src_clr,
        clk => src_clk,
        o => smpld_d
      );
    shutter_mux: process (adjusted_dest_ce, d, smpld_d)
    begin
      if adjusted_dest_ce = '0' then
        q <= smpld_d;
      else
        q <= d;
      end if;
    end process;
  end generate;
  latency_gt_0: if (latency > 0) generate
    dbl_reg_test: if (phase /= (ds_ratio-1)) generate
        smpl_d_reg: synth_reg
          generic map (
            width => d_width,
            latency => 1
          )
          port map (
            i => d,
            ce => adjusted_dest_ce_w_en,
            clr => src_clr,
            clk => src_clk,
            o => smpld_d
          );
    end generate;
    sngl_reg_test: if (phase = (ds_ratio -1)) generate
      smpld_d <= d;
    end generate;
    latency_pipe: synth_reg
      generic map (
        width => d_width,
        latency => latency
      )
      port map (
        i => smpld_d,
        ce => dest_ce_w_en,
        clr => src_clr,
        clk => dest_clk,
        o => q
      );
  end generate;
  dest_ce_w_en <= dest_ce and en(0);
  adjusted_dest_ce_w_en <= adjusted_dest_ce and en(0);
end architecture struct;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_04b0784a6e is
  port (
    sel : in std_logic_vector((2 - 1) downto 0);
    d0 : in std_logic_vector((2 - 1) downto 0);
    d1 : in std_logic_vector((2 - 1) downto 0);
    d2 : in std_logic_vector((3 - 1) downto 0);
    d3 : in std_logic_vector((3 - 1) downto 0);
    y : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_04b0784a6e;


architecture behavior of mux_04b0784a6e is
  signal sel_1_20: std_logic_vector((2 - 1) downto 0);
  signal d0_1_24: std_logic_vector((2 - 1) downto 0);
  signal d1_1_27: std_logic_vector((2 - 1) downto 0);
  signal d2_1_30: std_logic_vector((3 - 1) downto 0);
  signal d3_1_33: std_logic_vector((3 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((3 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  d3_1_33 <= d3;
  proc_switch_6_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "00" =>
        unregy_join_6_1 <= cast(d0_1_24, 0, 3, 0, xlUnsigned);
      when "01" =>
        unregy_join_6_1 <= cast(d1_1_27, 0, 3, 0, xlUnsigned);
      when "10" =>
        unregy_join_6_1 <= d2_1_30;
      when others =>
        unregy_join_6_1 <= d3_1_33;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_824669a396 is
  port (
    sel : in std_logic_vector((2 - 1) downto 0);
    d0 : in std_logic_vector((16 - 1) downto 0);
    d1 : in std_logic_vector((16 - 1) downto 0);
    d2 : in std_logic_vector((16 - 1) downto 0);
    d3 : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_824669a396;


architecture behavior of mux_824669a396 is
  signal sel_1_20: std_logic_vector((2 - 1) downto 0);
  signal d0_1_24: std_logic_vector((16 - 1) downto 0);
  signal d1_1_27: std_logic_vector((16 - 1) downto 0);
  signal d2_1_30: std_logic_vector((16 - 1) downto 0);
  signal d3_1_33: std_logic_vector((16 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((16 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  d3_1_33 <= d3;
  proc_switch_6_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "00" =>
        unregy_join_6_1 <= d0_1_24;
      when "01" =>
        unregy_join_6_1 <= d1_1_27;
      when "10" =>
        unregy_join_6_1 <= d2_1_30;
      when others =>
        unregy_join_6_1 <= d3_1_33;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity shift_4c1752dcd9 is
  port (
    ip : in std_logic_vector((16 - 1) downto 0);
    op : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end shift_4c1752dcd9;


architecture behavior of shift_4c1752dcd9 is
  signal ip_1_23: signed((16 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((16 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "0000000000000000");
  signal op_mem_46_20_front_din: signed((16 - 1) downto 0);
  signal op_mem_46_20_back: signed((16 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_36_3_convert: signed((16 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_36_3_convert <= s2s_cast(ip_1_23, 1, 16, 0);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_36_3_convert);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity shift_529a3020ac is
  port (
    ip : in std_logic_vector((16 - 1) downto 0);
    op : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end shift_529a3020ac;


architecture behavior of shift_529a3020ac is
  signal ip_1_23: signed((16 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((16 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "0000000000000000");
  signal op_mem_46_20_front_din: signed((16 - 1) downto 0);
  signal op_mem_46_20_back: signed((16 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_36_3_convert: signed((16 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_36_3_convert <= s2s_cast(ip_1_23, 2, 16, 0);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_36_3_convert);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity shift_df8070c965 is
  port (
    ip : in std_logic_vector((16 - 1) downto 0);
    op : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end shift_df8070c965;


architecture behavior of shift_df8070c965 is
  signal ip_1_23: signed((16 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((16 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "0000000000000000");
  signal op_mem_46_20_front_din: signed((16 - 1) downto 0);
  signal op_mem_46_20_back: signed((16 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_36_3_convert: signed((16 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_36_3_convert <= s2s_cast(ip_1_23, 3, 16, 0);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_36_3_convert);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity reinterpret_f88c654950 is
  port (
    input_port : in std_logic_vector((6 - 1) downto 0);
    output_port : out std_logic_vector((6 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_f88c654950;


architecture behavior of reinterpret_f88c654950 is
  signal input_port_1_40: unsigned((6 - 1) downto 0);
  signal output_port_5_5_force: signed((6 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port_5_5_force <= unsigned_to_signed(input_port_1_40);
  output_port <= signed_to_std_logic_vector(output_port_5_5_force);
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
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/ADC Inputs"

entity adc_inputs_entity_c93cca5505 is
  port (
    ce_1: in std_logic; 
    ce_8: in std_logic; 
    clk_1: in std_logic; 
    clk_8: in std_logic; 
    iq_valid: out std_logic
  );
end adc_inputs_entity_c93cca5505;

architecture structural of adc_inputs_entity_c93cca5505 is
  signal ce_1_sg_x0: std_logic;
  signal ce_8_sg_x0: std_logic;
  signal clk_1_sg_x0: std_logic;
  signal clk_8_sg_x0: std_logic;
  signal constant_op_net: std_logic;
  signal convert2_dout_net_x0: std_logic;
  signal up_sample_q_net: std_logic;

begin
  ce_1_sg_x0 <= ce_1;
  ce_8_sg_x0 <= ce_8;
  clk_1_sg_x0 <= clk_1;
  clk_8_sg_x0 <= clk_8;
  iq_valid <= convert2_dout_net_x0;

  constant_x0: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant_op_net
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
      ce => ce_1_sg_x0,
      clk => clk_1_sg_x0,
      clr => '0',
      din(0) => up_sample_q_net,
      en => "1",
      dout(0) => convert2_dout_net_x0
    );

  up_sample: entity work.xlusamp
    generic map (
      copy_samples => 0,
      d_arith => xlUnsigned,
      d_bin_pt => 0,
      d_width => 1,
      latency => 0,
      q_arith => xlUnsigned,
      q_bin_pt => 0,
      q_width => 1
    )
    port map (
      d(0) => constant_op_net,
      dest_ce => ce_1_sg_x0,
      dest_clk => clk_1_sg_x0,
      dest_clr => '0',
      en => "1",
      src_ce => ce_8_sg_x0,
      src_clk => clk_8_sg_x0,
      src_clr => '0',
      q(0) => up_sample_q_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Ctrl/Negedge"

entity negedge_entity_185fb70e0a is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    d: in std_logic; 
    q: out std_logic
  );
end negedge_entity_185fb70e0a;

architecture structural of negedge_entity_185fb70e0a is
  signal agc_run_net_x0: std_logic;
  signal ce_1_sg_x1: std_logic;
  signal clk_1_sg_x1: std_logic;
  signal delay_q_net: std_logic;
  signal inverter_op_net: std_logic;
  signal logical1_y_net_x0: std_logic;

begin
  ce_1_sg_x1 <= ce_1;
  clk_1_sg_x1 <= clk_1;
  agc_run_net_x0 <= d;
  q <= logical1_y_net_x0;

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      d(0) => agc_run_net_x0,
      en => '1',
      rst => '1',
      q(0) => delay_q_net
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      clr => '0',
      ip(0) => agc_run_net_x0,
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

-- Generated from Simulink block "wlan_agc/Ctrl/Posedge1"

entity posedge1_entity_004617dd31 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    d: in std_logic; 
    q: out std_logic
  );
end posedge1_entity_004617dd31;

architecture structural of posedge1_entity_004617dd31 is
  signal ce_1_sg_x2: std_logic;
  signal clk_1_sg_x2: std_logic;
  signal delay_q_net: std_logic;
  signal inverter_op_net: std_logic;
  signal logical1_y_net_x0: std_logic;
  signal relational_op_net_x0: std_logic;

begin
  ce_1_sg_x2 <= ce_1;
  clk_1_sg_x2 <= clk_1;
  relational_op_net_x0 <= d;
  q <= logical1_y_net_x0;

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      d(0) => relational_op_net_x0,
      en => '1',
      rst => '1',
      q(0) => delay_q_net
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
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
      d1(0) => relational_op_net_x0,
      y(0) => logical1_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Ctrl/Reset Counter/S-R Latch1"

entity s_r_latch1_entity_4a86541ec6 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    r: in std_logic; 
    s: in std_logic; 
    q: out std_logic
  );
end s_r_latch1_entity_4a86541ec6;

architecture structural of s_r_latch1_entity_4a86541ec6 is
  signal ce_1_sg_x12: std_logic;
  signal clk_1_sg_x12: std_logic;
  signal constant1_op_net: std_logic;
  signal convert1_dout_net: std_logic;
  signal convert2_dout_net: std_logic;
  signal inverter1_op_net_x0: std_logic;
  signal logical1_y_net_x1: std_logic;
  signal register2_q_net_x0: std_logic;

begin
  ce_1_sg_x12 <= ce_1;
  clk_1_sg_x12 <= clk_1;
  inverter1_op_net_x0 <= r;
  logical1_y_net_x1 <= s;
  q <= register2_q_net_x0;

  constant1: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant1_op_net
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
      ce => ce_1_sg_x12,
      clk => clk_1_sg_x12,
      clr => '0',
      din(0) => inverter1_op_net_x0,
      en => "1",
      dout(0) => convert1_dout_net
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
      ce => ce_1_sg_x12,
      clk => clk_1_sg_x12,
      clr => '0',
      din(0) => logical1_y_net_x1,
      en => "1",
      dout(0) => convert2_dout_net
    );

  register2: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x12,
      clk => clk_1_sg_x12,
      d(0) => constant1_op_net,
      en(0) => convert2_dout_net,
      rst(0) => convert1_dout_net,
      q(0) => register2_q_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Ctrl/Reset Counter"

entity reset_counter_entity_47866fe301 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    done: in std_logic; 
    iq_valid: in std_logic; 
    count: out std_logic_vector(7 downto 0)
  );
end reset_counter_entity_47866fe301;

architecture structural of reset_counter_entity_47866fe301 is
  signal ce_1_sg_x13: std_logic;
  signal clk_1_sg_x13: std_logic;
  signal constant2_op_net: std_logic_vector(7 downto 0);
  signal convert2_dout_net_x1: std_logic;
  signal counter1_op_net_x0: std_logic_vector(7 downto 0);
  signal inverter1_op_net_x0: std_logic;
  signal logical1_y_net_x2: std_logic;
  signal logical2_y_net: std_logic;
  signal register2_q_net_x0: std_logic;
  signal relational1_op_net: std_logic;

begin
  ce_1_sg_x13 <= ce_1;
  clk_1_sg_x13 <= clk_1;
  logical1_y_net_x2 <= done;
  convert2_dout_net_x1 <= iq_valid;
  count <= counter1_op_net_x0;

  constant2: entity work.constant_1993116bef
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant2_op_net
    );

  counter1: entity work.xlcounter_free_wlan_agc
    generic map (
      core_name0 => "cntr_11_0_86806e294f737f4c",
      op_arith => xlUnsigned,
      op_width => 8
    )
    port map (
      ce => ce_1_sg_x13,
      clk => clk_1_sg_x13,
      clr => '0',
      en(0) => logical2_y_net,
      rst(0) => inverter1_op_net_x0,
      op => counter1_op_net_x0
    );

  inverter1: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x13,
      clk => clk_1_sg_x13,
      clr => '0',
      ip(0) => relational1_op_net,
      op(0) => inverter1_op_net_x0
    );

  logical2: entity work.logical_954ee29728
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert2_dout_net_x1,
      d1(0) => register2_q_net_x0,
      d2(0) => relational1_op_net,
      y(0) => logical2_y_net
    );

  relational1: entity work.relational_5a9c998b07
    port map (
      a => counter1_op_net_x0,
      b => constant2_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net
    );

  s_r_latch1_4a86541ec6: entity work.s_r_latch1_entity_4a86541ec6
    port map (
      ce_1 => ce_1_sg_x13,
      clk_1 => clk_1_sg_x13,
      r => inverter1_op_net_x0,
      s => logical1_y_net_x2,
      q => register2_q_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Ctrl/Start Counter"

entity start_counter_entity_1de1ddce14 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    done: in std_logic; 
    iq_valid: in std_logic; 
    reg_agc_reset: in std_logic; 
    start: in std_logic; 
    agc_reset: out std_logic; 
    count: out std_logic_vector(7 downto 0)
  );
end start_counter_entity_1de1ddce14;

architecture structural of start_counter_entity_1de1ddce14 is
  signal ce_1_sg_x16: std_logic;
  signal clk_1_sg_x16: std_logic;
  signal constant1_op_net: std_logic_vector(7 downto 0);
  signal convert2_dout_net_x2: std_logic;
  signal counter_op_net_x0: std_logic_vector(7 downto 0);
  signal inverter_op_net_x0: std_logic;
  signal logical1_y_net_x3: std_logic;
  signal logical1_y_net_x4: std_logic;
  signal logical1_y_net_x5: std_logic;
  signal logical_y_net: std_logic;
  signal register2_q_net_x0: std_logic;
  signal register4_q_net_x0: std_logic;
  signal relational5_op_net: std_logic;

begin
  ce_1_sg_x16 <= ce_1;
  clk_1_sg_x16 <= clk_1;
  logical1_y_net_x4 <= done;
  convert2_dout_net_x2 <= iq_valid;
  register4_q_net_x0 <= reg_agc_reset;
  logical1_y_net_x5 <= start;
  agc_reset <= inverter_op_net_x0;
  count <= counter_op_net_x0;

  constant1: entity work.constant_1993116bef
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant1_op_net
    );

  counter: entity work.xlcounter_free_wlan_agc
    generic map (
      core_name0 => "cntr_11_0_86806e294f737f4c",
      op_arith => xlUnsigned,
      op_width => 8
    )
    port map (
      ce => ce_1_sg_x16,
      clk => clk_1_sg_x16,
      clr => '0',
      en(0) => logical_y_net,
      rst(0) => inverter_op_net_x0,
      op => counter_op_net_x0
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x16,
      clk => clk_1_sg_x16,
      clr => '0',
      ip(0) => register2_q_net_x0,
      op(0) => inverter_op_net_x0
    );

  logical: entity work.logical_954ee29728
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => register2_q_net_x0,
      d1(0) => convert2_dout_net_x2,
      d2(0) => relational5_op_net,
      y(0) => logical_y_net
    );

  logical1: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical1_y_net_x4,
      d1(0) => register4_q_net_x0,
      y(0) => logical1_y_net_x3
    );

  relational5: entity work.relational_5a9c998b07
    port map (
      a => counter_op_net_x0,
      b => constant1_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational5_op_net
    );

  s_r_latch_e5f5fbfff0: entity work.s_r_latch1_entity_4a86541ec6
    port map (
      ce_1 => ce_1_sg_x16,
      clk_1 => clk_1_sg_x16,
      r => logical1_y_net_x3,
      s => logical1_y_net_x5,
      q => register2_q_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Ctrl"

entity ctrl_entity_bc47da42ff is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    iq_valid: in std_logic; 
    reg_agc_reset: in std_logic; 
    reg_agc_timing_capt_rssi_1: in std_logic_vector(7 downto 0); 
    reg_agc_timing_capt_rssi_2: in std_logic_vector(7 downto 0); 
    reg_agc_timing_capt_v_db: in std_logic_vector(7 downto 0); 
    reg_agc_timing_done: in std_logic_vector(7 downto 0); 
    reg_agc_timing_en_iir: in std_logic_vector(7 downto 0); 
    reg_agc_timing_reset_g_bb: in std_logic_vector(7 downto 0); 
    reg_agc_timing_reset_g_rf: in std_logic_vector(7 downto 0); 
    reg_agc_timing_reset_rxhp: in std_logic_vector(7 downto 0); 
    reg_agc_timing_start_dco: in std_logic_vector(7 downto 0); 
    run: in std_logic; 
    agc_ctrl_capture_rssi: out std_logic; 
    agc_ctrl_capture_v_db: out std_logic; 
    agc_ctrl_done: out std_logic; 
    agc_ctrl_en_iir_filt: out std_logic; 
    agc_ctrl_g_bb_sel: out std_logic_vector(1 downto 0); 
    agc_ctrl_set_g_rf: out std_logic; 
    agc_ctrl_start_dco: out std_logic; 
    agc_done_g_bb: out std_logic; 
    agc_done_g_rf: out std_logic; 
    agc_done_rxhp: out std_logic; 
    start_counter: out std_logic
  );
end ctrl_entity_bc47da42ff;

architecture structural of ctrl_entity_bc47da42ff is
  signal agc_run_net_x2: std_logic;
  signal ce_1_sg_x17: std_logic;
  signal clk_1_sg_x17: std_logic;
  signal convert2_dout_net_x3: std_logic;
  signal counter1_op_net_x0: std_logic_vector(7 downto 0);
  signal counter1_op_net_x1: std_logic_vector(1 downto 0);
  signal counter_op_net_x0: std_logic_vector(7 downto 0);
  signal delay1_q_net_x0: std_logic;
  signal delay2_q_net: std_logic;
  signal delay3_q_net_x0: std_logic;
  signal delay_q_net: std_logic;
  signal inverter_op_net_x1: std_logic;
  signal logical1_y_net_x0: std_logic;
  signal logical1_y_net_x11: std_logic;
  signal logical1_y_net_x12: std_logic;
  signal logical1_y_net_x13: std_logic;
  signal logical1_y_net_x14: std_logic;
  signal logical1_y_net_x15: std_logic;
  signal logical1_y_net_x3: std_logic;
  signal logical1_y_net_x4: std_logic;
  signal logical1_y_net_x5: std_logic;
  signal logical1_y_net_x6: std_logic;
  signal logical1_y_net_x7: std_logic;
  signal logical1_y_net_x8: std_logic;
  signal logical2_y_net: std_logic;
  signal logical3_y_net_x0: std_logic;
  signal logical4_y_net_x1: std_logic;
  signal logical5_y_net_x0: std_logic;
  signal register10_q_net_x0: std_logic_vector(7 downto 0);
  signal register19_q_net_x0: std_logic_vector(7 downto 0);
  signal register20_q_net_x0: std_logic_vector(7 downto 0);
  signal register21_q_net_x0: std_logic_vector(7 downto 0);
  signal register2_q_net_x0: std_logic;
  signal register4_q_net_x1: std_logic;
  signal register5_q_net_x0: std_logic_vector(7 downto 0);
  signal register6_q_net_x0: std_logic_vector(7 downto 0);
  signal register7_q_net_x0: std_logic_vector(7 downto 0);
  signal register8_q_net_x0: std_logic_vector(7 downto 0);
  signal register9_q_net_x0: std_logic_vector(7 downto 0);
  signal relational1_op_net_x0: std_logic;
  signal relational2_op_net_x0: std_logic;
  signal relational3_op_net_x0: std_logic;
  signal relational4_op_net_x0: std_logic;
  signal relational5_op_net_x0: std_logic;
  signal relational6_op_net_x0: std_logic;
  signal relational7_op_net_x0: std_logic;
  signal relational8_op_net_x0: std_logic;
  signal relational_op_net_x0: std_logic;

begin
  ce_1_sg_x17 <= ce_1;
  clk_1_sg_x17 <= clk_1;
  convert2_dout_net_x3 <= iq_valid;
  register4_q_net_x1 <= reg_agc_reset;
  register5_q_net_x0 <= reg_agc_timing_capt_rssi_1;
  register6_q_net_x0 <= reg_agc_timing_capt_rssi_2;
  register7_q_net_x0 <= reg_agc_timing_capt_v_db;
  register8_q_net_x0 <= reg_agc_timing_done;
  register10_q_net_x0 <= reg_agc_timing_en_iir;
  register21_q_net_x0 <= reg_agc_timing_reset_g_bb;
  register19_q_net_x0 <= reg_agc_timing_reset_g_rf;
  register20_q_net_x0 <= reg_agc_timing_reset_rxhp;
  register9_q_net_x0 <= reg_agc_timing_start_dco;
  agc_run_net_x2 <= run;
  agc_ctrl_capture_rssi <= logical3_y_net_x0;
  agc_ctrl_capture_v_db <= logical1_y_net_x13;
  agc_ctrl_done <= logical1_y_net_x12;
  agc_ctrl_en_iir_filt <= logical1_y_net_x15;
  agc_ctrl_g_bb_sel <= counter1_op_net_x1;
  agc_ctrl_set_g_rf <= delay1_q_net_x0;
  agc_ctrl_start_dco <= logical1_y_net_x14;
  agc_done_g_bb <= logical4_y_net_x1;
  agc_done_g_rf <= logical5_y_net_x0;
  agc_done_rxhp <= logical1_y_net_x11;
  start_counter <= inverter_op_net_x1;

  counter1: entity work.xlcounter_free_wlan_agc
    generic map (
      core_name0 => "cntr_11_0_6454489cfe866515",
      op_arith => xlUnsigned,
      op_width => 2
    )
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      clr => '0',
      en(0) => logical2_y_net,
      rst(0) => register2_q_net_x0,
      op => counter1_op_net_x1
    );

  delay: entity work.xldelay
    generic map (
      latency => 2,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      d(0) => logical1_y_net_x13,
      en => '1',
      rst => '1',
      q(0) => delay_q_net
    );

  delay1: entity work.xldelay
    generic map (
      latency => 5,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      d(0) => logical1_y_net_x0,
      en => '1',
      rst => '1',
      q(0) => delay1_q_net_x0
    );

  delay2: entity work.xldelay
    generic map (
      latency => 6,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      d(0) => logical1_y_net_x3,
      en => '1',
      rst => '1',
      q(0) => delay2_q_net
    );

  delay3: entity work.xldelay
    generic map (
      latency => 6,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      d(0) => register2_q_net_x0,
      en => '1',
      rst => '1',
      q(0) => delay3_q_net_x0
    );

  logical1: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => register4_q_net_x1,
      d1(0) => logical1_y_net_x6,
      y(0) => logical1_y_net_x11
    );

  logical2: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => delay2_q_net,
      d1(0) => delay_q_net,
      y(0) => logical2_y_net
    );

  logical3: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical1_y_net_x0,
      d1(0) => logical1_y_net_x3,
      y(0) => logical3_y_net_x0
    );

  logical4: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => register4_q_net_x1,
      d1(0) => logical1_y_net_x7,
      y(0) => logical4_y_net_x1
    );

  logical5: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => register4_q_net_x1,
      d1(0) => logical1_y_net_x8,
      y(0) => logical5_y_net_x0
    );

  negedge_185fb70e0a: entity work.negedge_entity_185fb70e0a
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      d => agc_run_net_x2,
      q => logical1_y_net_x4
    );

  posedge10_f175bfe716: entity work.posedge1_entity_004617dd31
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      d => relational8_op_net_x0,
      q => logical1_y_net_x12
    );

  posedge1_004617dd31: entity work.posedge1_entity_004617dd31
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      d => relational_op_net_x0,
      q => logical1_y_net_x0
    );

  posedge2_57f2b92f23: entity work.posedge1_entity_004617dd31
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      d => relational1_op_net_x0,
      q => logical1_y_net_x13
    );

  posedge3_b3778e803c: entity work.posedge1_entity_004617dd31
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      d => agc_run_net_x2,
      q => logical1_y_net_x5
    );

  posedge4_3f4fe94e77: entity work.posedge1_entity_004617dd31
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      d => relational2_op_net_x0,
      q => logical1_y_net_x3
    );

  posedge5_d6062f0d9c: entity work.posedge1_entity_004617dd31
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      d => relational3_op_net_x0,
      q => logical1_y_net_x6
    );

  posedge6_a5519b2ba5: entity work.posedge1_entity_004617dd31
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      d => relational4_op_net_x0,
      q => logical1_y_net_x7
    );

  posedge7_9f3155135a: entity work.posedge1_entity_004617dd31
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      d => relational6_op_net_x0,
      q => logical1_y_net_x8
    );

  posedge8_0e91d87dbc: entity work.posedge1_entity_004617dd31
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      d => relational5_op_net_x0,
      q => logical1_y_net_x14
    );

  posedge9_d2a73cce4b: entity work.posedge1_entity_004617dd31
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      d => relational7_op_net_x0,
      q => logical1_y_net_x15
    );

  relational: entity work.relational_62f7926e41
    port map (
      a => counter_op_net_x0,
      b => register5_q_net_x0,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational_op_net_x0
    );

  relational1: entity work.relational_62f7926e41
    port map (
      a => counter_op_net_x0,
      b => register7_q_net_x0,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net_x0
    );

  relational2: entity work.relational_62f7926e41
    port map (
      a => counter_op_net_x0,
      b => register6_q_net_x0,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational2_op_net_x0
    );

  relational3: entity work.relational_62f7926e41
    port map (
      a => counter1_op_net_x0,
      b => register20_q_net_x0,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational3_op_net_x0
    );

  relational4: entity work.relational_62f7926e41
    port map (
      a => counter1_op_net_x0,
      b => register21_q_net_x0,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational4_op_net_x0
    );

  relational5: entity work.relational_62f7926e41
    port map (
      a => counter_op_net_x0,
      b => register9_q_net_x0,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational5_op_net_x0
    );

  relational6: entity work.relational_62f7926e41
    port map (
      a => counter1_op_net_x0,
      b => register19_q_net_x0,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational6_op_net_x0
    );

  relational7: entity work.relational_62f7926e41
    port map (
      a => counter_op_net_x0,
      b => register10_q_net_x0,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational7_op_net_x0
    );

  relational8: entity work.relational_62f7926e41
    port map (
      a => counter_op_net_x0,
      b => register8_q_net_x0,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational8_op_net_x0
    );

  reset_counter_47866fe301: entity work.reset_counter_entity_47866fe301
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      done => logical1_y_net_x4,
      iq_valid => convert2_dout_net_x3,
      count => counter1_op_net_x0
    );

  s_r_latch_191d5e2fbe: entity work.s_r_latch1_entity_4a86541ec6
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      r => delay3_q_net_x0,
      s => logical4_y_net_x1,
      q => register2_q_net_x0
    );

  start_counter_1de1ddce14: entity work.start_counter_entity_1de1ddce14
    port map (
      ce_1 => ce_1_sg_x17,
      clk_1 => clk_1_sg_x17,
      done => logical1_y_net_x4,
      iq_valid => convert2_dout_net_x3,
      reg_agc_reset => register4_q_net_x1,
      start => logical1_y_net_x5,
      agc_reset => inverter_op_net_x1,
      count => counter_op_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/DCO Correction/DCO Corr/S-R Latch"

entity s_r_latch_entity_4d279d5862 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    r: in std_logic; 
    s: in std_logic; 
    q: out std_logic
  );
end s_r_latch_entity_4d279d5862;

architecture structural of s_r_latch_entity_4d279d5862 is
  signal ce_1_sg_x18: std_logic;
  signal clk_1_sg_x18: std_logic;
  signal constant1_op_net: std_logic;
  signal logical1_y_net_x0: std_logic;
  signal logical1_y_net_x15: std_logic;
  signal register2_q_net_x0: std_logic;

begin
  ce_1_sg_x18 <= ce_1;
  clk_1_sg_x18 <= clk_1;
  logical1_y_net_x0 <= r;
  logical1_y_net_x15 <= s;
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
      ce => ce_1_sg_x18,
      clk => clk_1_sg_x18,
      d(0) => constant1_op_net,
      en(0) => logical1_y_net_x15,
      rst(0) => logical1_y_net_x0,
      q(0) => register2_q_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/DCO Correction/DCO Corr"

entity dco_corr_entity_d40d94c07f is
  port (
    agc_ctrl_start_dco: in std_logic; 
    agc_reset: in std_logic; 
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    i: in std_logic_vector(11 downto 0); 
    iq_valid: in std_logic; 
    q: in std_logic_vector(11 downto 0); 
    i_x0: out std_logic_vector(15 downto 0); 
    q_x0: out std_logic_vector(15 downto 0); 
    valid: out std_logic
  );
end dco_corr_entity_d40d94c07f;

architecture structural of dco_corr_entity_d40d94c07f is
  signal accumulator1_q_net: std_logic_vector(16 downto 0);
  signal accumulator_q_net: std_logic_vector(16 downto 0);
  signal addsub1_s_net_x0: std_logic_vector(15 downto 0);
  signal addsub_s_net_x0: std_logic_vector(15 downto 0);
  signal ce_1_sg_x19: std_logic;
  signal clk_1_sg_x19: std_logic;
  signal constant_op_net: std_logic_vector(4 downto 0);
  signal convert2_dout_net_x4: std_logic;
  signal counter_op_net: std_logic_vector(4 downto 0);
  signal delay_q_net_x0: std_logic;
  signal inverter_op_net_x2: std_logic;
  signal logical1_y_net_x0: std_logic;
  signal logical1_y_net_x16: std_logic;
  signal logical2_y_net: std_logic;
  signal logical_y_net: std_logic;
  signal register2_q_net_x0: std_logic;
  signal relational_op_net: std_logic;
  signal rfa_rx_i_in_net_x0: std_logic_vector(11 downto 0);
  signal rfa_rx_q_in_net_x0: std_logic_vector(11 downto 0);
  signal scale1_op_net: std_logic_vector(16 downto 0);
  signal scale_op_net: std_logic_vector(16 downto 0);

begin
  logical1_y_net_x16 <= agc_ctrl_start_dco;
  inverter_op_net_x2 <= agc_reset;
  ce_1_sg_x19 <= ce_1;
  clk_1_sg_x19 <= clk_1;
  rfa_rx_i_in_net_x0 <= i;
  convert2_dout_net_x4 <= iq_valid;
  rfa_rx_q_in_net_x0 <= q;
  i_x0 <= addsub_s_net_x0;
  q_x0 <= addsub1_s_net_x0;
  valid <= delay_q_net_x0;

  accumulator: entity work.accum_41fb841d92
    port map (
      b => rfa_rx_i_in_net_x0,
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      clr => '0',
      en(0) => logical_y_net,
      rst(0) => inverter_op_net_x2,
      q => accumulator_q_net
    );

  accumulator1: entity work.accum_41fb841d92
    port map (
      b => rfa_rx_q_in_net_x0,
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      clr => '0',
      en(0) => logical_y_net,
      rst(0) => inverter_op_net_x2,
      q => accumulator1_q_net
    );

  addsub: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 11,
      a_width => 12,
      b_arith => xlSigned,
      b_bin_pt => 16,
      b_width => 17,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 18,
      core_name0 => "addsb_11_0_6695c8a33176d3c2",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 18,
      latency => 1,
      overflow => 1,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 15,
      s_width => 16
    )
    port map (
      a => rfa_rx_i_in_net_x0,
      b => scale_op_net,
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      clr => '0',
      en => "1",
      s => addsub_s_net_x0
    );

  addsub1: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 11,
      a_width => 12,
      b_arith => xlSigned,
      b_bin_pt => 16,
      b_width => 17,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 18,
      core_name0 => "addsb_11_0_6695c8a33176d3c2",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 18,
      latency => 1,
      overflow => 1,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 15,
      s_width => 16
    )
    port map (
      a => rfa_rx_q_in_net_x0,
      b => scale1_op_net,
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      clr => '0',
      en => "1",
      s => addsub1_s_net_x0
    );

  constant_x0: entity work.constant_578dda96c6
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant_op_net
    );

  counter: entity work.xlcounter_free_wlan_agc
    generic map (
      core_name0 => "cntr_11_0_87d991c7bcfe987f",
      op_arith => xlUnsigned,
      op_width => 5
    )
    port map (
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      clr => '0',
      en(0) => logical_y_net,
      rst(0) => logical1_y_net_x0,
      op => counter_op_net
    );

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      d(0) => convert2_dout_net_x4,
      en => '1',
      rst => '1',
      q(0) => delay_q_net_x0
    );

  logical: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert2_dout_net_x4,
      d1(0) => register2_q_net_x0,
      y(0) => logical_y_net
    );

  logical1: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => inverter_op_net_x2,
      d1(0) => logical2_y_net,
      y(0) => logical1_y_net_x0
    );

  logical2: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert2_dout_net_x4,
      d1(0) => relational_op_net,
      y(0) => logical2_y_net
    );

  relational: entity work.relational_9ece3c8c4e
    port map (
      a => counter_op_net,
      b => constant_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational_op_net
    );

  s_r_latch_4d279d5862: entity work.s_r_latch_entity_4d279d5862
    port map (
      ce_1 => ce_1_sg_x19,
      clk_1 => clk_1_sg_x19,
      r => logical1_y_net_x0,
      s => logical1_y_net_x16,
      q => register2_q_net_x0
    );

  scale: entity work.scale_b42effccbc
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      ip => accumulator_q_net,
      op => scale_op_net
    );

  scale1: entity work.scale_b42effccbc
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      ip => accumulator1_q_net,
      op => scale1_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/DCO Correction/IIR HPF Filt"

entity iir_hpf_filt_entity_5d46d3d594 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    i: in std_logic_vector(15 downto 0); 
    iq_valid: in std_logic; 
    q: in std_logic_vector(15 downto 0); 
    reg_agc_iir_coef_a1_a: in std_logic_vector(17 downto 0); 
    reg_agc_iir_coef_b0_a: in std_logic_vector(17 downto 0); 
    reset: in std_logic; 
    i_x0: out std_logic_vector(15 downto 0); 
    iq_valid_x0: out std_logic; 
    q_x0: out std_logic_vector(15 downto 0)
  );
end iir_hpf_filt_entity_5d46d3d594;

architecture structural of iir_hpf_filt_entity_5d46d3d594 is
  signal addsub1_s_net: std_logic_vector(19 downto 0);
  signal addsub2_s_net: std_logic_vector(18 downto 0);
  signal addsub3_s_net: std_logic_vector(19 downto 0);
  signal addsub_s_net: std_logic_vector(18 downto 0);
  signal ce_1_sg_x26: std_logic;
  signal clk_1_sg_x26: std_logic;
  signal convert1_dout_net_x0: std_logic_vector(15 downto 0);
  signal convert2_dout_net_x0: std_logic_vector(15 downto 0);
  signal delay1_q_net: std_logic_vector(17 downto 0);
  signal delay2_q_net_x0: std_logic;
  signal delay2_q_net_x1: std_logic;
  signal delay3_q_net: std_logic;
  signal delay4_q_net: std_logic_vector(17 downto 0);
  signal delay5_q_net_x0: std_logic;
  signal delay6_q_net: std_logic;
  signal inverter_op_net_x0: std_logic;
  signal mult1_p_net: std_logic_vector(17 downto 0);
  signal mult2_p_net: std_logic_vector(17 downto 0);
  signal mult3_p_net: std_logic_vector(17 downto 0);
  signal mult_p_net: std_logic_vector(17 downto 0);
  signal register1_q_net: std_logic_vector(19 downto 0);
  signal register1_q_net_x1: std_logic_vector(15 downto 0);
  signal register22_q_net_x0: std_logic_vector(17 downto 0);
  signal register26_q_net_x0: std_logic_vector(17 downto 0);
  signal register2_q_net: std_logic_vector(17 downto 0);
  signal register_q_net: std_logic_vector(19 downto 0);
  signal register_q_net_x1: std_logic_vector(15 downto 0);

begin
  ce_1_sg_x26 <= ce_1;
  clk_1_sg_x26 <= clk_1;
  register_q_net_x1 <= i;
  delay2_q_net_x1 <= iq_valid;
  register1_q_net_x1 <= q;
  register26_q_net_x0 <= reg_agc_iir_coef_a1_a;
  register22_q_net_x0 <= reg_agc_iir_coef_b0_a;
  inverter_op_net_x0 <= reset;
  i_x0 <= convert1_dout_net_x0;
  iq_valid_x0 <= delay5_q_net_x0;
  q_x0 <= convert2_dout_net_x0;

  addsub: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 18,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 19,
      core_name0 => "addsb_11_0_97a86f347ff88c59",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 19,
      latency => 1,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 19
    )
    port map (
      a => mult_p_net,
      b => delay1_q_net,
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      clr => '0',
      en => "1",
      s => addsub_s_net
    );

  addsub1: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 19,
      b_arith => xlSigned,
      b_bin_pt => 16,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 20,
      core_name0 => "addsb_11_0_e14d732e56290152",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 20,
      latency => 0,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 20
    )
    port map (
      a => addsub_s_net,
      b => mult1_p_net,
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      clr => '0',
      en => "1",
      s => addsub1_s_net
    );

  addsub2: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 18,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 19,
      core_name0 => "addsb_11_0_97a86f347ff88c59",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 19,
      latency => 1,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 19
    )
    port map (
      a => mult2_p_net,
      b => delay4_q_net,
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      clr => '0',
      en => "1",
      s => addsub2_s_net
    );

  addsub3: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 19,
      b_arith => xlSigned,
      b_bin_pt => 16,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 20,
      core_name0 => "addsb_11_0_e14d732e56290152",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 20,
      latency => 0,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 20
    )
    port map (
      a => addsub2_s_net,
      b => mult3_p_net,
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      clr => '0',
      en => "1",
      s => addsub3_s_net
    );

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 2,
      din_bin_pt => 17,
      din_width => 20,
      dout_arith => 2,
      dout_bin_pt => 15,
      dout_width => 16,
      latency => 0,
      overflow => xlSaturate,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      clr => '0',
      din => register_q_net,
      en => "1",
      dout => convert1_dout_net_x0
    );

  convert2: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 2,
      din_bin_pt => 17,
      din_width => 20,
      dout_arith => 2,
      dout_bin_pt => 15,
      dout_width => 16,
      latency => 0,
      overflow => xlSaturate,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      clr => '0',
      din => register1_q_net,
      en => "1",
      dout => convert2_dout_net_x0
    );

  delay1: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 18
    )
    port map (
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      d => mult_p_net,
      en => delay2_q_net_x0,
      rst => '1',
      q => delay1_q_net
    );

  delay2: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      d(0) => delay2_q_net_x1,
      en => '1',
      rst => '1',
      q(0) => delay2_q_net_x0
    );

  delay3: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      d(0) => inverter_op_net_x0,
      en => '1',
      rst => '1',
      q(0) => delay3_q_net
    );

  delay4: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 18
    )
    port map (
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      d => mult2_p_net,
      en => delay2_q_net_x0,
      rst => '1',
      q => delay4_q_net
    );

  delay5: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      d(0) => delay2_q_net_x0,
      en => '1',
      rst => '1',
      q(0) => delay5_q_net_x0
    );

  delay6: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      d(0) => delay3_q_net,
      en => '1',
      rst => '1',
      q(0) => delay6_q_net
    );

  mult: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 15,
      a_width => 16,
      b_arith => xlUnsigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 16,
      c_b_type => 1,
      c_b_width => 18,
      c_baat => 16,
      c_output_width => 34,
      c_type => 0,
      core_name0 => "mult_11_2_956d7358e78b2265",
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 17,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => register_q_net_x1,
      b => register22_q_net_x0,
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      clr => '0',
      core_ce => ce_1_sg_x26,
      core_clk => clk_1_sg_x26,
      core_clr => '1',
      en => "1",
      rst => "0",
      p => mult_p_net
    );

  mult1: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 20,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 20,
      c_b_type => 0,
      c_b_width => 18,
      c_baat => 20,
      c_output_width => 38,
      c_type => 0,
      core_name0 => "mult_11_2_dd4c66afbde2a675",
      en_arith => xlUnsigned,
      en_bin_pt => 0,
      en_width => 1,
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 16,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => addsub1_s_net,
      b => register2_q_net,
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      clr => '0',
      core_ce => ce_1_sg_x26,
      core_clk => clk_1_sg_x26,
      core_clr => '1',
      en(0) => delay5_q_net_x0,
      rst => "0",
      p => mult1_p_net
    );

  mult2: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 15,
      a_width => 16,
      b_arith => xlUnsigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 16,
      c_b_type => 1,
      c_b_width => 18,
      c_baat => 16,
      c_output_width => 34,
      c_type => 0,
      core_name0 => "mult_11_2_956d7358e78b2265",
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 17,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => register1_q_net_x1,
      b => register22_q_net_x0,
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      clr => '0',
      core_ce => ce_1_sg_x26,
      core_clk => clk_1_sg_x26,
      core_clr => '1',
      en => "1",
      rst => "0",
      p => mult2_p_net
    );

  mult3: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 20,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 20,
      c_b_type => 0,
      c_b_width => 18,
      c_baat => 20,
      c_output_width => 38,
      c_type => 0,
      core_name0 => "mult_11_2_dd4c66afbde2a675",
      en_arith => xlUnsigned,
      en_bin_pt => 0,
      en_width => 1,
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 16,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => addsub3_s_net,
      b => register2_q_net,
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      clr => '0',
      core_ce => ce_1_sg_x26,
      core_clk => clk_1_sg_x26,
      core_clr => '1',
      en(0) => delay5_q_net_x0,
      rst => "0",
      p => mult3_p_net
    );

  register1: entity work.xlregister
    generic map (
      d_width => 20,
      init_value => b"00000000000000000000"
    )
    port map (
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      d => addsub3_s_net,
      en(0) => delay5_q_net_x0,
      rst => "0",
      q => register1_q_net
    );

  register2: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      d => register26_q_net_x0,
      en => "1",
      rst(0) => delay6_q_net,
      q => register2_q_net
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 20,
      init_value => b"00000000000000000000"
    )
    port map (
      ce => ce_1_sg_x26,
      clk => clk_1_sg_x26,
      d => addsub1_s_net,
      en(0) => delay5_q_net_x0,
      rst => "0",
      q => register_q_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/DCO Correction/IIR HPF Filt1"

entity iir_hpf_filt1_entity_6cd10ecaee is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    i: in std_logic_vector(15 downto 0); 
    iq_valid: in std_logic; 
    q: in std_logic_vector(15 downto 0); 
    reg_agc_iir_coef_a1_b: in std_logic_vector(17 downto 0); 
    reg_agc_iir_coef_b0_b: in std_logic_vector(17 downto 0); 
    reset: in std_logic; 
    i_x0: out std_logic_vector(15 downto 0); 
    q_x0: out std_logic_vector(15 downto 0)
  );
end iir_hpf_filt1_entity_6cd10ecaee;

architecture structural of iir_hpf_filt1_entity_6cd10ecaee is
  signal addsub1_s_net: std_logic_vector(19 downto 0);
  signal addsub2_s_net: std_logic_vector(18 downto 0);
  signal addsub3_s_net: std_logic_vector(19 downto 0);
  signal addsub_s_net: std_logic_vector(18 downto 0);
  signal ce_1_sg_x27: std_logic;
  signal clk_1_sg_x27: std_logic;
  signal convert1_dout_net_x0: std_logic_vector(15 downto 0);
  signal convert2_dout_net_x0: std_logic_vector(15 downto 0);
  signal delay1_q_net_x0: std_logic_vector(17 downto 0);
  signal delay1_q_net_x1: std_logic;
  signal delay2_q_net: std_logic;
  signal delay3_q_net: std_logic;
  signal delay4_q_net: std_logic_vector(17 downto 0);
  signal delay5_q_net: std_logic;
  signal delay6_q_net: std_logic;
  signal inverter_op_net_x1: std_logic;
  signal mult1_p_net: std_logic_vector(17 downto 0);
  signal mult2_p_net: std_logic_vector(17 downto 0);
  signal mult3_p_net: std_logic_vector(17 downto 0);
  signal mult_p_net: std_logic_vector(17 downto 0);
  signal register1_q_net: std_logic_vector(19 downto 0);
  signal register23_q_net_x0: std_logic_vector(17 downto 0);
  signal register27_q_net_x0: std_logic_vector(17 downto 0);
  signal register2_q_net: std_logic_vector(17 downto 0);
  signal register2_q_net_x1: std_logic_vector(15 downto 0);
  signal register3_q_net_x0: std_logic_vector(15 downto 0);
  signal register_q_net: std_logic_vector(19 downto 0);

begin
  ce_1_sg_x27 <= ce_1;
  clk_1_sg_x27 <= clk_1;
  register2_q_net_x1 <= i;
  delay1_q_net_x1 <= iq_valid;
  register3_q_net_x0 <= q;
  register27_q_net_x0 <= reg_agc_iir_coef_a1_b;
  register23_q_net_x0 <= reg_agc_iir_coef_b0_b;
  inverter_op_net_x1 <= reset;
  i_x0 <= convert1_dout_net_x0;
  q_x0 <= convert2_dout_net_x0;

  addsub: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 18,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 19,
      core_name0 => "addsb_11_0_97a86f347ff88c59",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 19,
      latency => 1,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 19
    )
    port map (
      a => mult_p_net,
      b => delay1_q_net_x0,
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      en => "1",
      s => addsub_s_net
    );

  addsub1: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 19,
      b_arith => xlSigned,
      b_bin_pt => 16,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 20,
      core_name0 => "addsb_11_0_e14d732e56290152",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 20,
      latency => 0,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 20
    )
    port map (
      a => addsub_s_net,
      b => mult1_p_net,
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      en => "1",
      s => addsub1_s_net
    );

  addsub2: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 18,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 19,
      core_name0 => "addsb_11_0_97a86f347ff88c59",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 19,
      latency => 1,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 19
    )
    port map (
      a => mult2_p_net,
      b => delay4_q_net,
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      en => "1",
      s => addsub2_s_net
    );

  addsub3: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 19,
      b_arith => xlSigned,
      b_bin_pt => 16,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 20,
      core_name0 => "addsb_11_0_e14d732e56290152",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 20,
      latency => 0,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 20
    )
    port map (
      a => addsub2_s_net,
      b => mult3_p_net,
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      en => "1",
      s => addsub3_s_net
    );

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 2,
      din_bin_pt => 17,
      din_width => 20,
      dout_arith => 2,
      dout_bin_pt => 15,
      dout_width => 16,
      latency => 0,
      overflow => xlSaturate,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      din => register_q_net,
      en => "1",
      dout => convert1_dout_net_x0
    );

  convert2: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 2,
      din_bin_pt => 17,
      din_width => 20,
      dout_arith => 2,
      dout_bin_pt => 15,
      dout_width => 16,
      latency => 0,
      overflow => xlSaturate,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      din => register1_q_net,
      en => "1",
      dout => convert2_dout_net_x0
    );

  delay1: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 18
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d => mult_p_net,
      en => delay2_q_net,
      rst => '1',
      q => delay1_q_net_x0
    );

  delay2: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d(0) => delay1_q_net_x1,
      en => '1',
      rst => '1',
      q(0) => delay2_q_net
    );

  delay3: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d(0) => inverter_op_net_x1,
      en => '1',
      rst => '1',
      q(0) => delay3_q_net
    );

  delay4: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 18
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d => mult2_p_net,
      en => delay2_q_net,
      rst => '1',
      q => delay4_q_net
    );

  delay5: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d(0) => delay2_q_net,
      en => '1',
      rst => '1',
      q(0) => delay5_q_net
    );

  delay6: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d(0) => delay3_q_net,
      en => '1',
      rst => '1',
      q(0) => delay6_q_net
    );

  mult: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 15,
      a_width => 16,
      b_arith => xlUnsigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 16,
      c_b_type => 1,
      c_b_width => 18,
      c_baat => 16,
      c_output_width => 34,
      c_type => 0,
      core_name0 => "mult_11_2_956d7358e78b2265",
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 17,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => register2_q_net_x1,
      b => register23_q_net_x0,
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      core_ce => ce_1_sg_x27,
      core_clk => clk_1_sg_x27,
      core_clr => '1',
      en => "1",
      rst => "0",
      p => mult_p_net
    );

  mult1: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 20,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 20,
      c_b_type => 0,
      c_b_width => 18,
      c_baat => 20,
      c_output_width => 38,
      c_type => 0,
      core_name0 => "mult_11_2_dd4c66afbde2a675",
      en_arith => xlUnsigned,
      en_bin_pt => 0,
      en_width => 1,
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 16,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => addsub1_s_net,
      b => register2_q_net,
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      core_ce => ce_1_sg_x27,
      core_clk => clk_1_sg_x27,
      core_clr => '1',
      en(0) => delay5_q_net,
      rst => "0",
      p => mult1_p_net
    );

  mult2: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 15,
      a_width => 16,
      b_arith => xlUnsigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 16,
      c_b_type => 1,
      c_b_width => 18,
      c_baat => 16,
      c_output_width => 34,
      c_type => 0,
      core_name0 => "mult_11_2_956d7358e78b2265",
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 17,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => register3_q_net_x0,
      b => register23_q_net_x0,
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      core_ce => ce_1_sg_x27,
      core_clk => clk_1_sg_x27,
      core_clr => '1',
      en => "1",
      rst => "0",
      p => mult2_p_net
    );

  mult3: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 20,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 20,
      c_b_type => 0,
      c_b_width => 18,
      c_baat => 20,
      c_output_width => 38,
      c_type => 0,
      core_name0 => "mult_11_2_dd4c66afbde2a675",
      en_arith => xlUnsigned,
      en_bin_pt => 0,
      en_width => 1,
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 16,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => addsub3_s_net,
      b => register2_q_net,
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      clr => '0',
      core_ce => ce_1_sg_x27,
      core_clk => clk_1_sg_x27,
      core_clr => '1',
      en(0) => delay5_q_net,
      rst => "0",
      p => mult3_p_net
    );

  register1: entity work.xlregister
    generic map (
      d_width => 20,
      init_value => b"00000000000000000000"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d => addsub3_s_net,
      en(0) => delay5_q_net,
      rst => "0",
      q => register1_q_net
    );

  register2: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d => register27_q_net_x0,
      en => "1",
      rst(0) => delay6_q_net,
      q => register2_q_net
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 20,
      init_value => b"00000000000000000000"
    )
    port map (
      ce => ce_1_sg_x27,
      clk => clk_1_sg_x27,
      d => addsub1_s_net,
      en(0) => delay5_q_net,
      rst => "0",
      q => register_q_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/DCO Correction/IIR HPF Filt2"

entity iir_hpf_filt2_entity_30d9fb4562 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    i: in std_logic_vector(15 downto 0); 
    iq_valid: in std_logic; 
    q: in std_logic_vector(15 downto 0); 
    reg_agc_iir_coef_a1_c: in std_logic_vector(17 downto 0); 
    reg_agc_iir_coef_b0_c: in std_logic_vector(17 downto 0); 
    reset: in std_logic; 
    i_x0: out std_logic_vector(15 downto 0); 
    q_x0: out std_logic_vector(15 downto 0)
  );
end iir_hpf_filt2_entity_30d9fb4562;

architecture structural of iir_hpf_filt2_entity_30d9fb4562 is
  signal addsub1_s_net: std_logic_vector(19 downto 0);
  signal addsub2_s_net: std_logic_vector(18 downto 0);
  signal addsub3_s_net: std_logic_vector(19 downto 0);
  signal addsub_s_net: std_logic_vector(18 downto 0);
  signal ce_1_sg_x28: std_logic;
  signal clk_1_sg_x28: std_logic;
  signal convert1_dout_net_x0: std_logic_vector(15 downto 0);
  signal convert2_dout_net_x0: std_logic_vector(15 downto 0);
  signal delay1_q_net: std_logic_vector(17 downto 0);
  signal delay2_q_net: std_logic;
  signal delay3_q_net_x0: std_logic;
  signal delay3_q_net_x1: std_logic;
  signal delay4_q_net: std_logic_vector(17 downto 0);
  signal delay5_q_net: std_logic;
  signal delay6_q_net: std_logic;
  signal inverter_op_net_x2: std_logic;
  signal mult1_p_net: std_logic_vector(17 downto 0);
  signal mult2_p_net: std_logic_vector(17 downto 0);
  signal mult3_p_net: std_logic_vector(17 downto 0);
  signal mult_p_net: std_logic_vector(17 downto 0);
  signal register1_q_net: std_logic_vector(19 downto 0);
  signal register24_q_net_x0: std_logic_vector(17 downto 0);
  signal register28_q_net_x0: std_logic_vector(17 downto 0);
  signal register2_q_net: std_logic_vector(17 downto 0);
  signal register6_q_net_x0: std_logic_vector(15 downto 0);
  signal register7_q_net_x0: std_logic_vector(15 downto 0);
  signal register_q_net: std_logic_vector(19 downto 0);

begin
  ce_1_sg_x28 <= ce_1;
  clk_1_sg_x28 <= clk_1;
  register6_q_net_x0 <= i;
  delay3_q_net_x1 <= iq_valid;
  register7_q_net_x0 <= q;
  register28_q_net_x0 <= reg_agc_iir_coef_a1_c;
  register24_q_net_x0 <= reg_agc_iir_coef_b0_c;
  inverter_op_net_x2 <= reset;
  i_x0 <= convert1_dout_net_x0;
  q_x0 <= convert2_dout_net_x0;

  addsub: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 18,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 19,
      core_name0 => "addsb_11_0_97a86f347ff88c59",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 19,
      latency => 1,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 19
    )
    port map (
      a => mult_p_net,
      b => delay1_q_net,
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      clr => '0',
      en => "1",
      s => addsub_s_net
    );

  addsub1: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 19,
      b_arith => xlSigned,
      b_bin_pt => 16,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 20,
      core_name0 => "addsb_11_0_e14d732e56290152",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 20,
      latency => 0,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 20
    )
    port map (
      a => addsub_s_net,
      b => mult1_p_net,
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      clr => '0',
      en => "1",
      s => addsub1_s_net
    );

  addsub2: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 18,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 19,
      core_name0 => "addsb_11_0_97a86f347ff88c59",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 19,
      latency => 1,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 19
    )
    port map (
      a => mult2_p_net,
      b => delay4_q_net,
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      clr => '0',
      en => "1",
      s => addsub2_s_net
    );

  addsub3: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 19,
      b_arith => xlSigned,
      b_bin_pt => 16,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 20,
      core_name0 => "addsb_11_0_e14d732e56290152",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 20,
      latency => 0,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 20
    )
    port map (
      a => addsub2_s_net,
      b => mult3_p_net,
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      clr => '0',
      en => "1",
      s => addsub3_s_net
    );

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 2,
      din_bin_pt => 17,
      din_width => 20,
      dout_arith => 2,
      dout_bin_pt => 15,
      dout_width => 16,
      latency => 0,
      overflow => xlSaturate,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      clr => '0',
      din => register_q_net,
      en => "1",
      dout => convert1_dout_net_x0
    );

  convert2: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 2,
      din_bin_pt => 17,
      din_width => 20,
      dout_arith => 2,
      dout_bin_pt => 15,
      dout_width => 16,
      latency => 0,
      overflow => xlSaturate,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      clr => '0',
      din => register1_q_net,
      en => "1",
      dout => convert2_dout_net_x0
    );

  delay1: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 18
    )
    port map (
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      d => mult_p_net,
      en => delay2_q_net,
      rst => '1',
      q => delay1_q_net
    );

  delay2: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      d(0) => delay3_q_net_x1,
      en => '1',
      rst => '1',
      q(0) => delay2_q_net
    );

  delay3: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      d(0) => inverter_op_net_x2,
      en => '1',
      rst => '1',
      q(0) => delay3_q_net_x0
    );

  delay4: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 18
    )
    port map (
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      d => mult2_p_net,
      en => delay2_q_net,
      rst => '1',
      q => delay4_q_net
    );

  delay5: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      d(0) => delay2_q_net,
      en => '1',
      rst => '1',
      q(0) => delay5_q_net
    );

  delay6: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      d(0) => delay3_q_net_x0,
      en => '1',
      rst => '1',
      q(0) => delay6_q_net
    );

  mult: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 15,
      a_width => 16,
      b_arith => xlUnsigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 16,
      c_b_type => 1,
      c_b_width => 18,
      c_baat => 16,
      c_output_width => 34,
      c_type => 0,
      core_name0 => "mult_11_2_956d7358e78b2265",
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 17,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => register6_q_net_x0,
      b => register24_q_net_x0,
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      clr => '0',
      core_ce => ce_1_sg_x28,
      core_clk => clk_1_sg_x28,
      core_clr => '1',
      en => "1",
      rst => "0",
      p => mult_p_net
    );

  mult1: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 20,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 20,
      c_b_type => 0,
      c_b_width => 18,
      c_baat => 20,
      c_output_width => 38,
      c_type => 0,
      core_name0 => "mult_11_2_dd4c66afbde2a675",
      en_arith => xlUnsigned,
      en_bin_pt => 0,
      en_width => 1,
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 16,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => addsub1_s_net,
      b => register2_q_net,
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      clr => '0',
      core_ce => ce_1_sg_x28,
      core_clk => clk_1_sg_x28,
      core_clr => '1',
      en(0) => delay5_q_net,
      rst => "0",
      p => mult1_p_net
    );

  mult2: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 15,
      a_width => 16,
      b_arith => xlUnsigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 16,
      c_b_type => 1,
      c_b_width => 18,
      c_baat => 16,
      c_output_width => 34,
      c_type => 0,
      core_name0 => "mult_11_2_956d7358e78b2265",
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 17,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => register7_q_net_x0,
      b => register24_q_net_x0,
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      clr => '0',
      core_ce => ce_1_sg_x28,
      core_clk => clk_1_sg_x28,
      core_clr => '1',
      en => "1",
      rst => "0",
      p => mult2_p_net
    );

  mult3: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 20,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 20,
      c_b_type => 0,
      c_b_width => 18,
      c_baat => 20,
      c_output_width => 38,
      c_type => 0,
      core_name0 => "mult_11_2_dd4c66afbde2a675",
      en_arith => xlUnsigned,
      en_bin_pt => 0,
      en_width => 1,
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 16,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => addsub3_s_net,
      b => register2_q_net,
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      clr => '0',
      core_ce => ce_1_sg_x28,
      core_clk => clk_1_sg_x28,
      core_clr => '1',
      en(0) => delay5_q_net,
      rst => "0",
      p => mult3_p_net
    );

  register1: entity work.xlregister
    generic map (
      d_width => 20,
      init_value => b"00000000000000000000"
    )
    port map (
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      d => addsub3_s_net,
      en(0) => delay5_q_net,
      rst => "0",
      q => register1_q_net
    );

  register2: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      d => register28_q_net_x0,
      en => "1",
      rst(0) => delay6_q_net,
      q => register2_q_net
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 20,
      init_value => b"00000000000000000000"
    )
    port map (
      ce => ce_1_sg_x28,
      clk => clk_1_sg_x28,
      d => addsub1_s_net,
      en(0) => delay5_q_net,
      rst => "0",
      q => register_q_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/DCO Correction/IIR HPF Filt3"

entity iir_hpf_filt3_entity_66c522057e is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    i: in std_logic_vector(15 downto 0); 
    iq_valid: in std_logic; 
    q: in std_logic_vector(15 downto 0); 
    reg_agc_iir_coef_a1_d: in std_logic_vector(17 downto 0); 
    reg_agc_iir_coef_b0_d: in std_logic_vector(17 downto 0); 
    reset: in std_logic; 
    i_x0: out std_logic_vector(15 downto 0); 
    q_x0: out std_logic_vector(15 downto 0)
  );
end iir_hpf_filt3_entity_66c522057e;

architecture structural of iir_hpf_filt3_entity_66c522057e is
  signal addsub1_s_net: std_logic_vector(19 downto 0);
  signal addsub2_s_net: std_logic_vector(18 downto 0);
  signal addsub3_s_net: std_logic_vector(19 downto 0);
  signal addsub_s_net: std_logic_vector(18 downto 0);
  signal ce_1_sg_x29: std_logic;
  signal clk_1_sg_x29: std_logic;
  signal convert1_dout_net_x0: std_logic_vector(15 downto 0);
  signal convert2_dout_net_x0: std_logic_vector(15 downto 0);
  signal delay1_q_net: std_logic_vector(17 downto 0);
  signal delay2_q_net: std_logic;
  signal delay3_q_net: std_logic;
  signal delay4_q_net_x0: std_logic_vector(17 downto 0);
  signal delay4_q_net_x1: std_logic;
  signal delay5_q_net: std_logic;
  signal delay6_q_net: std_logic;
  signal inverter_op_net_x3: std_logic;
  signal mult1_p_net: std_logic_vector(17 downto 0);
  signal mult2_p_net: std_logic_vector(17 downto 0);
  signal mult3_p_net: std_logic_vector(17 downto 0);
  signal mult_p_net: std_logic_vector(17 downto 0);
  signal register14_q_net_x0: std_logic_vector(15 downto 0);
  signal register15_q_net_x0: std_logic_vector(15 downto 0);
  signal register1_q_net: std_logic_vector(19 downto 0);
  signal register25_q_net_x0: std_logic_vector(17 downto 0);
  signal register29_q_net_x0: std_logic_vector(17 downto 0);
  signal register2_q_net: std_logic_vector(17 downto 0);
  signal register_q_net: std_logic_vector(19 downto 0);

begin
  ce_1_sg_x29 <= ce_1;
  clk_1_sg_x29 <= clk_1;
  register14_q_net_x0 <= i;
  delay4_q_net_x1 <= iq_valid;
  register15_q_net_x0 <= q;
  register29_q_net_x0 <= reg_agc_iir_coef_a1_d;
  register25_q_net_x0 <= reg_agc_iir_coef_b0_d;
  inverter_op_net_x3 <= reset;
  i_x0 <= convert1_dout_net_x0;
  q_x0 <= convert2_dout_net_x0;

  addsub: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 18,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 19,
      core_name0 => "addsb_11_0_97a86f347ff88c59",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 19,
      latency => 1,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 19
    )
    port map (
      a => mult_p_net,
      b => delay1_q_net,
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      clr => '0',
      en => "1",
      s => addsub_s_net
    );

  addsub1: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 19,
      b_arith => xlSigned,
      b_bin_pt => 16,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 20,
      core_name0 => "addsb_11_0_e14d732e56290152",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 20,
      latency => 0,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 20
    )
    port map (
      a => addsub_s_net,
      b => mult1_p_net,
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      clr => '0',
      en => "1",
      s => addsub1_s_net
    );

  addsub2: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 18,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 19,
      core_name0 => "addsb_11_0_97a86f347ff88c59",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 19,
      latency => 1,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 19
    )
    port map (
      a => mult2_p_net,
      b => delay4_q_net_x0,
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      clr => '0',
      en => "1",
      s => addsub2_s_net
    );

  addsub3: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 19,
      b_arith => xlSigned,
      b_bin_pt => 16,
      b_width => 18,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 20,
      core_name0 => "addsb_11_0_e14d732e56290152",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 20,
      latency => 0,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 17,
      s_width => 20
    )
    port map (
      a => addsub2_s_net,
      b => mult3_p_net,
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      clr => '0',
      en => "1",
      s => addsub3_s_net
    );

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 2,
      din_bin_pt => 17,
      din_width => 20,
      dout_arith => 2,
      dout_bin_pt => 15,
      dout_width => 16,
      latency => 0,
      overflow => xlSaturate,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      clr => '0',
      din => register_q_net,
      en => "1",
      dout => convert1_dout_net_x0
    );

  convert2: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 2,
      din_bin_pt => 17,
      din_width => 20,
      dout_arith => 2,
      dout_bin_pt => 15,
      dout_width => 16,
      latency => 0,
      overflow => xlSaturate,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      clr => '0',
      din => register1_q_net,
      en => "1",
      dout => convert2_dout_net_x0
    );

  delay1: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 18
    )
    port map (
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      d => mult_p_net,
      en => delay2_q_net,
      rst => '1',
      q => delay1_q_net
    );

  delay2: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      d(0) => delay4_q_net_x1,
      en => '1',
      rst => '1',
      q(0) => delay2_q_net
    );

  delay3: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      d(0) => inverter_op_net_x3,
      en => '1',
      rst => '1',
      q(0) => delay3_q_net
    );

  delay4: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 18
    )
    port map (
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      d => mult2_p_net,
      en => delay2_q_net,
      rst => '1',
      q => delay4_q_net_x0
    );

  delay5: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      d(0) => delay2_q_net,
      en => '1',
      rst => '1',
      q(0) => delay5_q_net
    );

  delay6: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      d(0) => delay3_q_net,
      en => '1',
      rst => '1',
      q(0) => delay6_q_net
    );

  mult: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 15,
      a_width => 16,
      b_arith => xlUnsigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 16,
      c_b_type => 1,
      c_b_width => 18,
      c_baat => 16,
      c_output_width => 34,
      c_type => 0,
      core_name0 => "mult_11_2_956d7358e78b2265",
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 17,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => register14_q_net_x0,
      b => register25_q_net_x0,
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      clr => '0',
      core_ce => ce_1_sg_x29,
      core_clk => clk_1_sg_x29,
      core_clr => '1',
      en => "1",
      rst => "0",
      p => mult_p_net
    );

  mult1: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 20,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 20,
      c_b_type => 0,
      c_b_width => 18,
      c_baat => 20,
      c_output_width => 38,
      c_type => 0,
      core_name0 => "mult_11_2_dd4c66afbde2a675",
      en_arith => xlUnsigned,
      en_bin_pt => 0,
      en_width => 1,
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 16,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => addsub1_s_net,
      b => register2_q_net,
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      clr => '0',
      core_ce => ce_1_sg_x29,
      core_clk => clk_1_sg_x29,
      core_clr => '1',
      en(0) => delay5_q_net,
      rst => "0",
      p => mult1_p_net
    );

  mult2: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 15,
      a_width => 16,
      b_arith => xlUnsigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 16,
      c_b_type => 1,
      c_b_width => 18,
      c_baat => 16,
      c_output_width => 34,
      c_type => 0,
      core_name0 => "mult_11_2_956d7358e78b2265",
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 17,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => register15_q_net_x0,
      b => register25_q_net_x0,
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      clr => '0',
      core_ce => ce_1_sg_x29,
      core_clk => clk_1_sg_x29,
      core_clr => '1',
      en => "1",
      rst => "0",
      p => mult2_p_net
    );

  mult3: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 17,
      a_width => 20,
      b_arith => xlSigned,
      b_bin_pt => 17,
      b_width => 18,
      c_a_type => 0,
      c_a_width => 20,
      c_b_type => 0,
      c_b_width => 18,
      c_baat => 20,
      c_output_width => 38,
      c_type => 0,
      core_name0 => "mult_11_2_dd4c66afbde2a675",
      en_arith => xlUnsigned,
      en_bin_pt => 0,
      en_width => 1,
      extra_registers => 0,
      multsign => 2,
      overflow => 3,
      p_arith => xlSigned,
      p_bin_pt => 16,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => addsub3_s_net,
      b => register2_q_net,
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      clr => '0',
      core_ce => ce_1_sg_x29,
      core_clk => clk_1_sg_x29,
      core_clr => '1',
      en(0) => delay5_q_net,
      rst => "0",
      p => mult3_p_net
    );

  register1: entity work.xlregister
    generic map (
      d_width => 20,
      init_value => b"00000000000000000000"
    )
    port map (
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      d => addsub3_s_net,
      en(0) => delay5_q_net,
      rst => "0",
      q => register1_q_net
    );

  register2: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      d => register29_q_net_x0,
      en => "1",
      rst(0) => delay6_q_net,
      q => register2_q_net
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 20,
      init_value => b"00000000000000000000"
    )
    port map (
      ce => ce_1_sg_x29,
      clk => clk_1_sg_x29,
      d => addsub1_s_net,
      en(0) => delay5_q_net,
      rst => "0",
      q => register_q_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/DCO Correction"

entity dco_correction_entity_d0d185c763 is
  port (
    a_i: in std_logic_vector(11 downto 0); 
    a_q: in std_logic_vector(11 downto 0); 
    agc_ctrl_en_iir_filt: in std_logic; 
    agc_reset: in std_logic; 
    b_i: in std_logic_vector(11 downto 0); 
    b_q: in std_logic_vector(11 downto 0); 
    c_i: in std_logic_vector(11 downto 0); 
    c_q: in std_logic_vector(11 downto 0); 
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    ctrl: in std_logic; 
    d_i: in std_logic_vector(11 downto 0); 
    d_q: in std_logic_vector(11 downto 0); 
    iq_valid: in std_logic; 
    register22: in std_logic_vector(17 downto 0); 
    register23: in std_logic_vector(17 downto 0); 
    register24: in std_logic_vector(17 downto 0); 
    register25: in std_logic_vector(17 downto 0); 
    register26: in std_logic_vector(17 downto 0); 
    register27: in std_logic_vector(17 downto 0); 
    register28: in std_logic_vector(17 downto 0); 
    register29: in std_logic_vector(17 downto 0); 
    iq_valid_x0: out std_logic; 
    rfa_i: out std_logic_vector(15 downto 0); 
    rfa_q: out std_logic_vector(15 downto 0); 
    rfb_i: out std_logic_vector(15 downto 0); 
    rfb_q: out std_logic_vector(15 downto 0); 
    rfc_i: out std_logic_vector(15 downto 0); 
    rfc_q: out std_logic_vector(15 downto 0); 
    rfd_i: out std_logic_vector(15 downto 0); 
    rfd_q: out std_logic_vector(15 downto 0)
  );
end dco_correction_entity_d0d185c763;

architecture structural of dco_correction_entity_d0d185c763 is
  signal addsub1_s_net_x0: std_logic_vector(15 downto 0);
  signal addsub1_s_net_x1: std_logic_vector(15 downto 0);
  signal addsub1_s_net_x2: std_logic_vector(15 downto 0);
  signal addsub1_s_net_x3: std_logic_vector(15 downto 0);
  signal addsub_s_net_x0: std_logic_vector(15 downto 0);
  signal addsub_s_net_x1: std_logic_vector(15 downto 0);
  signal addsub_s_net_x2: std_logic_vector(15 downto 0);
  signal addsub_s_net_x3: std_logic_vector(15 downto 0);
  signal ce_1_sg_x31: std_logic;
  signal clk_1_sg_x31: std_logic;
  signal convert1_dout_net_x0: std_logic_vector(15 downto 0);
  signal convert1_dout_net_x1: std_logic_vector(15 downto 0);
  signal convert1_dout_net_x2: std_logic_vector(15 downto 0);
  signal convert1_dout_net_x3: std_logic_vector(15 downto 0);
  signal convert2_dout_net_x0: std_logic_vector(15 downto 0);
  signal convert2_dout_net_x10: std_logic_vector(15 downto 0);
  signal convert2_dout_net_x11: std_logic;
  signal convert2_dout_net_x8: std_logic_vector(15 downto 0);
  signal convert2_dout_net_x9: std_logic_vector(15 downto 0);
  signal delay1_q_net_x1: std_logic;
  signal delay2_q_net_x1: std_logic;
  signal delay3_q_net_x1: std_logic;
  signal delay4_q_net_x1: std_logic;
  signal delay5_q_net_x1: std_logic;
  signal delay_q_net_x0: std_logic;
  signal delay_q_net_x1: std_logic;
  signal delay_q_net_x2: std_logic;
  signal delay_q_net_x3: std_logic;
  signal inverter_op_net_x3: std_logic;
  signal inverter_op_net_x7: std_logic;
  signal logical1_y_net_x23: std_logic;
  signal logical1_y_net_x24: std_logic;
  signal mux1_y_net: std_logic_vector(15 downto 0);
  signal mux2_y_net: std_logic_vector(15 downto 0);
  signal mux3_y_net: std_logic_vector(15 downto 0);
  signal mux4_y_net: std_logic_vector(15 downto 0);
  signal mux5_y_net: std_logic_vector(15 downto 0);
  signal mux6_y_net: std_logic_vector(15 downto 0);
  signal mux7_y_net: std_logic_vector(15 downto 0);
  signal mux_y_net: std_logic_vector(15 downto 0);
  signal register10_q_net_x0: std_logic_vector(15 downto 0);
  signal register11_q_net_x0: std_logic_vector(15 downto 0);
  signal register12_q_net_x0: std_logic_vector(15 downto 0);
  signal register13_q_net_x0: std_logic_vector(15 downto 0);
  signal register14_q_net_x0: std_logic_vector(15 downto 0);
  signal register15_q_net_x0: std_logic_vector(15 downto 0);
  signal register1_q_net_x1: std_logic_vector(15 downto 0);
  signal register22_q_net_x1: std_logic_vector(17 downto 0);
  signal register23_q_net_x1: std_logic_vector(17 downto 0);
  signal register24_q_net_x1: std_logic_vector(17 downto 0);
  signal register25_q_net_x1: std_logic_vector(17 downto 0);
  signal register26_q_net_x1: std_logic_vector(17 downto 0);
  signal register27_q_net_x1: std_logic_vector(17 downto 0);
  signal register28_q_net_x1: std_logic_vector(17 downto 0);
  signal register29_q_net_x1: std_logic_vector(17 downto 0);
  signal register2_q_net_x0: std_logic;
  signal register2_q_net_x1: std_logic_vector(15 downto 0);
  signal register3_q_net_x0: std_logic_vector(15 downto 0);
  signal register4_q_net_x0: std_logic_vector(15 downto 0);
  signal register5_q_net_x0: std_logic_vector(15 downto 0);
  signal register6_q_net_x0: std_logic_vector(15 downto 0);
  signal register7_q_net_x0: std_logic_vector(15 downto 0);
  signal register8_q_net_x0: std_logic_vector(15 downto 0);
  signal register9_q_net_x0: std_logic_vector(15 downto 0);
  signal register_q_net_x1: std_logic_vector(15 downto 0);
  signal rfa_rx_i_in_net_x1: std_logic_vector(11 downto 0);
  signal rfa_rx_q_in_net_x1: std_logic_vector(11 downto 0);
  signal rfb_rx_i_in_net_x1: std_logic_vector(11 downto 0);
  signal rfb_rx_q_in_net_x1: std_logic_vector(11 downto 0);
  signal rfc_rx_i_in_net_x1: std_logic_vector(11 downto 0);
  signal rfc_rx_q_in_net_x1: std_logic_vector(11 downto 0);
  signal rfd_rx_i_in_net_x1: std_logic_vector(11 downto 0);
  signal rfd_rx_q_in_net_x1: std_logic_vector(11 downto 0);

begin
  rfa_rx_i_in_net_x1 <= a_i;
  rfa_rx_q_in_net_x1 <= a_q;
  logical1_y_net_x24 <= agc_ctrl_en_iir_filt;
  inverter_op_net_x7 <= agc_reset;
  rfb_rx_i_in_net_x1 <= b_i;
  rfb_rx_q_in_net_x1 <= b_q;
  rfc_rx_i_in_net_x1 <= c_i;
  rfc_rx_q_in_net_x1 <= c_q;
  ce_1_sg_x31 <= ce_1;
  clk_1_sg_x31 <= clk_1;
  logical1_y_net_x23 <= ctrl;
  rfd_rx_i_in_net_x1 <= d_i;
  rfd_rx_q_in_net_x1 <= d_q;
  convert2_dout_net_x11 <= iq_valid;
  register22_q_net_x1 <= register22;
  register23_q_net_x1 <= register23;
  register24_q_net_x1 <= register24;
  register25_q_net_x1 <= register25;
  register26_q_net_x1 <= register26;
  register27_q_net_x1 <= register27;
  register28_q_net_x1 <= register28;
  register29_q_net_x1 <= register29;
  iq_valid_x0 <= delay5_q_net_x1;
  rfa_i <= register5_q_net_x0;
  rfa_q <= register4_q_net_x0;
  rfb_i <= register8_q_net_x0;
  rfb_q <= register9_q_net_x0;
  rfc_i <= register10_q_net_x0;
  rfc_q <= register11_q_net_x0;
  rfd_i <= register12_q_net_x0;
  rfd_q <= register13_q_net_x0;

  dco_corr1_0679dec98a: entity work.dco_corr_entity_d40d94c07f
    port map (
      agc_ctrl_start_dco => logical1_y_net_x23,
      agc_reset => inverter_op_net_x7,
      ce_1 => ce_1_sg_x31,
      clk_1 => clk_1_sg_x31,
      i => rfb_rx_i_in_net_x1,
      iq_valid => convert2_dout_net_x11,
      q => rfb_rx_q_in_net_x1,
      i_x0 => addsub_s_net_x1,
      q_x0 => addsub1_s_net_x1,
      valid => delay_q_net_x1
    );

  dco_corr2_d92655e6ea: entity work.dco_corr_entity_d40d94c07f
    port map (
      agc_ctrl_start_dco => logical1_y_net_x23,
      agc_reset => inverter_op_net_x7,
      ce_1 => ce_1_sg_x31,
      clk_1 => clk_1_sg_x31,
      i => rfc_rx_i_in_net_x1,
      iq_valid => convert2_dout_net_x11,
      q => rfc_rx_q_in_net_x1,
      i_x0 => addsub_s_net_x2,
      q_x0 => addsub1_s_net_x2,
      valid => delay_q_net_x2
    );

  dco_corr3_04988c5529: entity work.dco_corr_entity_d40d94c07f
    port map (
      agc_ctrl_start_dco => logical1_y_net_x23,
      agc_reset => inverter_op_net_x7,
      ce_1 => ce_1_sg_x31,
      clk_1 => clk_1_sg_x31,
      i => rfd_rx_i_in_net_x1,
      iq_valid => convert2_dout_net_x11,
      q => rfd_rx_q_in_net_x1,
      i_x0 => addsub_s_net_x3,
      q_x0 => addsub1_s_net_x3,
      valid => delay_q_net_x3
    );

  dco_corr_d40d94c07f: entity work.dco_corr_entity_d40d94c07f
    port map (
      agc_ctrl_start_dco => logical1_y_net_x23,
      agc_reset => inverter_op_net_x7,
      ce_1 => ce_1_sg_x31,
      clk_1 => clk_1_sg_x31,
      i => rfa_rx_i_in_net_x1,
      iq_valid => convert2_dout_net_x11,
      q => rfa_rx_q_in_net_x1,
      i_x0 => addsub_s_net_x0,
      q_x0 => addsub1_s_net_x0,
      valid => delay_q_net_x0
    );

  delay1: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d(0) => delay_q_net_x1,
      en => '1',
      rst => '1',
      q(0) => delay1_q_net_x1
    );

  delay2: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d(0) => delay_q_net_x0,
      en => '1',
      rst => '1',
      q(0) => delay2_q_net_x1
    );

  delay3: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d(0) => delay_q_net_x2,
      en => '1',
      rst => '1',
      q(0) => delay3_q_net_x1
    );

  delay4: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d(0) => delay_q_net_x3,
      en => '1',
      rst => '1',
      q(0) => delay4_q_net_x1
    );

  iir_hpf_filt1_6cd10ecaee: entity work.iir_hpf_filt1_entity_6cd10ecaee
    port map (
      ce_1 => ce_1_sg_x31,
      clk_1 => clk_1_sg_x31,
      i => register2_q_net_x1,
      iq_valid => delay1_q_net_x1,
      q => register3_q_net_x0,
      reg_agc_iir_coef_a1_b => register27_q_net_x1,
      reg_agc_iir_coef_b0_b => register23_q_net_x1,
      reset => inverter_op_net_x3,
      i_x0 => convert1_dout_net_x1,
      q_x0 => convert2_dout_net_x8
    );

  iir_hpf_filt2_30d9fb4562: entity work.iir_hpf_filt2_entity_30d9fb4562
    port map (
      ce_1 => ce_1_sg_x31,
      clk_1 => clk_1_sg_x31,
      i => register6_q_net_x0,
      iq_valid => delay3_q_net_x1,
      q => register7_q_net_x0,
      reg_agc_iir_coef_a1_c => register28_q_net_x1,
      reg_agc_iir_coef_b0_c => register24_q_net_x1,
      reset => inverter_op_net_x3,
      i_x0 => convert1_dout_net_x2,
      q_x0 => convert2_dout_net_x9
    );

  iir_hpf_filt3_66c522057e: entity work.iir_hpf_filt3_entity_66c522057e
    port map (
      ce_1 => ce_1_sg_x31,
      clk_1 => clk_1_sg_x31,
      i => register14_q_net_x0,
      iq_valid => delay4_q_net_x1,
      q => register15_q_net_x0,
      reg_agc_iir_coef_a1_d => register29_q_net_x1,
      reg_agc_iir_coef_b0_d => register25_q_net_x1,
      reset => inverter_op_net_x3,
      i_x0 => convert1_dout_net_x3,
      q_x0 => convert2_dout_net_x10
    );

  iir_hpf_filt_5d46d3d594: entity work.iir_hpf_filt_entity_5d46d3d594
    port map (
      ce_1 => ce_1_sg_x31,
      clk_1 => clk_1_sg_x31,
      i => register_q_net_x1,
      iq_valid => delay2_q_net_x1,
      q => register1_q_net_x1,
      reg_agc_iir_coef_a1_a => register26_q_net_x1,
      reg_agc_iir_coef_b0_a => register22_q_net_x1,
      reset => inverter_op_net_x3,
      i_x0 => convert1_dout_net_x0,
      iq_valid_x0 => delay5_q_net_x1,
      q_x0 => convert2_dout_net_x0
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      clr => '0',
      ip(0) => register2_q_net_x0,
      op(0) => inverter_op_net_x3
    );

  mux: entity work.mux_a54904b290
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => addsub_s_net_x0,
      d1 => convert1_dout_net_x0,
      sel(0) => register2_q_net_x0,
      y => mux_y_net
    );

  mux1: entity work.mux_a54904b290
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => addsub1_s_net_x0,
      d1 => convert2_dout_net_x0,
      sel(0) => register2_q_net_x0,
      y => mux1_y_net
    );

  mux2: entity work.mux_a54904b290
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => addsub_s_net_x1,
      d1 => convert1_dout_net_x1,
      sel(0) => register2_q_net_x0,
      y => mux2_y_net
    );

  mux3: entity work.mux_a54904b290
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => addsub1_s_net_x1,
      d1 => convert2_dout_net_x8,
      sel(0) => register2_q_net_x0,
      y => mux3_y_net
    );

  mux4: entity work.mux_a54904b290
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => addsub_s_net_x2,
      d1 => convert1_dout_net_x2,
      sel(0) => register2_q_net_x0,
      y => mux4_y_net
    );

  mux5: entity work.mux_a54904b290
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => addsub1_s_net_x2,
      d1 => convert2_dout_net_x9,
      sel(0) => register2_q_net_x0,
      y => mux5_y_net
    );

  mux6: entity work.mux_a54904b290
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => addsub_s_net_x3,
      d1 => convert1_dout_net_x3,
      sel(0) => register2_q_net_x0,
      y => mux6_y_net
    );

  mux7: entity work.mux_a54904b290
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => addsub1_s_net_x3,
      d1 => convert2_dout_net_x10,
      sel(0) => register2_q_net_x0,
      y => mux7_y_net
    );

  register1: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => addsub1_s_net_x0,
      en => "1",
      rst(0) => inverter_op_net_x3,
      q => register1_q_net_x1
    );

  register10: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => mux4_y_net,
      en => "1",
      rst => "0",
      q => register10_q_net_x0
    );

  register11: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => mux5_y_net,
      en => "1",
      rst => "0",
      q => register11_q_net_x0
    );

  register12: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => mux6_y_net,
      en => "1",
      rst => "0",
      q => register12_q_net_x0
    );

  register13: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => mux7_y_net,
      en => "1",
      rst => "0",
      q => register13_q_net_x0
    );

  register14: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => addsub_s_net_x3,
      en => "1",
      rst(0) => inverter_op_net_x3,
      q => register14_q_net_x0
    );

  register15: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => addsub1_s_net_x3,
      en => "1",
      rst(0) => inverter_op_net_x3,
      q => register15_q_net_x0
    );

  register2: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => addsub_s_net_x1,
      en => "1",
      rst(0) => inverter_op_net_x3,
      q => register2_q_net_x1
    );

  register3: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => addsub1_s_net_x1,
      en => "1",
      rst(0) => inverter_op_net_x3,
      q => register3_q_net_x0
    );

  register4: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => mux1_y_net,
      en => "1",
      rst => "0",
      q => register4_q_net_x0
    );

  register5: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => mux_y_net,
      en => "1",
      rst => "0",
      q => register5_q_net_x0
    );

  register6: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => addsub_s_net_x2,
      en => "1",
      rst(0) => inverter_op_net_x3,
      q => register6_q_net_x0
    );

  register7: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => addsub1_s_net_x2,
      en => "1",
      rst(0) => inverter_op_net_x3,
      q => register7_q_net_x0
    );

  register8: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => mux2_y_net,
      en => "1",
      rst => "0",
      q => register8_q_net_x0
    );

  register9: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => mux3_y_net,
      en => "1",
      rst => "0",
      q => register9_q_net_x0
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 16,
      init_value => b"0000000000000000"
    )
    port map (
      ce => ce_1_sg_x31,
      clk => clk_1_sg_x31,
      d => addsub_s_net_x0,
      en => "1",
      rst(0) => inverter_op_net_x3,
      q => register_q_net_x1
    );

  s_r_latch_dada342a31: entity work.s_r_latch_entity_4d279d5862
    port map (
      ce_1 => ce_1_sg_x31,
      clk_1 => clk_1_sg_x31,
      r => inverter_op_net_x7,
      s => logical1_y_net_x24,
      q => register2_q_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/EDK Processor"

entity edk_processor_entity_dd50257593 is
  port (
    axi_aresetn: in std_logic; 
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
    to_register2: in std_logic_vector(17 downto 0); 
    to_register3: in std_logic_vector(17 downto 0); 
    to_register4: in std_logic_vector(31 downto 0); 
    to_register5: in std_logic_vector(31 downto 0); 
    to_register6: in std_logic_vector(31 downto 0); 
    to_register7: in std_logic_vector(31 downto 0); 
    to_register8: in std_logic_vector(31 downto 0); 
    memmap_x0: out std_logic; 
    memmap_x1: out std_logic; 
    memmap_x10: out std_logic; 
    memmap_x11: out std_logic_vector(31 downto 0); 
    memmap_x12: out std_logic; 
    memmap_x13: out std_logic_vector(31 downto 0); 
    memmap_x14: out std_logic; 
    memmap_x15: out std_logic_vector(17 downto 0); 
    memmap_x16: out std_logic; 
    memmap_x17: out std_logic_vector(17 downto 0); 
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
    memmap_x3: out std_logic_vector(1 downto 0); 
    memmap_x4: out std_logic; 
    memmap_x5: out std_logic_vector(31 downto 0); 
    memmap_x6: out std_logic_vector(7 downto 0); 
    memmap_x7: out std_logic; 
    memmap_x8: out std_logic_vector(1 downto 0); 
    memmap_x9: out std_logic
  );
end edk_processor_entity_dd50257593;

architecture structural of edk_processor_entity_dd50257593 is
  signal axi_aresetn_net_x0: std_logic;
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
  signal memmap_sm_config_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_config_en_net_x0: std_logic;
  signal memmap_sm_iir_coef_a1_din_net_x0: std_logic_vector(17 downto 0);
  signal memmap_sm_iir_coef_a1_en_net_x0: std_logic;
  signal memmap_sm_iir_coef_b0_din_net_x0: std_logic_vector(17 downto 0);
  signal memmap_sm_iir_coef_b0_en_net_x0: std_logic;
  signal memmap_sm_reset_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_reset_en_net_x0: std_logic;
  signal memmap_sm_rssi_pwr_calib_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_rssi_pwr_calib_en_net_x0: std_logic;
  signal memmap_sm_target_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_target_en_net_x0: std_logic;
  signal memmap_sm_timing_agc_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_timing_agc_en_net_x0: std_logic;
  signal memmap_sm_timing_dco_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_timing_dco_en_net_x0: std_logic;
  signal memmap_sm_timing_reset_din_net_x0: std_logic_vector(31 downto 0);
  signal memmap_sm_timing_reset_en_net_x0: std_logic;
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
  signal to_register1_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register2_dout_net_x0: std_logic_vector(17 downto 0);
  signal to_register3_dout_net_x0: std_logic_vector(17 downto 0);
  signal to_register4_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register5_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register6_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register7_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register8_dout_net_x0: std_logic_vector(31 downto 0);
  signal to_register_dout_net_x0: std_logic_vector(31 downto 0);

begin
  axi_aresetn_net_x0 <= axi_aresetn;
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
  to_register2_dout_net_x0 <= to_register2;
  to_register3_dout_net_x0 <= to_register3;
  to_register4_dout_net_x0 <= to_register4;
  to_register5_dout_net_x0 <= to_register5;
  to_register6_dout_net_x0 <= to_register6;
  to_register7_dout_net_x0 <= to_register7;
  to_register8_dout_net_x0 <= to_register8;
  memmap_x0 <= memmap_s_axi_arready_net_x0;
  memmap_x1 <= memmap_s_axi_awready_net_x0;
  memmap_x10 <= memmap_s_axi_wready_net_x0;
  memmap_x11 <= memmap_sm_timing_reset_din_net_x0;
  memmap_x12 <= memmap_sm_timing_reset_en_net_x0;
  memmap_x13 <= memmap_sm_rssi_pwr_calib_din_net_x0;
  memmap_x14 <= memmap_sm_rssi_pwr_calib_en_net_x0;
  memmap_x15 <= memmap_sm_iir_coef_b0_din_net_x0;
  memmap_x16 <= memmap_sm_iir_coef_b0_en_net_x0;
  memmap_x17 <= memmap_sm_iir_coef_a1_din_net_x0;
  memmap_x18 <= memmap_sm_iir_coef_a1_en_net_x0;
  memmap_x19 <= memmap_sm_reset_din_net_x0;
  memmap_x2 <= memmap_s_axi_bid_net_x0;
  memmap_x20 <= memmap_sm_reset_en_net_x0;
  memmap_x21 <= memmap_sm_timing_agc_din_net_x0;
  memmap_x22 <= memmap_sm_timing_agc_en_net_x0;
  memmap_x23 <= memmap_sm_target_din_net_x0;
  memmap_x24 <= memmap_sm_target_en_net_x0;
  memmap_x25 <= memmap_sm_config_din_net_x0;
  memmap_x26 <= memmap_sm_config_en_net_x0;
  memmap_x27 <= memmap_sm_timing_dco_din_net_x0;
  memmap_x28 <= memmap_sm_timing_dco_en_net_x0;
  memmap_x3 <= memmap_s_axi_bresp_net_x0;
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
      sm_config_dout => to_register7_dout_net_x0,
      sm_iir_coef_a1_dout => to_register3_dout_net_x0,
      sm_iir_coef_b0_dout => to_register2_dout_net_x0,
      sm_reset_dout => to_register4_dout_net_x0,
      sm_rssi_pwr_calib_dout => to_register1_dout_net_x0,
      sm_target_dout => to_register6_dout_net_x0,
      sm_timing_agc_dout => to_register5_dout_net_x0,
      sm_timing_dco_dout => to_register8_dout_net_x0,
      sm_timing_reset_dout => to_register_dout_net_x0,
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
      sm_config_din => memmap_sm_config_din_net_x0,
      sm_config_en => memmap_sm_config_en_net_x0,
      sm_iir_coef_a1_din => memmap_sm_iir_coef_a1_din_net_x0,
      sm_iir_coef_a1_en => memmap_sm_iir_coef_a1_en_net_x0,
      sm_iir_coef_b0_din => memmap_sm_iir_coef_b0_din_net_x0,
      sm_iir_coef_b0_en => memmap_sm_iir_coef_b0_en_net_x0,
      sm_reset_din => memmap_sm_reset_din_net_x0,
      sm_reset_en => memmap_sm_reset_en_net_x0,
      sm_rssi_pwr_calib_din => memmap_sm_rssi_pwr_calib_din_net_x0,
      sm_rssi_pwr_calib_en => memmap_sm_rssi_pwr_calib_en_net_x0,
      sm_target_din => memmap_sm_target_din_net_x0,
      sm_target_en => memmap_sm_target_en_net_x0,
      sm_timing_agc_din => memmap_sm_timing_agc_din_net_x0,
      sm_timing_agc_en => memmap_sm_timing_agc_en_net_x0,
      sm_timing_dco_din => memmap_sm_timing_dco_din_net_x0,
      sm_timing_dco_en => memmap_sm_timing_dco_en_net_x0,
      sm_timing_reset_din => memmap_sm_timing_reset_din_net_x0,
      sm_timing_reset_en => memmap_sm_timing_reset_en_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Gain Calc A/BB gain"

entity bb_gain_entity_335e3bf8c7 is
  port (
    agc_ctrl_g_bb_sel: in std_logic_vector(1 downto 0); 
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    g_rf_db: in std_logic_vector(5 downto 0); 
    iq_dbv: in std_logic_vector(13 downto 0); 
    p_in_rssi: in std_logic_vector(7 downto 0); 
    reg_agc_init_g_bb: in std_logic_vector(4 downto 0); 
    reg_agc_target_pwr: in std_logic_vector(5 downto 0); 
    reg_agc_v_db_adj: in std_logic_vector(5 downto 0); 
    g_bb: out std_logic_vector(4 downto 0)
  );
end bb_gain_entity_335e3bf8c7;

architecture structural of bb_gain_entity_335e3bf8c7 is
  signal addsub1_s_net: std_logic_vector(7 downto 0);
  signal addsub2_s_net: std_logic_vector(7 downto 0);
  signal addsub3_s_net: std_logic_vector(7 downto 0);
  signal addsub4_s_net: std_logic_vector(7 downto 0);
  signal addsub_s_net: std_logic_vector(7 downto 0);
  signal addsub_s_net_x1: std_logic_vector(7 downto 0);
  signal ce_1_sg_x32: std_logic;
  signal clk_1_sg_x32: std_logic;
  signal convert1_dout_net: std_logic_vector(4 downto 0);
  signal convert2_dout_net: std_logic_vector(4 downto 0);
  signal counter1_op_net_x2: std_logic_vector(1 downto 0);
  signal mux1_y_net_x0: std_logic_vector(5 downto 0);
  signal mux_y_net_x0: std_logic_vector(4 downto 0);
  signal register14_q_net_x0: std_logic_vector(5 downto 0);
  signal register15_q_net_x0: std_logic_vector(4 downto 0);
  signal register16_q_net_x0: std_logic_vector(5 downto 0);
  signal register_q_net_x0: std_logic_vector(13 downto 0);
  signal shift1_op_net: std_logic_vector(7 downto 0);
  signal shift_op_net: std_logic_vector(7 downto 0);

begin
  counter1_op_net_x2 <= agc_ctrl_g_bb_sel;
  ce_1_sg_x32 <= ce_1;
  clk_1_sg_x32 <= clk_1;
  mux1_y_net_x0 <= g_rf_db;
  register_q_net_x0 <= iq_dbv;
  addsub_s_net_x1 <= p_in_rssi;
  register15_q_net_x0 <= reg_agc_init_g_bb;
  register16_q_net_x0 <= reg_agc_target_pwr;
  register14_q_net_x0 <= reg_agc_v_db_adj;
  g_bb <= mux_y_net_x0;

  addsub: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 0,
      a_width => 6,
      b_arith => xlSigned,
      b_bin_pt => 0,
      b_width => 8,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 9,
      core_name0 => "addsb_11_0_8942e2ad5d8d4897",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 9,
      latency => 1,
      overflow => 1,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 0,
      s_width => 8
    )
    port map (
      a => register16_q_net_x0,
      b => addsub_s_net_x1,
      ce => ce_1_sg_x32,
      clk => clk_1_sg_x32,
      clr => '0',
      en => "1",
      s => addsub_s_net
    );

  addsub1: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 0,
      a_width => 8,
      b_arith => xlUnsigned,
      b_bin_pt => 0,
      b_width => 6,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 9,
      core_name0 => "addsb_11_0_8942e2ad5d8d4897",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 9,
      latency => 1,
      overflow => 1,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 0,
      s_width => 8
    )
    port map (
      a => addsub_s_net,
      b => mux1_y_net_x0,
      ce => ce_1_sg_x32,
      clk => clk_1_sg_x32,
      clr => '0',
      en => "1",
      s => addsub1_s_net
    );

  addsub2: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 0,
      a_width => 6,
      b_arith => xlSigned,
      b_bin_pt => 0,
      b_width => 8,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 9,
      core_name0 => "addsb_11_0_a52ead9b8a3c1e76",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 9,
      latency => 0,
      overflow => 1,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 0,
      s_width => 8
    )
    port map (
      a => register16_q_net_x0,
      b => addsub4_s_net,
      ce => ce_1_sg_x32,
      clk => clk_1_sg_x32,
      clr => '0',
      en => "1",
      s => addsub2_s_net
    );

  addsub3: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 0,
      a_width => 8,
      b_arith => xlSigned,
      b_bin_pt => 0,
      b_width => 8,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 9,
      core_name0 => "addsb_11_0_4ed1308cac188ac9",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 9,
      latency => 1,
      overflow => 1,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 0,
      s_width => 8
    )
    port map (
      a => addsub2_s_net,
      b => addsub1_s_net,
      ce => ce_1_sg_x32,
      clk => clk_1_sg_x32,
      clr => '0',
      en => "1",
      s => addsub3_s_net
    );

  addsub4: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 8,
      a_width => 14,
      b_arith => xlSigned,
      b_bin_pt => 0,
      b_width => 6,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 15,
      core_name0 => "addsb_11_0_c62d62064f685a8c",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 15,
      latency => 0,
      overflow => 1,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 0,
      s_width => 8
    )
    port map (
      a => register_q_net_x0,
      b => register14_q_net_x0,
      ce => ce_1_sg_x32,
      clk => clk_1_sg_x32,
      clr => '0',
      en => "1",
      s => addsub4_s_net
    );

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 2,
      din_bin_pt => 0,
      din_width => 8,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 5,
      latency => 0,
      overflow => xlSaturate,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x32,
      clk => clk_1_sg_x32,
      clr => '0',
      din => shift_op_net,
      en => "1",
      dout => convert1_dout_net
    );

  convert2: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 2,
      din_bin_pt => 0,
      din_width => 8,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 5,
      latency => 0,
      overflow => xlSaturate,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x32,
      clk => clk_1_sg_x32,
      clr => '0',
      din => shift1_op_net,
      en => "1",
      dout => convert2_dout_net
    );

  mux: entity work.mux_71afdb0de4
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => register15_q_net_x0,
      d1 => convert1_dout_net,
      d2 => convert2_dout_net,
      sel => counter1_op_net_x2,
      y => mux_y_net_x0
    );

  shift: entity work.shift_c7000d680d
    port map (
      ce => ce_1_sg_x32,
      clk => clk_1_sg_x32,
      clr => '0',
      ip => addsub1_s_net,
      op => shift_op_net
    );

  shift1: entity work.shift_c7000d680d
    port map (
      ce => ce_1_sg_x32,
      clk => clk_1_sg_x32,
      clr => '0',
      ip => addsub3_s_net,
      op => shift1_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Gain Calc A/Capture & Convert"

entity \capture___convert_entity_2dc0791616\ is
  port (
    agc_ctrl_capture_rssi: in std_logic; 
    agc_reset: in std_logic; 
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    g_rf: in std_logic_vector(1 downto 0); 
    reg_agc_rssi_calib_g1: in std_logic_vector(7 downto 0); 
    reg_agc_rssi_calib_g2: in std_logic_vector(7 downto 0); 
    reg_agc_rssi_calib_g3: in std_logic_vector(7 downto 0); 
    rssi: in std_logic_vector(9 downto 0); 
    rx_pwr_dbm: out std_logic_vector(7 downto 0)
  );
end \capture___convert_entity_2dc0791616\;

architecture structural of \capture___convert_entity_2dc0791616\ is
  signal addsub_s_net_x2: std_logic_vector(7 downto 0);
  signal ce_1_sg_x33: std_logic;
  signal clk_1_sg_x33: std_logic;
  signal constant_op_net: std_logic_vector(11 downto 0);
  signal convert1_dout_net_x0: std_logic_vector(9 downto 0);
  signal inverter_op_net_x8: std_logic;
  signal logical3_y_net_x1: std_logic;
  signal mult_p_net: std_logic_vector(10 downto 0);
  signal mux1_y_net: std_logic_vector(7 downto 0);
  signal register1_q_net_x0: std_logic_vector(7 downto 0);
  signal register2_q_net_x0: std_logic_vector(7 downto 0);
  signal register3_q_net_x0: std_logic_vector(7 downto 0);
  signal register_q_net: std_logic_vector(9 downto 0);
  signal register_q_net_x1: std_logic_vector(1 downto 0);

begin
  logical3_y_net_x1 <= agc_ctrl_capture_rssi;
  inverter_op_net_x8 <= agc_reset;
  ce_1_sg_x33 <= ce_1;
  clk_1_sg_x33 <= clk_1;
  register_q_net_x1 <= g_rf;
  register2_q_net_x0 <= reg_agc_rssi_calib_g1;
  register1_q_net_x0 <= reg_agc_rssi_calib_g2;
  register3_q_net_x0 <= reg_agc_rssi_calib_g3;
  convert1_dout_net_x0 <= rssi;
  rx_pwr_dbm <= addsub_s_net_x2;

  addsub: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 4,
      a_width => 11,
      b_arith => xlUnsigned,
      b_bin_pt => 0,
      b_width => 8,
      c_has_c_out => 0,
      c_latency => 1,
      c_output_width => 13,
      core_name0 => "addsb_11_0_b48032ce427ab995",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 13,
      latency => 1,
      overflow => 3,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 0,
      s_width => 8
    )
    port map (
      a => mult_p_net,
      b => mux1_y_net,
      ce => ce_1_sg_x33,
      clk => clk_1_sg_x33,
      clr => '0',
      en => "1",
      s => addsub_s_net_x2
    );

  constant_x0: entity work.constant_357f42eab8
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant_op_net
    );

  mult: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 0,
      a_width => 10,
      b_arith => xlUnsigned,
      b_bin_pt => 12,
      b_width => 12,
      c_a_type => 1,
      c_a_width => 10,
      c_b_type => 1,
      c_b_width => 12,
      c_baat => 10,
      c_output_width => 22,
      c_type => 1,
      core_name0 => "mult_11_2_30380bd5df9eb5a0",
      extra_registers => 0,
      multsign => 1,
      overflow => 1,
      p_arith => xlUnsigned,
      p_bin_pt => 4,
      p_width => 11,
      quantization => 1
    )
    port map (
      a => register_q_net,
      b => constant_op_net,
      ce => ce_1_sg_x33,
      clk => clk_1_sg_x33,
      clr => '0',
      core_ce => ce_1_sg_x33,
      core_clk => clk_1_sg_x33,
      core_clr => '1',
      en => "1",
      rst => "0",
      p => mult_p_net
    );

  mux1: entity work.mux_998e20a1ca
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => register2_q_net_x0,
      d1 => register2_q_net_x0,
      d2 => register1_q_net_x0,
      d3 => register3_q_net_x0,
      sel => register_q_net_x1,
      y => mux1_y_net
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 10,
      init_value => b"0000000011"
    )
    port map (
      ce => ce_1_sg_x33,
      clk => clk_1_sg_x33,
      d => convert1_dout_net_x0,
      en(0) => logical3_y_net_x1,
      rst(0) => inverter_op_net_x8,
      q => register_q_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Gain Calc A/IQ Mag/Running Sum"

entity running_sum_entity_ef8571f60b is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    d: in std_logic_vector(19 downto 0); 
    en: in std_logic; 
    sum: out std_logic_vector(10 downto 0)
  );
end running_sum_entity_ef8571f60b;

architecture structural of running_sum_entity_ef8571f60b is
  signal accum1_q_net: std_logic_vector(25 downto 0);
  signal addsub1_s_net: std_logic_vector(20 downto 0);
  signal addsub_s_net_x0: std_logic_vector(19 downto 0);
  signal ce_1_sg_x34: std_logic;
  signal clk_1_sg_x34: std_logic;
  signal convert1_dout_net_x0: std_logic_vector(10 downto 0);
  signal convert_dout_net: std_logic_vector(25 downto 0);
  signal delay6_q_net: std_logic_vector(19 downto 0);
  signal delay_q_net_x0: std_logic;
  signal delay_q_net_x1: std_logic;
  signal register_q_net: std_logic_vector(25 downto 0);
  signal shift_op_net: std_logic_vector(25 downto 0);

begin
  ce_1_sg_x34 <= ce_1;
  clk_1_sg_x34 <= clk_1;
  addsub_s_net_x0 <= d;
  delay_q_net_x1 <= en;
  sum <= convert1_dout_net_x0;

  accum1: entity work.accum_4212bee193
    port map (
      b => addsub1_s_net,
      ce => ce_1_sg_x34,
      clk => clk_1_sg_x34,
      clr => '0',
      en(0) => delay_q_net_x0,
      q => accum1_q_net
    );

  addsub1: entity work.addsub_a89167bf37
    port map (
      a => addsub_s_net_x0,
      b => delay6_q_net,
      ce => ce_1_sg_x34,
      clk => clk_1_sg_x34,
      clr => '0',
      s => addsub1_s_net
    );

  convert: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 2,
      din_bin_pt => 19,
      din_width => 26,
      dout_arith => 1,
      dout_bin_pt => 19,
      dout_width => 26,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x34,
      clk => clk_1_sg_x34,
      clr => '0',
      din => accum1_q_net,
      en => "1",
      dout => convert_dout_net
    );

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 19,
      din_width => 26,
      dout_arith => 1,
      dout_bin_pt => 10,
      dout_width => 11,
      latency => 0,
      overflow => xlSaturate,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x34,
      clk => clk_1_sg_x34,
      clr => '0',
      din => shift_op_net,
      en => "1",
      dout => convert1_dout_net_x0
    );

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x34,
      clk => clk_1_sg_x34,
      d(0) => delay_q_net_x1,
      en => '1',
      rst => '1',
      q(0) => delay_q_net_x0
    );

  delay6: entity work.xldelay
    generic map (
      latency => 16,
      reg_retiming => 0,
      reset => 0,
      width => 20
    )
    port map (
      ce => ce_1_sg_x34,
      clk => clk_1_sg_x34,
      d => addsub_s_net_x0,
      en => delay_q_net_x1,
      rst => '1',
      q => delay6_q_net
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 26,
      init_value => b"00000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x34,
      clk => clk_1_sg_x34,
      d => convert_dout_net,
      en => "1",
      rst => "0",
      q => register_q_net
    );

  shift: entity work.shift_ae71adf6a0
    port map (
      ce => ce_1_sg_x34,
      clk => clk_1_sg_x34,
      clr => '0',
      ip => register_q_net,
      op => shift_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Gain Calc A/IQ Mag"

entity iq_mag_entity_92fc2cf206 is
  port (
    agc_ctrl_capture_v_db: in std_logic; 
    agc_done_g_bb: in std_logic; 
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    i: in std_logic_vector(11 downto 0); 
    q: in std_logic_vector(11 downto 0); 
    valid: in std_logic; 
    iq_dbv: out std_logic_vector(13 downto 0)
  );
end iq_mag_entity_92fc2cf206;

architecture structural of iq_mag_entity_92fc2cf206 is
  signal addsub_s_net_x0: std_logic_vector(19 downto 0);
  signal ce_1_sg_x35: std_logic;
  signal clk_1_sg_x35: std_logic;
  signal convert1_dout_net_x0: std_logic_vector(10 downto 0);
  signal convert2_dout_net_x12: std_logic;
  signal delay_q_net_x1: std_logic;
  signal logical1_y_net_x14: std_logic;
  signal logical4_y_net_x2: std_logic;
  signal mult1_p_net: std_logic_vector(19 downto 0);
  signal mult_p_net: std_logic_vector(19 downto 0);
  signal register_q_net_x1: std_logic_vector(13 downto 0);
  signal reinterpret_output_port_net: std_logic_vector(10 downto 0);
  signal rfa_rx_i_in_net_x2: std_logic_vector(11 downto 0);
  signal rfa_rx_q_in_net_x2: std_logic_vector(11 downto 0);
  signal rom_data_net: std_logic_vector(13 downto 0);

begin
  logical1_y_net_x14 <= agc_ctrl_capture_v_db;
  logical4_y_net_x2 <= agc_done_g_bb;
  ce_1_sg_x35 <= ce_1;
  clk_1_sg_x35 <= clk_1;
  rfa_rx_i_in_net_x2 <= i;
  rfa_rx_q_in_net_x2 <= q;
  convert2_dout_net_x12 <= valid;
  iq_dbv <= register_q_net_x1;

  addsub: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 20,
      a_width => 20,
      b_arith => xlUnsigned,
      b_bin_pt => 20,
      b_width => 20,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 21,
      core_name0 => "addsb_11_0_3e2164f3961f5928",
      extra_registers => 0,
      full_s_arith => 1,
      full_s_width => 21,
      latency => 0,
      overflow => 3,
      quantization => 1,
      s_arith => xlUnsigned,
      s_bin_pt => 19,
      s_width => 20
    )
    port map (
      a => mult_p_net,
      b => mult1_p_net,
      ce => ce_1_sg_x35,
      clk => clk_1_sg_x35,
      clr => '0',
      en => "1",
      s => addsub_s_net_x0
    );

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x35,
      clk => clk_1_sg_x35,
      d(0) => convert2_dout_net_x12,
      en => '1',
      rst => '1',
      q(0) => delay_q_net_x1
    );

  mult: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 11,
      a_width => 12,
      b_arith => xlSigned,
      b_bin_pt => 11,
      b_width => 12,
      c_a_type => 0,
      c_a_width => 12,
      c_b_type => 0,
      c_b_width => 12,
      c_baat => 12,
      c_output_width => 24,
      c_type => 0,
      core_name0 => "mult_11_2_3b49a62273275732",
      extra_registers => 1,
      multsign => 2,
      overflow => 2,
      p_arith => xlUnsigned,
      p_bin_pt => 20,
      p_width => 20,
      quantization => 1
    )
    port map (
      a => rfa_rx_i_in_net_x2,
      b => rfa_rx_i_in_net_x2,
      ce => ce_1_sg_x35,
      clk => clk_1_sg_x35,
      clr => '0',
      core_ce => ce_1_sg_x35,
      core_clk => clk_1_sg_x35,
      core_clr => '1',
      en => "1",
      rst => "0",
      p => mult_p_net
    );

  mult1: entity work.xlmult_wlan_agc
    generic map (
      a_arith => xlSigned,
      a_bin_pt => 11,
      a_width => 12,
      b_arith => xlSigned,
      b_bin_pt => 11,
      b_width => 12,
      c_a_type => 0,
      c_a_width => 12,
      c_b_type => 0,
      c_b_width => 12,
      c_baat => 12,
      c_output_width => 24,
      c_type => 0,
      core_name0 => "mult_11_2_3b49a62273275732",
      extra_registers => 1,
      multsign => 2,
      overflow => 2,
      p_arith => xlUnsigned,
      p_bin_pt => 20,
      p_width => 20,
      quantization => 1
    )
    port map (
      a => rfa_rx_q_in_net_x2,
      b => rfa_rx_q_in_net_x2,
      ce => ce_1_sg_x35,
      clk => clk_1_sg_x35,
      clr => '0',
      core_ce => ce_1_sg_x35,
      core_clk => clk_1_sg_x35,
      core_clr => '1',
      en => "1",
      rst => "0",
      p => mult1_p_net
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 14,
      init_value => b"00000000000000"
    )
    port map (
      ce => ce_1_sg_x35,
      clk => clk_1_sg_x35,
      d => rom_data_net,
      en(0) => logical1_y_net_x14,
      rst(0) => logical4_y_net_x2,
      q => register_q_net_x1
    );

  reinterpret: entity work.reinterpret_6b1adb5d55
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => convert1_dout_net_x0,
      output_port => reinterpret_output_port_net
    );

  rom: entity work.xlsprom_wlan_agc
    generic map (
      c_address_width => 11,
      c_width => 14,
      core_name0 => "bmg_72_3c8cb899503da0de",
      latency => 1
    )
    port map (
      addr => reinterpret_output_port_net,
      ce => ce_1_sg_x35,
      clk => clk_1_sg_x35,
      en => "1",
      rst => "0",
      data => rom_data_net
    );

  running_sum_ef8571f60b: entity work.running_sum_entity_ef8571f60b
    port map (
      ce_1 => ce_1_sg_x35,
      clk_1 => clk_1_sg_x35,
      d => addsub_s_net_x0,
      en => delay_q_net_x1,
      sum => convert1_dout_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Gain Calc A/RF Gain"

entity rf_gain_entity_a87af46734 is
  port (
    agc_ctrl_set_g_rf: in std_logic; 
    agc_done_g_rf: in std_logic; 
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    reg_agc_rfg_thresh_21: in std_logic_vector(7 downto 0); 
    reg_agc_rfg_thresh_32: in std_logic_vector(7 downto 0); 
    rx_pwr: in std_logic_vector(7 downto 0); 
    g_rf: out std_logic_vector(1 downto 0); 
    g_rf_db: out std_logic_vector(5 downto 0)
  );
end rf_gain_entity_a87af46734;

architecture structural of rf_gain_entity_a87af46734 is
  signal addsub_s_net_x3: std_logic_vector(7 downto 0);
  signal ce_1_sg_x36: std_logic;
  signal clk_1_sg_x36: std_logic;
  signal concat_y_net: std_logic_vector(1 downto 0);
  signal constant1_op_net: std_logic_vector(1 downto 0);
  signal constant2_op_net: std_logic_vector(1 downto 0);
  signal constant3_op_net: std_logic_vector(5 downto 0);
  signal constant4_op_net: std_logic_vector(5 downto 0);
  signal constant5_op_net: std_logic_vector(5 downto 0);
  signal constant_op_net: std_logic_vector(1 downto 0);
  signal delay1_q_net_x1: std_logic;
  signal logical5_y_net_x1: std_logic;
  signal mux1_y_net_x1: std_logic_vector(5 downto 0);
  signal mux_y_net: std_logic_vector(1 downto 0);
  signal register11_q_net_x0: std_logic_vector(7 downto 0);
  signal register12_q_net_x0: std_logic_vector(7 downto 0);
  signal register_q_net_x2: std_logic_vector(1 downto 0);
  signal relational1_op_net: std_logic;
  signal relational2_op_net: std_logic;

begin
  delay1_q_net_x1 <= agc_ctrl_set_g_rf;
  logical5_y_net_x1 <= agc_done_g_rf;
  ce_1_sg_x36 <= ce_1;
  clk_1_sg_x36 <= clk_1;
  register12_q_net_x0 <= reg_agc_rfg_thresh_21;
  register11_q_net_x0 <= reg_agc_rfg_thresh_32;
  addsub_s_net_x3 <= rx_pwr;
  g_rf <= register_q_net_x2;
  g_rf_db <= mux1_y_net_x1;

  concat: entity work.concat_32afb77cd2
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => relational1_op_net,
      in1(0) => relational2_op_net,
      y => concat_y_net
    );

  constant1: entity work.constant_e8ddc079e9
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant1_op_net
    );

  constant2: entity work.constant_a7e2bb9e12
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant2_op_net
    );

  constant3: entity work.constant_7ea0f2fff7
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant3_op_net
    );

  constant4: entity work.constant_c11beaf011
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant4_op_net
    );

  constant5: entity work.constant_b8537696ec
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant5_op_net
    );

  constant_x0: entity work.constant_3a9a3daeb9
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant_op_net
    );

  mux: entity work.mux_1a0db76efe
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => constant_op_net,
      d1 => constant1_op_net,
      d2 => constant1_op_net,
      d3 => constant2_op_net,
      sel => concat_y_net,
      y => mux_y_net
    );

  mux1: entity work.mux_593ae85213
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => constant3_op_net,
      d1 => constant3_op_net,
      d2 => constant4_op_net,
      d3 => constant5_op_net,
      sel => register_q_net_x2,
      y => mux1_y_net_x1
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 2,
      init_value => b"11"
    )
    port map (
      ce => ce_1_sg_x36,
      clk => clk_1_sg_x36,
      d => mux_y_net,
      en(0) => delay1_q_net_x1,
      rst(0) => logical5_y_net_x1,
      q => register_q_net_x2
    );

  relational1: entity work.relational_3e2cefc69d
    port map (
      a => addsub_s_net_x3,
      b => register12_q_net_x0,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net
    );

  relational2: entity work.relational_3e2cefc69d
    port map (
      a => addsub_s_net_x3,
      b => register11_q_net_x0,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational2_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Gain Calc A/RSSI Avg/Reset/S-R Latch"

entity s_r_latch_entity_7590533bfc is
  port (
    ce_16: in std_logic; 
    clk_16: in std_logic; 
    r: in std_logic; 
    s: in std_logic; 
    q: out std_logic
  );
end s_r_latch_entity_7590533bfc;

architecture structural of s_r_latch_entity_7590533bfc is
  signal ce_16_sg_x0: std_logic;
  signal clk_16_sg_x0: std_logic;
  signal constant1_op_net: std_logic;
  signal delay1_q_net_x0: std_logic;
  signal register2_q_net_x0: std_logic;
  signal relational_op_net_x0: std_logic;

begin
  ce_16_sg_x0 <= ce_16;
  clk_16_sg_x0 <= clk_16;
  delay1_q_net_x0 <= r;
  relational_op_net_x0 <= s;
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
      ce => ce_16_sg_x0,
      clk => clk_16_sg_x0,
      d(0) => constant1_op_net,
      en(0) => relational_op_net_x0,
      rst(0) => delay1_q_net_x0,
      q(0) => register2_q_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Gain Calc A/RSSI Avg/Reset"

entity reset_entity_ee26074249 is
  port (
    ce_16: in std_logic; 
    clk_16: in std_logic; 
    start: in std_logic_vector(1 downto 0); 
    rst: out std_logic
  );
end reset_entity_ee26074249;

architecture structural of reset_entity_ee26074249 is
  signal ce_16_sg_x1: std_logic;
  signal clk_16_sg_x1: std_logic;
  signal delay1_q_net_x0: std_logic;
  signal delay_q_net: std_logic_vector(1 downto 0);
  signal down_sample1_q_net_x0: std_logic_vector(1 downto 0);
  signal register2_q_net_x1: std_logic;
  signal relational_op_net_x0: std_logic;

begin
  ce_16_sg_x1 <= ce_16;
  clk_16_sg_x1 <= clk_16;
  down_sample1_q_net_x0 <= start;
  rst <= register2_q_net_x1;

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      reset => 0,
      width => 2
    )
    port map (
      ce => ce_16_sg_x1,
      clk => clk_16_sg_x1,
      d => down_sample1_q_net_x0,
      en => '1',
      rst => '1',
      q => delay_q_net
    );

  delay1: entity work.xldelay
    generic map (
      latency => 9,
      reg_retiming => 0,
      reset => 0,
      width => 1
    )
    port map (
      ce => ce_16_sg_x1,
      clk => clk_16_sg_x1,
      d(0) => register2_q_net_x1,
      en => '1',
      rst => '1',
      q(0) => delay1_q_net_x0
    );

  relational: entity work.relational_f9928864ea
    port map (
      a => down_sample1_q_net_x0,
      b => delay_q_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational_op_net_x0
    );

  s_r_latch_7590533bfc: entity work.s_r_latch_entity_7590533bfc
    port map (
      ce_16 => ce_16_sg_x1,
      clk_16 => clk_16_sg_x1,
      r => delay1_q_net_x0,
      s => relational_op_net_x0,
      q => register2_q_net_x1
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Gain Calc A/RSSI Avg"

entity rssi_avg_entity_1ca7fd5428 is
  port (
    ce_1: in std_logic; 
    ce_16: in std_logic; 
    clk_1: in std_logic; 
    clk_16: in std_logic; 
    reg_rssi_avg_len_sel: in std_logic_vector(1 downto 0); 
    rssi: in std_logic_vector(9 downto 0); 
    avg: out std_logic_vector(9 downto 0)
  );
end rssi_avg_entity_1ca7fd5428;

architecture structural of rssi_avg_entity_1ca7fd5428 is
  signal accumulator_q_net: std_logic_vector(15 downto 0);
  signal addsub_s_net: std_logic_vector(10 downto 0);
  signal asr_q_net: std_logic_vector(9 downto 0);
  signal ce_16_sg_x2: std_logic;
  signal ce_1_sg_x37: std_logic;
  signal clk_16_sg_x2: std_logic;
  signal clk_1_sg_x37: std_logic;
  signal constant1_op_net: std_logic_vector(1 downto 0);
  signal constant2_op_net: std_logic_vector(2 downto 0);
  signal constant3_op_net: std_logic_vector(2 downto 0);
  signal constant_op_net: std_logic_vector(1 downto 0);
  signal convert1_dout_net_x1: std_logic_vector(9 downto 0);
  signal down_sample1_q_net_x0: std_logic_vector(1 downto 0);
  signal down_sample_q_net_x0: std_logic_vector(9 downto 0);
  signal mux1_y_net: std_logic_vector(15 downto 0);
  signal mux_y_net: std_logic_vector(2 downto 0);
  signal register13_q_net_x0: std_logic_vector(1 downto 0);
  signal register2_q_net_x1: std_logic;
  signal register_q_net: std_logic_vector(9 downto 0);
  signal shift1_op_net: std_logic_vector(15 downto 0);
  signal shift2_op_net: std_logic_vector(15 downto 0);
  signal shift_op_net: std_logic_vector(15 downto 0);

begin
  ce_1_sg_x37 <= ce_1;
  ce_16_sg_x2 <= ce_16;
  clk_1_sg_x37 <= clk_1;
  clk_16_sg_x2 <= clk_16;
  register13_q_net_x0 <= reg_rssi_avg_len_sel;
  down_sample_q_net_x0 <= rssi;
  avg <= convert1_dout_net_x1;

  accumulator: entity work.accum_a47f50b4df
    port map (
      b => addsub_s_net,
      ce => ce_16_sg_x2,
      clk => clk_16_sg_x2,
      clr => '0',
      rst(0) => register2_q_net_x1,
      q => accumulator_q_net
    );

  addsub: entity work.xladdsub_wlan_agc
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 0,
      a_width => 10,
      b_arith => xlUnsigned,
      b_bin_pt => 0,
      b_width => 10,
      c_has_c_out => 0,
      c_latency => 0,
      c_output_width => 11,
      core_name0 => "addsb_11_0_76821d30ce8a19fb",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 11,
      latency => 0,
      overflow => 1,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 0,
      s_width => 11
    )
    port map (
      a => register_q_net,
      b => asr_q_net,
      ce => ce_16_sg_x2,
      clk => clk_16_sg_x2,
      clr => '0',
      en => "1",
      s => addsub_s_net
    );

  asr: entity work.xladdrsr_wlan_agc
    generic map (
      addr_arith => xlUnsigned,
      addr_bin_pt => 0,
      addr_width => 3,
      core_addr_width => 3,
      core_name0 => "asr_11_0_5c9c6a297ef30376",
      d_arith => xlUnsigned,
      d_bin_pt => 0,
      d_width => 10,
      q_arith => xlUnsigned,
      q_bin_pt => 0,
      q_width => 10
    )
    port map (
      addr => mux_y_net,
      ce => ce_16_sg_x2,
      clk => clk_16_sg_x2,
      clr => '0',
      d => register_q_net,
      en => "1",
      q => asr_q_net
    );

  constant1: entity work.constant_a7e2bb9e12
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant1_op_net
    );

  constant2: entity work.constant_0f59f02ba5
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant2_op_net
    );

  constant3: entity work.constant_1d6ad1c713
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant3_op_net
    );

  constant_x0: entity work.constant_cda50df78a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant_op_net
    );

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 2,
      din_bin_pt => 0,
      din_width => 16,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 10,
      latency => 0,
      overflow => xlSaturate,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x37,
      clk => clk_1_sg_x37,
      clr => '0',
      din => mux1_y_net,
      en => "1",
      dout => convert1_dout_net_x1
    );

  down_sample1: entity work.xldsamp
    generic map (
      d_arith => xlUnsigned,
      d_bin_pt => 0,
      d_width => 2,
      ds_ratio => 16,
      latency => 1,
      phase => 15,
      q_arith => xlUnsigned,
      q_bin_pt => 0,
      q_width => 2
    )
    port map (
      d => register13_q_net_x0,
      dest_ce => ce_16_sg_x2,
      dest_clk => clk_16_sg_x2,
      dest_clr => '0',
      en => "1",
      src_ce => ce_1_sg_x37,
      src_clk => clk_1_sg_x37,
      src_clr => '0',
      q => down_sample1_q_net_x0
    );

  mux: entity work.mux_04b0784a6e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => constant_op_net,
      d1 => constant1_op_net,
      d2 => constant2_op_net,
      d3 => constant3_op_net,
      sel => down_sample1_q_net_x0,
      y => mux_y_net
    );

  mux1: entity work.mux_824669a396
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => accumulator_q_net,
      d1 => shift_op_net,
      d2 => shift1_op_net,
      d3 => shift2_op_net,
      sel => register13_q_net_x0,
      y => mux1_y_net
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 10,
      init_value => b"0000000000"
    )
    port map (
      ce => ce_16_sg_x2,
      clk => clk_16_sg_x2,
      d => down_sample_q_net_x0,
      en => "1",
      rst(0) => register2_q_net_x1,
      q => register_q_net
    );

  reset_ee26074249: entity work.reset_entity_ee26074249
    port map (
      ce_16 => ce_16_sg_x2,
      clk_16 => clk_16_sg_x2,
      start => down_sample1_q_net_x0,
      rst => register2_q_net_x1
    );

  shift: entity work.shift_4c1752dcd9
    port map (
      ce => ce_16_sg_x2,
      clk => clk_16_sg_x2,
      clr => '0',
      ip => accumulator_q_net,
      op => shift_op_net
    );

  shift1: entity work.shift_529a3020ac
    port map (
      ce => ce_16_sg_x2,
      clk => clk_16_sg_x2,
      clr => '0',
      ip => accumulator_q_net,
      op => shift1_op_net
    );

  shift2: entity work.shift_df8070c965
    port map (
      ce => ce_16_sg_x2,
      clk => clk_16_sg_x2,
      clr => '0',
      ip => accumulator_q_net,
      op => shift2_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Gain Calc A"

entity gain_calc_a_entity_527cfe478a is
  port (
    ce_1: in std_logic; 
    ce_16: in std_logic; 
    clk_1: in std_logic; 
    clk_16: in std_logic; 
    ctrl: in std_logic_vector(1 downto 0); 
    ctrl_x0: in std_logic; 
    ctrl_x1: in std_logic; 
    ctrl_x2: in std_logic; 
    ctrl_x3: in std_logic; 
    ctrl_x4: in std_logic; 
    ctrl_x5: in std_logic; 
    i: in std_logic_vector(11 downto 0); 
    iq_valid: in std_logic; 
    q: in std_logic_vector(11 downto 0); 
    register11: in std_logic_vector(7 downto 0); 
    register12: in std_logic_vector(7 downto 0); 
    register13: in std_logic_vector(1 downto 0); 
    register14: in std_logic_vector(5 downto 0); 
    register15: in std_logic_vector(4 downto 0); 
    register16: in std_logic_vector(5 downto 0); 
    register1_x0: in std_logic_vector(7 downto 0); 
    register2_x0: in std_logic_vector(7 downto 0); 
    register3_x0: in std_logic_vector(7 downto 0); 
    rssi: in std_logic_vector(9 downto 0); 
    g_bb: out std_logic_vector(4 downto 0); 
    g_rf: out std_logic_vector(1 downto 0)
  );
end gain_calc_a_entity_527cfe478a;

architecture structural of gain_calc_a_entity_527cfe478a is
  signal addsub_s_net_x3: std_logic_vector(7 downto 0);
  signal ce_16_sg_x3: std_logic;
  signal ce_1_sg_x38: std_logic;
  signal clk_16_sg_x3: std_logic;
  signal clk_1_sg_x38: std_logic;
  signal convert1_dout_net_x1: std_logic_vector(9 downto 0);
  signal convert2_dout_net_x13: std_logic;
  signal counter1_op_net_x3: std_logic_vector(1 downto 0);
  signal delay1_q_net_x2: std_logic;
  signal down_sample_q_net_x1: std_logic_vector(9 downto 0);
  signal inverter_op_net_x9: std_logic;
  signal logical1_y_net_x15: std_logic;
  signal logical3_y_net_x2: std_logic;
  signal logical4_y_net_x3: std_logic;
  signal logical5_y_net_x2: std_logic;
  signal mux1_y_net_x1: std_logic_vector(5 downto 0);
  signal mux_y_net_x0: std_logic_vector(4 downto 0);
  signal register11_q_net_x1: std_logic_vector(7 downto 0);
  signal register12_q_net_x1: std_logic_vector(7 downto 0);
  signal register13_q_net_x1: std_logic_vector(1 downto 0);
  signal register14_q_net_x1: std_logic_vector(5 downto 0);
  signal register15_q_net_x1: std_logic_vector(4 downto 0);
  signal register16_q_net_x1: std_logic_vector(5 downto 0);
  signal register1_q_net: std_logic_vector(1 downto 0);
  signal register1_q_net_x1: std_logic_vector(7 downto 0);
  signal register2_q_net_x1: std_logic_vector(7 downto 0);
  signal register2_q_net_x2: std_logic_vector(1 downto 0);
  signal register3_q_net: std_logic_vector(4 downto 0);
  signal register3_q_net_x1: std_logic_vector(7 downto 0);
  signal register4_q_net_x0: std_logic_vector(4 downto 0);
  signal register_q_net_x1: std_logic_vector(13 downto 0);
  signal register_q_net_x2: std_logic_vector(1 downto 0);
  signal rfa_rx_i_in_net_x3: std_logic_vector(11 downto 0);
  signal rfa_rx_q_in_net_x3: std_logic_vector(11 downto 0);

begin
  ce_1_sg_x38 <= ce_1;
  ce_16_sg_x3 <= ce_16;
  clk_1_sg_x38 <= clk_1;
  clk_16_sg_x3 <= clk_16;
  counter1_op_net_x3 <= ctrl;
  delay1_q_net_x2 <= ctrl_x0;
  logical3_y_net_x2 <= ctrl_x1;
  logical4_y_net_x3 <= ctrl_x2;
  logical5_y_net_x2 <= ctrl_x3;
  logical1_y_net_x15 <= ctrl_x4;
  inverter_op_net_x9 <= ctrl_x5;
  rfa_rx_i_in_net_x3 <= i;
  convert2_dout_net_x13 <= iq_valid;
  rfa_rx_q_in_net_x3 <= q;
  register11_q_net_x1 <= register11;
  register12_q_net_x1 <= register12;
  register13_q_net_x1 <= register13;
  register14_q_net_x1 <= register14;
  register15_q_net_x1 <= register15;
  register16_q_net_x1 <= register16;
  register1_q_net_x1 <= register1_x0;
  register2_q_net_x1 <= register2_x0;
  register3_q_net_x1 <= register3_x0;
  down_sample_q_net_x1 <= rssi;
  g_bb <= register4_q_net_x0;
  g_rf <= register2_q_net_x2;

  bb_gain_335e3bf8c7: entity work.bb_gain_entity_335e3bf8c7
    port map (
      agc_ctrl_g_bb_sel => counter1_op_net_x3,
      ce_1 => ce_1_sg_x38,
      clk_1 => clk_1_sg_x38,
      g_rf_db => mux1_y_net_x1,
      iq_dbv => register_q_net_x1,
      p_in_rssi => addsub_s_net_x3,
      reg_agc_init_g_bb => register15_q_net_x1,
      reg_agc_target_pwr => register16_q_net_x1,
      reg_agc_v_db_adj => register14_q_net_x1,
      g_bb => mux_y_net_x0
    );

  capture_convert_2dc0791616: entity work.\capture___convert_entity_2dc0791616\
    port map (
      agc_ctrl_capture_rssi => logical3_y_net_x2,
      agc_reset => inverter_op_net_x9,
      ce_1 => ce_1_sg_x38,
      clk_1 => clk_1_sg_x38,
      g_rf => register_q_net_x2,
      reg_agc_rssi_calib_g1 => register2_q_net_x1,
      reg_agc_rssi_calib_g2 => register1_q_net_x1,
      reg_agc_rssi_calib_g3 => register3_q_net_x1,
      rssi => convert1_dout_net_x1,
      rx_pwr_dbm => addsub_s_net_x3
    );

  iq_mag_92fc2cf206: entity work.iq_mag_entity_92fc2cf206
    port map (
      agc_ctrl_capture_v_db => logical1_y_net_x15,
      agc_done_g_bb => logical4_y_net_x3,
      ce_1 => ce_1_sg_x38,
      clk_1 => clk_1_sg_x38,
      i => rfa_rx_i_in_net_x3,
      q => rfa_rx_q_in_net_x3,
      valid => convert2_dout_net_x13,
      iq_dbv => register_q_net_x1
    );

  register1: entity work.xlregister
    generic map (
      d_width => 2,
      init_value => b"00"
    )
    port map (
      ce => ce_1_sg_x38,
      clk => clk_1_sg_x38,
      d => register_q_net_x2,
      en => "1",
      rst => "0",
      q => register1_q_net
    );

  register2: entity work.xlregister
    generic map (
      d_width => 2,
      init_value => b"00"
    )
    port map (
      ce => ce_1_sg_x38,
      clk => clk_1_sg_x38,
      d => register1_q_net,
      en => "1",
      rst => "0",
      q => register2_q_net_x2
    );

  register3: entity work.xlregister
    generic map (
      d_width => 5,
      init_value => b"00000"
    )
    port map (
      ce => ce_1_sg_x38,
      clk => clk_1_sg_x38,
      d => mux_y_net_x0,
      en => "1",
      rst => "0",
      q => register3_q_net
    );

  register4: entity work.xlregister
    generic map (
      d_width => 5,
      init_value => b"00000"
    )
    port map (
      ce => ce_1_sg_x38,
      clk => clk_1_sg_x38,
      d => register3_q_net,
      en => "1",
      rst => "0",
      q => register4_q_net_x0
    );

  rf_gain_a87af46734: entity work.rf_gain_entity_a87af46734
    port map (
      agc_ctrl_set_g_rf => delay1_q_net_x2,
      agc_done_g_rf => logical5_y_net_x2,
      ce_1 => ce_1_sg_x38,
      clk_1 => clk_1_sg_x38,
      reg_agc_rfg_thresh_21 => register12_q_net_x1,
      reg_agc_rfg_thresh_32 => register11_q_net_x1,
      rx_pwr => addsub_s_net_x3,
      g_rf => register_q_net_x2,
      g_rf_db => mux1_y_net_x1
    );

  rssi_avg_1ca7fd5428: entity work.rssi_avg_entity_1ca7fd5428
    port map (
      ce_1 => ce_1_sg_x38,
      ce_16 => ce_16_sg_x3,
      clk_1 => clk_1_sg_x38,
      clk_16 => clk_16_sg_x3,
      reg_rssi_avg_len_sel => register13_q_net_x1,
      rssi => down_sample_q_net_x1,
      avg => convert1_dout_net_x1
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/RSSI Src"

entity rssi_src_entity_728a3def96 is
  port (
    ce_1: in std_logic; 
    ce_16: in std_logic; 
    clk_1: in std_logic; 
    clk_16: in std_logic; 
    rfa_rssi: in std_logic_vector(9 downto 0); 
    rfb_rssi: in std_logic_vector(9 downto 0); 
    rfc_rssi: in std_logic_vector(9 downto 0); 
    rfd_rssi: in std_logic_vector(9 downto 0); 
    rfa_rssi_x0: out std_logic_vector(9 downto 0); 
    rfb_rssi_x0: out std_logic_vector(9 downto 0); 
    rfc_rssi_x0: out std_logic_vector(9 downto 0); 
    rfd_rssi_x0: out std_logic_vector(9 downto 0)
  );
end rssi_src_entity_728a3def96;

architecture structural of rssi_src_entity_728a3def96 is
  signal ce_16_sg_x16: std_logic;
  signal ce_1_sg_x60: std_logic;
  signal clk_16_sg_x16: std_logic;
  signal clk_1_sg_x60: std_logic;
  signal down_sample1_q_net_x3: std_logic_vector(9 downto 0);
  signal down_sample2_q_net_x2: std_logic_vector(9 downto 0);
  signal down_sample3_q_net_x2: std_logic_vector(9 downto 0);
  signal down_sample_q_net_x2: std_logic_vector(9 downto 0);
  signal register1_q_net: std_logic_vector(9 downto 0);
  signal register2_q_net: std_logic_vector(9 downto 0);
  signal register3_q_net: std_logic_vector(9 downto 0);
  signal register_q_net: std_logic_vector(9 downto 0);
  signal rfa_rssi_net_x0: std_logic_vector(9 downto 0);
  signal rfb_rssi_net_x0: std_logic_vector(9 downto 0);
  signal rfc_rssi_net_x0: std_logic_vector(9 downto 0);
  signal rfd_rssi_net_x0: std_logic_vector(9 downto 0);

begin
  ce_1_sg_x60 <= ce_1;
  ce_16_sg_x16 <= ce_16;
  clk_1_sg_x60 <= clk_1;
  clk_16_sg_x16 <= clk_16;
  rfa_rssi_net_x0 <= rfa_rssi;
  rfb_rssi_net_x0 <= rfb_rssi;
  rfc_rssi_net_x0 <= rfc_rssi;
  rfd_rssi_net_x0 <= rfd_rssi;
  rfa_rssi_x0 <= down_sample_q_net_x2;
  rfb_rssi_x0 <= down_sample1_q_net_x3;
  rfc_rssi_x0 <= down_sample2_q_net_x2;
  rfd_rssi_x0 <= down_sample3_q_net_x2;

  down_sample: entity work.xldsamp
    generic map (
      d_arith => xlUnsigned,
      d_bin_pt => 0,
      d_width => 10,
      ds_ratio => 16,
      latency => 1,
      phase => 15,
      q_arith => xlUnsigned,
      q_bin_pt => 0,
      q_width => 10
    )
    port map (
      d => register_q_net,
      dest_ce => ce_16_sg_x16,
      dest_clk => clk_16_sg_x16,
      dest_clr => '0',
      en => "1",
      src_ce => ce_1_sg_x60,
      src_clk => clk_1_sg_x60,
      src_clr => '0',
      q => down_sample_q_net_x2
    );

  down_sample1: entity work.xldsamp
    generic map (
      d_arith => xlUnsigned,
      d_bin_pt => 0,
      d_width => 10,
      ds_ratio => 16,
      latency => 1,
      phase => 15,
      q_arith => xlUnsigned,
      q_bin_pt => 0,
      q_width => 10
    )
    port map (
      d => register1_q_net,
      dest_ce => ce_16_sg_x16,
      dest_clk => clk_16_sg_x16,
      dest_clr => '0',
      en => "1",
      src_ce => ce_1_sg_x60,
      src_clk => clk_1_sg_x60,
      src_clr => '0',
      q => down_sample1_q_net_x3
    );

  down_sample2: entity work.xldsamp
    generic map (
      d_arith => xlUnsigned,
      d_bin_pt => 0,
      d_width => 10,
      ds_ratio => 16,
      latency => 1,
      phase => 15,
      q_arith => xlUnsigned,
      q_bin_pt => 0,
      q_width => 10
    )
    port map (
      d => register2_q_net,
      dest_ce => ce_16_sg_x16,
      dest_clk => clk_16_sg_x16,
      dest_clr => '0',
      en => "1",
      src_ce => ce_1_sg_x60,
      src_clk => clk_1_sg_x60,
      src_clr => '0',
      q => down_sample2_q_net_x2
    );

  down_sample3: entity work.xldsamp
    generic map (
      d_arith => xlUnsigned,
      d_bin_pt => 0,
      d_width => 10,
      ds_ratio => 16,
      latency => 1,
      phase => 15,
      q_arith => xlUnsigned,
      q_bin_pt => 0,
      q_width => 10
    )
    port map (
      d => register3_q_net,
      dest_ce => ce_16_sg_x16,
      dest_clk => clk_16_sg_x16,
      dest_clr => '0',
      en => "1",
      src_ce => ce_1_sg_x60,
      src_clk => clk_1_sg_x60,
      src_clr => '0',
      q => down_sample3_q_net_x2
    );

  register1: entity work.xlregister
    generic map (
      d_width => 10,
      init_value => b"0000000000"
    )
    port map (
      ce => ce_1_sg_x60,
      clk => clk_1_sg_x60,
      d => rfb_rssi_net_x0,
      en => "1",
      rst => "0",
      q => register1_q_net
    );

  register2: entity work.xlregister
    generic map (
      d_width => 10,
      init_value => b"0000000000"
    )
    port map (
      ce => ce_1_sg_x60,
      clk => clk_1_sg_x60,
      d => rfc_rssi_net_x0,
      en => "1",
      rst => "0",
      q => register2_q_net
    );

  register3: entity work.xlregister
    generic map (
      d_width => 10,
      init_value => b"0000000000"
    )
    port map (
      ce => ce_1_sg_x60,
      clk => clk_1_sg_x60,
      d => rfd_rssi_net_x0,
      en => "1",
      rst => "0",
      q => register3_q_net
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 10,
      init_value => b"0000000000"
    )
    port map (
      ce => ce_1_sg_x60,
      clk => clk_1_sg_x60,
      d => rfa_rssi_net_x0,
      en => "1",
      rst => "0",
      q => register_q_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc/Registers"

entity registers_entity_1c13e4b926 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    from_register1: in std_logic_vector(31 downto 0); 
    from_register2: in std_logic_vector(31 downto 0); 
    from_register3: in std_logic_vector(31 downto 0); 
    from_register4: in std_logic_vector(31 downto 0); 
    from_register5: in std_logic_vector(31 downto 0); 
    from_register6: in std_logic_vector(17 downto 0); 
    from_register7: in std_logic_vector(17 downto 0); 
    from_register8: in std_logic_vector(31 downto 0); 
    from_register9: in std_logic_vector(31 downto 0); 
    reg_agc_iir_coef_a1_a: out std_logic_vector(17 downto 0); 
    reg_agc_iir_coef_a1_b: out std_logic_vector(17 downto 0); 
    reg_agc_iir_coef_a1_c: out std_logic_vector(17 downto 0); 
    reg_agc_iir_coef_a1_d: out std_logic_vector(17 downto 0); 
    reg_agc_iir_coef_b0_a: out std_logic_vector(17 downto 0); 
    reg_agc_iir_coef_b0_b: out std_logic_vector(17 downto 0); 
    reg_agc_iir_coef_b0_c: out std_logic_vector(17 downto 0); 
    reg_agc_iir_coef_b0_d: out std_logic_vector(17 downto 0); 
    reg_agc_init_g_bb: out std_logic_vector(4 downto 0); 
    reg_agc_reset: out std_logic; 
    reg_agc_rfg_thresh_21: out std_logic_vector(7 downto 0); 
    reg_agc_rfg_thresh_32: out std_logic_vector(7 downto 0); 
    reg_agc_rssi_calib_g1: out std_logic_vector(7 downto 0); 
    reg_agc_rssi_calib_g2: out std_logic_vector(7 downto 0); 
    reg_agc_rssi_calib_g3: out std_logic_vector(7 downto 0); 
    reg_agc_target_pwr: out std_logic_vector(5 downto 0); 
    reg_agc_timing_capt_rssi_1: out std_logic_vector(7 downto 0); 
    reg_agc_timing_capt_rssi_2: out std_logic_vector(7 downto 0); 
    reg_agc_timing_capt_v_db: out std_logic_vector(7 downto 0); 
    reg_agc_timing_done: out std_logic_vector(7 downto 0); 
    reg_agc_timing_en_iir: out std_logic_vector(7 downto 0); 
    reg_agc_timing_reset_g_bb: out std_logic_vector(7 downto 0); 
    reg_agc_timing_reset_g_rf: out std_logic_vector(7 downto 0); 
    reg_agc_timing_reset_rxhp: out std_logic_vector(7 downto 0); 
    reg_agc_timing_start_dco: out std_logic_vector(7 downto 0); 
    reg_agc_v_db_adj: out std_logic_vector(5 downto 0); 
    reg_rssi_avg_len_sel: out std_logic_vector(1 downto 0)
  );
end registers_entity_1c13e4b926;

architecture structural of registers_entity_1c13e4b926 is
  signal b0_y_net: std_logic;
  signal b_15_8_1_y_net: std_logic_vector(7 downto 0);
  signal b_15_8_2_y_net: std_logic_vector(7 downto 0);
  signal b_15_8_3_y_net: std_logic_vector(7 downto 0);
  signal b_15_8_4_y_net: std_logic_vector(7 downto 0);
  signal b_15_8_y_net: std_logic_vector(7 downto 0);
  signal b_17_16_y_net: std_logic_vector(1 downto 0);
  signal b_23_16_1_y_net: std_logic_vector(7 downto 0);
  signal b_23_16_2_y_net: std_logic_vector(7 downto 0);
  signal b_23_16_y_net: std_logic_vector(7 downto 0);
  signal b_23_18_y_net: std_logic_vector(5 downto 0);
  signal b_28_24_y_net: std_logic_vector(4 downto 0);
  signal b_31_24_y_net: std_logic_vector(7 downto 0);
  signal b_5_0_y_net: std_logic_vector(5 downto 0);
  signal b_7_0_1_y_net: std_logic_vector(7 downto 0);
  signal b_7_0_2_y_net: std_logic_vector(7 downto 0);
  signal b_7_0_3_y_net: std_logic_vector(7 downto 0);
  signal b_7_0_4_y_net: std_logic_vector(7 downto 0);
  signal b_7_0_y_net: std_logic_vector(7 downto 0);
  signal ce_1_sg_x61: std_logic;
  signal clk_1_sg_x61: std_logic;
  signal from_register1_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register2_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register3_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register4_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register5_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register6_data_out_net_x0: std_logic_vector(17 downto 0);
  signal from_register7_data_out_net_x0: std_logic_vector(17 downto 0);
  signal from_register8_data_out_net_x0: std_logic_vector(31 downto 0);
  signal from_register9_data_out_net_x0: std_logic_vector(31 downto 0);
  signal register10_q_net_x1: std_logic_vector(7 downto 0);
  signal register11_q_net_x8: std_logic_vector(7 downto 0);
  signal register12_q_net_x8: std_logic_vector(7 downto 0);
  signal register13_q_net_x8: std_logic_vector(1 downto 0);
  signal register14_q_net_x8: std_logic_vector(5 downto 0);
  signal register15_q_net_x8: std_logic_vector(4 downto 0);
  signal register16_q_net_x8: std_logic_vector(5 downto 0);
  signal register17_q_net: std_logic_vector(17 downto 0);
  signal register18_q_net: std_logic_vector(17 downto 0);
  signal register19_q_net_x1: std_logic_vector(7 downto 0);
  signal register1_q_net_x8: std_logic_vector(7 downto 0);
  signal register20_q_net_x1: std_logic_vector(7 downto 0);
  signal register21_q_net_x1: std_logic_vector(7 downto 0);
  signal register22_q_net_x2: std_logic_vector(17 downto 0);
  signal register23_q_net_x2: std_logic_vector(17 downto 0);
  signal register24_q_net_x2: std_logic_vector(17 downto 0);
  signal register25_q_net_x2: std_logic_vector(17 downto 0);
  signal register26_q_net_x2: std_logic_vector(17 downto 0);
  signal register27_q_net_x2: std_logic_vector(17 downto 0);
  signal register28_q_net_x2: std_logic_vector(17 downto 0);
  signal register29_q_net_x2: std_logic_vector(17 downto 0);
  signal register2_q_net_x8: std_logic_vector(7 downto 0);
  signal register3_q_net_x8: std_logic_vector(7 downto 0);
  signal register4_q_net_x2: std_logic;
  signal register5_q_net_x1: std_logic_vector(7 downto 0);
  signal register6_q_net_x1: std_logic_vector(7 downto 0);
  signal register7_q_net_x1: std_logic_vector(7 downto 0);
  signal register8_q_net_x1: std_logic_vector(7 downto 0);
  signal register9_q_net_x1: std_logic_vector(7 downto 0);
  signal reinterpret1_output_port_net: std_logic_vector(5 downto 0);
  signal reinterpret2_output_port_net: std_logic_vector(7 downto 0);
  signal reinterpret3_output_port_net: std_logic_vector(7 downto 0);
  signal reinterpret_output_port_net: std_logic_vector(5 downto 0);

begin
  ce_1_sg_x61 <= ce_1;
  clk_1_sg_x61 <= clk_1;
  from_register1_data_out_net_x0 <= from_register1;
  from_register2_data_out_net_x0 <= from_register2;
  from_register3_data_out_net_x0 <= from_register3;
  from_register4_data_out_net_x0 <= from_register4;
  from_register5_data_out_net_x0 <= from_register5;
  from_register6_data_out_net_x0 <= from_register6;
  from_register7_data_out_net_x0 <= from_register7;
  from_register8_data_out_net_x0 <= from_register8;
  from_register9_data_out_net_x0 <= from_register9;
  reg_agc_iir_coef_a1_a <= register26_q_net_x2;
  reg_agc_iir_coef_a1_b <= register27_q_net_x2;
  reg_agc_iir_coef_a1_c <= register28_q_net_x2;
  reg_agc_iir_coef_a1_d <= register29_q_net_x2;
  reg_agc_iir_coef_b0_a <= register22_q_net_x2;
  reg_agc_iir_coef_b0_b <= register23_q_net_x2;
  reg_agc_iir_coef_b0_c <= register24_q_net_x2;
  reg_agc_iir_coef_b0_d <= register25_q_net_x2;
  reg_agc_init_g_bb <= register15_q_net_x8;
  reg_agc_reset <= register4_q_net_x2;
  reg_agc_rfg_thresh_21 <= register12_q_net_x8;
  reg_agc_rfg_thresh_32 <= register11_q_net_x8;
  reg_agc_rssi_calib_g1 <= register2_q_net_x8;
  reg_agc_rssi_calib_g2 <= register1_q_net_x8;
  reg_agc_rssi_calib_g3 <= register3_q_net_x8;
  reg_agc_target_pwr <= register16_q_net_x8;
  reg_agc_timing_capt_rssi_1 <= register5_q_net_x1;
  reg_agc_timing_capt_rssi_2 <= register6_q_net_x1;
  reg_agc_timing_capt_v_db <= register7_q_net_x1;
  reg_agc_timing_done <= register8_q_net_x1;
  reg_agc_timing_en_iir <= register10_q_net_x1;
  reg_agc_timing_reset_g_bb <= register21_q_net_x1;
  reg_agc_timing_reset_g_rf <= register19_q_net_x1;
  reg_agc_timing_reset_rxhp <= register20_q_net_x1;
  reg_agc_timing_start_dco <= register9_q_net_x1;
  reg_agc_v_db_adj <= register14_q_net_x8;
  reg_rssi_avg_len_sel <= register13_q_net_x8;

  b0: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 0,
      x_width => 32,
      y_width => 1
    )
    port map (
      x => from_register5_data_out_net_x0,
      y(0) => b0_y_net
    );

  b_15_8: entity work.xlslice
    generic map (
      new_lsb => 8,
      new_msb => 15,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register4_data_out_net_x0,
      y => b_15_8_y_net
    );

  b_15_8_1: entity work.xlslice
    generic map (
      new_lsb => 8,
      new_msb => 15,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register1_data_out_net_x0,
      y => b_15_8_1_y_net
    );

  b_15_8_2: entity work.xlslice
    generic map (
      new_lsb => 8,
      new_msb => 15,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register2_data_out_net_x0,
      y => b_15_8_2_y_net
    );

  b_15_8_3: entity work.xlslice
    generic map (
      new_lsb => 8,
      new_msb => 15,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register8_data_out_net_x0,
      y => b_15_8_3_y_net
    );

  b_15_8_4: entity work.xlslice
    generic map (
      new_lsb => 8,
      new_msb => 15,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register9_data_out_net_x0,
      y => b_15_8_4_y_net
    );

  b_17_16: entity work.xlslice
    generic map (
      new_lsb => 16,
      new_msb => 17,
      x_width => 32,
      y_width => 2
    )
    port map (
      x => from_register2_data_out_net_x0,
      y => b_17_16_y_net
    );

  b_23_16: entity work.xlslice
    generic map (
      new_lsb => 16,
      new_msb => 23,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register4_data_out_net_x0,
      y => b_23_16_y_net
    );

  b_23_16_1: entity work.xlslice
    generic map (
      new_lsb => 16,
      new_msb => 23,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register8_data_out_net_x0,
      y => b_23_16_1_y_net
    );

  b_23_16_2: entity work.xlslice
    generic map (
      new_lsb => 16,
      new_msb => 23,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register9_data_out_net_x0,
      y => b_23_16_2_y_net
    );

  b_23_18: entity work.xlslice
    generic map (
      new_lsb => 18,
      new_msb => 23,
      x_width => 32,
      y_width => 6
    )
    port map (
      x => from_register2_data_out_net_x0,
      y => b_23_18_y_net
    );

  b_28_24: entity work.xlslice
    generic map (
      new_lsb => 24,
      new_msb => 28,
      x_width => 32,
      y_width => 5
    )
    port map (
      x => from_register2_data_out_net_x0,
      y => b_28_24_y_net
    );

  b_31_24: entity work.xlslice
    generic map (
      new_lsb => 24,
      new_msb => 31,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register4_data_out_net_x0,
      y => b_31_24_y_net
    );

  b_5_0: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 5,
      x_width => 32,
      y_width => 6
    )
    port map (
      x => from_register3_data_out_net_x0,
      y => b_5_0_y_net
    );

  b_7_0: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 7,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register4_data_out_net_x0,
      y => b_7_0_y_net
    );

  b_7_0_1: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 7,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register1_data_out_net_x0,
      y => b_7_0_1_y_net
    );

  b_7_0_2: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 7,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register2_data_out_net_x0,
      y => b_7_0_2_y_net
    );

  b_7_0_3: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 7,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register8_data_out_net_x0,
      y => b_7_0_3_y_net
    );

  b_7_0_4: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 7,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => from_register9_data_out_net_x0,
      y => b_7_0_4_y_net
    );

  register1: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_15_8_3_y_net,
      en => "1",
      rst => "0",
      q => register1_q_net_x8
    );

  register10: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_15_8_1_y_net,
      en => "1",
      rst => "0",
      q => register10_q_net_x1
    );

  register11: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => reinterpret3_output_port_net,
      en => "1",
      rst => "0",
      q => register11_q_net_x8
    );

  register12: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => reinterpret2_output_port_net,
      en => "1",
      rst => "0",
      q => register12_q_net_x8
    );

  register13: entity work.xlregister
    generic map (
      d_width => 2,
      init_value => b"00"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_17_16_y_net,
      en => "1",
      rst => "0",
      q => register13_q_net_x8
    );

  register14: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => reinterpret1_output_port_net,
      en => "1",
      rst => "0",
      q => register14_q_net_x8
    );

  register15: entity work.xlregister
    generic map (
      d_width => 5,
      init_value => b"00000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_28_24_y_net,
      en => "1",
      rst => "0",
      q => register15_q_net_x8
    );

  register16: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => reinterpret_output_port_net,
      en => "1",
      rst => "0",
      q => register16_q_net_x8
    );

  register17: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => from_register6_data_out_net_x0,
      en => "1",
      rst => "0",
      q => register17_q_net
    );

  register18: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => from_register7_data_out_net_x0,
      en => "1",
      rst => "0",
      q => register18_q_net
    );

  register19: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_15_8_4_y_net,
      en => "1",
      rst => "0",
      q => register19_q_net_x1
    );

  register2: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_23_16_1_y_net,
      en => "1",
      rst => "0",
      q => register2_q_net_x8
    );

  register20: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_7_0_4_y_net,
      en => "1",
      rst => "0",
      q => register20_q_net_x1
    );

  register21: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_23_16_2_y_net,
      en => "1",
      rst => "0",
      q => register21_q_net_x1
    );

  register22: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => register18_q_net,
      en => "1",
      rst => "0",
      q => register22_q_net_x2
    );

  register23: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => register18_q_net,
      en => "1",
      rst => "0",
      q => register23_q_net_x2
    );

  register24: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => register18_q_net,
      en => "1",
      rst => "0",
      q => register24_q_net_x2
    );

  register25: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => register18_q_net,
      en => "1",
      rst => "0",
      q => register25_q_net_x2
    );

  register26: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => register17_q_net,
      en => "1",
      rst => "0",
      q => register26_q_net_x2
    );

  register27: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => register17_q_net,
      en => "1",
      rst => "0",
      q => register27_q_net_x2
    );

  register28: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => register17_q_net,
      en => "1",
      rst => "0",
      q => register28_q_net_x2
    );

  register29: entity work.xlregister
    generic map (
      d_width => 18,
      init_value => b"000000000000000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => register17_q_net,
      en => "1",
      rst => "0",
      q => register29_q_net_x2
    );

  register3: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_7_0_3_y_net,
      en => "1",
      rst => "0",
      q => register3_q_net_x8
    );

  register4: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d(0) => b0_y_net,
      en => "1",
      rst => "0",
      q(0) => register4_q_net_x2
    );

  register5: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_7_0_y_net,
      en => "1",
      rst => "0",
      q => register5_q_net_x1
    );

  register6: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_15_8_y_net,
      en => "1",
      rst => "0",
      q => register6_q_net_x1
    );

  register7: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_23_16_y_net,
      en => "1",
      rst => "0",
      q => register7_q_net_x1
    );

  register8: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_31_24_y_net,
      en => "1",
      rst => "0",
      q => register8_q_net_x1
    );

  register9: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x61,
      clk => clk_1_sg_x61,
      d => b_7_0_1_y_net,
      en => "1",
      rst => "0",
      q => register9_q_net_x1
    );

  reinterpret: entity work.reinterpret_f88c654950
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => b_5_0_y_net,
      output_port => reinterpret_output_port_net
    );

  reinterpret1: entity work.reinterpret_f88c654950
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => b_23_18_y_net,
      output_port => reinterpret1_output_port_net
    );

  reinterpret2: entity work.reinterpret_4389dc89bf
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => b_15_8_2_y_net,
      output_port => reinterpret2_output_port_net
    );

  reinterpret3: entity work.reinterpret_4389dc89bf
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => b_7_0_2_y_net,
      output_port => reinterpret3_output_port_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "wlan_agc"

entity wlan_agc is
  port (
    adc_rx_clk: in std_logic; 
    agc_run: in std_logic; 
    axi_aresetn: in std_logic; 
    ce_1: in std_logic; 
    ce_16: in std_logic; 
    ce_8: in std_logic; 
    clk_1: in std_logic; 
    clk_16: in std_logic; 
    clk_8: in std_logic; 
    data_out: in std_logic_vector(31 downto 0); 
    data_out_x0: in std_logic_vector(31 downto 0); 
    data_out_x1: in std_logic_vector(31 downto 0); 
    data_out_x2: in std_logic_vector(31 downto 0); 
    data_out_x3: in std_logic_vector(31 downto 0); 
    data_out_x4: in std_logic_vector(17 downto 0); 
    data_out_x5: in std_logic_vector(17 downto 0); 
    data_out_x6: in std_logic_vector(31 downto 0); 
    data_out_x7: in std_logic_vector(31 downto 0); 
    dout: in std_logic_vector(31 downto 0); 
    dout_x0: in std_logic_vector(31 downto 0); 
    dout_x1: in std_logic_vector(17 downto 0); 
    dout_x2: in std_logic_vector(17 downto 0); 
    dout_x3: in std_logic_vector(31 downto 0); 
    dout_x4: in std_logic_vector(31 downto 0); 
    dout_x5: in std_logic_vector(31 downto 0); 
    dout_x6: in std_logic_vector(31 downto 0); 
    dout_x7: in std_logic_vector(31 downto 0); 
    plb_ce_1: in std_logic; 
    plb_clk_1: in std_logic; 
    rfa_rssi: in std_logic_vector(9 downto 0); 
    rfa_rx_i_in: in std_logic_vector(11 downto 0); 
    rfa_rx_q_in: in std_logic_vector(11 downto 0); 
    rfb_rssi: in std_logic_vector(9 downto 0); 
    rfb_rx_i_in: in std_logic_vector(11 downto 0); 
    rfb_rx_q_in: in std_logic_vector(11 downto 0); 
    rfc_rssi: in std_logic_vector(9 downto 0); 
    rfc_rx_i_in: in std_logic_vector(11 downto 0); 
    rfc_rx_q_in: in std_logic_vector(11 downto 0); 
    rfd_rssi: in std_logic_vector(9 downto 0); 
    rfd_rx_i_in: in std_logic_vector(11 downto 0); 
    rfd_rx_q_in: in std_logic_vector(11 downto 0); 
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
    agc_done: out std_logic; 
    data_in: out std_logic_vector(31 downto 0); 
    data_in_x0: out std_logic_vector(31 downto 0); 
    data_in_x1: out std_logic_vector(17 downto 0); 
    data_in_x2: out std_logic_vector(17 downto 0); 
    data_in_x3: out std_logic_vector(31 downto 0); 
    data_in_x4: out std_logic_vector(31 downto 0); 
    data_in_x5: out std_logic_vector(31 downto 0); 
    data_in_x6: out std_logic_vector(31 downto 0); 
    data_in_x7: out std_logic_vector(31 downto 0); 
    en: out std_logic; 
    en_x0: out std_logic; 
    en_x1: out std_logic; 
    en_x2: out std_logic; 
    en_x3: out std_logic; 
    en_x4: out std_logic; 
    en_x5: out std_logic; 
    en_x6: out std_logic; 
    en_x7: out std_logic; 
    iq_valid_out: out std_logic; 
    rfa_agc_g_bb: out std_logic_vector(4 downto 0); 
    rfa_agc_g_rf: out std_logic_vector(1 downto 0); 
    rfa_agc_rxhp: out std_logic; 
    rfa_rx_i_out: out std_logic_vector(15 downto 0); 
    rfa_rx_q_out: out std_logic_vector(15 downto 0); 
    rfb_agc_g_bb: out std_logic_vector(4 downto 0); 
    rfb_agc_g_rf: out std_logic_vector(1 downto 0); 
    rfb_agc_rxhp: out std_logic; 
    rfb_rx_i_out: out std_logic_vector(15 downto 0); 
    rfb_rx_q_out: out std_logic_vector(15 downto 0); 
    rfc_agc_g_bb: out std_logic_vector(4 downto 0); 
    rfc_agc_g_rf: out std_logic_vector(1 downto 0); 
    rfc_agc_rxhp: out std_logic; 
    rfc_rx_i_out: out std_logic_vector(15 downto 0); 
    rfc_rx_q_out: out std_logic_vector(15 downto 0); 
    rfd_agc_g_bb: out std_logic_vector(4 downto 0); 
    rfd_agc_g_rf: out std_logic_vector(1 downto 0); 
    rfd_agc_rxhp: out std_logic; 
    rfd_rx_i_out: out std_logic_vector(15 downto 0); 
    rfd_rx_q_out: out std_logic_vector(15 downto 0); 
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
end wlan_agc;

architecture structural of wlan_agc is
  attribute core_generation_info: string;
  attribute core_generation_info of structural : architecture is "wlan_agc,sysgen_core,{clock_period=10.00000000,clocking=Clock_Enables,sample_periods=1.00000000000 8.00000000000 16.00000000000 1.00000000000,testbench=0,total_blocks=1667,xilinx_accumulator_block=19,xilinx_adder_subtracter_block=67,xilinx_addressable_shift_register_block=4,xilinx_arithmetic_relational_operator_block=30,xilinx_binary_shift_operator_block=24,xilinx_bit_slice_extractor_block=19,xilinx_bus_concatenator_block=4,xilinx_bus_multiplexer_block=32,xilinx_constant_block_block=81,xilinx_counter_block=8,xilinx_delay_block=86,xilinx_disregard_subsystem_for_generation_block=1,xilinx_down_sampler_block=11,xilinx_edk_core_block=1,xilinx_edk_processor_block=1,xilinx_gateway_in_block=39,xilinx_gateway_out_block=233,xilinx_input_scaler_block=8,xilinx_inverter_block=17,xilinx_logical_block_block=34,xilinx_multiplier_block=38,xilinx_negate_block_block=1,xilinx_register_block=128,xilinx_shared_memory_based_from_register_block=9,xilinx_shared_memory_based_to_register_block=9,xilinx_single_port_read_only_memory_block=4,xilinx_system_generator_block=1,xilinx_type_converter_block=39,xilinx_type_reinterpreter_block=12,xilinx_up_sampler_block=1,}";

  signal adc_rx_clk_net: std_logic;
  signal agc_done_net: std_logic;
  signal agc_run_net: std_logic;
  signal axi_aresetn_net: std_logic;
  signal ce_16_sg_x17: std_logic;
  signal ce_1_sg_x63: std_logic;
  signal ce_8_sg_x1: std_logic;
  signal clk_16_sg_x17: std_logic;
  signal clk_1_sg_x63: std_logic;
  signal clk_8_sg_x1: std_logic;
  signal convert2_dout_net_x19: std_logic;
  signal counter1_op_net_x9: std_logic_vector(1 downto 0);
  signal data_in_net: std_logic_vector(31 downto 0);
  signal data_in_x0_net: std_logic_vector(31 downto 0);
  signal data_in_x1_net: std_logic_vector(17 downto 0);
  signal data_in_x2_net: std_logic_vector(17 downto 0);
  signal data_in_x3_net: std_logic_vector(31 downto 0);
  signal data_in_x4_net: std_logic_vector(31 downto 0);
  signal data_in_x5_net: std_logic_vector(31 downto 0);
  signal data_in_x6_net: std_logic_vector(31 downto 0);
  signal data_in_x7_net: std_logic_vector(31 downto 0);
  signal data_out_net: std_logic_vector(31 downto 0);
  signal data_out_x0_net: std_logic_vector(31 downto 0);
  signal data_out_x1_net: std_logic_vector(31 downto 0);
  signal data_out_x2_net: std_logic_vector(31 downto 0);
  signal data_out_x3_net: std_logic_vector(31 downto 0);
  signal data_out_x4_net: std_logic_vector(17 downto 0);
  signal data_out_x5_net: std_logic_vector(17 downto 0);
  signal data_out_x6_net: std_logic_vector(31 downto 0);
  signal data_out_x7_net: std_logic_vector(31 downto 0);
  signal delay1_q_net_x8: std_logic;
  signal dout_net: std_logic_vector(31 downto 0);
  signal dout_x0_net: std_logic_vector(31 downto 0);
  signal dout_x1_net: std_logic_vector(17 downto 0);
  signal dout_x2_net: std_logic_vector(17 downto 0);
  signal dout_x3_net: std_logic_vector(31 downto 0);
  signal dout_x4_net: std_logic_vector(31 downto 0);
  signal dout_x5_net: std_logic_vector(31 downto 0);
  signal dout_x6_net: std_logic_vector(31 downto 0);
  signal dout_x7_net: std_logic_vector(31 downto 0);
  signal down_sample1_q_net_x3: std_logic_vector(9 downto 0);
  signal down_sample2_q_net_x2: std_logic_vector(9 downto 0);
  signal down_sample3_q_net_x2: std_logic_vector(9 downto 0);
  signal down_sample_q_net_x2: std_logic_vector(9 downto 0);
  signal en_net: std_logic;
  signal en_x0_net: std_logic;
  signal en_x1_net: std_logic;
  signal en_x2_net: std_logic;
  signal en_x3_net: std_logic;
  signal en_x4_net: std_logic;
  signal en_x5_net: std_logic;
  signal en_x6_net: std_logic;
  signal en_x7_net: std_logic;
  signal inverter_op_net: std_logic;
  signal inverter_op_net_x15: std_logic;
  signal iq_valid_out_net: std_logic;
  signal logical1_y_net_x13: std_logic;
  signal logical1_y_net_x14: std_logic;
  signal logical1_y_net_x21: std_logic;
  signal logical1_y_net_x23: std_logic;
  signal logical1_y_net_x24: std_logic;
  signal logical3_y_net_x8: std_logic;
  signal logical4_y_net_x9: std_logic;
  signal logical5_y_net_x8: std_logic;
  signal plb_ce_1_sg_x1: std_logic;
  signal plb_clk_1_sg_x1: std_logic;
  signal register10_q_net_x1: std_logic_vector(7 downto 0);
  signal register11_q_net: std_logic;
  signal register11_q_net_x8: std_logic_vector(7 downto 0);
  signal register12_q_net_x8: std_logic_vector(7 downto 0);
  signal register13_q_net_x8: std_logic_vector(1 downto 0);
  signal register14_q_net_x8: std_logic_vector(5 downto 0);
  signal register15_q_net_x8: std_logic_vector(4 downto 0);
  signal register16_q_net_x8: std_logic_vector(5 downto 0);
  signal register19_q_net_x1: std_logic_vector(7 downto 0);
  signal register1_q_net: std_logic;
  signal register1_q_net_x8: std_logic_vector(7 downto 0);
  signal register20_q_net_x1: std_logic_vector(7 downto 0);
  signal register21_q_net_x1: std_logic_vector(7 downto 0);
  signal register22_q_net_x2: std_logic_vector(17 downto 0);
  signal register23_q_net_x2: std_logic_vector(17 downto 0);
  signal register24_q_net_x2: std_logic_vector(17 downto 0);
  signal register25_q_net_x2: std_logic_vector(17 downto 0);
  signal register26_q_net_x2: std_logic_vector(17 downto 0);
  signal register27_q_net_x2: std_logic_vector(17 downto 0);
  signal register28_q_net_x2: std_logic_vector(17 downto 0);
  signal register29_q_net_x2: std_logic_vector(17 downto 0);
  signal register2_q_net_x4: std_logic;
  signal register2_q_net_x8: std_logic_vector(7 downto 0);
  signal register3_q_net: std_logic;
  signal register3_q_net_x8: std_logic_vector(7 downto 0);
  signal register4_q_net_x5: std_logic;
  signal register5_q_net: std_logic;
  signal register5_q_net_x1: std_logic_vector(7 downto 0);
  signal register6_q_net_x1: std_logic_vector(7 downto 0);
  signal register7_q_net_x1: std_logic_vector(7 downto 0);
  signal register8_q_net: std_logic;
  signal register8_q_net_x1: std_logic_vector(7 downto 0);
  signal register9_q_net_x1: std_logic_vector(7 downto 0);
  signal rfa_agc_g_bb_net: std_logic_vector(4 downto 0);
  signal rfa_agc_g_rf_net: std_logic_vector(1 downto 0);
  signal rfa_agc_rxhp_net: std_logic;
  signal rfa_rssi_net: std_logic_vector(9 downto 0);
  signal rfa_rx_i_in_net: std_logic_vector(11 downto 0);
  signal rfa_rx_i_out_net: std_logic_vector(15 downto 0);
  signal rfa_rx_q_in_net: std_logic_vector(11 downto 0);
  signal rfa_rx_q_out_net: std_logic_vector(15 downto 0);
  signal rfb_agc_g_bb_net: std_logic_vector(4 downto 0);
  signal rfb_agc_g_rf_net: std_logic_vector(1 downto 0);
  signal rfb_agc_rxhp_net: std_logic;
  signal rfb_rssi_net: std_logic_vector(9 downto 0);
  signal rfb_rx_i_in_net: std_logic_vector(11 downto 0);
  signal rfb_rx_i_out_net: std_logic_vector(15 downto 0);
  signal rfb_rx_q_in_net: std_logic_vector(11 downto 0);
  signal rfb_rx_q_out_net: std_logic_vector(15 downto 0);
  signal rfc_agc_g_bb_net: std_logic_vector(4 downto 0);
  signal rfc_agc_g_rf_net: std_logic_vector(1 downto 0);
  signal rfc_agc_rxhp_net: std_logic;
  signal rfc_rssi_net: std_logic_vector(9 downto 0);
  signal rfc_rx_i_in_net: std_logic_vector(11 downto 0);
  signal rfc_rx_i_out_net: std_logic_vector(15 downto 0);
  signal rfc_rx_q_in_net: std_logic_vector(11 downto 0);
  signal rfc_rx_q_out_net: std_logic_vector(15 downto 0);
  signal rfd_agc_g_bb_net: std_logic_vector(4 downto 0);
  signal rfd_agc_g_rf_net: std_logic_vector(1 downto 0);
  signal rfd_agc_rxhp_net: std_logic;
  signal rfd_rssi_net: std_logic_vector(9 downto 0);
  signal rfd_rx_i_in_net: std_logic_vector(11 downto 0);
  signal rfd_rx_i_out_net: std_logic_vector(15 downto 0);
  signal rfd_rx_q_in_net: std_logic_vector(11 downto 0);
  signal rfd_rx_q_out_net: std_logic_vector(15 downto 0);
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
  agc_run_net <= agc_run;
  axi_aresetn_net <= axi_aresetn;
  ce_1_sg_x63 <= ce_1;
  ce_16_sg_x17 <= ce_16;
  ce_8_sg_x1 <= ce_8;
  clk_1_sg_x63 <= clk_1;
  clk_16_sg_x17 <= clk_16;
  clk_8_sg_x1 <= clk_8;
  data_out_net <= data_out;
  data_out_x0_net <= data_out_x0;
  data_out_x1_net <= data_out_x1;
  data_out_x2_net <= data_out_x2;
  data_out_x3_net <= data_out_x3;
  data_out_x4_net <= data_out_x4;
  data_out_x5_net <= data_out_x5;
  data_out_x6_net <= data_out_x6;
  data_out_x7_net <= data_out_x7;
  dout_net <= dout;
  dout_x0_net <= dout_x0;
  dout_x1_net <= dout_x1;
  dout_x2_net <= dout_x2;
  dout_x3_net <= dout_x3;
  dout_x4_net <= dout_x4;
  dout_x5_net <= dout_x5;
  dout_x6_net <= dout_x6;
  dout_x7_net <= dout_x7;
  plb_ce_1_sg_x1 <= plb_ce_1;
  plb_clk_1_sg_x1 <= plb_clk_1;
  rfa_rssi_net <= rfa_rssi;
  rfa_rx_i_in_net <= rfa_rx_i_in;
  rfa_rx_q_in_net <= rfa_rx_q_in;
  rfb_rssi_net <= rfb_rssi;
  rfb_rx_i_in_net <= rfb_rx_i_in;
  rfb_rx_q_in_net <= rfb_rx_q_in;
  rfc_rssi_net <= rfc_rssi;
  rfc_rx_i_in_net <= rfc_rx_i_in;
  rfc_rx_q_in_net <= rfc_rx_q_in;
  rfd_rssi_net <= rfd_rssi;
  rfd_rx_i_in_net <= rfd_rx_i_in;
  rfd_rx_q_in_net <= rfd_rx_q_in;
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
  agc_done <= agc_done_net;
  data_in <= data_in_net;
  data_in_x0 <= data_in_x0_net;
  data_in_x1 <= data_in_x1_net;
  data_in_x2 <= data_in_x2_net;
  data_in_x3 <= data_in_x3_net;
  data_in_x4 <= data_in_x4_net;
  data_in_x5 <= data_in_x5_net;
  data_in_x6 <= data_in_x6_net;
  data_in_x7 <= data_in_x7_net;
  en <= en_net;
  en_x0 <= en_x0_net;
  en_x1 <= en_x1_net;
  en_x2 <= en_x2_net;
  en_x3 <= en_x3_net;
  en_x4 <= en_x4_net;
  en_x5 <= en_x5_net;
  en_x6 <= en_x6_net;
  en_x7 <= en_x7_net;
  iq_valid_out <= iq_valid_out_net;
  rfa_agc_g_bb <= rfa_agc_g_bb_net;
  rfa_agc_g_rf <= rfa_agc_g_rf_net;
  rfa_agc_rxhp <= rfa_agc_rxhp_net;
  rfa_rx_i_out <= rfa_rx_i_out_net;
  rfa_rx_q_out <= rfa_rx_q_out_net;
  rfb_agc_g_bb <= rfb_agc_g_bb_net;
  rfb_agc_g_rf <= rfb_agc_g_rf_net;
  rfb_agc_rxhp <= rfb_agc_rxhp_net;
  rfb_rx_i_out <= rfb_rx_i_out_net;
  rfb_rx_q_out <= rfb_rx_q_out_net;
  rfc_agc_g_bb <= rfc_agc_g_bb_net;
  rfc_agc_g_rf <= rfc_agc_g_rf_net;
  rfc_agc_rxhp <= rfc_agc_rxhp_net;
  rfc_rx_i_out <= rfc_rx_i_out_net;
  rfc_rx_q_out <= rfc_rx_q_out_net;
  rfd_agc_g_bb <= rfd_agc_g_bb_net;
  rfd_agc_g_rf <= rfd_agc_g_rf_net;
  rfd_agc_rxhp <= rfd_agc_rxhp_net;
  rfd_rx_i_out <= rfd_rx_i_out_net;
  rfd_rx_q_out <= rfd_rx_q_out_net;
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

  adc_inputs_c93cca5505: entity work.adc_inputs_entity_c93cca5505
    port map (
      ce_1 => ce_1_sg_x63,
      ce_8 => ce_8_sg_x1,
      clk_1 => clk_1_sg_x63,
      clk_8 => clk_8_sg_x1,
      iq_valid => convert2_dout_net_x19
    );

  ctrl_bc47da42ff: entity work.ctrl_entity_bc47da42ff
    port map (
      ce_1 => ce_1_sg_x63,
      clk_1 => clk_1_sg_x63,
      iq_valid => convert2_dout_net_x19,
      reg_agc_reset => register4_q_net_x5,
      reg_agc_timing_capt_rssi_1 => register5_q_net_x1,
      reg_agc_timing_capt_rssi_2 => register6_q_net_x1,
      reg_agc_timing_capt_v_db => register7_q_net_x1,
      reg_agc_timing_done => register8_q_net_x1,
      reg_agc_timing_en_iir => register10_q_net_x1,
      reg_agc_timing_reset_g_bb => register21_q_net_x1,
      reg_agc_timing_reset_g_rf => register19_q_net_x1,
      reg_agc_timing_reset_rxhp => register20_q_net_x1,
      reg_agc_timing_start_dco => register9_q_net_x1,
      run => agc_run_net,
      agc_ctrl_capture_rssi => logical3_y_net_x8,
      agc_ctrl_capture_v_db => logical1_y_net_x21,
      agc_ctrl_done => logical1_y_net_x14,
      agc_ctrl_en_iir_filt => logical1_y_net_x24,
      agc_ctrl_g_bb_sel => counter1_op_net_x9,
      agc_ctrl_set_g_rf => delay1_q_net_x8,
      agc_ctrl_start_dco => logical1_y_net_x23,
      agc_done_g_bb => logical4_y_net_x9,
      agc_done_g_rf => logical5_y_net_x8,
      agc_done_rxhp => logical1_y_net_x13,
      start_counter => inverter_op_net_x15
    );

  dco_correction_d0d185c763: entity work.dco_correction_entity_d0d185c763
    port map (
      a_i => rfa_rx_i_in_net,
      a_q => rfa_rx_q_in_net,
      agc_ctrl_en_iir_filt => logical1_y_net_x24,
      agc_reset => inverter_op_net_x15,
      b_i => rfb_rx_i_in_net,
      b_q => rfb_rx_q_in_net,
      c_i => rfc_rx_i_in_net,
      c_q => rfc_rx_q_in_net,
      ce_1 => ce_1_sg_x63,
      clk_1 => clk_1_sg_x63,
      ctrl => logical1_y_net_x23,
      d_i => rfd_rx_i_in_net,
      d_q => rfd_rx_q_in_net,
      iq_valid => convert2_dout_net_x19,
      register22 => register22_q_net_x2,
      register23 => register23_q_net_x2,
      register24 => register24_q_net_x2,
      register25 => register25_q_net_x2,
      register26 => register26_q_net_x2,
      register27 => register27_q_net_x2,
      register28 => register28_q_net_x2,
      register29 => register29_q_net_x2,
      iq_valid_x0 => iq_valid_out_net,
      rfa_i => rfa_rx_i_out_net,
      rfa_q => rfa_rx_q_out_net,
      rfb_i => rfb_rx_i_out_net,
      rfb_q => rfb_rx_q_out_net,
      rfc_i => rfc_rx_i_out_net,
      rfc_q => rfc_rx_q_out_net,
      rfd_i => rfd_rx_i_out_net,
      rfd_q => rfd_rx_q_out_net
    );

  edk_processor_dd50257593: entity work.edk_processor_entity_dd50257593
    port map (
      axi_aresetn => axi_aresetn_net,
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
      to_register2 => dout_x1_net,
      to_register3 => dout_x2_net,
      to_register4 => dout_x3_net,
      to_register5 => dout_x4_net,
      to_register6 => dout_x5_net,
      to_register7 => dout_x6_net,
      to_register8 => dout_x7_net,
      memmap_x0 => s_axi_arready_net,
      memmap_x1 => s_axi_awready_net,
      memmap_x10 => s_axi_wready_net,
      memmap_x11 => data_in_net,
      memmap_x12 => en_net,
      memmap_x13 => data_in_x0_net,
      memmap_x14 => en_x0_net,
      memmap_x15 => data_in_x1_net,
      memmap_x16 => en_x1_net,
      memmap_x17 => data_in_x2_net,
      memmap_x18 => en_x2_net,
      memmap_x19 => data_in_x3_net,
      memmap_x2 => s_axi_bid_net,
      memmap_x20 => en_x3_net,
      memmap_x21 => data_in_x4_net,
      memmap_x22 => en_x4_net,
      memmap_x23 => data_in_x5_net,
      memmap_x24 => en_x5_net,
      memmap_x25 => data_in_x6_net,
      memmap_x26 => en_x6_net,
      memmap_x27 => data_in_x7_net,
      memmap_x28 => en_x7_net,
      memmap_x3 => s_axi_bresp_net,
      memmap_x4 => s_axi_bvalid_net,
      memmap_x5 => s_axi_rdata_net,
      memmap_x6 => s_axi_rid_net,
      memmap_x7 => s_axi_rlast_net,
      memmap_x8 => s_axi_rresp_net,
      memmap_x9 => s_axi_rvalid_net
    );

  gain_calc_a_527cfe478a: entity work.gain_calc_a_entity_527cfe478a
    port map (
      ce_1 => ce_1_sg_x63,
      ce_16 => ce_16_sg_x17,
      clk_1 => clk_1_sg_x63,
      clk_16 => clk_16_sg_x17,
      ctrl => counter1_op_net_x9,
      ctrl_x0 => delay1_q_net_x8,
      ctrl_x1 => logical3_y_net_x8,
      ctrl_x2 => logical4_y_net_x9,
      ctrl_x3 => logical5_y_net_x8,
      ctrl_x4 => logical1_y_net_x21,
      ctrl_x5 => inverter_op_net_x15,
      i => rfa_rx_i_in_net,
      iq_valid => convert2_dout_net_x19,
      q => rfa_rx_q_in_net,
      register11 => register11_q_net_x8,
      register12 => register12_q_net_x8,
      register13 => register13_q_net_x8,
      register14 => register14_q_net_x8,
      register15 => register15_q_net_x8,
      register16 => register16_q_net_x8,
      register1_x0 => register1_q_net_x8,
      register2_x0 => register2_q_net_x8,
      register3_x0 => register3_q_net_x8,
      rssi => down_sample_q_net_x2,
      g_bb => rfa_agc_g_bb_net,
      g_rf => rfa_agc_g_rf_net
    );

  gain_calc_b_e67b0e66fd: entity work.gain_calc_a_entity_527cfe478a
    port map (
      ce_1 => ce_1_sg_x63,
      ce_16 => ce_16_sg_x17,
      clk_1 => clk_1_sg_x63,
      clk_16 => clk_16_sg_x17,
      ctrl => counter1_op_net_x9,
      ctrl_x0 => delay1_q_net_x8,
      ctrl_x1 => logical3_y_net_x8,
      ctrl_x2 => logical4_y_net_x9,
      ctrl_x3 => logical5_y_net_x8,
      ctrl_x4 => logical1_y_net_x21,
      ctrl_x5 => inverter_op_net_x15,
      i => rfb_rx_i_in_net,
      iq_valid => convert2_dout_net_x19,
      q => rfb_rx_q_in_net,
      register11 => register11_q_net_x8,
      register12 => register12_q_net_x8,
      register13 => register13_q_net_x8,
      register14 => register14_q_net_x8,
      register15 => register15_q_net_x8,
      register16 => register16_q_net_x8,
      register1_x0 => register1_q_net_x8,
      register2_x0 => register2_q_net_x8,
      register3_x0 => register3_q_net_x8,
      rssi => down_sample1_q_net_x3,
      g_bb => rfb_agc_g_bb_net,
      g_rf => rfb_agc_g_rf_net
    );

  gain_calc_c_b1aa00a171: entity work.gain_calc_a_entity_527cfe478a
    port map (
      ce_1 => ce_1_sg_x63,
      ce_16 => ce_16_sg_x17,
      clk_1 => clk_1_sg_x63,
      clk_16 => clk_16_sg_x17,
      ctrl => counter1_op_net_x9,
      ctrl_x0 => delay1_q_net_x8,
      ctrl_x1 => logical3_y_net_x8,
      ctrl_x2 => logical4_y_net_x9,
      ctrl_x3 => logical5_y_net_x8,
      ctrl_x4 => logical1_y_net_x21,
      ctrl_x5 => inverter_op_net_x15,
      i => rfc_rx_i_in_net,
      iq_valid => convert2_dout_net_x19,
      q => rfc_rx_q_in_net,
      register11 => register11_q_net_x8,
      register12 => register12_q_net_x8,
      register13 => register13_q_net_x8,
      register14 => register14_q_net_x8,
      register15 => register15_q_net_x8,
      register16 => register16_q_net_x8,
      register1_x0 => register1_q_net_x8,
      register2_x0 => register2_q_net_x8,
      register3_x0 => register3_q_net_x8,
      rssi => down_sample2_q_net_x2,
      g_bb => rfc_agc_g_bb_net,
      g_rf => rfc_agc_g_rf_net
    );

  gain_calc_d_32a476224d: entity work.gain_calc_a_entity_527cfe478a
    port map (
      ce_1 => ce_1_sg_x63,
      ce_16 => ce_16_sg_x17,
      clk_1 => clk_1_sg_x63,
      clk_16 => clk_16_sg_x17,
      ctrl => counter1_op_net_x9,
      ctrl_x0 => delay1_q_net_x8,
      ctrl_x1 => logical3_y_net_x8,
      ctrl_x2 => logical4_y_net_x9,
      ctrl_x3 => logical5_y_net_x8,
      ctrl_x4 => logical1_y_net_x21,
      ctrl_x5 => inverter_op_net_x15,
      i => rfd_rx_i_in_net,
      iq_valid => convert2_dout_net_x19,
      q => rfd_rx_q_in_net,
      register11 => register11_q_net_x8,
      register12 => register12_q_net_x8,
      register13 => register13_q_net_x8,
      register14 => register14_q_net_x8,
      register15 => register15_q_net_x8,
      register16 => register16_q_net_x8,
      register1_x0 => register1_q_net_x8,
      register2_x0 => register2_q_net_x8,
      register3_x0 => register3_q_net_x8,
      rssi => down_sample3_q_net_x2,
      g_bb => rfd_agc_g_bb_net,
      g_rf => rfd_agc_g_rf_net
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x63,
      clk => clk_1_sg_x63,
      clr => '0',
      ip(0) => register2_q_net_x4,
      op(0) => inverter_op_net
    );

  register1: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x63,
      clk => clk_1_sg_x63,
      d(0) => inverter_op_net,
      en => "1",
      rst => "0",
      q(0) => register1_q_net
    );

  register10: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x63,
      clk => clk_1_sg_x63,
      d(0) => register11_q_net,
      en => "1",
      rst => "0",
      q(0) => agc_done_net
    );

  register11: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x63,
      clk => clk_1_sg_x63,
      d(0) => register2_q_net_x4,
      en => "1",
      rst => "0",
      q(0) => register11_q_net
    );

  register2: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x63,
      clk => clk_1_sg_x63,
      d(0) => register1_q_net,
      en => "1",
      rst => "0",
      q(0) => rfb_agc_rxhp_net
    );

  register3: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x63,
      clk => clk_1_sg_x63,
      d(0) => inverter_op_net,
      en => "1",
      rst => "0",
      q(0) => register3_q_net
    );

  register4: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x63,
      clk => clk_1_sg_x63,
      d(0) => register3_q_net,
      en => "1",
      rst => "0",
      q(0) => rfc_agc_rxhp_net
    );

  register5: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x63,
      clk => clk_1_sg_x63,
      d(0) => inverter_op_net,
      en => "1",
      rst => "0",
      q(0) => register5_q_net
    );

  register6: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x63,
      clk => clk_1_sg_x63,
      d(0) => register5_q_net,
      en => "1",
      rst => "0",
      q(0) => rfd_agc_rxhp_net
    );

  register8: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x63,
      clk => clk_1_sg_x63,
      d(0) => inverter_op_net,
      en => "1",
      rst => "0",
      q(0) => register8_q_net
    );

  register9: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x63,
      clk => clk_1_sg_x63,
      d(0) => register8_q_net,
      en => "1",
      rst => "0",
      q(0) => rfa_agc_rxhp_net
    );

  registers_1c13e4b926: entity work.registers_entity_1c13e4b926
    port map (
      ce_1 => ce_1_sg_x63,
      clk_1 => clk_1_sg_x63,
      from_register1 => data_out_net,
      from_register2 => data_out_x0_net,
      from_register3 => data_out_x1_net,
      from_register4 => data_out_x2_net,
      from_register5 => data_out_x3_net,
      from_register6 => data_out_x4_net,
      from_register7 => data_out_x5_net,
      from_register8 => data_out_x6_net,
      from_register9 => data_out_x7_net,
      reg_agc_iir_coef_a1_a => register26_q_net_x2,
      reg_agc_iir_coef_a1_b => register27_q_net_x2,
      reg_agc_iir_coef_a1_c => register28_q_net_x2,
      reg_agc_iir_coef_a1_d => register29_q_net_x2,
      reg_agc_iir_coef_b0_a => register22_q_net_x2,
      reg_agc_iir_coef_b0_b => register23_q_net_x2,
      reg_agc_iir_coef_b0_c => register24_q_net_x2,
      reg_agc_iir_coef_b0_d => register25_q_net_x2,
      reg_agc_init_g_bb => register15_q_net_x8,
      reg_agc_reset => register4_q_net_x5,
      reg_agc_rfg_thresh_21 => register12_q_net_x8,
      reg_agc_rfg_thresh_32 => register11_q_net_x8,
      reg_agc_rssi_calib_g1 => register2_q_net_x8,
      reg_agc_rssi_calib_g2 => register1_q_net_x8,
      reg_agc_rssi_calib_g3 => register3_q_net_x8,
      reg_agc_target_pwr => register16_q_net_x8,
      reg_agc_timing_capt_rssi_1 => register5_q_net_x1,
      reg_agc_timing_capt_rssi_2 => register6_q_net_x1,
      reg_agc_timing_capt_v_db => register7_q_net_x1,
      reg_agc_timing_done => register8_q_net_x1,
      reg_agc_timing_en_iir => register10_q_net_x1,
      reg_agc_timing_reset_g_bb => register21_q_net_x1,
      reg_agc_timing_reset_g_rf => register19_q_net_x1,
      reg_agc_timing_reset_rxhp => register20_q_net_x1,
      reg_agc_timing_start_dco => register9_q_net_x1,
      reg_agc_v_db_adj => register14_q_net_x8,
      reg_rssi_avg_len_sel => register13_q_net_x8
    );

  rssi_src_728a3def96: entity work.rssi_src_entity_728a3def96
    port map (
      ce_1 => ce_1_sg_x63,
      ce_16 => ce_16_sg_x17,
      clk_1 => clk_1_sg_x63,
      clk_16 => clk_16_sg_x17,
      rfa_rssi => rfa_rssi_net,
      rfb_rssi => rfb_rssi_net,
      rfc_rssi => rfc_rssi_net,
      rfd_rssi => rfd_rssi_net,
      rfa_rssi_x0 => down_sample_q_net_x2,
      rfb_rssi_x0 => down_sample1_q_net_x3,
      rfc_rssi_x0 => down_sample2_q_net_x2,
      rfd_rssi_x0 => down_sample3_q_net_x2
    );

  s_r_latch_c407b96a50: entity work.s_r_latch1_entity_4a86541ec6
    port map (
      ce_1 => ce_1_sg_x63,
      clk_1 => clk_1_sg_x63,
      r => logical1_y_net_x13,
      s => logical1_y_net_x14,
      q => register2_q_net_x4
    );

end structural;
