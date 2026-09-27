n = -1:1;
x = [1, 3, -2];

// plot x(n)
subplot(3, 1, 1);
plot2d3(n, x);
plot(n, x, 'ro');
xgrid();

// Extend
a = gca(); 
// [x_min, y_min; x_max, y_max]
a.data_bounds = [-1.5, -3; 1.5, 4]; 

title("Tin hieu roi rac x(n)");
xlabel("n");
ylabel("x(n)");

x_fold = x($:-1:1);
x_o = 0.5 * (x - x_fold);
x_e = 0.5 * (x + x_fold);

// Plot x_o(n)
subplot(3, 1, 2);
plot2d3(n, x_o);
plot(n, x_o, 'ro');
xgrid();

a = gca();
a.data_bounds = [-1.5, -3; 1.5, 4];

title("Thanh phan le x_o(n)");
xlabel("n");
ylabel("x_o(n)");

// plot x_e(n)
subplot(3, 1, 3);
plot2d3(n, x_e);
plot(n, x_e, 'ro');
xgrid();

a = gca();
a.data_bounds = [-1.5, -3; 1.5, 4];

title("Thanh phan chan x_e(n)");
xlabel("n");
ylabel("x_e(n)");
