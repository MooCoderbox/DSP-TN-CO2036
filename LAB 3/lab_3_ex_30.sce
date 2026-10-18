N = 12;
x = zeros(1, N+2);
y = zeros(1, N+2);

for i = 3:(N+2)
    x(i) = 4^(i-3);
end

for i = 3:(N+2)
    y(i) = 3*y(i-1) + 4*y(i-2) + x(i) + 2*x(i-1);
end

n_out = 0:(N-1);
y_out = y(3:N+2);

clf;
plot2d3(n_out, y_out);
plot2d(n_out, y_out, -9);

a = gca();
a.x_location = "origin";
a.y_location = "origin";
dy = max(y_out);
if dy == 0 then dy = 1; end
a.data_bounds = [min(n_out)-1, -0.05*dy; max(n_out)+1, dy + 0.1*dy];
xtitle('System Response y(n)', 'n', 'y(n)');
