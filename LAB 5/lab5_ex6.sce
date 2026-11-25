

clear;
clc;
clf;

N = 40;
n = 0:(N - 1);
a = 0.5 + 0.3*%i;
x = a.^n; // Tin hieu phuc

// Diem kiem tra z0 tren mat phang Z (|z0| > |a| de hoi tu)
z0 = 1.2 + 0.8*%i;
w0 = %pi / 3;

// Tinh Z{x(n)} tai z0 theo dinh nghia chuoi luy thua
X_z0 = sum(x .* (z0.^(-n)));

// 1. Kiem chung Z{x*(n)} = X*(z*)
x_conj = conj(x);
Z_x_conj = sum(x_conj .* (z0.^(-n)));
X_conj_z_conj = conj(sum(x .* (conj(z0).^(-n))));

// 2. Kiem chung Z{Re{x(n)}} = 0.5 * [X(z) + X*(z*)]
x_real = real(x);
Z_x_real = sum(x_real .* (z0.^(-n)));
RHS_real = 0.5 * (X_z0 + X_conj_z_conj);

// 3. Kiem chung Z{Im{x(n)}} = (1/(2j)) * [X(z) - X*(z*)]
x_imag = imag(x);
Z_x_imag = sum(x_imag .* (z0.^(-n)));
RHS_imag = (1 / (2*%i)) * (X_z0 - X_conj_z_conj);

// 4. Kiem chung Z{e^(j*w0*n)*x(n)} = X(z * e^(-j*w0))
x_mod = exp(%i * w0 * n) .* x;
Z_x_mod = sum(x_mod .* (z0.^(-n)));
z_shifted = z0 * exp(-%i * w0);
X_shifted = sum(x .* (z_shifted.^(-n)));

// In ket qua kiem chung ra Console
mprintf("Sai so tinh chat 1: %e\n", abs(Z_x_conj - X_conj_z_conj));
mprintf("Sai so tinh chat 2: %e\n", abs(Z_x_real - RHS_real));
mprintf("Sai so tinh chat 3: %e\n", abs(Z_x_imag - RHS_imag));
mprintf("Sai so tinh chat 4: %e\n", abs(Z_x_mod - X_shifted));

// --------------------------------------------------------------------
// Ve do thi truc quan hoa cac thanh phan tin hieu
// --------------------------------------------------------------------
figure(1);

// Subplot 1: Real part
subplot(2, 2, 1);
plot2d3('gnn', n(1:16), real(x(1:16)));
plot(n(1:16), real(x(1:16)), 'bo');
xtitle('Phần thực Re{x(n)}', 'n', 'Biên độ');
gca().data_bounds = [-1, -0.6; 16, 1.2];
xgrid();

// Subplot 2: Imaginary part
subplot(2, 2, 2);
plot2d3('gnn', n(1:16), imag(x(1:16)));
plot(n(1:16), imag(x(1:16)), 'ro');
xtitle('Phần ảo Im{x(n)}', 'n', 'Biên độ');
gca().data_bounds = [-1, -0.6; 16, 0.6];
xgrid();

// Subplot 3: Conjugate signal
subplot(2, 2, 3);
plot2d3('gnn', n(1:16), real(x_conj(1:16)), 2);
plot2d3('gnn', n(1:16), imag(x_conj(1:16)), 5);
xtitle('Tín hiệu liên hợp x*(n)', 'n', 'Biên độ');
hl1 = legend(['Re{x*(n)}'; 'Im{x*(n)}'], "in_upper_right");
gca().data_bounds = [-1, -0.6; 16, 1.2];
xgrid();

// Subplot 4: Frequency-shifted signal
subplot(2, 2, 4);
plot2d3('gnn', n(1:16), real(x_mod(1:16)), 3);
plot(n(1:16), real(x_mod(1:16)), 'g.');
xtitle('Tín hiệu dịch tần Re{e^{j\omega_0 n} x(n)}', 'n', 'Biên độ');
gca().data_bounds = [-1, -1.2; 16, 1.2];
xgrid();
