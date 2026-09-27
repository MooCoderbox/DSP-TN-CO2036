f0 = 1/50;
N = 200;
n = 0:(N-1);
x = sin(2 * %pi * f0 * n); 


Px = sum(x.^2) / N;

L_vals = [64, 128, 256];
b_vals = [6, 7, 8]; 

for i = 1:3
    L = L_vals(i);
    b = b_vals(i);
    
    // Tinh Delta 
    delta = (max(x) - min(x)) / (L - 1); 
    
    // trunc
    xq_trunc = delta * floor(x / delta);
    e_trunc = xq_trunc - x;
    Pq_trunc = sum(e_trunc.^2) / N;
    SQNR_trunc = 10 * log10(Px / Pq_trunc);
    
    // round
    xq_round = delta * round(x / delta);
    e_round = xq_round - x;
    Pq_round = sum(e_round.^2) / N;
    SQNR_round = 10 * log10(Px / Pq_round);
    
    // Tinh SQNR ly thuyet 
    SQNR_theory = 1.76 + 6.02 * b;
    
    // In ket qua ra Console
    mprintf("L = %d (b = %d bits):\n", L, b);
    mprintf("  SQNR Chat cut   : %.2f dB\n", SQNR_trunc);
    mprintf("  SQNR Lam tron   : %.2f dB\n", SQNR_round);
    mprintf("  SQNR Ly thuyet  : %.2f dB\n\n", SQNR_theory);
    
    // --- Trunc ---
    scf(i); 
    clf;
    subplot(3,1,1);
    plot2d3(n, x);
    title("Tin hieu goc x(n)");
    
    subplot(3,1,2);
    plot2d3(n, xq_trunc);
    title("Tin hieu luong tu hoa x_q(n) (Chat cut, L = " + string(L) + ")");
    
    subplot(3,1,3);
    plot2d3(n, e_trunc);
    title("Sai so luong tu e(n) (Chat cut, L = " + string(L) + ")");

    // --- Round ---
    scf(i + 3); 
    clf;
    subplot(3,1,1);
    plot2d3(n, x);
    title("Tin hieu goc x(n)");
    
    subplot(3,1,2);
    plot2d3(n, xq_round);
    title("Tin hieu luong tu hoa x_q(n) (Lam tron, L = " + string(L) + ")");
    
    subplot(3,1,3);
    plot2d3(n, e_round);
    title("Sai so luong tu e(n) (Lam tron, L = " + string(L) + ")");
end
