function [mod_order, code_rate, N_CBPS, N_DBPS, valid] = signal_rate_decode_tx(signal_rate)

%Inputs:
% signal_rate: 4-bit RATE field from received SIGNAL field

%Outputs:
% mod_order: payload modulation order in bits-per-sym
%  ([1,2,4,6] for [BSPK,QPSK,16-QAM,64-QAM])
% code_rate: payload coding rate ([0,1,2] for [1/2, 2/3, 3/4])
% valid: 0 when signal_rate is not a valid 4-bit value

BPSK = 1;
QPSK = 2;
QAM16 = 4;
QAM64 = 6;

CODE12 = 0;
CODE23 = 1;
CODE34 = 2;

%Coded bits per OFDM symbol
% Depends only on modulation rate
N_CPBS_BPSK = 48;
N_CPBS_QPSK = 96;
N_CPBS_16QAM = 192;
N_CPBS_64QAM = 288;

%Data bits per OFDM symbol
% Depends on modulation and code rates
N_DBPS_BPSK12 = 24;
N_DBPS_BPSK34 = 36;
N_DBPS_QPSK12 = 48;
N_DBPS_QPSK34 = 72;
N_DBPS_16QAM12 = 96;
N_DBPS_16QAM34 = 144;
N_DBPS_64QAM23 = 192;
N_DBPS_64QAM34 = 216;

switch double(signal_rate)
    
    case 13 %bin2dec('1101')
        mod_order = BPSK;
        code_rate = CODE12;
        N_CBPS = N_CPBS_BPSK;
        N_DBPS = N_DBPS_BPSK12;
        valid = 1;
    case 15 %bin2dec('1111')
        mod_order = BPSK;
        code_rate = CODE34;
        N_CBPS = N_CPBS_BPSK;
        N_DBPS = N_DBPS_BPSK34;
        valid = 1;
    case 5 %bin2dec('0101')
        mod_order = QPSK;
        code_rate = CODE12;
        N_CBPS = N_CPBS_QPSK;
        N_DBPS = N_DBPS_QPSK12;
        valid = 1;
    case 7 %bin2dec('0111')
        mod_order = QPSK;
        code_rate = CODE34;
        N_CBPS = N_CPBS_QPSK;
        N_DBPS = N_DBPS_QPSK34;
        valid = 1;
    case 9 %bin2dec('1001')
        mod_order = QAM16;
        code_rate = CODE12;
        N_CBPS = N_CPBS_16QAM;
        N_DBPS = N_DBPS_16QAM12;
        valid = 1;
    case 11 %bin2dec('1011')
        mod_order = QAM16;
        code_rate = CODE34;
        N_CBPS = N_CPBS_16QAM;
        N_DBPS = N_DBPS_16QAM34;
        valid = 1;
    case 1 %bin2dec('0001')
        mod_order = QAM64;
        code_rate = CODE23;
        N_CBPS = N_CPBS_64QAM;
        N_DBPS = N_DBPS_64QAM23;
        valid = 1;
    case 3 %bin2dec('0011')
        mod_order = QAM64;
        code_rate = CODE34;
        N_CBPS = N_CPBS_64QAM;
        N_DBPS = N_DBPS_64QAM34;
        valid = 1;
    otherwise
        mod_order = BPSK;
        code_rate = CODE12;
        N_CBPS = N_CPBS_BPSK;
        N_DBPS = N_DBPS_BPSK12;
        valid = 0;
end %end switch
        
end %end function

