n = 0:8;
y = [1, 2, 2.5, 3, 3, 3, 2, 1, 0];
h = (0.5).^(0:4);

x = zeros(1, 9);
for i = 1:9
    sum_hx = 0;
    for k = 2:min(i, 5)
        sum_hx = sum_hx + h(k) * x(i - k + 1);
    end
    x(i) = y(i) - sum_hx;
end

clf;
plot2d3(n, x);
plot2d(n, x, -9);

a = gca();
a.x_location = "origin";
a.y_location = "origin";
dy = max(x) - min(x);
a.data_bounds = [min(n)-1, min(x)-0.1*dy; max(n)+1, max(x)+0.1*dy];
xtitle('Input Signal x(n)', 'n', 'x(n)');
