clf;

Fs = 8000;              // Tan so lay mau 8 kHz
Ts = 1 / Fs;
t_max = 0.002;          // Quan sat trong 2 ms
t_cont = 0:1e-6:t_max;  // Mo phong tin hieu lien tuc voi buoc thoi gian rat nho
n = 0:floor(t_max / Ts);
t_samples = n * Ts;

// === Cau (b): Tin hieu 5 kHz va tin hieu bieu kien 3 kHz ===
subplot(2, 1, 1);
// Ve tin hieu 5 kHz lien tuc
plot(t_cont * 1000, cos(2 * %pi * 5000 * t_cont), "r--");
// Ve tin hieu 3 kHz bieu kien
plot(t_cont * 1000, cos(2 * %pi * 3000 * t_cont), "g-");
// Ve cac diem lay mau tai Fs = 8 kHz
plot2d3(t_samples * 1000, cos(2 * %pi * 5000 * t_samples));
plot(t_samples * 1000, cos(2 * %pi * 5000 * t_samples), "bo");
xtitle("Cau (b): Lay mau F1 = 5 kHz tai Fs = 8 kHz -> Fa1 = 3 kHz", "Thoi gian t (ms)", "Bien do");
hl1 = captions(get("current_axes").children([4, 3, 1]), ["5 kHz (Goc)"; "3 kHz (Bieu kien)"; "Mau Fs = 8 kHz"]);

// === Cau (c): Tin hieu 9 kHz va tin hieu bieu kien 1 kHz ===
subplot(2, 1, 2);
// Ve tin hieu 9 kHz lien tuc
plot(t_cont * 1000, cos(2 * %pi * 9000 * t_cont), "r--");
// Ve tin hieu 1 kHz bieu kien
plot(t_cont * 1000, cos(2 * %pi * 1000 * t_cont), "g-");
// Ve cac diem lay mau tai Fs = 8 kHz
plot2d3(t_samples * 1000, cos(2 * %pi * 9000 * t_samples));
plot(t_samples * 1000, cos(2 * %pi * 9000 * t_samples), "bo");
xtitle("Cau (c): Lay mau F2 = 9 kHz tai Fs = 8 kHz -> Fa2 = 1 kHz", "Thoi gian t (ms)", "Bien do");
hl2 = captions(get("current_axes").children([4, 3, 1]), ["9 kHz (Goc)"; "1 kHz (Bieu kien)"; "Mau Fs = 8 kHz"]);
