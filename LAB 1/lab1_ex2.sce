




// 1. Tin hieu tuong tu xa(t) = 3*sin(100*pi*t) trong 5 chu ky

F0 = 50;
T0 = 1 / F0;
t = 0:0.0001:(5 * T0);
xa = 3 * sin(100 * %pi * t);

// Do thi 1 tren cua so chung
subplot(3, 1, 1);
plot(t, xa, "b-", "LineWidth", 2);
title("1. Tin hieu tuong tu xa(t) trong 5 chu ky (0 - 0.1s)");
xlabel("Thoi gian t (giay)");
ylabel("xa(t)");
xgrid();


// 2. Tin hieu roi rac x(n) sau lay mau voi Fs = 300 samples/s trong 5 chu ky

Fs = 300;
N = 6;
n = 0:(5 * N - 1);
xn = 3 * sin((%pi / 3) * n);

// Do thi 2 tren cua so chung (ve dang que stem plot)
subplot(3, 1, 2);
plot2d3(n, xn);
plot(n, xn, "ro");
title("2. Tin hieu roi rac x(n) sau lay mau (5 chu ky = 30 mau)");
xlabel("Chi so mau n");
ylabel("x(n)");
xgrid();


delta = 0.1;
xq = delta * floor(xn / delta);

// Do thi 3 tren cua so chung (ve dang que stem plot)
subplot(3, 1, 3);
plot2d3(n, xq);
plot(n, xq, "mo");
title("3. Tin hieu luong tu hoa xq(n) (Delta = 0.1, Truncation) trong 5 chu ky");
xlabel("Chi so mau n");
ylabel("xq(n)");
xgrid();
