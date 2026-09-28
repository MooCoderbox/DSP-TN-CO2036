clf;

N = 16;
n = 0:32; 
k_vals = [1, 2, 4, 8];
expected_Np = [16, 8, 4, 2];

for i = 1:4
    k = k_vals(i);
    // sk(n) = exp(j * 2 * pi * k * n / N)
    sk = exp(%i * 2 * %pi * k * n / N);
    
    subplot(4, 1, i);
    plot2d3(n, real(sk)); 
    xtitle(msprintf("Re{s_%d(n)} voi k = %d, N = 16 (Chu ky co ban N_p = %d)", k, k, expected_Np(i)), "n", "Amplitute");
end
