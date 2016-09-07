% Mango 802.11 Reference Design
% WLAN PHY Rx Init script
% Copyright 2014 Mango Communications
% Distributed under the Mango Research License:
% http://mangocomm.com/802.11/license

addpath('./util');
addpath('./mcode_blocks');
addpath('./blackboxes');

%Call util scripts to generate the PHY preamble signals
PLCP_Preamble = PLCP_Preamble_gen;

%% Define an input signal for simulation

%---------
%PHY debugging with ChipScope captures of I/Q
% ChipScope waveforms must be saved in ASCII format with (at least) ADC_I and ADC_Q signals
%xlLoadChipScopeData('cs_capt/ofdm_rx_signal.prn'); cs_interp = 1; cs_start = 1; cs_end = length(ADC_I);
%rx_sim_sig_adc_IQ = complex(ADC_I([cs_start:cs_interp:cs_end]), ADC_Q(cs_start:cs_interp:cs_end));
%rx_sim_sig_adc_IQ = [zeros(50,1); rx_sim_sig_adc_IQ; zeros(1000,1);];
%rx_sim_sig_samp_time = 8;

%Output of PHY Tx simulation
% .mat files from Tx PHY sim store I/Q signal in 'wlan_tx_out' variable
load('rx_sigs/wlan_tx_sig_Data_16Byte_Payload_6Mbps.mat'); tx_sig_t = [1:length(wlan_tx_out)];
rx_sim_sig_adc_IQ = [zeros(50,1); wlan_tx_out(tx_sig_t); zeros(500,1); ];
rx_sim_sig_samp_time = 8;

%Set simulation time to just long enough for the input waveform
rx_sim_time = rx_sim_sig_samp_time*length(rx_sim_sig_adc_IQ) + 500;

%Define contents of "From Workspace" block driving ADC inputs in simulation
rx_sim_sig_adc_I.time = [];
rx_sim_sig_adc_Q.time = [];
rx_sim_sig_adc_I.signals.values = real(rx_sim_sig_adc_IQ);
rx_sim_sig_adc_Q.signals.values = imag(rx_sim_sig_adc_IQ);

%%

% DSSS de-spreading sequence - interpolated version of 11-chip sequence defined in the spec
barker_seq20 = [1.29007 1.04043 1.20873 -0.32809 -1.55859 0.69252 1.62682 0.54184 1.06449 1.40040 0.11423 -1.20708 -1.26002 -0.54425 -1.31058 -1.27990 1.38940 0.97934 -1.65552 -0.38597];
barker_seq20 = 0.95 * circshift(barker_seq20, [0 4]) ./ max(abs(barker_seq20));

%Fixed PHY parameters - these values affect data types throughout the design
MAX_NUM_SC = 64;
MAX_CP_LEN = 32;
MAX_NUM_SAMPS = 50e3;
MAX_NUM_SYMS = 600;
MAX_NUM_BYTES = 4096;

%PHY params - used as default values in registers
PHY_CONFIG_NUM_SC = 64;
PHY_CONFIG_CP_LEN = 16;
PHY_CONFIG_FFT_OFFSET = 3;% 1 = no CP samples into FFT (5=zero actual offset)
PHY_CONFIG_CFO_EST_OFFSET = 0;
PHY_CONFIG_FFT_SCALING = bin2dec('000101');

%% Define the LTS correlation coefficients

% Rx PHY uses Fix3_0 to store coefficients
longCorr_coef_nbits = 3;
longCorr_coef_bp = 0;
long_cor_acc_n_bits = 6 * 2;

%Scale, conjugate and time-reverse the standard LTS
longCorr_coef = fliplr(conj(PLCP_Preamble.LTS_t./max(abs(PLCP_Preamble.LTS_t))));

longCorr_coef_i = [3*real(longCorr_coef)];
longCorr_coef_q = [3*imag(longCorr_coef)];


%Define the size of the circular sample buffer before the FFT
% This buffer must be large enough to hold the full LTS section of the
% preamble plus enough post-preamble samples to acommodate the latency
% of the FFT taking the transforms of the LTS. 4*lengh(LTS) is enough
% for the standard preamble and 64 subcarriers
preFFT_sampBuff_numSamps = 4*MAX_NUM_SC;

%Define the frequency-domain training symbol coefficients
% sign() here stores +/-1 (LTS is BPSK in freq domain) for smaller memory in  hardware
train_sym_f = sign(PLCP_Preamble.LTS_f);

%Initialize a vector defining the subcarrier map
% This vector is used by the interleaver control logic to select which
% subcarriers carry data symbols. A value of MAX_NUM_SC tells the hardware to
% not use the subcarrier for data.
sc_ind_data = [2:7 9:21 23:27 39:43 45:57 59:64];
sc_data_sym_map = MAX_NUM_SC*ones(1,MAX_NUM_SC);
sc_data_sym_map(sc_ind_data) = fftshift(0:47);

%Register init
PHY_CONFIG_RSSI_SUM_LEN = 8;

PHY_MIN_PKT_LEN = 14;

PHY_CONFIG_LTS_CORR_THRESH_LOWSNR = 10e3; %FIXME back to 10e3!
PHY_CONFIG_LTS_CORR_THRESH_HIGHSNR = 10e3; %FIXME back to 10e3!
PHY_CONFIG_LTS_CORR_RSSI_THRESH = PHY_CONFIG_RSSI_SUM_LEN*400;

PHY_CONFIG_LTS_CORR_TIMEOUT = 250;%150;%*2 in hardware

PHY_CONFIG_PKT_DET_CORR_THRESH = (0.75) * 2^8; %UFix8_8 threshold

PHY_CONFIG_PKT_DET_DSSS_MIN_ONES = 30;
PHY_CONFIG_PKT_DET_DSSS_MIN_ONES_TOT = 40;

%Good defaults for hw
PHY_CONFIG_PKT_DET_CORR_THRESH_DSSS = 1.5 * 2^6;%hex2dec('FF');%(1) * 2^7;
PHY_CONFIG_PKT_DET_ENERGY_THRESH_DSSS = 400;%hex2dec('3FF');%(20) * 2^4; %UFix10_0

%For sim testing with signal captured post-AGC
%PHY_CONFIG_PKT_DET_CORR_THRESH_DSSS = 1.0 * 2^6;%hex2dec('FF');%(1) * 2^7;
%PHY_CONFIG_PKT_DET_ENERGY_THRESH_DSSS = 0;%hex2dec('3FF');%(20) * 2^4; %UFix10_0


PHY_CONFIG_PKT_DET_ENERGY_THRESH = 1; %UFix14_4 thresh; set to low non-zero value
PHY_CONFIG_PKT_DET_MIN_DURR = 4; %UFix4_0 duration
PHY_CONFIG_PKT_DET_RESET_EXT_DUR = hex2dec('3F');

CS_CONFIG_CS_RSSI_THRESH = 300 * PHY_CONFIG_RSSI_SUM_LEN;
CS_CONFIG_POSTRX_EXTENSION = 120; %6usec as 120 20MHz samples

SOFT_DEMAP_SCALE_QPSK = 6;
SOFT_DEMAP_SCALE_16QAM = 16;
SOFT_DEMAP_SCALE_64QAM = 16;

REG_RX_PktDet_AutoCorr_Config = ...
    2^0  *  (PHY_CONFIG_PKT_DET_CORR_THRESH) +...%b[7:0] UFix8_8
    2^8  *  (PHY_CONFIG_PKT_DET_ENERGY_THRESH) +...%b[21:8] UFix14_8
    2^22 *  (PHY_CONFIG_PKT_DET_MIN_DURR) +...%b[25:22]
    2^26 *  (PHY_CONFIG_PKT_DET_RESET_EXT_DUR) + ...%b[31:26]
    0;

REG_RX_LTS_Corr_Thresh = ...
    2^0  *  (PHY_CONFIG_LTS_CORR_THRESH_LOWSNR) +... %b[15:0]
    2^16  * (PHY_CONFIG_LTS_CORR_THRESH_HIGHSNR) +... %b[31:16]
    0;

REG_RX_LTS_Corr_Confg = ...
    2^0 *  (PHY_CONFIG_LTS_CORR_TIMEOUT) + ... %b[7:0]
    2^8 *  (PHY_CONFIG_LTS_CORR_RSSI_THRESH) + ... %b[23:8]
    0;

REG_RX_FFT_Config = ...
    2^0  * (PHY_CONFIG_NUM_SC) +...  %b[7:0]
    2^8  * (PHY_CONFIG_CP_LEN) +...  %b[15:8]
    2^16 * (PHY_CONFIG_FFT_OFFSET) +...  %b[23:16]
    2^24 * (PHY_CONFIG_FFT_SCALING) + ... b[29:24]
    0;

REG_RX_Control = ...
    2^0 * 0 + ... %b[0]: Global Reset
    2^1 * 0 + ... %b[1]: Pkt done latch reset
    0;

REG_RX_Config = ...
    2^0  * 1 + ... %DSSS RX EN
    2^1  * 1 + ... %Block inputs on INVALID input
    2^2  * 1 + ... %Swap pkt buf byte order
    2^3  * 1 + ... %Swap order of chan est u32 writes
    2^4  * 1 + ... %Allow DSSS Rx to keep AGC locked
    2^5  * 0 + ... %Bypass CFO est/correction
    2^6  * 1 + ... %Enable chan est recording to pkt buf
    2^7  * 0 + ... %Enable switching diversity
    2^8  * 1 + ... %Block DSSS Rx until AGC is settled
    2^9  * 1 + ... %Enable pkt det on Ant A
    2^10 * 0 + ... %Enable pkt det on Ant B
    2^11 * 0 + ... %Enable pkt det on Ant C
    2^12 * 0 + ... %Enable pkt det on Ant D
    2^13 * 0 + ... %Enable ext pkt det
    2^14 * 0 + ... %PHY CCA mode (0=any, 1=all)
    2^15 * 0 + ... %Manual ant sel when sel div disabled (2-bits, 00=RFA)
    2^17 * 2 + ... %Max SIGNAL.LENGTH value, in kB (UFix4_0)
    0;

REG_RX_DSSS_RX_CONFIG = ...
    2^0  * (hex2dec('20')) + ... %b[11:0]: Code Thresh UFix12_4
    2^12 * (7) + ... %b[16:12]: Depsread delay (UFix5_0)
    2^24 * 140 + ... %b[31:24]: Bits to SFD timeout
    0;

REG_RX_PktDet_DSSS_Config = ...
    2^0  *  (PHY_CONFIG_PKT_DET_CORR_THRESH_DSSS) +...  %b[7:0] UFix8_7
    2^8  *  (PHY_CONFIG_PKT_DET_ENERGY_THRESH_DSSS) +...%b[17:8] UFix10_4
    2^18 *  (PHY_CONFIG_PKT_DET_DSSS_MIN_ONES) + ...    %b[24:18] UFix7_0
    2^25 *  (PHY_CONFIG_PKT_DET_DSSS_MIN_ONES_TOT) + ...%b[31:25] UFix7_0
    0;

REG_RX_PKTDET_RSSI_CONFIG = ...
    2^0 * (PHY_CONFIG_RSSI_SUM_LEN) + ... %b[4:0]: RSSI sum len
    2^5 * (300*8) + ... %b[19:5]: RSSI thresh
    2^20 * (4) + ... %b[24:20]: Min duration
    0;

REG_RX_CCA_CONFIG = ...
    2^0 *  (CS_CONFIG_CS_RSSI_THRESH) + ... %b[15:0]
    2^16 * (CS_CONFIG_POSTRX_EXTENSION) + ... %b[23:16]
    0;

REG_RX_PktBuf_Sel = ...
    2^0 *  0 + ... %b[3:0]: OFDM Pkt Buf
    2^8 *  0 + ... %b[11:8]: DSSS Pkt Buf
    2^16 * 0 + ... %b[23:16]: Pkt buf offset for Rx bytes (u64 words)
    2^24 * (8/8) + ... %b[31:24]: Pkt buf offset for chan est (u64 words)
    0;

REG_RX_FEC_Config = ...
    2^0  * (SOFT_DEMAP_SCALE_QPSK) + ...
    2^5  * (SOFT_DEMAP_SCALE_16QAM) + ...
    2^10 * (SOFT_DEMAP_SCALE_64QAM) + ...
    0;

REG_RX_PKT_BUF_Max_Write_Addr = 3800;

%%
bit_scrambler_lfsr = ones(1,7);
bit_scrambler_lfsr_states = zeros(127, 7);
scr = zeros(1,127);
for ii=1:127
    bit_scrambler_lfsr_states(ii, :) = bit_scrambler_lfsr;

    %LFSR polynomial: x^7 + x^4 + 1
    x = xor(bit_scrambler_lfsr(4), bit_scrambler_lfsr(7));
    bit_scrambler_lfsr = [x bit_scrambler_lfsr(1:6)];

    scr(ii) = x;
end

%Convert bitwise descrambler states to bytewise descramber states
bit_scrambler_lfsr_bytes = bi2de(reshape(repmat(scr, 1, 8), 8, 127)', 'left-msb');

%Generate the vector of addresses for the bytewise descramber ROM
scr = [scr scr(1:10)];
scr_ind_rev = zeros(1,128);
for ii=1:127
    scr_ind_rev(1 + bi2de(scr(ii:ii+6))) = ii - 1;
end
clear scr x bit_scrambler_lfsr ii

%% Cyclic Redundancy Check parameters
CRCPolynomial32 = hex2dec('04c11db7'); %CRC-32
CRC_Table32 = CRC_table_gen(CRCPolynomial32, 32);

%% Calculate de-interleaving vectors
NCBPS_BPSK = 48;
NCBPS_QPSK = 96;
NCBPS_16QAM = 192;
NCBPS_64QAM = 288;

%Max bits-per-symbol determines size of de-interleaver RAM
MAX_NCBPS = NCBPS_64QAM;

NDBPS_BPSK12 = 24;
NDBPS_BPSK34 = 36;
NDBPS_QPSK12 = 48;
NDBPS_QPSK34 = 72;
NDBPS_16QAM12 = 96;
NDBPS_16QAM34 = 144;
NDBPS_64QAM23 = 192;
NDBPS_64QAM34 = 216;

% BPSK
N_CBPS = 48;
N_BPSC = 1;
s = max(N_BPSC/2, 1);

%Interleaver (k=src bit index -> j=dest bit index)
k = 0:N_CBPS-1;
i = (N_CBPS/16) .* mod(k,16) + floor(k/16);
%BPSK doesn't need j

interleave_BPSK = i;
clear N_CBPS N_BPSC s k i

% QPSK
N_CBPS = 96;
N_BPSC = 2;
s = max(N_BPSC/2, 1);

k = 0:N_CBPS-1;
i = (N_CBPS/16) .* mod(k,16) + floor(k/16);
j = s * floor(i/s) + mod( (i + N_CBPS - floor(16*i/N_CBPS)), s);
interleave_QPSK = j;
clear N_CBPS N_BPSC s k i j

% 16-QAM
N_CBPS = 192;
N_BPSC = 4;
s = max(N_BPSC/2, 1);

k = 0:N_CBPS-1;
i = (N_CBPS/16) .* mod(k,16) + floor(k/16);
j = s * floor(i/s) + mod( (i + N_CBPS - floor(16*i/N_CBPS)), s);
interleave_16QAM = j;
clear N_CBPS N_BPSC s k i j

% 64-QAM
N_CBPS = 288;
N_BPSC = 6;
s = max(N_BPSC/2, 1);

k = 0:N_CBPS-1;
i = (N_CBPS/16) .* mod(k,16) + floor(k/16);
j = s * floor(i/s) + mod( (i + N_CBPS - floor(16*i/N_CBPS)), s);
interleave_64QAM = j;
clear N_CBPS N_BPSC s k i j

%FFT Shift
interleave_BPSK = mod(interleave_BPSK + (NCBPS_BPSK/2), NCBPS_BPSK);
interleave_QPSK = mod(interleave_QPSK + (NCBPS_QPSK/2), NCBPS_QPSK);
interleave_16QAM = mod(interleave_16QAM + (NCBPS_16QAM/2), NCBPS_16QAM);
interleave_64QAM = mod(interleave_64QAM + (NCBPS_64QAM/2), NCBPS_64QAM);

%De-interleaver ROM contents - one ROM used for all rates
deinterleave_ROM = [];
deinterleave_ROM = [deinterleave_ROM interleave_BPSK zeros(1, 512-length(interleave_BPSK))];
deinterleave_ROM = [deinterleave_ROM interleave_QPSK zeros(1, 512-length(interleave_QPSK))];
deinterleave_ROM = [deinterleave_ROM interleave_16QAM zeros(1, 512-length(interleave_16QAM))];
deinterleave_ROM = [deinterleave_ROM interleave_64QAM zeros(1, 512-length(interleave_64QAM))];
