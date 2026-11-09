nx = -2:4;
x = ones(1, length(nx));

nh = -1:2;
h = 2 * ones(1, length(nh));

y = convol(x, h);
ny = (nx(1) + nh(1)) : (nx($) + nh($));

clf;
subplot(3,1,1);
plot2d3(nx, x);
plot2d(nx, x, -9);
a = gca(); a.x_location = "origin"; a.y_location = "origin";
a.data_bounds = [-4, -0.5; 7, 2.5];
xtitle('Signal x(n)', 'n', 'x(n)');

subplot(3,1,2);
plot2d3(nh, h);
plot2d(nh, h, -9);
b = gca(); b.x_location = "origin"; b.y_location = "origin";
b.data_bounds = [-4, -0.5; 7, 3.5];
xtitle('Signal h(n)', 'n', 'h(n)');

subplot(3,1,3);
plot2d3(ny, y);
plot2d(ny, y, -9);
c = gca(); c.x_location = "origin"; c.y_location = "origin";
c.data_bounds = [-4, -0.5; 7, 9.5];
xtitle('Convolution y(n)', 'n', 'y(n)');
