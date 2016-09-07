% Mango 802.11 Reference Design
% WLAN PHY Tx Init script
% Copyright 2014 Mango Communications
% Distributed under the Mango Research License:
% http://mangocomm.com/802.11/license

addpath('./util');
addpath('./mcode_blocks');

%Call util scripts to generate the interleaving permutation arrays
% and PHY preamble signals
wifi_permute_calc
PLCP_Preamble = PLCP_Preamble_gen;

%Define the 64-QAM interleave pattern. This uses the pattern from the standard
% modified to support the 1-to-8 aspect switch in the Tx interleaver dual-port
% RAM for 64-QAM. This adaptation is not required for the other mod schemes as
% their aspect switches are even powers of 2
interleave_64QAM_addr = interleave_64QAM + 2*floor(interleave_64QAM/6);

%Define sane values for maximum parameter values; these maximums define
% the bit widths of various signals throughout the design. Increasing
% these maximum values will increae resource usage in hardware.
MAX_NUM_BYTES = 4096;
MAX_NUM_SC = 64;
MAX_CP_LEN = 32;
MAX_NUM_SAMPS = 50e3;
MAX_NUM_SYMS = 600;

%%
%Define a few interesting MPDU payloads. These byte sequences start with
% the MAC header, followed by the MAC payload, followed by the FCS. The FCS
% is calculated and inserted by the PHY automatically, so 4 zeros are defined
% as placeholders in each byte sequence below.

%Null data frame:
% Frame Control field: 0x4811
% Duration: 0x2c00 (44 usec)
% Receiver address:    40-d8-55-04-21-4a
% Transmitter address: 40-d8-55-04-21-5a
% Destination address: 40-d8-55-04-21-4a
% Fragment/Seq Num field: 0xf092
% FCS placeholder: 0x00000000
MPDU_Null_Data = sscanf('48 11 2c 00 40 d8 55 04 21 4a 40 d8 55 04 21 5a 40 d8 55 04 21 4a f0 92 00 00 00 00', '%02x');

%Data frames:
% Frame Control field: 0x0801
% Duration: 0x2c00 (44 usec)
% Receiver address:    40-d8-55-04-21-4a
% Transmitter address: 40-d8-55-04-21-5a
% Destination address: 40-d8-55-04-21-6a
% Fragment/Seq Num field: 0xb090
% LLC header: aa-aa-03-00-00-00-08-00
% Arbitrary payload: 00-01-02...0f
% FCS placeholder: 0x00000000

%Short pkt - 16 payload bytes
MPDU_Data_short = sscanf(['08 01 2c 00 40 d8 55 04 21 4a 40 d8 55 04 21 5a 40 d8 55 04 21 6a b0 90 aa aa 03 00 00 00 08 00 ' sprintf('%02x ', [0:15]) ' 00 00 00 00'], '%02x');

%Long pkt - 1420 payload bytes
MPDU_Data_long = sscanf(['08 01 2c 00 40 d8 55 04 21 4a 40 d8 55 04 21 5a 40 d8 55 04 21 6a b0 90 aa aa 03 00 00 00 08 00 ' sprintf('%02x ', mod([1:1420], 256)) ' 00 00 00 00'], '%02x');

%ACK frame:
% Frame Control field: 0xd400
% Duration: 0x0000 (0 usec)
% Receiver address: 40-d8-55-04-21-4a
% FCS placeholder: 0x00000000
ControlFrame_ACK = sscanf('d4 00 00 00 40 d8 55 04 21 4a 00 00 00 00', '%02x');

%Choose a payload for simulation
%Pkt_Payload = MPDU_Null_Data;
%Pkt_Payload = MPDU_Data_short;
Pkt_Payload = MPDU_Data_long;
%Pkt_Payload = ControlFrame_ACK;

Pkt_len = length(Pkt_Payload);

%Reshape byte vector to u32 vector, necessary to initialize the 32-bit BRAM
% in the simulation
Pkt_Payload = [Pkt_Payload zeros(1,-mod(Pkt_len, -4))];
Pkt_Payload4 = reshape(Pkt_Payload, 4, Pkt_len/4);
Pkt_Payload_words = sum(Pkt_Payload4 .* repmat(2.^[0:8:24]', 1, size(Pkt_Payload4,2)));

PPDU_words = zeros(1, MAX_NUM_BYTES/4);

%Select the Tx rate in Mbps - must be one of the supported rates
Tx_Rate = 54;

%Choose a modulation/coding rate and insert SIGNAL field in first 3 bytes
switch Tx_Rate
    case 6
        PPDU_words(1) = tx_signal_calc(Pkt_len, 1, 0); %BPSK 1/2
    case 9
        PPDU_words(1) = tx_signal_calc(Pkt_len, 1, 1); %BPSK 3/4
    case 12
        PPDU_words(1) = tx_signal_calc(Pkt_len, 2, 0); %QPSK 1/2
    case 18
        PPDU_words(1) = tx_signal_calc(Pkt_len, 2, 1); %QPSK 3/4
    case 24
        PPDU_words(1) = tx_signal_calc(Pkt_len, 4, 0); %16QAM 1/2
    case 36
        PPDU_words(1) = tx_signal_calc(Pkt_len, 4, 1); %16QAM 3/4
    case 48
        PPDU_words(1) = tx_signal_calc(Pkt_len, 6, 0); %64QAM 2/3
    case 54
        PPDU_words(1) = tx_signal_calc(Pkt_len, 6, 1); %64QAM 3/4
    otherwise
        error('Invalid value for Tx_Rate!')
end

%Insert SERVICE field (always 0)
PPDU_words(2) = 0;

%Populate payload after with the MPDU
PPDU_words(2+[1:length(Pkt_Payload_words)]) = Pkt_Payload_words;

%Calculate the approximate Tx duration and set the simulation time
% Preamble time, SIGNAL field time, data time, 1 OFDM symbol padding
Tx_Time_usec = ceil(16 + 4 + 32*length(Pkt_Payload_words) / Tx_Rate + 4);
Sim_Tx_Start_Period = 1*(160 * Tx_Time_usec) + 2e3; %Padding, convert to 160MHz clock cycles

%Set the simulation time as a multiple of whole packet durations (1 by default)
Sim_Time = 1 * Sim_Tx_Start_Period;

%%

%Define sane initial value for SIGNAL field register
% The register takes this value on reset; it must be a valid SIGNAL value
% to avoid asserting an error in between packet transmissions
% Sysgen regs require init values of double data type
TX_SIGNAL_INIT_VALUE = double(tx_signal_calc(24, 1, 0));

%Define the complex-valued sequence for the preamble ROMs
Preamble_IQ = PLCP_Preamble.Preamble_t;

%Define the data-bearing subcarriers
sc_ind_data = [2:7 9:21 23:27 39:43 45:57 59:64];

%Initialize a vector defining the subcarrier map
% This vector is used by the interleaver control logic to select which
% subcarriers carry data symbols. A value of MAX_NUM_SC tells the hardware to
% not use the subcarrier for data. Any other value is a subcarrier index,
% starting at 0, and will instruct the hardware to use that subcarrier for
% a data symbol.
sc_data_sym_map = MAX_NUM_SC*ones(1,64);
sc_data_sym_map(sc_ind_data) = fftshift(0:length(sc_ind_data)-1);

%% Register Init

%Sane initial values for PHY config registers. These values will be overwritten
% at run-time by the software in CPU Low
PHY_CONFIG_NUM_SC = 64;
PHY_CONFIG_CP_LEN = 16;
PHY_CONFIG_FFT_SCALING = bin2dec('101010');
PHY_TX_ACTIVE_EXTENSION = 120;
PHY_TX_RF_EN_EXTENSION = 50;

REG_Tx_Timing = ...
    2^0  * (PHY_TX_ACTIVE_EXTENSION) + ... %b[7:0]
    2^8  * (PHY_TX_RF_EN_EXTENSION) + ... %b[15:8]
    0;

REG_TX_FFT_Config = ...
    2^0  * (PHY_CONFIG_NUM_SC) +...  %b[7:0]
    2^8  * (PHY_CONFIG_CP_LEN) +...  %b[15:8]
    2^24 * (PHY_CONFIG_FFT_SCALING) + ... b[29:24]
    0;

REG_TX_Config = ...
    2^0  * 1 + ... %Force RxEN to radio_controller
    2^1  * 0 + ... %Reset scrambler per pkt
    2^2  * 1 + ... %Enable Tx on RF A
    2^3  * 0 + ... %Enable Tx on RF B
    2^4  * 0 + ... %Enable Tx on RF C
    2^5  * 0 + ... %Enable Tx on RF D
    2^6  * 1 + ... %Use ant mask from MAC hw port
    2^8  * 2 + ... %Max pkt length (SIGNAL.LENGTH max) in kB (UFix4_0)
    0;

REG_TX_PKT_BUF_SEL = ...
    2^0  * 0  + ... %b[3:0] pkt buf index
    2^4  * 32 + ... %b[9:4] timestamp insert start byte
    2^10 * 31 + ... %b[15:10] timestamp insert end byte
    2^16 * 0  + ... %b[23:16] pkt buf address offset
    0;

REG_TX_Output_Scaling = (2.5 * 2^12) + (2^16 * 2.5 * 2^12); %UFix16_12 values


%% Cyclic Redundancy Check parameters
CRCPolynomial32 = hex2dec('04c11db7'); %CRC-32
CRC_Table32 = CRC_table_gen(CRCPolynomial32, 32);

%% Constellation params

%Common scaling for preamble and all constellations that keeps all points within
% numeric range of Fix16_15 values at input to IFFT
ALL_MOD_SCALING = ( 1.0 - (2^-15) )/(7/sqrt(42));
Preamble_IQ_scaled = ALL_MOD_SCALING * Preamble_IQ;

Mod_Constellation_BPSK(1) = ALL_MOD_SCALING * -1;
Mod_Constellation_BPSK(2) = ALL_MOD_SCALING *  1;

Mod_Constellation_QPSK(1) = ALL_MOD_SCALING * -1/sqrt(2);
Mod_Constellation_QPSK(2) = ALL_MOD_SCALING *  1/sqrt(2);

Mod_Constellation_16QAM(1) = ALL_MOD_SCALING * -3/sqrt(10);
Mod_Constellation_16QAM(2) = ALL_MOD_SCALING * -1/sqrt(10);
Mod_Constellation_16QAM(3) = ALL_MOD_SCALING *  3/sqrt(10);
Mod_Constellation_16QAM(4) = ALL_MOD_SCALING *  1/sqrt(10);

Mod_Constellation_64QAM(1) = ALL_MOD_SCALING * -7/sqrt(42);
Mod_Constellation_64QAM(2) = ALL_MOD_SCALING * -5/sqrt(42);
Mod_Constellation_64QAM(3) = ALL_MOD_SCALING * -1/sqrt(42);
Mod_Constellation_64QAM(4) = ALL_MOD_SCALING * -3/sqrt(42);
Mod_Constellation_64QAM(5) = ALL_MOD_SCALING *  7/sqrt(42);
Mod_Constellation_64QAM(6) = ALL_MOD_SCALING *  5/sqrt(42);
Mod_Constellation_64QAM(7) = ALL_MOD_SCALING *  1/sqrt(42);
Mod_Constellation_64QAM(8) = ALL_MOD_SCALING *  3/sqrt(42);

