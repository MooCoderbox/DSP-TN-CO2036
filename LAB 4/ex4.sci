// ========================================================
// Lab 4 - Exercise 6: Linear Convolution and Signal Energy
// Da mo rong bien cac truc do thi de hien thi ro rang hai dau
// ========================================================

clear;
clc;
clf;

// 1. Dinh nghia tin hieu dau vao
x = [1, 2, -3, 2, 1];
h = [1, 0, -1];

Nx = length(x);
Nh = length(h);
Ny = Nx + Nh - 1; // Do dai tin hieu ngo ra y(n) = 7

// --------------------------------------------------------
// Phuong phap Folding and Shifting
// --------------------------------------------------------
y_fold = zeros(1, Ny);
for n = 1:Ny
    sum_val = 0;
    for k = 1:Nh
        if (n - k + 1 >= 1) & (n - k + 1 <= Nx) then
            sum_val = sum_val + h(k) * x(n - k + 1);
        end
    end
    y_fold(n) = sum_val;
end

// --------------------------------------------------------
// Phuong phap ma tran (Matrix method)
// --------------------------------------------------------
H_mat = zeros(Ny, Nh);
for col = 1:Nh
    H_mat(col:col + Nx - 1, col) = x';
end
y_matrix = (H_mat * (h'))';

// --------------------------------------------------------
// Tinh toan nang luong tin hieu
// --------------------------------------------------------
E_x = sum(x.^2);
E_y = sum(y_matrix.^2);

disp("y(n) = ");
disp(y_matrix);
disp("E_x = " + string(E_x) + ", E_y = " + string(E_y));

// --------------------------------------------------------
// 2. Ve do thi (Da can chinh data_bounds khong bi dinh bien)
// --------------------------------------------------------
figure(1);

n_x = 0:(Nx - 1);
n_y = 0:(Ny - 1);

// Subplot 1: Tin hieu x(n)
subplot(2, 2, 1);
plot2d3('gnn', n_x, x);
plot(n_x, x, 'bo');
xtitle('Tín hiệu đầu vào x(n)', 'n', 'Biên độ');
// Noi rong truc x tu -1 den 5, truc y tu -4 den 3.5
gca().data_bounds = [-1, -4; 5, 3.5];
xgrid();

// Subplot 2: Tin hieu y(n)
subplot(2, 2, 2);
plot2d3('gnn', n_y, y_matrix);
plot(n_y, y_matrix, 'ro');
xtitle('Tín hiệu ngõ ra y(n) = x(n) * h(n)', 'n', 'Biên độ');
// Noi rong truc x tu -1 den 7, truc y tu -5.5 den 5.5
gca().data_bounds = [-1, -5.5; 7, 5.5];
xgrid();

// Subplot 3: So sanh x(n) va y(n)
subplot(2, 2, 3);
plot2d3('gnn', n_x, x, 2);        // Mau xanh duong
plot2d3('gnn', n_y, y_matrix, 5); // Mau do
xtitle('So sánh dạng sóng x(n) và y(n)', 'n', 'Biên độ');
hl = legend(['x(n)'; 'y(n)'], "in_upper_right");
// Truc x tu -1 den 7, truc y tu -5.5 den 5.5 de bao tron ca hai
gca().data_bounds = [-1, -5.5; 7, 5.5];
xgrid();

// Subplot 4: Bieu do cot nang luong
subplot(2, 2, 4);
bar([1, 2], [E_x, E_y], 0.4, 'blue');
gca().x_ticks = tlist(['ticks', 'locations', 'labels'], [1, 2], ['E_x', 'E_y']);
xtitle('Năng lượng của x(n) và y(n)', '', 'Năng lượng (Energy)');
// Noi rong truc de cot khong cham vao vien khung
gca().data_bounds = [0.2, 0; 2.8, max(E_x, E_y) * 1.25];
xgrid();
