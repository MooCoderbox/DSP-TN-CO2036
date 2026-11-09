
function [yn, yorigin] = convolution(xn, xorigin, hn, horigin)
    // 1. Tinh tich chap bang ham convol trong Scilab
    yn = convol(xn, hn);

    // 2. Xac dinh vi tri goc thoi gian n = 0 cua yn
    yorigin = xorigin + horigin - 1;

    // 3. Xac dinh truc chi so thoi gian cho cac tin hieu
    nx = (1:length(xn)) - xorigin;
    nh = (1:length(hn)) - horigin;
    ny = (1:length(yn)) - yorigin;

    // 4. Ve do thi x(n), h(n) va y(n) tren cung mot figure
    clf();

    // Do thi tin hieu vao x(n)
    subplot(3, 1, 1);
    plot2d3(nx, xn);
    plot(nx, xn, "ro");
    xtitle("Input Signal x(n)", "n", "x(n)");
    xgrid(color("gray"));
    a1 = gca();
    a1.data_bounds = [min(nx)-1, min(xn)-1; max(nx)+1, max(xn)+1];

    // Do thi dap ung xung h(n)
    subplot(3, 1, 2);
    plot2d3(nh, hn);
    plot(nh, hn, "go");
    xtitle("Impulse Response h(n)", "n", "h(n)");
    xgrid(color("gray"));
    a2 = gca();
    a2.data_bounds = [min(nh)-1, min(hn)-1; max(nh)+1, max(hn)+1];

    // Do thi tin hieu ra y(n) = x(n) * h(n)
    subplot(3, 1, 3);
    plot2d3(ny, yn);
    plot(ny, yn, "bo");
    xtitle("Convolution Output y(n) = x(n) * h(n)", "n", "y(n)");
    xgrid(color("gray"));
    a3 = gca();
    a3.data_bounds = [min(ny)-1, min(yn)-1; max(ny)+1, max(yn)+1];
endfunction



xn_test = [1, 2, 3, 1];
xorigin_test = 3;

hn_test = [1, 1, 2];
horigin_test = 1;

// Goi ham convolution
[yn_result, yorigin_result] = convolution(xn_test, xorigin_test, hn_test, horigin_test);

// Hien thi ket qua ra man hinh Console
mprintf("\n--- KET QUA EXERCISE 6 ---\n");
disp(yn_result, "Vector yn = ");
disp(yorigin_result, "Vi tri goc yorigin = ");
