// ================================================================
// DIGITAL SIGNAL PROCESSING - LAB #4
// EXERCISE 7: CIRCULAR CONVOLUTION
// Standalone Scilab script (Fixed Plotting & Stem Markers)
// ================================================================

clear;
clc;

mprintf("\n========== EXERCISE 7: CIRCULAR CONVOLUTION ==========\n");

// Input signals
x = [1, 2, -3, 2, 1];
h = [1, 0, -1, -1, 1];

N = length(x);
M = length(h);

n = 0:N-1;

// Circular convolution in this exercise assumes M = N.
if M <> N then
    error("This implementation requires M = N.");
end


// ================================================================
// METHOD 1: FOLDING AND SHIFTING
// y(n) = sum_{k=0}^{M-1} h(k) * x[(n-k) mod N]
// ================================================================

yFold = zeros(1, N);

for ni = 0:N-1
    sumValue = 0;
    for ki = 0:M-1
        // Calculate circular index: (ni - ki) mod N
        idx = pmodulo(ni - ki, N);
        
        // Convert to Scilab 1-based index
        sumValue = sumValue + h(ki+1) * x(idx+1);
    end
    yFold(ni+1) = sumValue;
end


// ================================================================
// METHOD 2: CIRCULANT MATRIX
// C(n,m) = h[(n-m) mod N], y = C * x^T
// ================================================================

C = zeros(N, N);

for ni = 0:N-1
    for mi = 0:N-1
        idx = pmodulo(ni - mi, N);
        C(ni+1, mi+1) = h(idx+1);
    end
end

// Matrix multiplication
yMatrix = (C * x')';


// ================================================================
// DISPLAY & VERIFY RESULTS
// ================================================================

mprintf("\nInput signal x(n):\n");
disp(x);

mprintf("Impulse response h(n):\n");
disp(h);

mprintf("Circular convolution - Folding and Shifting y(n):\n");
disp(yFold);

mprintf("Circular convolution - Circulant Matrix y(n):\n");
disp(yMatrix);

mprintf("Circulant Matrix C:\n");
disp(C);

maxDifference = max(abs(yFold - yMatrix));
mprintf("Maximum absolute difference = %.12f\n", maxDifference);

if maxDifference < 1d-10 then
    mprintf("PASS: Both methods produce identical results.\n");
else
    mprintf("FAIL: Results do not match.\n");
end


// ================================================================
// ENERGY CALCULATION
// E = sum |s(n)|^2
// ================================================================

Ex = sum(x .^ 2);
Ey = sum(yFold .^ 2);

mprintf("\nEnergy of x(n): Ex = %.0f\n", Ex);
mprintf("Energy of y(n): Ey = %.0f\n", Ey);


// ================================================================
// PLOTTING (With Circular Stem Markers & Padded Axis Bounds)
// ================================================================

scf(7);
clf();
f = gcf();
f.figure_size = [1000, 750];

// ----------------------------------------------------------------
// Plot 1: Input signal x(n)
// ----------------------------------------------------------------
subplot(2, 2, 1);
plot2d3(n, x, style=2);              // Vẽ thân cột màu xanh dương (style=2)
e1 = gce(); e1.children.thickness = 2;
plot(n, x, 'bo', 'MarkerSize', 8, 'LineWidth', 1.5); // Vòng tròn trên đỉnh cột
plot([-1, N], [0, 0], 'k-');         // Đường trục hoành y = 0
xgrid(1);
xtitle("Input Signal x(n)", "n", "Amplitude");
ax1 = gca();
ax1.data_bounds = [-0.5, -4; N-0.5, 3]; // Mở rộng biên để không dính viền

// ----------------------------------------------------------------
// Plot 2: Circular convolution y(n)
// ----------------------------------------------------------------
subplot(2, 2, 2);
plot2d3(n, yFold, style=5);          // Vẽ thân cột màu đỏ (style=5)
e2 = gce(); e2.children.thickness = 2;
plot(n, yFold, 'ro', 'MarkerSize', 8, 'LineWidth', 1.5); // Vòng tròn đỏ trên đỉnh
plot([-1, N], [0, 0], 'k-');         // Đường trục hoành y = 0
xgrid(1);
xtitle("Circular Convolution y(n)", "n", "Amplitude");
ax2 = gca();
ax2.data_bounds = [-0.5, -6; N-0.5, 4]; // Đủ rộng để thấy rõ đỉnh -5 và +3

// ----------------------------------------------------------------
// Plot 3: Comparison of x(n) and y(n) (Discrete Stem Plot)
// ----------------------------------------------------------------
subplot(2, 2, 3);
// Vẽ thân cột cho x(n) và y(n)
plot2d3(n, x, style=2);
ex = gce(); ex.children.thickness = 2;
plot2d3(n, yFold, style=5);
ey = gce(); ey.children.thickness = 2;

// Vẽ vòng tròn trên đỉnh cột (dùng cho cả legend)
plot(n, x, 'bo', 'MarkerSize', 8, 'LineWidth', 1.5);
plot(n, yFold, 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
plot([-1, N], [0, 0], 'k-');
xgrid(1);
xtitle("Comparison of x(n) and y(n)", "n", "Amplitude");
ax3 = gca();
ax3.data_bounds = [-0.5, -6; N-0.5, 4];
legend(["x(n)"; "y(n)"], 1);

// ----------------------------------------------------------------
// Plot 4: Signal Energy
// ----------------------------------------------------------------
subplot(2, 2, 4);
bar([1, 2], [Ex, Ey], 0.4, "blue");  // Dùng biểu đồ cột (bar) giống Bài 6
xgrid(1);
xtitle("Signal Energy", "Signal", "Energy");
ax4 = gca();
ax4.data_bounds = [0.3, 0; 2.7, 50]; // Căn lề trái/phải để 2 cột nằm giữa đồ thị
ax4.x_ticks = tlist(["ticks", "locations", "labels"], [1; 2], ["E_x"; "E_y"]);

mprintf("\nExercise 7 completed.\n");