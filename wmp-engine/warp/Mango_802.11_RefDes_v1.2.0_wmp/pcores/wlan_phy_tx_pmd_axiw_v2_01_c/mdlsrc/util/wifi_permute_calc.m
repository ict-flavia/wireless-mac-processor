

%% BPSK
N_CBPS = 48;
N_BPSC = 1;
s = max(N_BPSC/2, 1);

%Interleaver (k=src bit index -> j=dest bit index)
k = 0:N_CBPS-1;
i = (N_CBPS/16) .* mod(k,16) + floor(k/16);
%BPSK doesn't need j

interleave_bpsk = i;

%De-interleaver (j=src bit index -> k=dest bit index)
j = 0:N_CBPS-1;
i = s * floor(j/s) + mod( (j+floor(16*j/N_CBPS)), s);
k = 16*i - (N_CBPS-1)*floor(16*i/N_CBPS);
deinterleave_bpsk = k;

%% QPSK
N_CBPS = 96;
N_BPSC = 2;
s = max(N_BPSC/2, 1);

k = 0:N_CBPS-1;
i = (N_CBPS/16) .* mod(k,16) + floor(k/16);
j = s * floor(i/s) + mod( (i + N_CBPS - floor(16*i/N_CBPS)), s);
interleave_QPSK = j;

%De-interleaver (j=src bit index -> k=dest bit index)
j = 0:N_CBPS-1;
i = s * floor(j/s) + mod( (j+floor(16*j/N_CBPS)), s);
k = 16*i - (N_CBPS-1)*floor(16*i/N_CBPS);
deinterleave_QPSK = k;

%% 16-QAM
N_CBPS = 192;
N_BPSC = 4;
s = max(N_BPSC/2, 1);

k = 0:N_CBPS-1;
i = (N_CBPS/16) .* mod(k,16) + floor(k/16);
j = s * floor(i/s) + mod( (i + N_CBPS - floor(16*i/N_CBPS)), s);
interleave_16QAM = j;

%De-interleaver (j=src bit index -> k=dest bit index)
j = 0:N_CBPS-1;
i = s * floor(j/s) + mod( (j+floor(16*j/N_CBPS)), s);
k = 16*i - (N_CBPS-1)*floor(16*i/N_CBPS);
deinterleave_16QAM = k;

%% 64-QAM
N_CBPS = 288;
N_BPSC = 6;
s = max(N_BPSC/2, 1);

k = 0:N_CBPS-1;
i = (N_CBPS/16) .* mod(k,16) + floor(k/16);
j = s * floor(i/s) + mod( (i + N_CBPS - floor(16*i/N_CBPS)), s);
interleave_64QAM = j;

%De-interleaver (j=src bit index -> k=dest bit index)
j = 0:N_CBPS-1;
i = s * floor(j/s) + mod( (j+floor(16*j/N_CBPS)), s);
k = 16*i - (N_CBPS-1)*floor(16*i/N_CBPS);
deinterleave_64QAM = k;
