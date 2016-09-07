function SIGNAL_u32 = tx_signal_calc(length, mod_order, code_rate)

switch(sprintf('%d %d', mod_order, code_rate))
    case '1 0' %BPSK 1/2
        RATE = uint8(11); %1101 -> 1011
    case '1 1' %BPSK 3/4
        RATE = uint8(15); %1111 -> 1111
    case '2 0' %QPSK 1/2
        RATE = uint8(10); %0101 -> 1010
    case '2 1' %QPSK 3/4
        RATE = uint8(14); %0111 -> 1110
    case '4 0' %16QAM 1/2
        RATE = uint8(9); %1001 -> 1001
    case '4 1' %16QAM 3/4
        RATE = uint8(13); %1011 -> 1101
    case '6 0' %64QAM 2/3
        RATE = uint8(8); %0001 -> 1000
    case '6 1' %64QAM 3/4
        RATE = uint8(12); %0011 -> 1100
    otherwise
        error('Invalid mod_order or code_rate');
end

length_u = bitand(uint16(length), hex2dec('fff'));

length_2to0 = uint8(bitand(length_u, 7));
length_10to3 = uint8(bitand(bitshift(length_u, -3), 255));
length_msb = uint8(bitshift(length_u, -11));

parity = mod(sum(sum(dec2bin([uint32(length_u) uint32(RATE)]) == '1')), 2);

b0 = bitor(RATE, bitshift(length_2to0, 5));
b1 = length_10to3;
b2 = bitor(length_msb, bitshift(parity, 1));

SIGNAL_u32 = uint32(b0) + uint32(b1)*2^8 + uint32(b2)*2^16;
end
