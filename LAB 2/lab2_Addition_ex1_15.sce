clf;

// (a) Fs = 5 kHz, n = 0:99 (hien thi 50 mau dau tien de do thi khong bi chong kin)
n_a = 0:49;

x_05 = sin(2 * %pi * (0.5 / 5) * n_a);
x_20 = sin(2 * %pi * (2.0 / 5) * n_a);
x_30 = sin(2 * %pi * (3.0 / 5) * n_a);
x_45 = sin(2 * %pi * (4.5 / 5) * n_a);

subplot(3, 2, 1);
plot2d3(n_a, x_05);
xtitle("(a) F0 = 0.5 kHz (Fa = 0.5 kHz)", "n", "x(n)");

subplot(3, 2, 2);
plot2d3(n_a, x_45);
xtitle("(a) F0 = 4.5 kHz (Fa = 0.5 kHz, Nguoc pha)", "n", "x(n)");

subplot(3, 2, 3);
plot2d3(n_a, x_20);
xtitle("(a) F0 = 2.0 kHz (Fa = 2.0 kHz)", "n", "x(n)");

subplot(3, 2, 4);
plot2d3(n_a, x_30);
xtitle("(a) F0 = 3.0 kHz (Fa = 2.0 kHz, Nguoc pha)", "n", "x(n)");

// (b) F0 = 2 kHz, Fs = 50 kHz
n_b = 0:50;
xn = sin(2 * %pi * (2 / 50) * n_b);

// y(n) = x(2n)
n_y = 0:25;
yn = sin(2 * %pi * (4 / 50) * n_y);

subplot(3, 2, 5);
plot2d3(n_b, xn);
xtitle("(b1) x(n): f0 = 0.04 cycles/sample", "n", "x(n)");

subplot(3, 2, 6);
plot2d3(n_y, yn);
xtitle("(b2) y(n) = x(2n): fy = 0.08 cycles/sample", "n", "y(n)");
