// ====================================================================
// Lab 5 - Exercise 4: LTI System Analysis
// Difference equation: y(n) = 0.7*y(n-1) + x(n)
// ====================================================================

clear;
clc;
clf;

N = 25; // So mau quan sat (n = 0..24)
n = 0:(N - 1);

// --------------------------------------------------------------------
// Cau b: Dap ung xung h(n) = (0.7)^n * u(n)
// --------------------------------------------------------------------
h_theory = (0.7).^n;

// Kiem chung bang cach mo phong he thong voi x(n) = delta(n)
delta = [1, zeros(1, N - 1)];
h_sim = zeros(1, N);
h_sim(1) = delta(1); // y(0) = 0.7*y(-1) + x(0) = 1
for k = 2:N
    h_sim(k) = 0.7 * h_sim(k - 1) + delta(k);
end

// --------------------------------------------------------------------
// Cau c: Dap ung buoc nhay y(n) khi x(n) = u(n)
// Ly thuyet: y(n) = [(10/3) - (7/3)*(0.7)^n] * u(n)
// --------------------------------------------------------------------
y_theory = (10/3) - (7/3)*((0.7).^n);

// Kiem chung bang mo phong lap
u = ones(1, N);
y_sim = zeros(1, N);
y_sim(1) = u(1);
for k = 2:N
    y_sim(k) = 0.7 * y_sim(k - 1) + u(k);
end

// --------------------------------------------------------------------
// Ve do thi
// --------------------------------------------------------------------
figure(1);

// Subplot 1: Dap ung xung h(n)
subplot(2, 1, 1);
plot2d3('gnn', n, h_theory);
plot(n, h_theory, 'bo');
xtitle('Đáp ứng xung h(n) = (0.7)^n u(n)', 'n', 'Biên độ h(n)');
gca().data_bounds = [-1, -0.1; N, 1.2];
xgrid();

// Subplot 2: Dap ung buoc nhay y(n)
subplot(2, 1, 2);
plot2d3('gnn', n, y_theory);
plot(n, y_theory, 'ro');
xtitle('Đáp ứng bước nhảy y(n) khi x(n) = u(n)', 'n', 'Biên độ y(n)');
gca().data_bounds = [-1, 0; N, 4.0];
xgrid();
