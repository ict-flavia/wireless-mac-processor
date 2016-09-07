function CRC_Table = CRC_table_gen(CRCPolynomial, bitLen)
%Calculates table of polynomial remainders for CRC computation
%Based on example code at http://www.netrino.com/Embedded-Systems/How-To/CRC-Calculation-C-Code

if(bitLen > 32 | bitLen < 1)
	error('bitLen must be in [1,32]');
end

crc_accum = 0;

for n=0:255
	crc_accum = bitshift(n,(bitLen-8),bitLen);

	for m=0:7
		x = bitshift(crc_accum, 1, bitLen);
		if(crc_accum >= 2^(bitLen-1))
			crc_accum = bitxor(x, CRCPolynomial);
		else
			crc_accum = x;
		end
	end

	CRC_Table(n+1) = crc_accum;
end
