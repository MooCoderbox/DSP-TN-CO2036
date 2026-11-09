
function [yn, yorigin] = advance(xn, xorigin, k)
    // 1. Gan vector mau ngo ra
    yn = xn;
    
    // 2. Cap nhat vi tri goc thoi gian n = 0
    yorigin = xorigin + k;
    
    // 3. Xac dinh truc thoi gian bieu dien
    nx = (1:length(xn)) - xorigin;
    ny = (1:length(yn)) - yorigin;
    
    // 4. Ve do thi x(n) va y(n) tren cung mot figure
    clf();
    
    // Đồ thị tín hiệu gốc x(n)
    subplot(2, 1, 1);
    plot2d3(nx, xn);
    plot(nx, xn, "ro");
    xtitle("Original Signal x(n)", "n", "x(n)");
    xgrid(color("gray"));
    // Mở rộng lề trục hoành 2 bên để không bị sát mép
    a1 = gca();
    a1.data_bounds = [min(nx)-1, min(xn)-1; max(nx)+1, max(xn)+1];
    
    // Đồ thị tín hiệu sớm pha y(n) = x(n + k)
    subplot(2, 1, 2);
    plot2d3(ny, yn);
    plot(ny, yn, "bo");
    xtitle(msprintf("Advance Signal y(n) = x(n + %d)", k), "n", "y(n)");
    xgrid(color("gray"));
    // Mở rộng lề trục hoành 2 bên để không bị sát mép
    a2 = gca();
    a2.data_bounds = [min(ny)-1, min(yn)-1; max(ny)+1, max(yn)+1];
endfunction



xn_test = [1, -2, 3, 6];
xorigin_test = 3; 
k_test = 2;

// Gọi hàm advance
[yn_result, yorigin_result] = advance(xn_test, xorigin_test, k_test);

// Hiển thị kết quả ra màn hình Console
mprintf("\n--- KET QUA EXERCISE 2 ---\n");
disp(yn_result, "Vector yn = ");
disp(yorigin_result, "Vi tri goc yorigin = ");
