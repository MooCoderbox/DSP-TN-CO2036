
function [yn, yorigin] = add(x1n, x1origin, x2n, x2origin)
    // 1. Xac dinh truc chi so thoi gian cua tung tin hieu
    n1 = (1:length(x1n)) - x1origin;
    n2 = (1:length(x2n)) - x2origin;
    
    // 2. Xac dinh mien thoi gian chung phu het ca hai tin hieu
    n_min = min(min(n1), min(n2));
    n_max = max(max(n1), max(n2));
    ny = n_min : n_max;
    
    // 3. Vi tri goc toa do n = 0 trong vector ket qua ny
    yorigin = find(ny == 0);
    
    // 4. Khoi tao cac vector dem co cung kich thuoc voi ny
    x1_pad = zeros(1, length(ny));
    x2_pad = zeros(1, length(ny));
    
    // Dien gia tri cua x1 vao dung toa do tren truc ny
    idx1 = (n1(1) - n_min + 1) : (n1($) - n_min + 1);
    x1_pad(idx1) = x1n;
    
    // Dien gia tri cua x2 vao dung toa do tren truc ny
    idx2 = (n2(1) - n_min + 1) : (n2($) - n_min + 1);
    x2_pad(idx2) = x2n;
    
    // 5. Thuc hien phep cong tin hieu
    yn = x1_pad + x2_pad;
    
    // 6. Ve do thi x1(n), x2(n) va y(n) tren cung mot figure
    clf();
    
    // Do thi x1(n)
    subplot(3, 1, 1);
    plot2d3(n1, x1n);
    plot(n1, x1n, "ro");
    xtitle("Signal x1(n)", "n", "x1(n)");
    xgrid(color("gray"));
    a1 = gca();
    a1.data_bounds = [min(n1)-1, min(x1n)-1; max(n1)+1, max(x1n)+1];
    
    // Do thi x2(n)
    subplot(3, 1, 2);
    plot2d3(n2, x2n);
    plot(n2, x2n, "go");
    xtitle("Signal x2(n)", "n", "x2(n)");
    xgrid(color("gray"));
    a2 = gca();
    a2.data_bounds = [min(n2)-1, min(x2n)-1; max(n2)+1, max(x2n)+1];
    
    // Do thi tong y(n) = x1(n) + x2(n)
    subplot(3, 1, 3);
    plot2d3(ny, yn);
    plot(ny, yn, "bo");
    xtitle("Output Signal y(n) = x1(n) + x2(n)", "n", "y(n)");
    xgrid(color("gray"));
    a3 = gca();
    a3.data_bounds = [min(ny)-1, min(yn)-1; max(ny)+1, max(yn)+1];
endfunction



x1_test = [0, 1, 3, -2];
x1origin_test = 1;

x2_test = [1, 1, 2, 3];
x2origin_test = 2;

// Goi ham add
[yn_result, yorigin_result] = add(x1_test, x1origin_test, x2_test, x2origin_test);

// Hien thi ket qua kiem tra ra Console
mprintf("\n--- KET QUA EXERCISE 4 ---\n");
disp(yn_result, "Vector yn = ");
disp(yorigin_result, "Vi tri goc yorigin = ");
