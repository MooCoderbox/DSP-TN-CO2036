// (a) cos(0.01*pi*n) -> Chu ky N = 200 (ve khoang 2 chu ky)
n_a = 0:400; 
x_a = cos(0.01 * %pi * n_a);

// (b) cos(pi*30n/105) -> Chu ky N = 7 (ve khoang 3 chu ky)
n_b = 0:21;
x_b = cos(%pi * 30 * n_b / 105);

// (c) cos(3*pi*n) -> Chu ky N = 2 (ve khoang 5 chu ky)
n_c = 0:10;
x_c = cos(3 * %pi * n_c);

// (d) sin(3n) -> Khong tuan hoan
n_d = 0:50;
x_d = sin(3 * n_d);

// (e) sin(pi*62n/10) -> Chu ky N = 10 (ve khoang 3 chu ky)
n_e = 0:30;
x_e = sin(%pi * 62 * n_e / 10);

// Ve do thi 
scf(0); // Khoi tao cua so Figure 0
subplot(5, 1, 1);
plot2d3(n_a, x_a);
title("(a) x(n) = cos(0.01*pi*n) -> Tuan hoan voi N = 200");

subplot(5, 1, 2);
plot2d3(n_b, x_b);
title("(b) x(n) = cos(pi*30n/105) -> Tuan hoan voi N = 7");

subplot(5, 1, 3);
plot2d3(n_c, x_c);
title("(c) x(n) = cos(3*pi*n) -> Tuan hoan voi N = 2");

subplot(5, 1, 4);
plot2d3(n_d, x_d);
title("(d) x(n) = sin(3n) -> Khong tuan hoan");

subplot(5, 1, 5);
plot2d3(n_e, x_e);
title("(e) x(n) = sin(pi*62n/10) -> Tuan hoan voi N = 10");
