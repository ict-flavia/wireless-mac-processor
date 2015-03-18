function no_errors = check_80211_fcs(thePacketBytes)
%Based on the C code example at:
%http://www.netrino.com/Embedded-Systems/How-To/CRC-Calculation-C-Code
%Uses slightly modified version of CRC-32:
% No output XOR
% No bit-order swapping on message or digest bytes

%%% Modified from WARP OFDM ref design version, to comply with
% normal CRC32 (no idea why I changed from CRC32 for the WARP PHY...)

CRCPolynomial = hex2dec('04c11db7');
CRC_Table = CRC_table_gen(CRCPolynomial, 32);

init_crc = hex2dec('ffffffff');
myData = thePacketBytes;
%de2bi(49,'left-msb',8))
crc_accum = init_crc;
for n=1:length(myData)
	x = bitshift(crc_accum,-24,32);
%CRC32 would swap bit order here:
	x = bitxor(x, bi2de( de2bi(myData(n),'left-msb',8)));
%	x = bitxor(x, myData(n));
	x = bitand(x,hex2dec('ff'));
	crc_accum = bitxor(bitshift(crc_accum,8,32),CRC_Table(x+1));
end

CRC32 = crc_accum;


if(CRC32 == hex2dec('C704DD7B'))
    no_errors = 1;
else
    no_errors = 0;
end
