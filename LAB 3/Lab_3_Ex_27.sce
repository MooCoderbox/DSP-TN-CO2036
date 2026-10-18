// Bai 2.27: nghiem rieng cua y(n) = 5/6 y(n-1) - 1/6 y(n-2) + x(n)
// voi x(n) = 2^n u(n)
clc; clear;

N  = 15;
n  = 0:N;
x  = 2 .^ n;                 // x(n) = 2^n u(n)
yp = (8/5) * 2 .^ n;         // nghiem rieng ly thuyet

// Kiem tra yp thoa phuong trinh sai phan voi n >= 2
res = zeros(1, N+1);
for i = 3:N+1                // i = 3 tuong ung n = 2
    res(i) = yp(i) - (5/6*yp(i-1) - 1/6*yp(i-2) + x(i));
    // disp("i =", i, ": ", "yp(i) = ", yp(i), ", (5/6*yp(i-1) - 1/6*yp(i-2) + x(i) = ", 5/6*yp(i-1) - 1/6*yp(i-2) + x(i));
    printf("i = %d : yp(i) = %f, (5/6*yp(i-1) - 1/6*yp(i-2) + x(i) = %f\n", i, yp(i), (5/6*yp(i-1) - 1/6*yp(i-2) + x(i)));
end
sai_so = max(abs(res(3:$)));
disp("Sai so lon nhat cua phuong trinh voi n >= 2:");
disp(sai_so);
if sai_so > 1e-8 then
    error("Nghiem rieng khong thoa phuong trinh");
end
disp("Bai 2.27: kiem tra thanh cong");

// Ve do thi
scf(); clf();
plot2d3(n, yp, 2);
plot2d(n, yp, -9, "000");
xgrid();
xtitle("Nghiem rieng y_p(n) = (8/5) 2^n u(n)", "n", "y_p(n)");
