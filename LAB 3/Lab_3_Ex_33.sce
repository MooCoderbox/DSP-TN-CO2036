// Bai 2.33: dap ung xung va dap ung buoc
clc; clear;

// Giai de quy: y(n) = -a1*y(n-1) - a2*y(n-2) + b0*x(n) + b1*x(n-1) + b2*x(n-2)
// a = [a1 a2], b = [b0 b1 b2], dieu kien dau bang 0
function y = de_quy(a, b, x)
    L = length(x);
    y = zeros(1, L);
    for i = 1:L
        v = b(1) * x(i);
        if i >= 2 then v = v + b(2)*x(i-1) - a(1)*y(i-1); end
        if i >= 3 then v = v + b(3)*x(i-2) - a(2)*y(i-2); end
        y(i) = v;
    end
endfunction

N = 15;
n = 0:N;
delta = zeros(1, N+1); delta(1) = 1;     // x(n) = delta(n)
ustep = ones(1, N+1);                    // x(n) = u(n)

// (a) y(n) = 0.6y(n-1) - 0.08y(n-2) + x(n)
aa = [-0.6 0.08]; ba = [1 0 0];
ha = de_quy(aa, ba, delta);
sa = de_quy(aa, ba, ustep);
ha_ct = 2*0.4.^n - 0.2.^n;
sa_ct = 25/12 - (4/3)*0.4.^n + (1/4)*0.2.^n;

// (b) y(n) = 0.7y(n-1) - 0.1y(n-2) + 2x(n) - x(n-2)
ab = [-0.7 0.1]; bb = [2 0 -1];
hb = de_quy(ab, bb, delta);
sb = de_quy(ab, bb, ustep);
hb_ct = -(10/3)*0.5.^n + (46/3)*0.2.^n;
hb_ct(1) = hb_ct(1) - 10;                // thanh phan -10*delta(n)
sb_ct = 5/2 + (10/3)*0.5.^n - (23/6)*0.2.^n;

disp("(a) h(n):"); disp(ha(1:5));
disp("(a) s(n):"); disp(sa(1:5));
disp("(b) h(n):"); disp(hb(1:5));
disp("(b) s(n):"); disp(sb(1:5));

sai_so = max([max(abs(ha-ha_ct)), max(abs(sa-sa_ct)), ..
              max(abs(hb-hb_ct)), max(abs(sb-sb_ct))]);
disp("Sai so lon nhat:"); disp(sai_so);
if sai_so > 1e-8 then
    error("Cong thuc khong khop de quy");
end
disp("Bai 2.33: kiem tra thanh cong");

// Ve do thi
scf(); clf();
subplot(2,2,1);
plot2d3(n, ha, 2); plot2d(n, ha, -9, "000"); xgrid();
xtitle("(a) h(n)", "n", "h(n)");
subplot(2,2,2);
plot2d3(n, sa, 5); plot2d(n, sa, -9, "000"); xgrid();
xtitle("(a) s(n)", "n", "s(n)");
subplot(2,2,3);
plot2d3(n, hb, 2); plot2d(n, hb, -9, "000"); xgrid();
xtitle("(b) h(n)", "n", "h(n)");
subplot(2,2,4);
plot2d3(n, sb, 5); plot2d(n, sb, -9, "000"); xgrid();
xtitle("(b) s(n)", "n", "s(n)");
