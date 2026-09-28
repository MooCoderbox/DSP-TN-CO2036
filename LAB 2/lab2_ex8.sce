
n_x = -2:1;
x = [1, -2, 3, 6];


figure(1);
n_y1 = -1:2;
y1 = [6, 3, -2, 1]; 

subplot(2, 1, 1);
plot2d3(n_x, x);
title("Original Signal x(n)");
xlabel("n");
ylabel("x(n)");

subplot(2, 1, 2);
plot2d3(n_y1, y1);
title("Manipulated Signal y1(n) = x(-n)");
xlabel("n");
ylabel("y1(n)");



figure(2);
n_y2 = -5:-2;
y2 = x; 

subplot(2, 1, 1);
plot2d3(n_x, x);
title("Original Signal x(n)");
xlabel("n");
ylabel("x(n)");

subplot(2, 1, 2);
plot2d3(n_y2, y2);
title("Manipulated Signal y2(n) = x(n+3)");
xlabel("n");
ylabel("y2(n)");



figure(3);
n_y3 = -3:0;
y3 = [12, 6, -4, 2];

subplot(2, 1, 1);
plot2d3(n_x, x);
title("Original Signal x(n)");
xlabel("n");
ylabel("x(n)");

subplot(2, 1, 2);
plot2d3(n_y3, y3);
title("Manipulated Signal y3(n) = 2x(-n-2)");
xlabel("n");
ylabel("y3(n)");
