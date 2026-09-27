//  n tu -1 den 3
n = -1:3;

// zero-padding
x1 = [0, 0, 1, 3, -2]; 
x2 = [0, 1, 2, 3, 0];  

y = x1 .* x2;

// Plot x1(n)
subplot(3, 1, 1);
plot2d3(n, x1);
plot(n, x1, 'ro');
xgrid();
a = gca();
a.data_bounds = [-2, -3; 4, 4]; 
title("Tin hieu x_1(n)");
xlabel("n");
ylabel("x_1(n)");

// Plot x2(n)
subplot(3, 1, 2);
plot2d3(n, x2);
plot(n, x2, 'ro');
xgrid();
a = gca();
a.data_bounds = [-2, -1; 4, 4]; 
title("Tin hieu x_2(n)");
xlabel("n");
ylabel("x_2(n)");

// Plot y(n) = x1(n) * x2(n)
subplot(3, 1, 3);
plot2d3(n, y);
plot(n, y, 'ro');
xgrid();
a = gca();
a.data_bounds = [-2, -1; 4, 10]; 
title("Tin hieu y(n) = x_1(n) * x_2(n)");
xlabel("n");
ylabel("y(n)");
