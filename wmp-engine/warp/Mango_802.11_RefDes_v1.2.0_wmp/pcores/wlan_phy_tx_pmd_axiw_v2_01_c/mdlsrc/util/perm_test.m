x = 0:N_CBPS-1;

N_CBPS = 192;
N_BPSC = 4;

perm_1      = zeros(1, N_CBPS);
perm_2      = zeros(1, N_CBPS);
s = max(N_BPSC/2, 1);


k           = 0:N_CBPS-1;

j           = s*floor(k/s) + mod(k + N_CBPS - floor(16*k/N_CBPS), s);
i           = (N_CBPS/16) * mod(k,16) + floor(k/16);

for( b = 1:1 ) 
    perm_1(1,i+1)     = x(b,:); %first permutation
    perm_2(1,j+1)     = perm_1(b,:); %second permutation
end