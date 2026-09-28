clf;

// 1. Dinh nghia thoi gian lien tuc cho tin hieu goc (quan sat trong 40 ms)
t_in = 0:1e-5:0.04;
xa = 3 * cos(100 * %pi * t_in) + 2 * sin(250 * %pi * t_in);

// 2. Lay mau qua A/D (T = 5 ms -> Fs = 200 Hz)
T = 0.005;
n = 0:floor(0.04 / T);
t_samples_in = n * T;
xn = 3 * cos(100 * %pi * t_samples_in) + 2 * sin(250 * %pi * t_samples_in);

// 3. Tin hieu tai tao qua D/A (T' = 1 ms -> Fs' = 1000 Hz)
// Voi moi mau n, thoi diem tai tao la t_out = n * T' (quan sat tren 8 ms tuong ung)
t_out = 0:1e-5:0.008;
ya = 3 * cos(500 * %pi * t_out) - 2 * sin(750 * %pi * t_out);
T_prime = 0.001;
t_samples_out = n * T_prime;

// --- Ve do thi ---
// Do thi tin hieu vao va cac mau lay duoc
subplot(2, 1, 1);
plot(t_in * 1000, xa, "b-");
plot2d3(t_samples_in * 1000, xn);
plot(t_samples_in * 1000, xn, "ro");
xtitle("Tin hieu vao x_a(t) va cac diem lay mau tai Fs = 200 Hz (T = 5 ms)", "Thoi gian t (ms)", "Bien do");
legend(["x_a(t)"; "Mau x(n)"]);

// Do thi tin hieu ra tai tao ya(t)
subplot(2, 1, 2);
plot(t_out * 1000, ya, "g-");
plot2d3(t_samples_out * 1000, xn);
plot(t_samples_out * 1000, xn, "ro");
xtitle("Tin hieu ra y_a(t) sau D/A (T'' = 1 ms) va Postfilter", "Thoi gian t (ms)", "Bien do");
legend(["y_a(t)"; "Mau tai tao"]);
