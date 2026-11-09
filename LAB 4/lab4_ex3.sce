// DIGITAL SIGNAL PROCESSING - LAB #4

clear;
clc;

// EXERCISE 3 - Z-transform and ROC for a two-sided sequence

// ------------------------------------------------
// Helper function: draw Pole-Zero diagram + unit circle
// ------------------------------------------------

function draw_pz(zeroLoc, poleLoc, figureTitle)

    theta = linspace(0, 2*%pi, 500);

    // ROC boundaries.
    rInner = 0.5;
    rOuter = 0.9;

    // Dynamic plotting range.
    allValues = [1.2; abs(real(zeroLoc(:))); abs(imag(zeroLoc(:))); ..
                 abs(real(poleLoc(:))); abs(imag(poleLoc(:)))];

    plotLimit = max(allValues) + 0.2;

    // Draw ROC as a shaded annular region.
    xOuter = rOuter*cos(theta);
    yOuter = rOuter*sin(theta);

    xInner = rInner*cos(theta);
    yInner = rInner*sin(theta);

    // Draw outer filled circle first.
    xfpoly(xOuter, yOuter, color("light blue"));

    // Draw inner white circle to create the annulus.
    xfpoly(xInner, yInner, color("white"));

    // Draw inner and outer ROC boundaries.
    plot(rOuter*cos(theta), rOuter*sin(theta), "b--");
    plot(rInner*cos(theta), rInner*sin(theta), "b--");

    // Draw unit circle.
    plot(cos(theta), sin(theta), "k--");

    // Draw zeros and poles.
    plot(real(zeroLoc), imag(zeroLoc), "bo");
    plot(real(poleLoc), imag(poleLoc), "rx");

    // Configure axes.
    a = gca();
    a.isoview = "on";
    a.data_bounds = [-plotLimit, -plotLimit; plotLimit, plotLimit];
    a.x_location = "origin";
    a.y_location = "origin";

    xgrid();

    xtitle(figureTitle, "Real{z}", "Imaginary{z}");

    legend("ROC outer boundary", "ROC inner boundary", ...
           "Unit circle", "Zeros", "Poles");

endfunction


// ================================================================
// EXERCISE 3
// x(n) = 0.5^n*u(n) + 0.9^n*u(-n-1)
// X(z) = z/(z-0.5) - z/(z-0.9)
// ROC: 0.5 < |z| < 0.9
// ================================================================
mprintf("\n========== EXERCISE 3: Z-TRANSFORM ==========\n");

mprintf("X3(z) = z/(z - 0.5) - z/(z - 0.9)\n");
mprintf("Equivalent form: -0.4*z / ((z - 0.5)*(z - 0.9))\n");
mprintf("ROC: 0.5 < abs(z) < 0.9\n");

// Build x(n) over a finite interval for plotting.
// For n >= 0, only the right-sided term is active.
// For n <= -1, only the left-sided term is active.
n3 = -15:20;
x3 = zeros(1, length(n3));
for i = 1:length(n3)
    if n3(i) >= 0 then
        x3(i) = 0.5 ^ n3(i);
    else
        x3(i) = 0.9 ^ n3(i);
    end
end

// Numerator -0.4*z has one zero at z=0.
zeros3 = [0];
poles3 = [0.5; 0.9];

// ================================================================
// DISPLAY BOTH PLOTS IN ONE WINDOW
// ================================================================

scf(2);
clf();

f = gcf();
f.name = "Exercise 3 - Z-Transform Analysis";
f.figure_size = [1200, 600];

// ================= LEFT: DISCRETE-TIME SIGNAL ==================

subplot(1, 2, 1);

// Draw stems and overlay circular markers.
a = gca();
a.auto_clear = "off";

plot2d3(n3, x3);
plot(n3, x3, "bo");

a.auto_clear = "on";

xgrid();

xtitle( "Two-sided Discrete-time Signal x(n)",  "n",  "x(n)");

// ================= RIGHT: POLE-ZERO DIAGRAM ====================

subplot(1, 2, 2);

draw_pz(zeros3,   poles3,    "Pole-Zero Diagram and Unit Circle");
