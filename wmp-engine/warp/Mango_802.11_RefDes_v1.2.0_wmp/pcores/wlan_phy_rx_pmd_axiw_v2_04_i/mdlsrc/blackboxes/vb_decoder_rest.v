// This file is copyright 2013 by Rice University and was ported from the
//  original WARP OFDM Reference Design. It is distributed under the WARP license:
//  http://warpproject.org/license


//**************************************************************
// File:    unpack_m2n.v
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 1/15/07
// Des:     unpack from M bit to N bit, M > N
// History: $ 1/15/07, Init coding
//          $ 1/21/07, K = 7
//          $ 3/23, Fixed a naming problem for sysgen
//                  Can not use VHDL reserved key world
//          $ 12/1/07: Updated
//**************************************************************

module unpack_m2n (
        clk     ,   // I, clock 
        nrst    ,   // I, n reset
        start   ,   // I, start pulse
        din     ,   // I, data input
        vin     ,   // I, valid input
        dout    ,   // O, data output
        vout    ,   // O, valid output
        remain  ,   // I, remain
        last    ,   // I, last data
        done    ,   // O, done
		early_trace
        ) ;

parameter               BITM = 48 ;
parameter               BITM_EARLY = 24 ;
parameter               BITN = 8 ;
parameter               LW = 7 ;

input                   clk ;
input                   nrst ;
input                   start ;
input   [BITM-1 :0]     din ;
input                   vin ;
input   [LW -1:0]       remain ;
input                   last ;
input					early_trace;

output  [BITN-1 :0]     dout ;
output                  vout ;
output                  done ;

//================================================
//Internal signal
//================================================
reg     [BITM + BITN -1 :0]     sreg ;
wire    [BITM + BITN -1 :0]     sreg_next ;
reg     [LW -1 : 0]             cnt = 0;
wire                            rd ;
wire    [BITN-1 :0]             data ;
wire    [BITM + BITN -1 :0]     tmp ;
wire    [BITM + BITN -1 :0]     tmp2 ;
wire    [LW -1 : 0]             shift ;
reg                             last_i ;
reg                             last_byte_s0 ;
wire                            last_byte ;

//================================================
// Main RTL code
//================================================
assign dout = data ;
assign vout = rd ;

always @ (posedge clk)
  if (~nrst)
    cnt <= 0 ;
  else if (start)
    cnt <= 0 ;
  else if (vin & early_trace)
  begin
      cnt <= cnt + BITM_EARLY ;
  end
  else if (vin)// & ~early_trace)
  begin
    if (~last)
      cnt <= cnt + BITM ;
    else
      cnt <= cnt + remain ;
  end
  else if (rd)
    cnt <= cnt - BITN ;
    
assign rd = cnt >= BITN ;
assign data = sreg [BITM + BITN -1 : BITM] ;
assign tmp = {{BITM{1'b0}}, din} ;
assign shift = BITN - cnt ;
assign tmp2 = (tmp << shift) | sreg ;
assign sreg_next = vin ? tmp2 : rd ? {sreg[BITM -1 : 0], {BITN{1'b0}}} : sreg ;

always @ (posedge clk)
  if (~nrst)
    sreg <= 0 ;
  else if (start)
    sreg <= 0 ;
  else 
    sreg <= sreg_next ;

always @ (posedge clk)
  if (~nrst)
    last_i <= 1'b0 ;
  else if (start)
    last_i <= 1'b0 ;
  else if (vin & last)
    last_i <= 1'b1 ;

assign last_byte = last_i && cnt < BITN ;
always @ (posedge clk)
  last_byte_s0 <= last_byte ;

assign done = ~last_byte_s0 & last_byte ;

endmodule


//**************************************************************
// File:    viterbi_core
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 1/14/07
// Des:     The top level of viterbi decoder
//          Take 4 bit soft value is [-8 : +7]
//          K = 3. g0 = 7, g1 = 5
//          K = 5, g0 (A) = 1 + x + x^2 + x^4, g1 (B) = 1 + x^3 + x^4
//          K = 7, g0 (A) = 1 + x^2 + x^3 + x^4 + x^5
//                 g1 (B) = 1 + x + x^2 + x^3 + x^6 
// History: $ 1/14/07, Init coding, K = 3
//          $ 1/22/07, K = 5
//          $ 1/26/07, Updated
//          $ 1/27/07, Change to LLR domain
//          $ 2/18/07, Supported K = 7
//          $ 2/23/07, Added pipeline to max_metric
//          $ 12/1/07, Updated
//**************************************************************
//`define ZERO_TERM

module viterbi_core (
        clk         ,   // I, clock
        nrst        ,   // I, n reset
        packet_start,   // I, packet start pulse
        zero_tail   ,   // I, the code is zero terminated
        dv_in       ,   // I, data valid input
        llr0        ,   // I, LLR 2nd
        llr1        ,   // I, LLR 1st
        packet_end  ,   // I, packet end pulse
        dv_out      ,   // O, data valid out
        dout        ,   // O, data out
        done        ,   // O, done pulse
        remain,          // O, remain data cnt
		early_trace
        ) ;
        input early_trace;
parameter           SW = 4 ;        // soft input precision
parameter           M = 7 ;         // metric width

parameter           R = 48 ;        // reliable trace
parameter           C = 40 ;        // unreliable trace
parameter           L = 88 ;        // total trace depth
parameter           LW = 7 ;        // L width

parameter			R_EARLY = 24; //Early total trace depth
parameter			C_EARLY = 0;  //Early unreliable trace
parameter			L_EARLY = 24; //Early reliable trace trace 

parameter           K = 7 ;         // constraint length
parameter           N = 64 ;        // number of states = 2^(K-1)
parameter           TR = 128 ;      // trace buffer
parameter           TRW = 7 ;       // trace

input               clk ;           // system clock
input               nrst ;          // active low reset
input               packet_start ;  // start of packet pulse
input               zero_tail ;     // 1 = the code is terminated with 0, 0 = no termination
input               packet_end ;    // end of packet pulse
input               dv_in ;         // data valid input
input   [SW -1:0]   llr1 ;          // LLR soft value for bit1, LLR = log(Pr(ci=0/ri)/Pr(ci=1/ri))
input   [SW -1:0]   llr0 ;          // LLR soft value for bit0, LLR = log(Pr(ci=0/ri)/Pr(ci=1/ri))

output              done ;
output  [LW -1:0]   remain ;
output              dv_out ;
output  [R-1:0]     dout ;

//======================================
//Internal signal
//======================================
wire    [SW:0]      branch_00 ;
wire    [SW:0]      branch_01 ;
wire    [SW:0]      branch_10 ;
wire    [SW:0]      branch_11 ;

wire    [SW:0]      branch_A_0 ;
wire    [SW:0]      branch_B_0 ;
wire    [SW:0]      branch_A_1 ;
wire    [SW:0]      branch_B_1 ;
wire    [SW:0]      branch_A_2 ;
wire    [SW:0]      branch_B_2 ;
wire    [SW:0]      branch_A_3 ;
wire    [SW:0]      branch_B_3 ;
wire    [SW:0]      branch_A_4 ;
wire    [SW:0]      branch_B_4 ;
wire    [SW:0]      branch_A_5 ;
wire    [SW:0]      branch_B_5 ;
wire    [SW:0]      branch_A_6 ;
wire    [SW:0]      branch_B_6 ;
wire    [SW:0]      branch_A_7 ;
wire    [SW:0]      branch_B_7 ;
wire    [SW:0]      branch_A_8 ;
wire    [SW:0]      branch_B_8 ;
wire    [SW:0]      branch_A_9 ;
wire    [SW:0]      branch_B_9 ;
wire    [SW:0]      branch_A_10 ;
wire    [SW:0]      branch_B_10 ;
wire    [SW:0]      branch_A_11 ;
wire    [SW:0]      branch_B_11 ;
wire    [SW:0]      branch_A_12 ;
wire    [SW:0]      branch_B_12 ;
wire    [SW:0]      branch_A_13 ;
wire    [SW:0]      branch_B_13 ;
wire    [SW:0]      branch_A_14 ;
wire    [SW:0]      branch_B_14 ;
wire    [SW:0]      branch_A_15 ;
wire    [SW:0]      branch_B_15 ;
wire    [SW:0]      branch_A_16 ;
wire    [SW:0]      branch_B_16 ;
wire    [SW:0]      branch_A_17;
wire    [SW:0]      branch_B_17;
wire    [SW:0]      branch_A_18;
wire    [SW:0]      branch_B_18;
wire    [SW:0]      branch_A_19;
wire    [SW:0]      branch_B_19;
wire    [SW:0]      branch_A_20;
wire    [SW:0]      branch_B_20;
wire    [SW:0]      branch_A_21;
wire    [SW:0]      branch_B_21;
wire    [SW:0]      branch_A_22;
wire    [SW:0]      branch_B_22;
wire    [SW:0]      branch_A_23;
wire    [SW:0]      branch_B_23;
wire    [SW:0]      branch_A_24;
wire    [SW:0]      branch_B_24;
wire    [SW:0]      branch_A_25;
wire    [SW:0]      branch_B_25;
wire    [SW:0]      branch_A_26 ;
wire    [SW:0]      branch_B_26 ;
wire    [SW:0]      branch_A_27 ;
wire    [SW:0]      branch_B_27 ;
wire    [SW:0]      branch_A_28 ;
wire    [SW:0]      branch_B_28 ;
wire    [SW:0]      branch_A_29 ;
wire    [SW:0]      branch_B_29 ;
wire    [SW:0]      branch_A_30 ;
wire    [SW:0]      branch_B_30 ;
wire    [SW:0]      branch_A_31 ;
wire    [SW:0]      branch_B_31 ;
wire    [SW:0]      branch_A_32;
wire    [SW:0]      branch_B_32;
wire    [SW:0]      branch_A_33;
wire    [SW:0]      branch_B_33;
wire    [SW:0]      branch_A_34;
wire    [SW:0]      branch_B_34;
wire    [SW:0]      branch_A_35;
wire    [SW:0]      branch_B_35;
wire    [SW:0]      branch_A_36;
wire    [SW:0]      branch_B_36;
wire    [SW:0]      branch_A_37;
wire    [SW:0]      branch_B_37;
wire    [SW:0]      branch_A_38;
wire    [SW:0]      branch_B_38;
wire    [SW:0]      branch_A_39;
wire    [SW:0]      branch_B_39;
wire    [SW:0]      branch_A_40;
wire    [SW:0]      branch_B_40;
wire    [SW:0]      branch_A_41;
wire    [SW:0]      branch_B_41;
wire    [SW:0]      branch_A_42 ;
wire    [SW:0]      branch_B_42 ;
wire    [SW:0]      branch_A_43 ;
wire    [SW:0]      branch_B_43 ;
wire    [SW:0]      branch_A_44 ;
wire    [SW:0]      branch_B_44 ;
wire    [SW:0]      branch_A_45 ;
wire    [SW:0]      branch_B_45 ;
wire    [SW:0]      branch_A_46 ;
wire    [SW:0]      branch_B_46 ;
wire    [SW:0]      branch_A_47 ;
wire    [SW:0]      branch_B_47 ;
wire    [SW:0]      branch_A_48;
wire    [SW:0]      branch_B_48;
wire    [SW:0]      branch_A_49;
wire    [SW:0]      branch_B_49;
wire    [SW:0]      branch_A_50;
wire    [SW:0]      branch_B_50;
wire    [SW:0]      branch_A_51;
wire    [SW:0]      branch_B_51;
wire    [SW:0]      branch_A_52;
wire    [SW:0]      branch_B_52;
wire    [SW:0]      branch_A_53;
wire    [SW:0]      branch_B_53;
wire    [SW:0]      branch_A_54;
wire    [SW:0]      branch_B_54;
wire    [SW:0]      branch_A_55;
wire    [SW:0]      branch_B_55;
wire    [SW:0]      branch_A_56;
wire    [SW:0]      branch_B_56;
wire    [SW:0]      branch_A_57;
wire    [SW:0]      branch_B_57;
wire    [SW:0]      branch_A_58 ;
wire    [SW:0]      branch_B_58 ;
wire    [SW:0]      branch_A_59 ;
wire    [SW:0]      branch_B_59 ;
wire    [SW:0]      branch_A_60 ;
wire    [SW:0]      branch_B_60 ;
wire    [SW:0]      branch_A_61 ;
wire    [SW:0]      branch_B_61 ;
wire    [SW:0]      branch_A_62 ;
wire    [SW:0]      branch_B_62 ;
wire    [SW:0]      branch_A_63 ;
wire    [SW:0]      branch_B_63 ;

reg     [M -1:0]    metric_0 ;
reg     [M -1:0]    metric_1 ;
reg     [M -1:0]    metric_2 ;
reg     [M -1:0]    metric_3 ;
reg     [M -1:0]    metric_4 ;
reg     [M -1:0]    metric_5 ;
reg     [M -1:0]    metric_6 ;
reg     [M -1:0]    metric_7 ;
reg     [M -1:0]    metric_8 ;
reg     [M -1:0]    metric_9 ;
reg     [M -1:0]    metric_10 ;
reg     [M -1:0]    metric_11 ;
reg     [M -1:0]    metric_12 ;
reg     [M -1:0]    metric_13 ;
reg     [M -1:0]    metric_14 ;
reg     [M -1:0]    metric_15 ;
reg     [M -1:0]    metric_16;
reg     [M -1:0]    metric_17;
reg     [M -1:0]    metric_18;
reg     [M -1:0]    metric_19;
reg     [M -1:0]    metric_20;
reg     [M -1:0]    metric_21;
reg     [M -1:0]    metric_22;
reg     [M -1:0]    metric_23;
reg     [M -1:0]    metric_24;
reg     [M -1:0]    metric_25;
reg     [M -1:0]    metric_26 ;
reg     [M -1:0]    metric_27 ;
reg     [M -1:0]    metric_28 ;
reg     [M -1:0]    metric_29 ;
reg     [M -1:0]    metric_30 ;
reg     [M -1:0]    metric_31 ;
reg     [M -1:0]    metric_32;
reg     [M -1:0]    metric_33;
reg     [M -1:0]    metric_34;
reg     [M -1:0]    metric_35;
reg     [M -1:0]    metric_36;
reg     [M -1:0]    metric_37;
reg     [M -1:0]    metric_38;
reg     [M -1:0]    metric_39;
reg     [M -1:0]    metric_40;
reg     [M -1:0]    metric_41;
reg     [M -1:0]    metric_42 ;
reg     [M -1:0]    metric_43 ;
reg     [M -1:0]    metric_44 ;
reg     [M -1:0]    metric_45 ;
reg     [M -1:0]    metric_46 ;
reg     [M -1:0]    metric_47 ;
reg     [M -1:0]    metric_48;
reg     [M -1:0]    metric_49;
reg     [M -1:0]    metric_50;
reg     [M -1:0]    metric_51;
reg     [M -1:0]    metric_52;
reg     [M -1:0]    metric_53;
reg     [M -1:0]    metric_54;
reg     [M -1:0]    metric_55;
reg     [M -1:0]    metric_56;
reg     [M -1:0]    metric_57;
reg     [M -1:0]    metric_58 ;
reg     [M -1:0]    metric_59 ;
reg     [M -1:0]    metric_60 ;
reg     [M -1:0]    metric_61 ;
reg     [M -1:0]    metric_62 ;
reg     [M -1:0]    metric_63 ;

wire    [M -1:0]    metric_next_0 ;
wire    [M -1:0]    metric_next_1 ;
wire    [M -1:0]    metric_next_2 ;
wire    [M -1:0]    metric_next_3 ;
wire    [M -1:0]    metric_next_4 ;
wire    [M -1:0]    metric_next_5 ;
wire    [M -1:0]    metric_next_6 ;
wire    [M -1:0]    metric_next_7 ;
wire    [M -1:0]    metric_next_8 ;
wire    [M -1:0]    metric_next_9 ;
wire    [M -1:0]    metric_next_10 ;
wire    [M -1:0]    metric_next_11 ;
wire    [M -1:0]    metric_next_12 ;
wire    [M -1:0]    metric_next_13 ;
wire    [M -1:0]    metric_next_14 ;
wire    [M -1:0]    metric_next_15 ;
wire    [M -1:0]    metric_next_16;
wire    [M -1:0]    metric_next_17;
wire    [M -1:0]    metric_next_18;
wire    [M -1:0]    metric_next_19;
wire    [M -1:0]    metric_next_20;
wire    [M -1:0]    metric_next_21;
wire    [M -1:0]    metric_next_22;
wire    [M -1:0]    metric_next_23;
wire    [M -1:0]    metric_next_24;
wire    [M -1:0]    metric_next_25;
wire    [M -1:0]    metric_next_26 ;
wire    [M -1:0]    metric_next_27 ;
wire    [M -1:0]    metric_next_28 ;
wire    [M -1:0]    metric_next_29 ;
wire    [M -1:0]    metric_next_30 ;
wire    [M -1:0]    metric_next_31 ;
wire    [M -1:0]    metric_next_32;
wire    [M -1:0]    metric_next_33;
wire    [M -1:0]    metric_next_34;
wire    [M -1:0]    metric_next_35;
wire    [M -1:0]    metric_next_36;
wire    [M -1:0]    metric_next_37;
wire    [M -1:0]    metric_next_38;
wire    [M -1:0]    metric_next_39;
wire    [M -1:0]    metric_next_40;
wire    [M -1:0]    metric_next_41;
wire    [M -1:0]    metric_next_42 ;
wire    [M -1:0]    metric_next_43 ;
wire    [M -1:0]    metric_next_44 ;
wire    [M -1:0]    metric_next_45 ;
wire    [M -1:0]    metric_next_46 ;
wire    [M -1:0]    metric_next_47 ;
wire    [M -1:0]    metric_next_48;
wire    [M -1:0]    metric_next_49;
wire    [M -1:0]    metric_next_50;
wire    [M -1:0]    metric_next_51;
wire    [M -1:0]    metric_next_52;
wire    [M -1:0]    metric_next_53;
wire    [M -1:0]    metric_next_54;
wire    [M -1:0]    metric_next_55;
wire    [M -1:0]    metric_next_56;
wire    [M -1:0]    metric_next_57;
wire    [M -1:0]    metric_next_58 ;
wire    [M -1:0]    metric_next_59 ;
wire    [M -1:0]    metric_next_60 ;
wire    [M -1:0]    metric_next_61 ;
wire    [M -1:0]    metric_next_62 ;
wire    [M -1:0]    metric_next_63 ;

wire    [M -1:0]    metric_A_0 ;
wire    [M -1:0]    metric_B_0 ;
wire    [M -1:0]    metric_A_1 ;
wire    [M -1:0]    metric_B_1 ;
wire    [M -1:0]    metric_A_2 ;
wire    [M -1:0]    metric_B_2 ;
wire    [M -1:0]    metric_A_3 ;
wire    [M -1:0]    metric_B_3 ;
wire    [M -1:0]    metric_A_4 ;
wire    [M -1:0]    metric_B_4 ;
wire    [M -1:0]    metric_A_5 ;
wire    [M -1:0]    metric_B_5 ;
wire    [M -1:0]    metric_A_6 ;
wire    [M -1:0]    metric_B_6 ;
wire    [M -1:0]    metric_A_7 ;
wire    [M -1:0]    metric_B_7 ;
wire    [M -1:0]    metric_A_8 ;
wire    [M -1:0]    metric_B_8 ;
wire    [M -1:0]    metric_A_9 ;
wire    [M -1:0]    metric_B_9 ;
wire    [M -1:0]    metric_A_10 ;
wire    [M -1:0]    metric_B_10 ;
wire    [M -1:0]    metric_A_11 ;
wire    [M -1:0]    metric_B_11 ;
wire    [M -1:0]    metric_A_12 ;
wire    [M -1:0]    metric_B_12 ;
wire    [M -1:0]    metric_A_13 ;
wire    [M -1:0]    metric_B_13 ;
wire    [M -1:0]    metric_A_14 ;
wire    [M -1:0]    metric_B_14 ;
wire    [M -1:0]    metric_A_15 ;
wire    [M -1:0]    metric_B_15 ;
wire    [M -1:0]    metric_A_16;
wire    [M -1:0]    metric_B_16;
wire    [M -1:0]    metric_A_17;
wire    [M -1:0]    metric_B_17;
wire    [M -1:0]    metric_A_18;
wire    [M -1:0]    metric_B_18;
wire    [M -1:0]    metric_A_19;
wire    [M -1:0]    metric_B_19;
wire    [M -1:0]    metric_A_20;
wire    [M -1:0]    metric_B_20;
wire    [M -1:0]    metric_A_21;
wire    [M -1:0]    metric_B_21;
wire    [M -1:0]    metric_A_22;
wire    [M -1:0]    metric_B_22;
wire    [M -1:0]    metric_A_23;
wire    [M -1:0]    metric_B_23;
wire    [M -1:0]    metric_A_24;
wire    [M -1:0]    metric_B_24;
wire    [M -1:0]    metric_A_25;
wire    [M -1:0]    metric_B_25;
wire    [M -1:0]    metric_A_26 ;
wire    [M -1:0]    metric_B_26 ;
wire    [M -1:0]    metric_A_27 ;
wire    [M -1:0]    metric_B_27 ;
wire    [M -1:0]    metric_A_28 ;
wire    [M -1:0]    metric_B_28 ;
wire    [M -1:0]    metric_A_29 ;
wire    [M -1:0]    metric_B_29 ;
wire    [M -1:0]    metric_A_30 ;
wire    [M -1:0]    metric_B_30 ;
wire    [M -1:0]    metric_A_31 ;
wire    [M -1:0]    metric_B_31 ;
wire    [M -1:0]    metric_A_32;
wire    [M -1:0]    metric_B_32;
wire    [M -1:0]    metric_A_33;
wire    [M -1:0]    metric_B_33;
wire    [M -1:0]    metric_A_34;
wire    [M -1:0]    metric_B_34;
wire    [M -1:0]    metric_A_35;
wire    [M -1:0]    metric_B_35;
wire    [M -1:0]    metric_A_36;
wire    [M -1:0]    metric_B_36;
wire    [M -1:0]    metric_A_37;
wire    [M -1:0]    metric_B_37;
wire    [M -1:0]    metric_A_38;
wire    [M -1:0]    metric_B_38;
wire    [M -1:0]    metric_A_39;
wire    [M -1:0]    metric_B_39;
wire    [M -1:0]    metric_A_40;
wire    [M -1:0]    metric_B_40;
wire    [M -1:0]    metric_A_41;
wire    [M -1:0]    metric_B_41;
wire    [M -1:0]    metric_A_42 ;
wire    [M -1:0]    metric_B_42 ;
wire    [M -1:0]    metric_A_43 ;
wire    [M -1:0]    metric_B_43 ;
wire    [M -1:0]    metric_A_44 ;
wire    [M -1:0]    metric_B_44 ;
wire    [M -1:0]    metric_A_45 ;
wire    [M -1:0]    metric_B_45 ;
wire    [M -1:0]    metric_A_46 ;
wire    [M -1:0]    metric_B_46 ;
wire    [M -1:0]    metric_A_47 ;
wire    [M -1:0]    metric_B_47 ;
wire    [M -1:0]    metric_A_48;
wire    [M -1:0]    metric_B_48;
wire    [M -1:0]    metric_A_49;
wire    [M -1:0]    metric_B_49;
wire    [M -1:0]    metric_A_50;
wire    [M -1:0]    metric_B_50;
wire    [M -1:0]    metric_A_51;
wire    [M -1:0]    metric_B_51;
wire    [M -1:0]    metric_A_52;
wire    [M -1:0]    metric_B_52;
wire    [M -1:0]    metric_A_53;
wire    [M -1:0]    metric_B_53;
wire    [M -1:0]    metric_A_54;
wire    [M -1:0]    metric_B_54;
wire    [M -1:0]    metric_A_55;
wire    [M -1:0]    metric_B_55;
wire    [M -1:0]    metric_A_56;
wire    [M -1:0]    metric_B_56;
wire    [M -1:0]    metric_A_57;
wire    [M -1:0]    metric_B_57;
wire    [M -1:0]    metric_A_58 ;
wire    [M -1:0]    metric_B_58 ;
wire    [M -1:0]    metric_A_59 ;
wire    [M -1:0]    metric_B_59 ;
wire    [M -1:0]    metric_A_60 ;
wire    [M -1:0]    metric_B_60 ;
wire    [M -1:0]    metric_A_61 ;
wire    [M -1:0]    metric_B_61 ;
wire    [M -1:0]    metric_A_62 ;
wire    [M -1:0]    metric_B_62 ;
wire    [M -1:0]    metric_A_63 ;
wire    [M -1:0]    metric_B_63 ;
                             
// 64 state tran             
reg     [0:0]       tran_state_0  [TR -1:0] ;
reg     [0:0]       tran_state_1  [TR -1:0] ;
reg     [0:0]       tran_state_2  [TR -1:0] ;
reg     [0:0]       tran_state_3  [TR -1:0] ;
reg     [0:0]       tran_state_4  [TR -1:0] ;
reg     [0:0]       tran_state_5  [TR -1:0] ;
reg     [0:0]       tran_state_6  [TR -1:0] ;
reg     [0:0]       tran_state_7  [TR -1:0] ;
reg     [0:0]       tran_state_8  [TR -1:0] ;
reg     [0:0]       tran_state_9  [TR -1:0] ;
reg     [0:0]       tran_state_10 [TR -1:0] ;
reg     [0:0]       tran_state_11 [TR -1:0] ;
reg     [0:0]       tran_state_12 [TR -1:0] ;
reg     [0:0]       tran_state_13 [TR -1:0] ;
reg     [0:0]       tran_state_14 [TR -1:0] ;
reg     [0:0]       tran_state_15 [TR -1:0] ;
reg     [0:0]       tran_state_16 [TR -1:0] ;
reg     [0:0]       tran_state_17 [TR -1:0] ;
reg     [0:0]       tran_state_18 [TR -1:0] ;
reg     [0:0]       tran_state_19 [TR -1:0] ;
reg     [0:0]       tran_state_20 [TR -1:0] ;
reg     [0:0]       tran_state_21 [TR -1:0] ;
reg     [0:0]       tran_state_22 [TR -1:0] ;
reg     [0:0]       tran_state_23 [TR -1:0] ;
reg     [0:0]       tran_state_24 [TR -1:0] ;
reg     [0:0]       tran_state_25 [TR -1:0] ;
reg     [0:0]       tran_state_26 [TR -1:0] ;
reg     [0:0]       tran_state_27 [TR -1:0] ;
reg     [0:0]       tran_state_28 [TR -1:0] ;
reg     [0:0]       tran_state_29 [TR -1:0] ;
reg     [0:0]       tran_state_30 [TR -1:0] ;
reg     [0:0]       tran_state_31 [TR -1:0] ;
reg     [0:0]       tran_state_32 [TR -1:0] ;
reg     [0:0]       tran_state_33 [TR -1:0] ;
reg     [0:0]       tran_state_34 [TR -1:0] ;
reg     [0:0]       tran_state_35 [TR -1:0] ;
reg     [0:0]       tran_state_36 [TR -1:0] ;
reg     [0:0]       tran_state_37 [TR -1:0] ;
reg     [0:0]       tran_state_38 [TR -1:0] ;
reg     [0:0]       tran_state_39 [TR -1:0] ;
reg     [0:0]       tran_state_40 [TR -1:0] ;
reg     [0:0]       tran_state_41 [TR -1:0] ;
reg     [0:0]       tran_state_42 [TR -1:0] ;
reg     [0:0]       tran_state_43 [TR -1:0] ;
reg     [0:0]       tran_state_44 [TR -1:0] ;
reg     [0:0]       tran_state_45 [TR -1:0] ;
reg     [0:0]       tran_state_46 [TR -1:0] ;
reg     [0:0]       tran_state_47 [TR -1:0] ;
reg     [0:0]       tran_state_48 [TR -1:0] ;
reg     [0:0]       tran_state_49 [TR -1:0] ;
reg     [0:0]       tran_state_50 [TR -1:0] ;
reg     [0:0]       tran_state_51 [TR -1:0] ;
reg     [0:0]       tran_state_52 [TR -1:0] ;
reg     [0:0]       tran_state_53 [TR -1:0] ;
reg     [0:0]       tran_state_54 [TR -1:0] ;
reg     [0:0]       tran_state_55 [TR -1:0] ;
reg     [0:0]       tran_state_56 [TR -1:0] ;
reg     [0:0]       tran_state_57 [TR -1:0] ;
reg     [0:0]       tran_state_58 [TR -1:0] ;
reg     [0:0]       tran_state_59 [TR -1:0] ;
reg     [0:0]       tran_state_60 [TR -1:0] ;
reg     [0:0]       tran_state_61 [TR -1:0] ;
reg     [0:0]       tran_state_62 [TR -1:0] ;
reg     [0:0]       tran_state_63 [TR -1:0] ;
                             
reg     [TRW -1:0]  wptr ;   
reg     [TRW -1:0]  last_wptr ;
                             
wire    [M -1:0]    diff_0 ; 
wire    [M -1:0]    diff_1 ; 
wire    [M -1:0]    diff_2 ; 
wire    [M -1:0]    diff_3 ; 
wire    [M -1:0]    diff_4 ; 
wire    [M -1:0]    diff_5 ; 
wire    [M -1:0]    diff_6 ; 
wire    [M -1:0]    diff_7 ; 
wire    [M -1:0]    diff_8 ; 
wire    [M -1:0]    diff_9 ;
wire    [M -1:0]    diff_10;
wire    [M -1:0]    diff_11;
wire    [M -1:0]    diff_12;
wire    [M -1:0]    diff_13;
wire    [M -1:0]    diff_14;
wire    [M -1:0]    diff_15;
wire    [M -1:0]    diff_16; 
wire    [M -1:0]    diff_17; 
wire    [M -1:0]    diff_18; 
wire    [M -1:0]    diff_19; 
wire    [M -1:0]    diff_20; 
wire    [M -1:0]    diff_21; 
wire    [M -1:0]    diff_22; 
wire    [M -1:0]    diff_23; 
wire    [M -1:0]    diff_24; 
wire    [M -1:0]    diff_25;
wire    [M -1:0]    diff_26;
wire    [M -1:0]    diff_27;
wire    [M -1:0]    diff_28;
wire    [M -1:0]    diff_29;
wire    [M -1:0]    diff_30;
wire    [M -1:0]    diff_31;
wire    [M -1:0]    diff_32; 
wire    [M -1:0]    diff_33; 
wire    [M -1:0]    diff_34; 
wire    [M -1:0]    diff_35; 
wire    [M -1:0]    diff_36; 
wire    [M -1:0]    diff_37; 
wire    [M -1:0]    diff_38; 
wire    [M -1:0]    diff_39; 
wire    [M -1:0]    diff_40; 
wire    [M -1:0]    diff_41;
wire    [M -1:0]    diff_42;
wire    [M -1:0]    diff_43;
wire    [M -1:0]    diff_44;
wire    [M -1:0]    diff_45;
wire    [M -1:0]    diff_46;
wire    [M -1:0]    diff_47;
wire    [M -1:0]    diff_48; 
wire    [M -1:0]    diff_49; 
wire    [M -1:0]    diff_50; 
wire    [M -1:0]    diff_51; 
wire    [M -1:0]    diff_52; 
wire    [M -1:0]    diff_53; 
wire    [M -1:0]    diff_54; 
wire    [M -1:0]    diff_55; 
wire    [M -1:0]    diff_56; 
wire    [M -1:0]    diff_57;
wire    [M -1:0]    diff_58;
wire    [M -1:0]    diff_59;
wire    [M -1:0]    diff_60;
wire    [M -1:0]    diff_61;
wire    [M -1:0]    diff_62;
wire    [M -1:0]    diff_63;

reg                 nd ;
reg     [LW -1:0]   cnt ;
reg                 trace ;
reg                 trace_en ;
reg					early_trace_en;

wire                trace_done ;
reg                 trace_done_s0 ;
wire                trace_done_pos ;
reg     [TRW -1:0]  trace_cnt ;
reg     [L-1:0]     res ;
wire    [L-1:0]     res_shift ;
wire    [K-2: 0]    init_state_i ;
reg     [K-2: 0]    trace_state ;

wire    [K-2: 0]    cur_state0 ;
wire    [K-2: 0]    cur_state1 ;
wire    [K-2: 0]    next_state ;
reg     [TRW -1:0]  trace_start_wptr ;
wire    [TRW -1:0]  trace_start_pos ;
wire    [TRW -1:0]  trace_start_pos0 ;
wire    [TRW -1:0]  trace_start_pos1 ;
reg                 last_trace ;
reg                 last_trace_s0 ;
wire                trace2 ;
reg                 trace2_s1 ;
reg                 trace2_s2 ;
reg                 trace_pos ;
wire                trace_pos_i ;
reg     [LW -1:0]   last_trace_num ;
reg                 flush_en ;
wire                flush ;
reg                 done_i ;

wire    [K-2: 0]    state_0 ;
wire    [K-2: 0]    state_1 ;
wire    [K-2: 0]    state_2 ;
wire    [K-2: 0]    state_3 ;
wire    [K-2: 0]    state_4 ;
wire    [K-2: 0]    state_5 ;
wire    [K-2: 0]    state_6 ;
wire    [K-2: 0]    state_7 ;
wire    [K-2: 0]    state_8 ;
wire    [K-2: 0]    state_9 ;
wire    [K-2: 0]    state_10 ;
wire    [K-2: 0]    state_11 ;
wire    [K-2: 0]    state_12 ;
wire    [K-2: 0]    state_13 ;
wire    [K-2: 0]    state_14 ;
wire    [K-2: 0]    state_15 ;

wire    [K-2: 0]    state_s1_0 ;
wire    [K-2: 0]    state_s1_1 ;
wire    [K-2: 0]    state_s1_2 ;
wire    [K-2: 0]    state_s1_3 ;

wire    [K-2: 0]    state_s2_0 ;

wire    [M-1: 0]    max_0  ;
wire    [M-1: 0]    max_1  ;
wire    [M-1: 0]    max_2  ;
wire    [M-1: 0]    max_3  ;
wire    [M-1: 0]    max_4  ;
wire    [M-1: 0]    max_5  ;
wire    [M-1: 0]    max_6  ;
wire    [M-1: 0]    max_7  ;
wire    [M-1: 0]    max_8  ;
wire    [M-1: 0]    max_9  ;
wire    [M-1: 0]    max_10 ;
wire    [M-1: 0]    max_11 ;
wire    [M-1: 0]    max_12 ;
wire    [M-1: 0]    max_13 ;
wire    [M-1: 0]    max_14 ;
wire    [M-1: 0]    max_15 ;

wire    [M-1: 0]    max_s1_0 ;
wire    [M-1: 0]    max_s1_1 ;
wire    [M-1: 0]    max_s1_2 ;
wire    [M-1: 0]    max_s1_3 ;

//reg     [M-1: 0]    max_s1_0_s0 ;
//reg     [M-1: 0]    max_s1_1_s0 ;
//reg     [M-1: 0]    max_s1_2_s0 ;
//reg     [M-1: 0]    max_s1_3_s0 ;

//wire    [M-1: 0]    max_s2_0 ;

wire    [N -1:0]    tran_all_0 ;
wire    [N -1:0]    tran_all_1 ;

reg     [6:0]       flush_cnt ;
wire    [LW -1:0]   rem_i ;
reg     [LW -1:0]   last_cnt ;
wire    [LW -1:0]   last_cnt_next ;
reg                 last_trace_d0 ;
reg                 last_trace_d1 ;
reg                 last_trace_d2 ;
reg                 last_trace_d3 ;
reg                 last_trace_d4 ;
reg                 last_trace_d5 ;
reg                 one_more_out ;
reg                 in_dec ;
wire                dv_in_gate ;
reg                 trace_pos_s0 ; 

//======================================
// Main body of code
//======================================
assign dv_out = trace_done_pos | one_more_out ;
assign res_shift = res << last_trace_num ;
assign dout = res_shift [L -1:C] ;
assign remain = last_trace ? rem_i : 0 ;
assign done = dv_out & done_i ;
assign rem_i = ~last_cnt_next[LW-1] ? 0 : last_cnt ;

//assign dv_in_gate = dv_in & in_dec ;
assign dv_in_gate = dv_in & in_dec & (~packet_end) ;

always @ (posedge clk)
  if (~nrst)
    in_dec <= 1'b0 ;
  else if (packet_start)
    in_dec <= 1'b1 ;
  else if (packet_end)
    in_dec <= 1'b0 ;


//{coe_0 coe_1}, generated from C model gen_table
//0 0; 
//0 1;
//1 0;
//1 1;
//1 0;
//1 1;
//0 0;
//0 1;

assign branch_00 = {llr1[SW -1], llr1} + {llr0[SW -1], llr0} ;  //LLR(bit1) + LLR(bit0)
assign branch_01 = {llr1[SW -1], llr1} ;                        //LLR(bit1)
assign branch_10 = {llr0[SW -1], llr0} ;                        //LLR(bit0)
assign branch_11 = 0  ;                                         //0

assign branch_A_0 = branch_00 ;
assign branch_B_0 = branch_11 ;
assign branch_A_1 = branch_10 ;
assign branch_B_1 = branch_01 ;
assign branch_A_2 = branch_00 ;
assign branch_B_2 = branch_11 ;
assign branch_A_3 = branch_10 ;
assign branch_B_3 = branch_01 ;
assign branch_A_4 = branch_11 ;
assign branch_B_4 = branch_00 ;
assign branch_A_5 = branch_01 ;
assign branch_B_5 = branch_10 ;
assign branch_A_6 = branch_11 ;
assign branch_B_6 = branch_00 ;
assign branch_A_7 = branch_01 ;
assign branch_B_7 = branch_10 ;
assign branch_A_8 = branch_11 ;
assign branch_B_8 = branch_00 ;
assign branch_A_9 = branch_01 ;
assign branch_B_9 = branch_10 ;
assign branch_A_10 = branch_11 ;
assign branch_B_10 = branch_00 ;
assign branch_A_11 = branch_01 ;
assign branch_B_11 = branch_10 ;
assign branch_A_12 = branch_00 ;
assign branch_B_12 = branch_11 ;
assign branch_A_13 = branch_10 ;
assign branch_B_13 = branch_01 ;
assign branch_A_14 = branch_00 ;
assign branch_B_14 = branch_11 ;
assign branch_A_15 = branch_10 ;
assign branch_B_15 = branch_01 ;
assign branch_A_16 = branch_01 ;
assign branch_B_16 = branch_10 ;
assign branch_A_17 = branch_11 ;
assign branch_B_17 = branch_00 ;
assign branch_A_18 = branch_01 ;
assign branch_B_18 = branch_10 ;
assign branch_A_19 = branch_11 ;
assign branch_B_19 = branch_00 ;
assign branch_A_20 = branch_10 ;
assign branch_B_20 = branch_01 ;
assign branch_A_21 = branch_00 ;
assign branch_B_21 = branch_11 ;
assign branch_A_22 = branch_10 ;
assign branch_B_22 = branch_01 ;
assign branch_A_23 = branch_00 ;
assign branch_B_23 = branch_11 ;
assign branch_A_24 = branch_10 ;
assign branch_B_24 = branch_01 ;
assign branch_A_25 = branch_00 ;
assign branch_B_25 = branch_11 ;
assign branch_A_26 = branch_10 ;
assign branch_B_26 = branch_01 ;
assign branch_A_27 = branch_00 ;
assign branch_B_27 = branch_11 ;
assign branch_A_28 = branch_01 ;
assign branch_B_28 = branch_10 ;
assign branch_A_29 = branch_11 ;
assign branch_B_29 = branch_00 ;
assign branch_A_30 = branch_01 ;
assign branch_B_30 = branch_10 ;
assign branch_A_31 = branch_11 ;
assign branch_B_31 = branch_00 ;

assign branch_A_32 = branch_B_0 ;
assign branch_B_32 = branch_A_0 ;
assign branch_A_33 = branch_B_1 ;
assign branch_B_33 = branch_A_1 ;
assign branch_A_34 = branch_B_2 ;
assign branch_B_34 = branch_A_2 ;
assign branch_A_35 = branch_B_3 ;
assign branch_B_35 = branch_A_3 ;
assign branch_A_36 = branch_B_4 ;
assign branch_B_36 = branch_A_4 ;
assign branch_A_37 = branch_B_5 ;
assign branch_B_37 = branch_A_5 ;
assign branch_A_38 = branch_B_6 ;
assign branch_B_38 = branch_A_6 ;
assign branch_A_39 = branch_B_7 ;
assign branch_B_39 = branch_A_7 ;
assign branch_A_40 = branch_B_8 ;
assign branch_B_40 = branch_A_8 ;
assign branch_A_41 = branch_B_9 ;
assign branch_B_41 = branch_A_9 ;
assign branch_A_42 = branch_B_10 ;
assign branch_B_42 = branch_A_10 ;
assign branch_A_43 = branch_B_11 ;
assign branch_B_43 = branch_A_11 ;
assign branch_A_44 = branch_B_12 ;
assign branch_B_44 = branch_A_12 ;
assign branch_A_45 = branch_B_13 ;
assign branch_B_45 = branch_A_13 ;
assign branch_A_46 = branch_B_14 ;
assign branch_B_46 = branch_A_14 ;
assign branch_A_47 = branch_B_15 ;
assign branch_B_47 = branch_A_15 ;
assign branch_A_48 = branch_B_16 ;
assign branch_B_48 = branch_A_16 ;
assign branch_A_49 = branch_B_17 ;
assign branch_B_49 = branch_A_17 ;
assign branch_A_50 = branch_B_18 ;
assign branch_B_50 = branch_A_18 ;
assign branch_A_51 = branch_B_19 ;
assign branch_B_51 = branch_A_19 ;
assign branch_A_52 = branch_B_20 ;
assign branch_B_52 = branch_A_20 ;
assign branch_A_53 = branch_B_21 ;
assign branch_B_53 = branch_A_21 ;
assign branch_A_54 = branch_B_22 ;
assign branch_B_54 = branch_A_22 ;
assign branch_A_55 = branch_B_23 ;
assign branch_B_55 = branch_A_23 ;
assign branch_A_56 = branch_B_24 ;
assign branch_B_56 = branch_A_24 ;
assign branch_A_57 = branch_B_25 ;
assign branch_B_57 = branch_A_25 ;
assign branch_A_58 = branch_B_26 ;
assign branch_B_58 = branch_A_26 ;
assign branch_A_59 = branch_B_27 ;
assign branch_B_59 = branch_A_27 ;
assign branch_A_60 = branch_B_28 ;
assign branch_B_60 = branch_A_28 ;
assign branch_A_61 = branch_B_29 ;
assign branch_B_61 = branch_A_29 ;
assign branch_A_62 = branch_B_30 ;
assign branch_B_62 = branch_A_30 ;
assign branch_A_63 = branch_B_31 ;
assign branch_B_63 = branch_A_31 ;

assign metric_A_0 = metric_0 + {{(M -SW -1){branch_A_0[SW]}}, branch_A_0} ;
assign metric_B_0 = metric_1 + {{(M -SW -1){branch_B_0[SW]}}, branch_B_0} ;
assign metric_A_1 = metric_2 + {{(M -SW -1){branch_A_1[SW]}}, branch_A_1} ;
assign metric_B_1 = metric_3 + {{(M -SW -1){branch_B_1[SW]}}, branch_B_1} ;
assign metric_A_2 = metric_4 + {{(M -SW -1){branch_A_2[SW]}}, branch_A_2} ;
assign metric_B_2 = metric_5 + {{(M -SW -1){branch_B_2[SW]}}, branch_B_2} ;
assign metric_A_3 = metric_6 + {{(M -SW -1){branch_A_3[SW]}}, branch_A_3} ;
assign metric_B_3 = metric_7 + {{(M -SW -1){branch_B_3[SW]}}, branch_B_3} ;
assign metric_A_4 = metric_8 + {{(M -SW -1){branch_A_4[SW]}}, branch_A_4} ;
assign metric_B_4 = metric_9 + {{(M -SW -1){branch_B_4[SW]}}, branch_B_4} ;
assign metric_A_5 = metric_10 + {{(M -SW -1){branch_A_5[SW]}}, branch_A_5} ;
assign metric_B_5 = metric_11 + {{(M -SW -1){branch_B_5[SW]}}, branch_B_5} ;
assign metric_A_6 = metric_12 + {{(M -SW -1){branch_A_6[SW]}}, branch_A_6} ;
assign metric_B_6 = metric_13 + {{(M -SW -1){branch_B_6[SW]}}, branch_B_6} ;
assign metric_A_7 = metric_14 + {{(M -SW -1){branch_A_7[SW]}}, branch_A_7} ;
assign metric_B_7 = metric_15 + {{(M -SW -1){branch_B_7[SW]}}, branch_B_7} ;
assign metric_A_8 = metric_16 + {{(M -SW -1){branch_A_8[SW]}}, branch_A_8} ;
assign metric_B_8 = metric_17 + {{(M -SW -1){branch_B_8[SW]}}, branch_B_8} ;
assign metric_A_9 = metric_18 + {{(M -SW -1){branch_A_9[SW]}}, branch_A_9} ;
assign metric_B_9 = metric_19 + {{(M -SW -1){branch_B_9[SW]}}, branch_B_9} ;
assign metric_A_10 = metric_20 + {{(M -SW -1){branch_A_10[SW]}}, branch_A_10} ;
assign metric_B_10 = metric_21 + {{(M -SW -1){branch_B_10[SW]}}, branch_B_10} ;
assign metric_A_11 = metric_22 + {{(M -SW -1){branch_A_11[SW]}}, branch_A_11} ;
assign metric_B_11 = metric_23 + {{(M -SW -1){branch_B_11[SW]}}, branch_B_11} ;
assign metric_A_12 = metric_24 + {{(M -SW -1){branch_A_12[SW]}}, branch_A_12} ;
assign metric_B_12 = metric_25 + {{(M -SW -1){branch_B_12[SW]}}, branch_B_12} ;
assign metric_A_13 = metric_26 + {{(M -SW -1){branch_A_13[SW]}}, branch_A_13} ;
assign metric_B_13 = metric_27 + {{(M -SW -1){branch_B_13[SW]}}, branch_B_13} ;
assign metric_A_14 = metric_28 + {{(M -SW -1){branch_A_14[SW]}}, branch_A_14} ;
assign metric_B_14 = metric_29 + {{(M -SW -1){branch_B_14[SW]}}, branch_B_14} ;
assign metric_A_15 = metric_30 + {{(M -SW -1){branch_A_15[SW]}}, branch_A_15} ;
assign metric_B_15 = metric_31 + {{(M -SW -1){branch_B_15[SW]}}, branch_B_15} ;
assign metric_A_16 = metric_32 + {{(M -SW -1){branch_A_16[SW]}}, branch_A_16} ;
assign metric_B_16 = metric_33 + {{(M -SW -1){branch_B_16[SW]}}, branch_B_16} ;
assign metric_A_17 = metric_34 + {{(M -SW -1){branch_A_17[SW]}}, branch_A_17} ;
assign metric_B_17 = metric_35 + {{(M -SW -1){branch_B_17[SW]}}, branch_B_17} ;
assign metric_A_18 = metric_36 + {{(M -SW -1){branch_A_18[SW]}}, branch_A_18} ;
assign metric_B_18 = metric_37 + {{(M -SW -1){branch_B_18[SW]}}, branch_B_18} ;
assign metric_A_19 = metric_38 + {{(M -SW -1){branch_A_19[SW]}}, branch_A_19} ;
assign metric_B_19 = metric_39 + {{(M -SW -1){branch_B_19[SW]}}, branch_B_19} ;
assign metric_A_20 = metric_40 + {{(M -SW -1){branch_A_20[SW]}}, branch_A_20} ;
assign metric_B_20 = metric_41 + {{(M -SW -1){branch_B_20[SW]}}, branch_B_20} ;
assign metric_A_21 = metric_42 + {{(M -SW -1){branch_A_21[SW]}}, branch_A_21} ;
assign metric_B_21 = metric_43 + {{(M -SW -1){branch_B_21[SW]}}, branch_B_21} ;
assign metric_A_22 = metric_44 + {{(M -SW -1){branch_A_22[SW]}}, branch_A_22} ;
assign metric_B_22 = metric_45 + {{(M -SW -1){branch_B_22[SW]}}, branch_B_22} ;
assign metric_A_23 = metric_46 + {{(M -SW -1){branch_A_23[SW]}}, branch_A_23} ;
assign metric_B_23 = metric_47 + {{(M -SW -1){branch_B_23[SW]}}, branch_B_23} ;
assign metric_A_24 = metric_48 + {{(M -SW -1){branch_A_24[SW]}}, branch_A_24} ;
assign metric_B_24 = metric_49 + {{(M -SW -1){branch_B_24[SW]}}, branch_B_24} ;
assign metric_A_25 = metric_50 + {{(M -SW -1){branch_A_25[SW]}}, branch_A_25} ;
assign metric_B_25 = metric_51 + {{(M -SW -1){branch_B_25[SW]}}, branch_B_25} ;
assign metric_A_26 = metric_52 + {{(M -SW -1){branch_A_26[SW]}}, branch_A_26} ;
assign metric_B_26 = metric_53 + {{(M -SW -1){branch_B_26[SW]}}, branch_B_26} ;
assign metric_A_27 = metric_54 + {{(M -SW -1){branch_A_27[SW]}}, branch_A_27} ;
assign metric_B_27 = metric_55 + {{(M -SW -1){branch_B_27[SW]}}, branch_B_27} ;
assign metric_A_28 = metric_56 + {{(M -SW -1){branch_A_28[SW]}}, branch_A_28} ;
assign metric_B_28 = metric_57 + {{(M -SW -1){branch_B_28[SW]}}, branch_B_28} ;
assign metric_A_29 = metric_58 + {{(M -SW -1){branch_A_29[SW]}}, branch_A_29} ;
assign metric_B_29 = metric_59 + {{(M -SW -1){branch_B_29[SW]}}, branch_B_29} ;
assign metric_A_30 = metric_60 + {{(M -SW -1){branch_A_30[SW]}}, branch_A_30} ;
assign metric_B_30 = metric_61 + {{(M -SW -1){branch_B_30[SW]}}, branch_B_30} ;
assign metric_A_31 = metric_62 + {{(M -SW -1){branch_A_31[SW]}}, branch_A_31} ;
assign metric_B_31 = metric_63 + {{(M -SW -1){branch_B_31[SW]}}, branch_B_31} ;
assign metric_A_32 = metric_0 + {{(M -SW -1){branch_A_32[SW]}}, branch_A_32} ;
assign metric_B_32 = metric_1 + {{(M -SW -1){branch_B_32[SW]}}, branch_B_32} ;
assign metric_A_33 = metric_2 + {{(M -SW -1){branch_A_33[SW]}}, branch_A_33} ;
assign metric_B_33 = metric_3 + {{(M -SW -1){branch_B_33[SW]}}, branch_B_33} ;
assign metric_A_34 = metric_4 + {{(M -SW -1){branch_A_34[SW]}}, branch_A_34} ;
assign metric_B_34 = metric_5 + {{(M -SW -1){branch_B_34[SW]}}, branch_B_34} ;
assign metric_A_35 = metric_6 + {{(M -SW -1){branch_A_35[SW]}}, branch_A_35} ;
assign metric_B_35 = metric_7 + {{(M -SW -1){branch_B_35[SW]}}, branch_B_35} ;
assign metric_A_36 = metric_8 + {{(M -SW -1){branch_A_36[SW]}}, branch_A_36} ;
assign metric_B_36 = metric_9 + {{(M -SW -1){branch_B_36[SW]}}, branch_B_36} ;
assign metric_A_37 = metric_10 + {{(M -SW -1){branch_A_37[SW]}}, branch_A_37} ;
assign metric_B_37 = metric_11 + {{(M -SW -1){branch_B_37[SW]}}, branch_B_37} ;
assign metric_A_38 = metric_12 + {{(M -SW -1){branch_A_38[SW]}}, branch_A_38} ;
assign metric_B_38 = metric_13 + {{(M -SW -1){branch_B_38[SW]}}, branch_B_38} ;
assign metric_A_39 = metric_14 + {{(M -SW -1){branch_A_39[SW]}}, branch_A_39} ;
assign metric_B_39 = metric_15 + {{(M -SW -1){branch_B_39[SW]}}, branch_B_39} ;
assign metric_A_40 = metric_16 + {{(M -SW -1){branch_A_40[SW]}}, branch_A_40} ;
assign metric_B_40 = metric_17 + {{(M -SW -1){branch_B_40[SW]}}, branch_B_40} ;
assign metric_A_41 = metric_18 + {{(M -SW -1){branch_A_41[SW]}}, branch_A_41} ;
assign metric_B_41 = metric_19 + {{(M -SW -1){branch_B_41[SW]}}, branch_B_41} ;
assign metric_A_42 = metric_20 + {{(M -SW -1){branch_A_42[SW]}}, branch_A_42} ;
assign metric_B_42 = metric_21 + {{(M -SW -1){branch_B_42[SW]}}, branch_B_42} ;
assign metric_A_43 = metric_22 + {{(M -SW -1){branch_A_43[SW]}}, branch_A_43} ;
assign metric_B_43 = metric_23 + {{(M -SW -1){branch_B_43[SW]}}, branch_B_43} ;
assign metric_A_44 = metric_24 + {{(M -SW -1){branch_A_44[SW]}}, branch_A_44} ;
assign metric_B_44 = metric_25 + {{(M -SW -1){branch_B_44[SW]}}, branch_B_44} ;
assign metric_A_45 = metric_26 + {{(M -SW -1){branch_A_45[SW]}}, branch_A_45} ;
assign metric_B_45 = metric_27 + {{(M -SW -1){branch_B_45[SW]}}, branch_B_45} ;
assign metric_A_46 = metric_28 + {{(M -SW -1){branch_A_46[SW]}}, branch_A_46} ;
assign metric_B_46 = metric_29 + {{(M -SW -1){branch_B_46[SW]}}, branch_B_46} ;
assign metric_A_47 = metric_30 + {{(M -SW -1){branch_A_47[SW]}}, branch_A_47} ;
assign metric_B_47 = metric_31 + {{(M -SW -1){branch_B_47[SW]}}, branch_B_47} ;
assign metric_A_48 = metric_32 + {{(M -SW -1){branch_A_48[SW]}}, branch_A_48} ;
assign metric_B_48 = metric_33 + {{(M -SW -1){branch_B_48[SW]}}, branch_B_48} ;
assign metric_A_49 = metric_34 + {{(M -SW -1){branch_A_49[SW]}}, branch_A_49} ;
assign metric_B_49 = metric_35 + {{(M -SW -1){branch_B_49[SW]}}, branch_B_49} ;
assign metric_A_50 = metric_36 + {{(M -SW -1){branch_A_50[SW]}}, branch_A_50} ;
assign metric_B_50 = metric_37 + {{(M -SW -1){branch_B_50[SW]}}, branch_B_50} ;
assign metric_A_51 = metric_38 + {{(M -SW -1){branch_A_51[SW]}}, branch_A_51} ;
assign metric_B_51 = metric_39 + {{(M -SW -1){branch_B_51[SW]}}, branch_B_51} ;
assign metric_A_52 = metric_40 + {{(M -SW -1){branch_A_52[SW]}}, branch_A_52} ;
assign metric_B_52 = metric_41 + {{(M -SW -1){branch_B_52[SW]}}, branch_B_52} ;
assign metric_A_53 = metric_42 + {{(M -SW -1){branch_A_53[SW]}}, branch_A_53} ;
assign metric_B_53 = metric_43 + {{(M -SW -1){branch_B_53[SW]}}, branch_B_53} ;
assign metric_A_54 = metric_44 + {{(M -SW -1){branch_A_54[SW]}}, branch_A_54} ;
assign metric_B_54 = metric_45 + {{(M -SW -1){branch_B_54[SW]}}, branch_B_54} ;
assign metric_A_55 = metric_46 + {{(M -SW -1){branch_A_55[SW]}}, branch_A_55} ;
assign metric_B_55 = metric_47 + {{(M -SW -1){branch_B_55[SW]}}, branch_B_55} ;
assign metric_A_56 = metric_48 + {{(M -SW -1){branch_A_56[SW]}}, branch_A_56} ;
assign metric_B_56 = metric_49 + {{(M -SW -1){branch_B_56[SW]}}, branch_B_56} ;
assign metric_A_57 = metric_50 + {{(M -SW -1){branch_A_57[SW]}}, branch_A_57} ;
assign metric_B_57 = metric_51 + {{(M -SW -1){branch_B_57[SW]}}, branch_B_57} ;
assign metric_A_58 = metric_52 + {{(M -SW -1){branch_A_58[SW]}}, branch_A_58} ;
assign metric_B_58 = metric_53 + {{(M -SW -1){branch_B_58[SW]}}, branch_B_58} ;
assign metric_A_59 = metric_54 + {{(M -SW -1){branch_A_59[SW]}}, branch_A_59} ;
assign metric_B_59 = metric_55 + {{(M -SW -1){branch_B_59[SW]}}, branch_B_59} ;
assign metric_A_60 = metric_56 + {{(M -SW -1){branch_A_60[SW]}}, branch_A_60} ;
assign metric_B_60 = metric_57 + {{(M -SW -1){branch_B_60[SW]}}, branch_B_60} ;
assign metric_A_61 = metric_58 + {{(M -SW -1){branch_A_61[SW]}}, branch_A_61} ;
assign metric_B_61 = metric_59 + {{(M -SW -1){branch_B_61[SW]}}, branch_B_61} ;
assign metric_A_62 = metric_60 + {{(M -SW -1){branch_A_62[SW]}}, branch_A_62} ;
assign metric_B_62 = metric_61 + {{(M -SW -1){branch_B_62[SW]}}, branch_B_62} ;
assign metric_A_63 = metric_62 + {{(M -SW -1){branch_A_63[SW]}}, branch_A_63} ;
assign metric_B_63 = metric_63 + {{(M -SW -1){branch_B_63[SW]}}, branch_B_63} ;

assign diff_0 = metric_A_0 - metric_B_0 ;
assign diff_1 = metric_A_1 - metric_B_1 ;
assign diff_2 = metric_A_2 - metric_B_2 ;
assign diff_3 = metric_A_3 - metric_B_3 ;
assign diff_4 = metric_A_4 - metric_B_4 ;
assign diff_5 = metric_A_5 - metric_B_5 ;
assign diff_6 = metric_A_6 - metric_B_6 ;
assign diff_7 = metric_A_7 - metric_B_7 ;
assign diff_8 = metric_A_8 - metric_B_8 ;
assign diff_9 = metric_A_9 - metric_B_9 ;
assign diff_10 = metric_A_10 - metric_B_10 ;
assign diff_11 = metric_A_11 - metric_B_11 ;
assign diff_12 = metric_A_12 - metric_B_12 ;
assign diff_13 = metric_A_13 - metric_B_13 ;
assign diff_14 = metric_A_14 - metric_B_14 ;
assign diff_15 = metric_A_15 - metric_B_15 ;
assign diff_16 = metric_A_16 - metric_B_16 ;
assign diff_17 = metric_A_17 - metric_B_17 ;
assign diff_18 = metric_A_18 - metric_B_18 ;
assign diff_19 = metric_A_19 - metric_B_19 ;
assign diff_20 = metric_A_20 - metric_B_20 ;
assign diff_21 = metric_A_21 - metric_B_21 ;
assign diff_22 = metric_A_22 - metric_B_22 ;
assign diff_23 = metric_A_23 - metric_B_23 ;
assign diff_24 = metric_A_24 - metric_B_24 ;
assign diff_25 = metric_A_25 - metric_B_25 ;
assign diff_26 = metric_A_26 - metric_B_26 ;
assign diff_27 = metric_A_27 - metric_B_27 ;
assign diff_28 = metric_A_28 - metric_B_28 ;
assign diff_29 = metric_A_29 - metric_B_29 ;
assign diff_30 = metric_A_30 - metric_B_30 ;
assign diff_31 = metric_A_31 - metric_B_31 ;
assign diff_32 = metric_A_32 - metric_B_32 ;
assign diff_33 = metric_A_33 - metric_B_33 ;
assign diff_34 = metric_A_34 - metric_B_34 ;
assign diff_35 = metric_A_35 - metric_B_35 ;
assign diff_36 = metric_A_36 - metric_B_36 ;
assign diff_37 = metric_A_37 - metric_B_37 ;
assign diff_38 = metric_A_38 - metric_B_38 ;
assign diff_39 = metric_A_39 - metric_B_39 ;
assign diff_40 = metric_A_40 - metric_B_40 ;
assign diff_41 = metric_A_41 - metric_B_41 ;
assign diff_42 = metric_A_42 - metric_B_42 ;
assign diff_43 = metric_A_43 - metric_B_43 ;
assign diff_44 = metric_A_44 - metric_B_44 ;
assign diff_45 = metric_A_45 - metric_B_45 ;
assign diff_46 = metric_A_46 - metric_B_46 ;
assign diff_47 = metric_A_47 - metric_B_47 ;
assign diff_48 = metric_A_48 - metric_B_48 ;
assign diff_49 = metric_A_49 - metric_B_49 ;
assign diff_50 = metric_A_50 - metric_B_50 ;
assign diff_51 = metric_A_51 - metric_B_51 ;
assign diff_52 = metric_A_52 - metric_B_52 ;
assign diff_53 = metric_A_53 - metric_B_53 ;
assign diff_54 = metric_A_54 - metric_B_54 ;
assign diff_55 = metric_A_55 - metric_B_55 ;
assign diff_56 = metric_A_56 - metric_B_56 ;
assign diff_57 = metric_A_57 - metric_B_57 ;
assign diff_58 = metric_A_58 - metric_B_58 ;
assign diff_59 = metric_A_59 - metric_B_59 ;
assign diff_60 = metric_A_60 - metric_B_60 ;
assign diff_61 = metric_A_61 - metric_B_61 ;
assign diff_62 = metric_A_62 - metric_B_62 ;
assign diff_63 = metric_A_63 - metric_B_63 ;

assign metric_next_0 = diff_0 [M -1] ? metric_B_0 : metric_A_0 ;
assign metric_next_1 = diff_1 [M -1] ? metric_B_1 : metric_A_1 ;
assign metric_next_2 = diff_2 [M -1] ? metric_B_2 : metric_A_2 ;
assign metric_next_3 = diff_3 [M -1] ? metric_B_3 : metric_A_3 ;
assign metric_next_4 = diff_4 [M -1] ? metric_B_4 : metric_A_4 ;
assign metric_next_5 = diff_5 [M -1] ? metric_B_5 : metric_A_5 ;
assign metric_next_6 = diff_6 [M -1] ? metric_B_6 : metric_A_6 ;
assign metric_next_7 = diff_7 [M -1] ? metric_B_7 : metric_A_7 ;
assign metric_next_8 = diff_8 [M -1] ? metric_B_8 : metric_A_8 ;
assign metric_next_9 = diff_9 [M -1] ? metric_B_9 : metric_A_9 ;
assign metric_next_10 = diff_10 [M -1] ? metric_B_10 : metric_A_10 ;
assign metric_next_11 = diff_11 [M -1] ? metric_B_11 : metric_A_11 ;
assign metric_next_12 = diff_12 [M -1] ? metric_B_12 : metric_A_12 ;
assign metric_next_13 = diff_13 [M -1] ? metric_B_13 : metric_A_13 ;
assign metric_next_14 = diff_14 [M -1] ? metric_B_14 : metric_A_14 ;
assign metric_next_15 = diff_15 [M -1] ? metric_B_15 : metric_A_15 ;
assign metric_next_16 = diff_16 [M -1] ? metric_B_16 : metric_A_16 ;
assign metric_next_17 = diff_17 [M -1] ? metric_B_17 : metric_A_17 ;
assign metric_next_18 = diff_18 [M -1] ? metric_B_18 : metric_A_18 ;
assign metric_next_19 = diff_19 [M -1] ? metric_B_19 : metric_A_19 ;
assign metric_next_20 = diff_20 [M -1] ? metric_B_20 : metric_A_20 ;
assign metric_next_21 = diff_21 [M -1] ? metric_B_21 : metric_A_21 ;
assign metric_next_22 = diff_22 [M -1] ? metric_B_22 : metric_A_22 ;
assign metric_next_23 = diff_23 [M -1] ? metric_B_23 : metric_A_23 ;
assign metric_next_24 = diff_24 [M -1] ? metric_B_24 : metric_A_24 ;
assign metric_next_25 = diff_25 [M -1] ? metric_B_25 : metric_A_25 ;
assign metric_next_26 = diff_26 [M -1] ? metric_B_26 : metric_A_26 ;
assign metric_next_27 = diff_27 [M -1] ? metric_B_27 : metric_A_27 ;
assign metric_next_28 = diff_28 [M -1] ? metric_B_28 : metric_A_28 ;
assign metric_next_29 = diff_29 [M -1] ? metric_B_29 : metric_A_29 ;
assign metric_next_30 = diff_30 [M -1] ? metric_B_30 : metric_A_30 ;
assign metric_next_31 = diff_31 [M -1] ? metric_B_31 : metric_A_31 ;
assign metric_next_32 = diff_32 [M -1] ? metric_B_32 : metric_A_32 ;
assign metric_next_33 = diff_33 [M -1] ? metric_B_33 : metric_A_33 ;
assign metric_next_34 = diff_34 [M -1] ? metric_B_34 : metric_A_34 ;
assign metric_next_35 = diff_35 [M -1] ? metric_B_35 : metric_A_35 ;
assign metric_next_36 = diff_36 [M -1] ? metric_B_36 : metric_A_36 ;
assign metric_next_37 = diff_37 [M -1] ? metric_B_37 : metric_A_37 ;
assign metric_next_38 = diff_38 [M -1] ? metric_B_38 : metric_A_38 ;
assign metric_next_39 = diff_39 [M -1] ? metric_B_39 : metric_A_39 ;
assign metric_next_40 = diff_40 [M -1] ? metric_B_40 : metric_A_40 ;
assign metric_next_41 = diff_41 [M -1] ? metric_B_41 : metric_A_41 ;
assign metric_next_42 = diff_42 [M -1] ? metric_B_42 : metric_A_42 ;
assign metric_next_43 = diff_43 [M -1] ? metric_B_43 : metric_A_43 ;
assign metric_next_44 = diff_44 [M -1] ? metric_B_44 : metric_A_44 ;
assign metric_next_45 = diff_45 [M -1] ? metric_B_45 : metric_A_45 ;
assign metric_next_46 = diff_46 [M -1] ? metric_B_46 : metric_A_46 ;
assign metric_next_47 = diff_47 [M -1] ? metric_B_47 : metric_A_47 ;
assign metric_next_48 = diff_48 [M -1] ? metric_B_48 : metric_A_48 ;
assign metric_next_49 = diff_49 [M -1] ? metric_B_49 : metric_A_49 ;
assign metric_next_50 = diff_50 [M -1] ? metric_B_50 : metric_A_50 ;
assign metric_next_51 = diff_51 [M -1] ? metric_B_51 : metric_A_51 ;
assign metric_next_52 = diff_52 [M -1] ? metric_B_52 : metric_A_52 ;
assign metric_next_53 = diff_53 [M -1] ? metric_B_53 : metric_A_53 ;
assign metric_next_54 = diff_54 [M -1] ? metric_B_54 : metric_A_54 ;
assign metric_next_55 = diff_55 [M -1] ? metric_B_55 : metric_A_55 ;
assign metric_next_56 = diff_56 [M -1] ? metric_B_56 : metric_A_56 ;
assign metric_next_57 = diff_57 [M -1] ? metric_B_57 : metric_A_57 ;
assign metric_next_58 = diff_58 [M -1] ? metric_B_58 : metric_A_58 ;
assign metric_next_59 = diff_59 [M -1] ? metric_B_59 : metric_A_59 ;
assign metric_next_60 = diff_60 [M -1] ? metric_B_60 : metric_A_60 ;
assign metric_next_61 = diff_61 [M -1] ? metric_B_61 : metric_A_61 ;
assign metric_next_62 = diff_62 [M -1] ? metric_B_62 : metric_A_62 ;
assign metric_next_63 = diff_63 [M -1] ? metric_B_63 : metric_A_63 ;

always @ (posedge clk)
  if (~nrst)
  begin
    metric_0  <= 10 ;
    metric_1  <= 0 ;
    metric_2  <= 0 ;
    metric_3  <= 0 ;
    metric_4  <= 0 ;
    metric_5  <= 0 ;
    metric_6  <= 0 ;
    metric_7  <= 0 ;
    metric_8  <= 0 ;
    metric_9  <= 0 ;
    metric_10 <= 0 ;
    metric_11 <= 0 ;
    metric_12 <= 0 ;
    metric_13 <= 0 ;
    metric_14 <= 0 ;
    metric_15 <= 0 ;
    metric_16 <= 0 ; 
    metric_17 <= 0 ;  
    metric_18 <= 0 ;  
    metric_19 <= 0 ;  
    metric_20 <= 0 ;  
    metric_21 <= 0 ;  
    metric_22 <= 0 ;  
    metric_23 <= 0 ;  
    metric_24 <= 0 ;  
    metric_25 <= 0 ;  
    metric_26 <= 0 ;  
    metric_27 <= 0 ;  
    metric_28 <= 0 ;  
    metric_29 <= 0 ;  
    metric_30 <= 0 ;  
    metric_31 <= 0 ;  
    metric_32 <= 0 ; 
    metric_33 <= 0 ;  
    metric_34 <= 0 ;  
    metric_35 <= 0 ;  
    metric_36 <= 0 ;  
    metric_37 <= 0 ;  
    metric_38 <= 0 ;  
    metric_39 <= 0 ;  
    metric_40 <= 0 ;  
    metric_41 <= 0 ;  
    metric_42 <= 0 ;  
    metric_43 <= 0 ;  
    metric_44 <= 0 ;  
    metric_45 <= 0 ;  
    metric_46 <= 0 ;  
    metric_47 <= 0 ;  
    metric_48 <= 0 ; 
    metric_49 <= 0 ;  
    metric_50 <= 0 ;  
    metric_51 <= 0 ;  
    metric_52 <= 0 ;  
    metric_53 <= 0 ;  
    metric_54 <= 0 ;  
    metric_55 <= 0 ;  
    metric_56 <= 0 ;  
    metric_57 <= 0 ;  
    metric_58 <= 0 ;  
    metric_59 <= 0 ;  
    metric_60 <= 0 ;  
    metric_61 <= 0 ;  
    metric_62 <= 0 ;  
    metric_63 <= 0 ;  
  end
  else if (packet_start)
  begin
    metric_0  <= 10 ;
    metric_1  <= 0 ;
    metric_2  <= 0 ;
    metric_3  <= 0 ;
    metric_4  <= 0 ;
    metric_5  <= 0 ;    
    metric_6  <= 0 ;
    metric_7  <= 0 ;
    metric_8  <= 0 ;
    metric_9  <= 0 ;
    metric_10 <= 0 ;
    metric_11 <= 0 ;    
    metric_12 <= 0 ;
    metric_13 <= 0 ;
    metric_14 <= 0 ;
    metric_15 <= 0 ;
    metric_16 <= 0 ; 
    metric_17 <= 0 ;  
    metric_18 <= 0 ;  
    metric_19 <= 0 ;  
    metric_20 <= 0 ;  
    metric_21 <= 0 ;  
    metric_22 <= 0 ;  
    metric_23 <= 0 ;  
    metric_24 <= 0 ;  
    metric_25 <= 0 ;  
    metric_26 <= 0 ;  
    metric_27 <= 0 ;  
    metric_28 <= 0 ;  
    metric_29 <= 0 ;  
    metric_30 <= 0 ;  
    metric_31 <= 0 ;  
    metric_32 <= 0 ; 
    metric_33 <= 0 ;  
    metric_34 <= 0 ;  
    metric_35 <= 0 ;  
    metric_36 <= 0 ;  
    metric_37 <= 0 ;  
    metric_38 <= 0 ;  
    metric_39 <= 0 ;  
    metric_40 <= 0 ;  
    metric_41 <= 0 ;  
    metric_42 <= 0 ;  
    metric_43 <= 0 ;  
    metric_44 <= 0 ;  
    metric_45 <= 0 ;  
    metric_46 <= 0 ;  
    metric_47 <= 0 ;  
    metric_48 <= 0 ; 
    metric_49 <= 0 ;  
    metric_50 <= 0 ;  
    metric_51 <= 0 ;  
    metric_52 <= 0 ;  
    metric_53 <= 0 ;  
    metric_54 <= 0 ;  
    metric_55 <= 0 ;  
    metric_56 <= 0 ;  
    metric_57 <= 0 ;  
    metric_58 <= 0 ;  
    metric_59 <= 0 ;  
    metric_60 <= 0 ;  
    metric_61 <= 0 ;  
    metric_62 <= 0 ;  
    metric_63 <= 0 ;  
  end
  else if (dv_in_gate)
  begin
    // update metric
    metric_0  <= metric_next_0 ;
    metric_1  <= metric_next_1 ;
    metric_2  <= metric_next_2 ;
    metric_3  <= metric_next_3 ;
    metric_4  <= metric_next_4 ;
    metric_5  <= metric_next_5 ;    
    metric_6  <= metric_next_6 ;
    metric_7  <= metric_next_7 ;
    metric_8  <= metric_next_8 ;
    metric_9  <= metric_next_9 ;
    metric_10 <= metric_next_10;
    metric_11 <= metric_next_11;    
    metric_12 <= metric_next_12;
    metric_13 <= metric_next_13;
    metric_14 <= metric_next_14;
    metric_15 <= metric_next_15;
    metric_16 <= metric_next_16 ;
    metric_17 <= metric_next_17;
    metric_18 <= metric_next_18;
    metric_19 <= metric_next_19;
    metric_20 <= metric_next_20;
    metric_21 <= metric_next_21;    
    metric_22 <= metric_next_22;
    metric_23 <= metric_next_23;
    metric_24 <= metric_next_24;
    metric_25 <= metric_next_25;
    metric_26 <= metric_next_26;
    metric_27 <= metric_next_27;    
    metric_28 <= metric_next_28;
    metric_29 <= metric_next_29;
    metric_30 <= metric_next_30;
    metric_31 <= metric_next_31;
    metric_32 <= metric_next_32 ;
    metric_33 <= metric_next_33;
    metric_34 <= metric_next_34;
    metric_35 <= metric_next_35;
    metric_36 <= metric_next_36;
    metric_37 <= metric_next_37;    
    metric_38 <= metric_next_38;
    metric_39 <= metric_next_39;
    metric_40 <= metric_next_40;
    metric_41 <= metric_next_41;
    metric_42 <= metric_next_42;
    metric_43 <= metric_next_43;    
    metric_44 <= metric_next_44;
    metric_45 <= metric_next_45;
    metric_46 <= metric_next_46;
    metric_47 <= metric_next_47;
    metric_48 <= metric_next_48 ;
    metric_49 <= metric_next_49;
    metric_50 <= metric_next_50;
    metric_51 <= metric_next_51;
    metric_52 <= metric_next_52;
    metric_53 <= metric_next_53;    
    metric_54 <= metric_next_54;
    metric_55 <= metric_next_55;
    metric_56 <= metric_next_56;
    metric_57 <= metric_next_57;
    metric_58 <= metric_next_58;
    metric_59 <= metric_next_59;    
    metric_60 <= metric_next_60;
    metric_61 <= metric_next_61;
    metric_62 <= metric_next_62;
    metric_63 <= metric_next_63;
  end

always @ (posedge clk)
  if (~nrst)
    wptr <= 0 ;
  else if (packet_start)
    wptr <= 0 ;
  else if (dv_in_gate)
      wptr <= wptr + 1 ;

always @ (posedge clk)
  if (~nrst)
    last_wptr <= 1'b0 ;
  else if (dv_in_gate)
    last_wptr <= wptr ;
 
always @ (posedge clk)
  if(dv_in_gate)
  begin
    // update transition
    tran_state_0  [wptr] <= diff_0  [M -1] ;
    tran_state_1  [wptr] <= diff_1  [M -1] ;
    tran_state_2  [wptr] <= diff_2  [M -1] ;
    tran_state_3  [wptr] <= diff_3  [M -1] ;
    tran_state_4  [wptr] <= diff_4  [M -1] ;
    tran_state_5  [wptr] <= diff_5  [M -1] ;
    tran_state_6  [wptr] <= diff_6  [M -1] ;
    tran_state_7  [wptr] <= diff_7  [M -1] ;
    tran_state_8  [wptr] <= diff_8  [M -1] ;
    tran_state_9  [wptr] <= diff_9  [M -1] ;
    tran_state_10 [wptr] <= diff_10 [M -1] ;
    tran_state_11 [wptr] <= diff_11 [M -1] ;
    tran_state_12 [wptr] <= diff_12 [M -1] ;
    tran_state_13 [wptr] <= diff_13 [M -1] ;
    tran_state_14 [wptr] <= diff_14 [M -1] ;
    tran_state_15 [wptr] <= diff_15 [M -1] ;
    tran_state_16 [wptr] <= diff_16 [M -1] ;
    tran_state_17 [wptr] <= diff_17 [M -1] ;
    tran_state_18 [wptr] <= diff_18 [M -1] ;
    tran_state_19 [wptr] <= diff_19 [M -1] ;
    tran_state_20 [wptr] <= diff_20 [M -1] ;
    tran_state_21 [wptr] <= diff_21 [M -1] ;
    tran_state_22 [wptr] <= diff_22 [M -1] ;
    tran_state_23 [wptr] <= diff_23 [M -1] ;
    tran_state_24 [wptr] <= diff_24 [M -1] ;
    tran_state_25 [wptr] <= diff_25 [M -1] ;
    tran_state_26 [wptr] <= diff_26 [M -1] ;
    tran_state_27 [wptr] <= diff_27 [M -1] ;
    tran_state_28 [wptr] <= diff_28 [M -1] ;
    tran_state_29 [wptr] <= diff_29 [M -1] ;
    tran_state_30 [wptr] <= diff_30 [M -1] ;
    tran_state_31 [wptr] <= diff_31 [M -1] ;
    tran_state_32 [wptr] <= diff_32 [M -1] ;
    tran_state_33 [wptr] <= diff_33 [M -1] ;
    tran_state_34 [wptr] <= diff_34 [M -1] ;
    tran_state_35 [wptr] <= diff_35 [M -1] ;
    tran_state_36 [wptr] <= diff_36 [M -1] ;
    tran_state_37 [wptr] <= diff_37 [M -1] ;
    tran_state_38 [wptr] <= diff_38 [M -1] ;
    tran_state_39 [wptr] <= diff_39 [M -1] ;
    tran_state_40 [wptr] <= diff_40 [M -1] ;
    tran_state_41 [wptr] <= diff_41 [M -1] ;
    tran_state_42 [wptr] <= diff_42 [M -1] ;
    tran_state_43 [wptr] <= diff_43 [M -1] ;
    tran_state_44 [wptr] <= diff_44 [M -1] ;
    tran_state_45 [wptr] <= diff_45 [M -1] ;
    tran_state_46 [wptr] <= diff_46 [M -1] ;
    tran_state_47 [wptr] <= diff_47 [M -1] ;
    tran_state_48 [wptr] <= diff_48 [M -1] ;
    tran_state_49 [wptr] <= diff_49 [M -1] ;
    tran_state_50 [wptr] <= diff_50 [M -1] ;
    tran_state_51 [wptr] <= diff_51 [M -1] ;
    tran_state_52 [wptr] <= diff_52 [M -1] ;
    tran_state_53 [wptr] <= diff_53 [M -1] ;
    tran_state_54 [wptr] <= diff_54 [M -1] ;
    tran_state_55 [wptr] <= diff_55 [M -1] ;
    tran_state_56 [wptr] <= diff_56 [M -1] ;
    tran_state_57 [wptr] <= diff_57 [M -1] ;
    tran_state_58 [wptr] <= diff_58 [M -1] ;
    tran_state_59 [wptr] <= diff_59 [M -1] ;
    tran_state_60 [wptr] <= diff_60 [M -1] ;
    tran_state_61 [wptr] <= diff_61 [M -1] ;
    tran_state_62 [wptr] <= diff_62 [M -1] ;
    tran_state_63 [wptr] <= diff_63 [M -1] ;
  end
  
	reg early_trace_d0;
	wire early_trace_pos;

	always @ (posedge clk)
	begin
		early_trace_d0 <= early_trace;
	end

	assign early_trace_pos = (early_trace & ~early_trace_d0);

always @ (posedge clk)
  if (~nrst)
  begin
    early_trace_en <= 1'b0;
    trace <= 1'b0 ;
    cnt <= 0 ;
    trace_start_wptr <= 0 ;
  end
  else if (packet_start)
  begin
    early_trace_en <= 1'b0;
    trace <= 1'b0 ;
    cnt <= 0 ;
  end
  else if (dv_in_gate)
  begin
    if (cnt == L-1)
    begin
      early_trace_en <= 1'b0;
      trace <= 1'b1 ;
      trace_start_wptr <= wptr ;
      cnt <= C ;
    end
    else if (early_trace_pos)
    begin
	  early_trace_en <= 1'b1;
      trace <= 1'b1 ;
      trace_start_wptr <= wptr ;
      cnt <= C_EARLY ;
    end
	else
    begin
      early_trace_en <= 1'b0;
      trace <= 1'b0 ;
      cnt <= cnt + 1 ;
    end
  end
  else if (trace2)
    trace_start_wptr <= last_wptr ;
  else
    trace <= 1'b0 ;

always @ (posedge clk)
  if (~nrst)
  begin
    flush_en <= 1'b0 ;
    flush_cnt <= 0 ;
  end
  else if (packet_end)
  begin
    flush_en <= 1 ;
    flush_cnt <= 0 ;
  end
  else if (flush_en)
  begin
    if (flush_cnt == 63)
      flush_en <= 1'b0 ;
    else
      flush_cnt <= flush_cnt + 1 ; 
  end

assign flush = flush_cnt == 60 ;

always @ (posedge clk)
  if (~nrst)
    done_i <= 1'b0 ;
  else if (packet_start)
    done_i <= 1'b0 ;
  //else if (packet_end && cnt == L-1)
  else if (trace2 & last_cnt_next[LW-1])
    done_i <= 1'b1 ;
  else if (last_trace_d3)
    done_i <= 1'b1 ;


always @ (posedge clk)
  if (~nrst)
    last_trace <= 1'b0 ;
  else if (packet_start)
    last_trace <= 1'b0 ;
  else if (flush && trace_done && cnt !=L-1 )
    last_trace <= 1'b1 ;

always @ (posedge clk)
  last_trace_s0 <= last_trace ;

assign trace2 = ~last_trace_s0 & last_trace ;
assign trace_pos_i = trace | trace2 ;

always @ (posedge clk)
  if (~nrst)
  begin
    trace2_s1 <= 1'b0 ;
    trace2_s2 <= 1'b0 ;
  end
  else
  begin
    trace2_s1 <= trace2 ;
    trace2_s2 <= trace2_s1 ;
  end


always @ (posedge clk)
begin
  trace_pos_s0 <= trace_pos_i ;
  trace_pos <= trace_pos_s0 ;
end

always @ (posedge clk)
  if(~nrst)
    last_trace_num <= 0 ;
  else
  begin
    if (packet_start)
      last_trace_num <= 0 ;
    else if (trace2)
      last_trace_num <= L -cnt  ;
    else if (last_trace_d0)
      last_trace_num <= last_trace_num + R ;
  end

always @ (posedge clk)
begin
  last_trace_d0 <= last_trace & trace_done_pos ;
  last_trace_d1 <= last_trace_d0 ;
  last_trace_d2 <= last_trace_d1 ;
  last_trace_d3 <= last_trace_d2 ;
  last_trace_d4 <= last_trace_d3 ;
  last_trace_d5 <= last_trace_d4 ;
end

assign last_cnt_next = last_cnt - R ;

always @ (posedge clk)
  if(~nrst)
  begin
    one_more_out <= 1'b0 ;
    last_cnt <= 0 ;
  end
  else
  begin
    if (packet_start)
    begin
      one_more_out <= 1'b0 ;
      last_cnt <= 0 ;
    end
    else if (flush)
      last_cnt <= cnt ;
    else if (last_trace_d5)
    begin
      if (~last_cnt_next[LW-1])
      begin
        last_cnt <= last_cnt_next ;
        one_more_out <= 1'b1 ;
      end
    end
    else
      one_more_out <= 1'b0 ;
  end

always @ (posedge clk)
  if (~nrst)
    trace_en <= 0 ;
  else if (packet_start)
    trace_en <= 0 ;
  else if (trace_pos)
    trace_en <= 1'b1 ;
  else if ((trace_cnt == L-2) & (early_trace_en == 0))
    trace_en <= 1'b0 ;
  else if ((trace_cnt == L_EARLY-2) & (early_trace_en == 1))
    trace_en <= 1'b0 ;
    
always @ (posedge clk)
  if (~nrst)
    trace_cnt <= 0 ;
  else if (trace_pos)
    trace_cnt <= 0 ;
  else if (trace_en)
    trace_cnt <= trace_cnt + 2; 
    
//assign trace_done = (trace_cnt == L);
assign trace_done = early_trace_en ? (trace_cnt == L_EARLY) : (trace_cnt == L);

always @ (posedge clk)
  trace_done_s0 <= trace_done ;
assign trace_done_pos = ~trace_done_s0 & trace_done ;

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_0 (
        .clk    (clk        ),
        .a      (metric_0   ), 
        .b      (metric_1   ), 
        .c      (metric_2   ), 
        .d      (metric_3   ), 
        .sa     (6'd0       ), 
        .sb     (6'd1       ), 
        .sc     (6'd2       ), 
        .sd     (6'd3       ), 
        .state  (state_0    ), 
        .max    (max_0      )
        ) ;
        
//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_1 (
        .clk    (clk        ),
        .a      (metric_4   ), 
        .b      (metric_5   ), 
        .c      (metric_6   ), 
        .d      (metric_7   ), 
        .sa     (6'd4       ), 
        .sb     (6'd5       ), 
        .sc     (6'd6       ), 
        .sd     (6'd7       ), 
        .state  (state_1    ), 
        .max    (max_1      )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_2 (
        .clk    (clk        ),
        .a      (metric_8   ), 
        .b      (metric_9   ), 
        .c      (metric_10  ), 
        .d      (metric_11  ), 
        .sa     (6'd8       ), 
        .sb     (6'd9       ), 
        .sc     (6'd10      ), 
        .sd     (6'd11      ), 
        .state  (state_2    ), 
        .max    (max_2      )
        ) ;   

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_3 (
        .clk    (clk        ),
        .a      (metric_12  ), 
        .b      (metric_13  ), 
        .c      (metric_14  ), 
        .d      (metric_15  ), 
        .sa     (6'd12      ), 
        .sb     (6'd13      ), 
        .sc     (6'd14      ), 
        .sd     (6'd15      ), 
        .state  (state_3    ), 
        .max    (max_3      )
        ) ;

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_4 (
        .clk    (clk        ),
        .a      (metric_16  ), 
        .b      (metric_17  ), 
        .c      (metric_18  ), 
        .d      (metric_19  ), 
        .sa     (6'd16      ), 
        .sb     (6'd17      ), 
        .sc     (6'd18      ), 
        .sd     (6'd19      ), 
        .state  (state_4    ), 
        .max    (max_4      )
        ) ;

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_5 (
        .clk    (clk        ),
        .a      (metric_20  ), 
        .b      (metric_21  ), 
        .c      (metric_22  ), 
        .d      (metric_23  ), 
        .sa     (6'd20      ), 
        .sb     (6'd21      ), 
        .sc     (6'd22      ), 
        .sd     (6'd23      ), 
        .state  (state_5    ), 
        .max    (max_5      )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_6 (
        .clk    (clk        ),
        .a      (metric_24  ), 
        .b      (metric_25  ), 
        .c      (metric_26  ), 
        .d      (metric_27  ), 
        .sa     (6'd24      ), 
        .sb     (6'd25      ), 
        .sc     (6'd26      ), 
        .sd     (6'd27      ), 
        .state  (state_6    ), 
        .max    (max_6      )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_7 (
        .clk    (clk        ),
        .a      (metric_28  ), 
        .b      (metric_29  ), 
        .c      (metric_30  ), 
        .d      (metric_31  ), 
        .sa     (6'd28      ), 
        .sb     (6'd29      ), 
        .sc     (6'd30      ), 
        .sd     (6'd31      ), 
        .state  (state_7    ), 
        .max    (max_7      )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_8 (
        .clk    (clk        ),
        .a      (metric_32  ), 
        .b      (metric_33  ), 
        .c      (metric_34  ), 
        .d      (metric_35  ), 
        .sa     (6'd32      ), 
        .sb     (6'd33      ), 
        .sc     (6'd34      ), 
        .sd     (6'd35      ), 
        .state  (state_8    ), 
        .max    (max_8      )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_9 (
        .clk    (clk        ),
        .a      (metric_36  ), 
        .b      (metric_37  ), 
        .c      (metric_38  ), 
        .d      (metric_39  ), 
        .sa     (6'd36      ), 
        .sb     (6'd37      ), 
        .sc     (6'd38      ), 
        .sd     (6'd39      ), 
        .state  (state_9    ), 
        .max    (max_9      )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_10 (
        .clk    (clk        ),
        .a      (metric_40  ), 
        .b      (metric_41  ), 
        .c      (metric_42  ), 
        .d      (metric_43  ), 
        .sa     (6'd40      ), 
        .sb     (6'd41      ), 
        .sc     (6'd42      ), 
        .sd     (6'd43      ), 
        .state  (state_10   ), 
        .max    (max_10     )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_11 (
        .clk    (clk        ),
        .a      (metric_44  ), 
        .b      (metric_45  ), 
        .c      (metric_46  ), 
        .d      (metric_47  ), 
        .sa     (6'd44      ), 
        .sb     (6'd45      ), 
        .sc     (6'd46      ), 
        .sd     (6'd47      ), 
        .state  (state_11   ), 
        .max    (max_11     )
        ) ;

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_12 (
        .clk    (clk        ),
        .a      (metric_48  ), 
        .b      (metric_49  ), 
        .c      (metric_50  ), 
        .d      (metric_51  ), 
        .sa     (6'd48      ), 
        .sb     (6'd49      ), 
        .sc     (6'd50      ), 
        .sd     (6'd51      ), 
        .state  (state_12   ), 
        .max    (max_12     )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_13 (
        .clk    (clk        ),
        .a      (metric_52  ), 
        .b      (metric_53  ), 
        .c      (metric_54  ), 
        .d      (metric_55  ), 
        .sa     (6'd52      ), 
        .sb     (6'd53      ), 
        .sc     (6'd54      ), 
        .sd     (6'd55      ), 
        .state  (state_13   ), 
        .max    (max_13     )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_14 (
        .clk    (clk        ),
        .a      (metric_56  ), 
        .b      (metric_57  ), 
        .c      (metric_58  ), 
        .d      (metric_59  ), 
        .sa     (6'd56      ), 
        .sb     (6'd57      ), 
        .sc     (6'd58      ), 
        .sd     (6'd59      ), 
        .state  (state_14   ), 
        .max    (max_14     )
        ) ;        

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_15 (
        .clk    (clk        ),
        .a      (metric_60  ), 
        .b      (metric_61  ), 
        .c      (metric_62  ), 
        .d      (metric_63  ), 
        .sa     (6'd60      ), 
        .sb     (6'd61      ), 
        .sc     (6'd62      ), 
        .sd     (6'd63      ), 
        .state  (state_15    ), 
        .max    (max_15      )
        ) ;
        
//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_s1_0 (
        .clk    (clk        ),
        .a      (max_0      ), 
        .b      (max_1      ), 
        .c      (max_2      ), 
        .d      (max_3      ), 
        .sa     (state_0    ), 
        .sb     (state_1    ), 
        .sc     (state_2    ), 
        .sd     (state_3    ), 
        .state  (state_s1_0 ), 
        .max    (max_s1_0   )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_s1_1 (
        .clk    (clk        ),
        .a      (max_4      ), 
        .b      (max_5      ), 
        .c      (max_6      ), 
        .d      (max_7      ), 
        .sa     (state_4    ), 
        .sb     (state_5    ), 
        .sc     (state_6    ), 
        .sd     (state_7    ), 
        .state  (state_s1_1 ), 
        .max    (max_s1_1   )
        ) ;

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_s1_2 (
        .clk    (clk        ),
        .a      (max_8      ), 
        .b      (max_9      ), 
        .c      (max_10     ), 
        .d      (max_11     ), 
        .sa     (state_8    ), 
        .sb     (state_9    ), 
        .sc     (state_10   ), 
        .sd     (state_11   ), 
        .state  (state_s1_2 ), 
        .max    (max_s1_2   )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_s1_3 (
        .clk    (clk        ),
        .a      (max_12     ), 
        .b      (max_13     ), 
        .c      (max_14     ), 
        .d      (max_15     ), 
        .sa     (state_12   ), 
        .sb     (state_13   ), 
        .sc     (state_14   ), 
        .sd     (state_15   ), 
        .state  (state_s1_3 ), 
        .max    (max_s1_3   )
        ) ;

//==============================
// Get max metric
//==============================
max_metric_logic #(M, K) max_metric_s2_0 (
        .a      (max_s1_0    ), 
        .b      (max_s1_1    ), 
        .c      (max_s1_2    ), 
        .d      (max_s1_3    ), 
        .sa     (state_s1_0  ), 
        .sb     (state_s1_1  ), 
        .sc     (state_s1_2  ), 
        .sd     (state_s1_3  ), 
        .state  (state_s2_0  ), 
        .max    (            )
        ) ;

assign init_state_i = state_s2_0 ;

always @ (posedge clk)
  if(~nrst)
    trace_state <= 0 ;
  else
  begin
    if (trace_pos)
    begin
      if(zero_tail & trace2_s2)
        trace_state <= 0 ;
      else
        trace_state <= init_state_i ;
    end
    else if (trace_en)
      trace_state <= next_state ;
  end

assign  trace_start_pos = trace_start_wptr ;

assign trace_start_pos0 = trace_start_pos - trace_cnt ;
assign trace_start_pos1 = trace_start_pos - trace_cnt -1 ;

assign cur_state0 = trace_state ;

assign tran_all_0 = {
                     tran_state_63[trace_start_pos0], tran_state_62[trace_start_pos0], tran_state_61[trace_start_pos0], tran_state_60[trace_start_pos0], 
                     tran_state_59[trace_start_pos0], tran_state_58[trace_start_pos0], tran_state_57[trace_start_pos0], tran_state_56[trace_start_pos0], 
                     tran_state_55[trace_start_pos0], tran_state_54[trace_start_pos0], tran_state_53[trace_start_pos0], tran_state_52[trace_start_pos0], 
                     tran_state_51[trace_start_pos0], tran_state_50[trace_start_pos0], tran_state_49[trace_start_pos0], tran_state_48[trace_start_pos0],
                     
                     tran_state_47[trace_start_pos0], tran_state_46[trace_start_pos0], tran_state_45[trace_start_pos0], tran_state_44[trace_start_pos0], 
                     tran_state_43[trace_start_pos0], tran_state_42[trace_start_pos0], tran_state_41[trace_start_pos0], tran_state_40[trace_start_pos0], 
                     tran_state_39[trace_start_pos0], tran_state_38[trace_start_pos0], tran_state_37[trace_start_pos0], tran_state_36[trace_start_pos0], 
                     tran_state_35[trace_start_pos0], tran_state_34[trace_start_pos0], tran_state_33[trace_start_pos0], tran_state_32[trace_start_pos0],
                     
                     tran_state_31[trace_start_pos0], tran_state_30[trace_start_pos0], tran_state_29[trace_start_pos0], tran_state_28[trace_start_pos0], 
                     tran_state_27[trace_start_pos0], tran_state_26[trace_start_pos0], tran_state_25[trace_start_pos0], tran_state_24[trace_start_pos0], 
                     tran_state_23[trace_start_pos0], tran_state_22[trace_start_pos0], tran_state_21[trace_start_pos0], tran_state_20[trace_start_pos0], 
                     tran_state_19[trace_start_pos0], tran_state_18[trace_start_pos0], tran_state_17[trace_start_pos0], tran_state_16[trace_start_pos0],

                     tran_state_15[trace_start_pos0], tran_state_14[trace_start_pos0], tran_state_13[trace_start_pos0], tran_state_12[trace_start_pos0], 
                     tran_state_11[trace_start_pos0], tran_state_10[trace_start_pos0], tran_state_9[trace_start_pos0], tran_state_8[trace_start_pos0], 
                     tran_state_7[trace_start_pos0], tran_state_6[trace_start_pos0], tran_state_5[trace_start_pos0], tran_state_4[trace_start_pos0], 
                     tran_state_3[trace_start_pos0], tran_state_2[trace_start_pos0], tran_state_1[trace_start_pos0], tran_state_0[trace_start_pos0]} ;

assign tran_all_1 =  {
                     tran_state_63[trace_start_pos1], tran_state_62[trace_start_pos1], tran_state_61[trace_start_pos1], tran_state_60[trace_start_pos1], 
                     tran_state_59[trace_start_pos1], tran_state_58[trace_start_pos1], tran_state_57[trace_start_pos1], tran_state_56[trace_start_pos1], 
                     tran_state_55[trace_start_pos1], tran_state_54[trace_start_pos1], tran_state_53[trace_start_pos1], tran_state_52[trace_start_pos1], 
                     tran_state_51[trace_start_pos1], tran_state_50[trace_start_pos1], tran_state_49[trace_start_pos1], tran_state_48[trace_start_pos1],
                     
                     tran_state_47[trace_start_pos1], tran_state_46[trace_start_pos1], tran_state_45[trace_start_pos1], tran_state_44[trace_start_pos1], 
                     tran_state_43[trace_start_pos1], tran_state_42[trace_start_pos1], tran_state_41[trace_start_pos1], tran_state_40[trace_start_pos1], 
                     tran_state_39[trace_start_pos1], tran_state_38[trace_start_pos1], tran_state_37[trace_start_pos1], tran_state_36[trace_start_pos1], 
                     tran_state_35[trace_start_pos1], tran_state_34[trace_start_pos1], tran_state_33[trace_start_pos1], tran_state_32[trace_start_pos1],
                     
                     tran_state_31[trace_start_pos1], tran_state_30[trace_start_pos1], tran_state_29[trace_start_pos1], tran_state_28[trace_start_pos1], 
                     tran_state_27[trace_start_pos1], tran_state_26[trace_start_pos1], tran_state_25[trace_start_pos1], tran_state_24[trace_start_pos1], 
                     tran_state_23[trace_start_pos1], tran_state_22[trace_start_pos1], tran_state_21[trace_start_pos1], tran_state_20[trace_start_pos1], 
                     tran_state_19[trace_start_pos1], tran_state_18[trace_start_pos1], tran_state_17[trace_start_pos1], tran_state_16[trace_start_pos1],

                     tran_state_15[trace_start_pos1], tran_state_14[trace_start_pos1], tran_state_13[trace_start_pos1], tran_state_12[trace_start_pos1], 
                     tran_state_11[trace_start_pos1], tran_state_10[trace_start_pos1], tran_state_9[trace_start_pos1], tran_state_8[trace_start_pos1], 
                     tran_state_7[trace_start_pos1], tran_state_6[trace_start_pos1], tran_state_5[trace_start_pos1], tran_state_4[trace_start_pos1], 
                     tran_state_3[trace_start_pos1], tran_state_2[trace_start_pos1], tran_state_1[trace_start_pos1], tran_state_0[trace_start_pos1]} ;


assign cur_state1 = get_next_trace_state (cur_state0, tran_all_0) ;
assign next_state = get_next_trace_state (cur_state1, tran_all_1) ;

assign state0_bit = cur_state0 [K -2] ;
assign state1_bit = cur_state1 [K -2] ;

always @ (posedge clk)
  if(~nrst)
    res <= 0 ;
  else
  begin
    if (trace_pos)
      res <= 0 ;
    else if (trace_en)
    begin
      res <= {state1_bit, state0_bit, res [L-1:2]} ;
    end
  end

//======================================
// function: get_next_trace_state
//====================================== 
function [K-2:0] get_next_trace_state ;
input   [K-2:0]     cur_state_in ;
input   [N -1:0]    tran_state_in ;
reg     [N -1:0]    tmp ;
begin
  tmp = tran_state_in >> cur_state_in ;
  get_next_trace_state = {cur_state_in [K-3:0], tmp[0]} ;
end
endfunction

endmodule


//**************************************************************
// File:    max_metric_logic.v
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 1/14/07
// Des:     The top level of viterbi decoder
//          Take 5 bit soft value is [-16 : +15]
//          K = 7. g0 = 133, g1 = 171
// History: $ 1/14/07, Init coding
//          $ 1/22/07, K = 5, Zero latency
//          $ 12/1/07: Updated
//**************************************************************
module max_metric_logic (
    a       ,   // I, metric a
    b       ,   // I, metric b
    c       ,   // I, metric c
    d       ,   // I, metric d
    sa      ,   // I, state a
    sb      ,   // I, state b
    sc      ,   // I, state c
    sd      ,   // I, state d
    state   ,   // O, state
    max         // O, max metric
    ) ;
    
parameter   M = 7 ;
parameter   K = 7 ;

input   [M -1:0]    a ;
input   [M -1:0]    b ;
input   [M -1:0]    c ;
input   [M -1:0]    d ;

input   [K -2:0]    sa ;
input   [K -2:0]    sb ;
input   [K -2:0]    sc ;
input   [K -2:0]    sd ;

output  [K -2:0]    state ;
output  [M -1:0]    max ;

//==================================
//Internal signal
//==================================

reg     [K -2:0]    pos0 ;
reg     [K -2:0]    pos1 ;
reg     [M -1:0]    max0 ;
reg     [M -1:0]    max1 ;
reg     [M -1:0]    tmp ;
reg     [K -2:0]    state_i ;
reg     [M -1:0]    max_i ;

//==================================
// Main body of code
//==================================
assign state = state_i ;
assign max = max_i ;

always @*
begin  
  tmp = a-b ;
  if(~tmp[M -1])
  begin
    max0 = a ;
    pos0 = sa ;
  end
  else
  begin
    max0 = b ;
    pos0 = sb ;
  end

  tmp = c-d ;
  if(~tmp[M-1])
  begin
    max1 = c ;
    pos1 = sc ;
  end
  else
  begin
    max1 = d ;
    pos1 = sd ;
  end

  tmp = max0 - max1 ;
  if (~tmp[M-1])
  begin
    max_i = max0 ;
    state_i = pos0 ;
  end
  else
  begin
    state_i = pos1 ;
    max_i = max1 ;
  end
end

endmodule

//**************************************************************
// File:    max_metric
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 1/14/07
// Des:     Find max metric
//          K = 7. g0 = 133, g1 = 171
// History: $ 1/14/07, Init coding
//          $ 1/22/07, K = 5
//          $ 2/23/07, 1 pipeline
//          $ 12/1/07: updated
//**************************************************************
module max_metric (
    clk     ,   // I, clock
    a       ,   // I, metric a
    b       ,   // I, metric b
    c       ,   // I, metric c
    d       ,   // I, metric d
    sa      ,   // I, state a
    sb      ,   // I, state b
    sc      ,   // I, state c
    sd      ,   // I, state d
    state   ,   // O, state
    max         // O, max metric
    ) ;

parameter   M = 7 ;
parameter   K = 7 ;

input               clk ;
input   [M -1:0]    a ;
input   [M -1:0]    b ;
input   [M -1:0]    c ;
input   [M -1:0]    d ;

input   [K -2:0]    sa ;
input   [K -2:0]    sb ;
input   [K -2:0]    sc ;
input   [K -2:0]    sd ;

output  [K -2:0]    state ;
output  [M -1:0]    max ;

//=====================================
//Internal signal
//=====================================
reg     [K -2:0]    pos0 ;
reg     [K -2:0]    pos1 ;
reg     [M -1:0]    max0 ;
reg     [M -1:0]    max1 ;
reg     [M -1:0]    tmp ;
reg     [K -2:0]    state_i ;
reg     [M -1:0]    max_i ;
reg     [K -2:0]    state_reg ;
reg     [M -1:0]    max_reg ;

//=====================================
// Main RTL code
//=====================================
assign state = state_reg ;
assign max = max_reg ;

always @ (posedge clk)
begin
  state_reg <= state_i ;
  max_reg <= max_i ;
end

always @*
begin  
  tmp = a-b ;
  if(~tmp[M -1])
  begin
    max0 = a ;
    pos0 = sa ;
  end
  else
  begin
    max0 = b ;
    pos0 = sb ;
  end

  tmp = c-d ;
  if(~tmp[M-1])
  begin
    max1 = c ;
    pos1 = sc ;
  end
  else
  begin
    max1 = d ;
    pos1 = sd ;
  end

  tmp = max0 - max1 ;
  if (~tmp[M-1])
  begin
    max_i = max0 ;
    state_i = pos0 ;
  end
  else
  begin
    state_i = pos1 ;
    max_i = max1 ;
  end
end

endmodule
