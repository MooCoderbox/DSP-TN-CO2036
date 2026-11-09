

clear;
clc;

// ================================================================
// EXERCISE 1: Z-TRANSFORM AND ROC
// ================================================================

// ------------------------------------------------
// Helper function: draw Pole-Zero diagram + unit circle
// ------------------------------------------------

function draw_pz(zeroLoc, poleLoc, figureTitle)

    theta = linspace(0, 2*%pi, 500);

    // Dynamic plotting range.
    allValues = [1.2; abs(real(zeroLoc(:))); abs(imag(zeroLoc(:))); ..
                 abs(real(poleLoc(:))); abs(imag(poleLoc(:)))];

    plotLimit = max(allValues) + 0.2;

    // Unit circle, zeros and poles.
    plot(cos(theta), sin(theta), "k--", ..
         real(zeroLoc), imag(zeroLoc), "bo", ..
         real(poleLoc), imag(poleLoc), "rx");

    a = gca();
    a.isoview = "on";
    a.data_bounds = [-plotLimit, -plotLimit; plotLimit, plotLimit];
    a.x_location = "origin";
    a.y_location = "origin";

    xgrid();

    xtitle(figureTitle, "Real{z}", "Imaginary{z}");
    legend("Unit circle", "Zeros", "Poles");

endfunction

// ================================================================
// EXERCISE 1
// x(n) = 2d(n+2) - d(n+1) + 2d(n) - 3d(n-1) + 4d(n-2)
//
// X(z) = 2z^2 - z + 2 - 3z^(-1) + 4z^(-2)
//
// ROC: 0 < |z| < infinity
// ================================================================

mprintf("\n========== EXERCISE 1: Z-TRANSFORM ==========\n");

// Define discrete-time sequence.
n1 = -2:2;
x1 = [2, -1, 2, -3, 4];

// Display Z-transform.
mprintf("X1(z) = 2*z^2 - z + 2 - 3/z + 4/z^2\n");
mprintf("ROC: 0 < abs(z) < infinity\n");

// ------------------------------------------------
// Calculate zeros and poles.
// ------------------------------------------------

// Multiply X1(z) by z^2 to obtain numerator polynomial.
// Numerator = 2*z^4 - z^3 + 2*z^2 - 3*z + 4.

z = poly(0, "z");

num1 = poly([4, -3, 2, -1, 2], "z", "coeff");

zeros1 = roots(num1);

// Two poles at the origin due to z^(-2).
poles1 = [0; 0];

mprintf("\nZeros of X1(z):\n");
disp(zeros1);

mprintf("Poles of X1(z):\n");
disp(poles1);

// ================================================================
// DISPLAY BOTH PLOTS IN ONE WINDOW
// ================================================================

scf(1);
clf();

f = gcf();
f.name = "Exercise 1 - Z-Transform Analysis";
f.figure_size = [1200, 600];

// ================= LEFT: DISCRETE-TIME SIGNAL ==================

subplot(1, 2, 1);

// Draw stems and overlay circular markers.
a = gca();
a.auto_clear = "off";

plot2d3(n1, x1);
plot(n1, x1, "bo");

a.auto_clear = "on";

xgrid();

xtitle( ...
    "Finite-duration Discrete-time Signal x(n)", ...
    "n", ...
    "x(n)");

// ================= RIGHT: POLE-ZERO DIAGRAM ====================

subplot(1, 2, 2);

draw_pz( ...
    zeros1, ...
    poles1, ...
    "Exercise 1 - Pole-Zero Diagram");
