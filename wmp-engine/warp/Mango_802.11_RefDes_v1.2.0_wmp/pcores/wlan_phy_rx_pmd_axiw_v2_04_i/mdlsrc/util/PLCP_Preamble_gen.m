function PLCP_Preamble = PLCP_Preamble_gen()

% Preamble definition (802.11-2007 17.3.3)

%STS for AGC convergence and coarse CFO
% STS is derived from 64 points in frequency domain, only 16 non-zero
% STS is defined as 16 points in time domain
%%
sts_f = zeros(1,64);
sts_f(1:27) = [0 0 0 0 -1-1i 0 0 0 -1-1i 0 0 0 1+1i 0 0 0 1+1i 0 0 0 1+1i 0 0 0 1+1i 0 0];
sts_f(39:64) = [0 0 1+1i 0 0 0 -1-1i 0 0 0 1+1i 0 0 0 -1-1i 0 0 0 -1-1i 0 0 0 1+1i 0 0 0];
sts_t = ifft(sqrt(13/6).*sts_f, 64);
sts_t = sts_t(1:16);

%%
sts_t_norm = 1;%max(abs([real(sts_t) imag(sts_t)]));
sts_t = sts_t .* 1/sts_t_norm;

%LTS for CFO and channel estimation
lts_f = [0 1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1];
lts_t = ifft(lts_f, 64);

%%
lts_t_norm = 1;%max(abs([real(lts_t) imag(lts_t)]));
lts_t = lts_t .* 1/lts_t_norm;

preamble = [repmat(sts_t, 1, 10)  lts_t(33:64) lts_t lts_t];

PLCP_Preamble = struct();
PLCP_Preamble.STS_t = sts_t;
PLCP_Preamble.LTS_t = lts_t;
PLCP_Preamble.LTS_f = lts_f;
PLCP_Preamble.Preamble_t = preamble;
