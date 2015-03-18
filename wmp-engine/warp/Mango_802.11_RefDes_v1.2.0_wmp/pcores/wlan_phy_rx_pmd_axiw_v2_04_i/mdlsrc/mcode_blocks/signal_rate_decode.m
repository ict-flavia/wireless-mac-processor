function [mod_order, code_rate, valid, supported, N_DBPS] = signal_rate_decode(signal_rate)

%Inputs:
% signal_rate: 4-bit RATE field from received SIGNAL field

%Outputs:
% mod_order: payload modulation order in bits-per-sym
%  ([1,2,4,6] for [BSPK,QPSK,16-QAM,64-QAM])
% code_rate: payload coding rate ([0,1,2] for [1/2, 2/3, 3/4])
% valid: 0 when signal_rate is not a valid 4-bit value
% supported: 0 when this PHY can't decode the otherwise-valid RATE
% N_DBPS: num data bits per OFDM symbol

%Mod rates as selection indices
% (helpfully equal to (bits-per-sym>>1))
BPSK = 0;
QPSK = 1;
QAM16 = 2;
QAM64 = 3;

CODE12 = 0;
CODE23 = 1;
CODE34 = 2;

switch double(signal_rate)
    
    case 11 %13 %bin2dec('1101')
        mod_order = BPSK;
        code_rate = CODE12;
        valid = 1;
        supported = 1;
        N_DBPS = 24;
    case 15 %bin2dec('1111')
        mod_order = BPSK;
        code_rate = CODE34;
        valid = 1;
        supported = 1;
        N_DBPS = 36;
    case 10 %5 %bin2dec('0101')
        mod_order = QPSK;
        code_rate = CODE12;
        valid = 1;
        supported = 1;
        N_DBPS = 48;
    case 14 %7 %bin2dec('0111')
        mod_order = QPSK;
        code_rate = CODE34;
        valid = 1;
        supported = 1;
        N_DBPS = 72;
    case 9 %bin2dec('1001')
        mod_order = QAM16;
        code_rate = CODE12;
        valid = 1;
        supported = 1;
        N_DBPS = 96;
    case 13 %11 %bin2dec('1011')
        mod_order = QAM16;
        code_rate = CODE34;
        valid = 1;
        supported = 1;
        N_DBPS = 144;
    case 8 %1 %bin2dec('0001')
        mod_order = QAM64;
        code_rate = CODE23;
        valid = 1;
        supported = 1;
        N_DBPS = 192;
    case 12 %3 %bin2dec('0011')
        mod_order = QAM64;
        code_rate = CODE34;
        valid = 1;
        supported = 1;
        N_DBPS = 216;
    otherwise
        mod_order = BPSK;
        code_rate = CODE12;
        valid = 0;
        supported = 0;
        N_DBPS = 24;
end %end switch
        
end %end function

