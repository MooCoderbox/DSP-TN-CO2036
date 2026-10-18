N = 15;
y = zeros(1, N+2);
y(1) = 1; 
y(2) = 2; 

for i = 3:(N+2)
    y(i) = 3*y(i-1) + 4*y(i-2);
end

n = 0:(N-1);
y_out = y(3:N+2);

clf;
plot2d3(n, y_out);
plot2d(n, y_out, -9);
xtitle('Zero-input response', 'n', 'y_zi(n)');

// Ép trục x và y cắt nhau tại gốc tọa độ
a = gca();
a.x_location = "origin"; 
a.y_location = "origin";

// Chỉnh lại lề để đồ thị thoáng mà không bị tụt trục
dy = max(y_out);
a.data_bounds = [min(n)-1, -0.05*dy; max(n)+1, dy + 0.1*dy];
