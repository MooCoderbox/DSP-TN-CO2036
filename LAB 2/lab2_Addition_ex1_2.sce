clf;

// (a) cos(0.01*pi*n)
n_a = 0:200;
xa = cos(0.01 * %pi * n_a);
subplot(5, 1, 1);
plot2d3(n_a, xa);
xtitle("(a) x(n) = cos(0.01*%pi*n), Periodic N=200", "n", "x(n)");

// (b) cos(pi * 30n / 105)
n_b = 0:21; 
xb = cos(%pi * (30 * n_b) / 105);
subplot(5, 1, 2);
plot2d3(n_b, xb);
xtitle("(b) x(n) = cos(%pi*30n/105), Periodic N=7", "n", "x(n)");

// (c) cos(3*pi*n)
n_c = 0:10; 
xc = cos(3 * %pi * n_c);
subplot(5, 1, 3);
plot2d3(n_c, xc);
xtitle("(c) x(n) = cos(3*%pi*n), Periodic N=2", "n", "x(n)");

// (d) sin(3*n)
n_d = 0:30;
xd = sin(3 * n_d);
subplot(5, 1, 4);
plot2d3(n_d, xd);
xtitle("(d) x(n) = sin(3n), Non-periodic", "n", "x(n)");

// (e) sin(pi * 62n / 10)
n_e = 0:20; 
xe = sin(%pi * (62 * n_e) / 10);
subplot(5, 1, 5);
plot2d3(n_e, xe);
xtitle("(e) x(n) = sin(%pi*62n/10), Periodic N=10", "n", "x(n)");
