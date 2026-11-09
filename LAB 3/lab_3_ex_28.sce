n = 0:40;
a1 = -0.9;
y_m1 = 0; // Giả sử điều kiện đầu y(-1) = 0 để có số cụ thể vẽ đồ thị

// Tính toán 2 đáp ứng
yss = 10 * ones(1, length(n));
ytr = ((0.9).^(n+1)) * (y_m1 - 10);

clf;
// Đồ thị đáp ứng quá độ
subplot(2,1,1);
plot2d3(n, ytr);
plot2d(n, ytr, -9);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
a.data_bounds = [min(n)-1, -11; max(n)+1, 2];
xtitle('Transient response y_{tr}(n)', 'n', 'y_{tr}(n)');

// Đồ thị đáp ứng xác lập
subplot(2,1,2);
plot2d3(n, yss);
plot2d(n, yss, -9);
b = gca();
b.x_location = "origin";
b.y_location = "origin";
b.data_bounds = [min(n)-1, -1; max(n)+1, 12];
xtitle('Steady-state response y_{ss}(n)', 'n', 'y_{ss}(n)');
