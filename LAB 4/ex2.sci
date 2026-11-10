// ========================================================
// Lab 4 - Exercise 2: Z-Transform and ROC of x(n)
// x(n) = 0.5^n * u(n) + 0.4^n * u(n)
// ========================================================

clear;
clc;
clf;

// 1. Ve tin hieu x(n) theo mien thoi gian roi rac
n = 0:15;
x = (0.5.^n) + (0.4.^n);

figure(1);
subplot(1, 2, 1);
plot2d3('gnn', n, x); // Ve dang stem
plot(n, x, 'r.');     // Diem dau stem
xtitle('Tín hiệu x(n) = 0.5^n u(n) + 0.4^n u(n)', 'n', 'x(n)');
xgrid();

// 2. Bieu dien tren mat phang phuc Z va mien hoi tu (ROC)
subplot(1, 2, 2);

// Dinh nghia cac zero va pole
zeros_val = [0, 0.45];
poles_val = [0.4, 0.5];

// Ve duong tron don vi |z| = 1 de tham chieu
theta = linspace(0, 2*%pi, 300);
plot(cos(theta), sin(theta), 'k--'); 

// To mien hoi tu ROC: |z| > 0.5 (duong tron qua cuc lon nhat r = 0.5)
r_max_pole = 0.5;
plot(r_max_pole * cos(theta), r_max_pole * sin(theta), 'b-');

// Ve cac diem zero (hinh tron 'o') va pole (dau 'x')
plot(real(zeros_val), imag(zeros_val), 'bo');
plot(real(poles_val), imag(poles_val), 'rx');

// Canh chinh ty le va truc toa do
square(-1.5, -1.5, 1.5, 1.5);
xpoly([-1.5, 1.5], [0, 0]); // Truc thuc
xpoly([0, 0], [-1.5, 1.5]); // Truc ao
xtitle('Mặt phẳng Z: Pole-Zero và ROC (|z| > 0.5)', 'Real(z)', 'Imag(z)');
hl = legend(['Đường tròn đơn vị (|z|=1)'; 'Biên ROC (|z|=0.5)'; 'Zero (o)'; 'Pole (x)'], "in_upper_right");
xgrid();
