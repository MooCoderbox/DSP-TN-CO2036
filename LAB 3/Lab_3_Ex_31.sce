// Bai 2.31: dap ung xung cua he nhan qua
// y(n) - 3y(n-1) - 4y(n-2) = x(n) + 2x(n-1)
clc; clear;

N = 10;
n = 0:N;
x = zeros(1, N+1);
x(1) = 1;                    // x(n) = delta(n)

// Tinh de quy: y(n) = 3y(n-1) + 4y(n-2) + x(n) + 2x(n-1)
y = zeros(1, N+1);
for i = 1:N+1
    y(i) = x(i);
    if i >= 2 then
        y(i) = y(i) + 3*y(i-1) + 2*x(i-1);
    end
    if i >= 3 then
        y(i) = y(i) + 4*y(i-2);
    end
end

// Cong thuc dang dong
h = (6/5) * 4 .^ n - (1/5) * (-1) .^ n;

disp("h(n) tinh de quy:");
disp(y);
disp("h(n) tu cong thuc:");
disp(h);

sai_so = max(abs(y - h));
disp("Sai so lon nhat:");
disp(sai_so);
if sai_so > 1e-8 then
    error("Cong thuc khong khop de quy");
end
disp("Bai 2.31: kiem tra thanh cong");

// Ve do thi
scf(); clf();
plot2d3(n, h, 2);
plot2d(n, h, -9, "000");
xgrid();
xtitle("h(n) = (6/5)4^n - (1/5)(-1)^n, n >= 0", "n", "h(n)");
