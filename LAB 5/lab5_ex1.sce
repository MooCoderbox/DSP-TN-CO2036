// ================================================================
// DIGITAL SIGNAL PROCESSING - LAB 5
// EXERCISE 1: IMPULSE RESPONSE h(n) AND POLE-ZERO DIAGRAM
// ================================================================

clear;
clc;

// ----------------------------------------------------------------
// Helper function: draw Pole-Zero diagram + shaded exterior ROC
// ----------------------------------------------------------------

function draw_pz_exterior(zeroLoc, poleLoc, rInner, figureTitle)

    theta = linspace(0, 2*%pi, 500);

    // Dynamic plotting range.
    allValues = [1.4; rInner; abs(real(zeroLoc(:))); abs(imag(zeroLoc(:))); ..
                 abs(real(poleLoc(:))); abs(imag(poleLoc(:)))];

    plotLimit = max(allValues) + 0.6;

    // Fill the entire axes background with light blue (exterior ROC: |z| > rInner).
    a = gca();
    a.background = color("light blue");

    // Draw inner white circle (non-ROC region) without solid black border.
    xfpoly(rInner*cos(theta), rInner*sin(theta), color("white"));
    hInner = gce();
    hInner.line_mode = "off";

    // Draw ROC boundary, unit circle, zeros and poles (capture handles for legend).
    plot(rInner*cos(theta), rInner*sin(theta), "b--");
    hRoc = gce().children(1);

    plot(cos(theta), sin(theta), "k--");
    hUnit = gce().children(1);

    plot(real(zeroLoc), imag(zeroLoc), "bo");
    hZero = gce().children(1);

    plot(real(poleLoc), imag(poleLoc), "rx");
    hPole = gce().children(1);

    // Configure axes.
    a.isoview = "on";
    a.tight_limits = "on";
    a.data_bounds = [-plotLimit, -plotLimit; plotLimit, plotLimit];
    a.x_location = "origin";
    a.y_location = "origin";
    a.grid_position = "foreground";

    xgrid();

    xtitle(figureTitle, "Real{z}", "Imaginary{z}");
    legend([hRoc, hUnit, hZero, hPole], ..
           ["ROC boundary (|z|=1)", "Unit circle", "Zeros (m=2 at 0)", "Poles"]);

endfunction


// ================================================================
// EXERCISE 1
// y(n) - y(n-2) = x(n)
// H(z) = z^2 / (z^2 - 1), ROC: |z| > 1
// h(n) = 0.5 * [1 + (-1)^n] * u(n)
// ================================================================

mprintf("\n========== EXERCISE 1: IMPULSE RESPONSE ==========\n");

mprintf("System equation: y(n) - y(n-2) = x(n)\n");
mprintf("H(z) = z^2 / (z^2 - 1)\n");
mprintf("ROC: abs(z) > 1 (Causal, BIBO Unstable)\n");

// ----------------------------------------------------------------
// Calculate zeros and poles.
// ----------------------------------------------------------------

num1 = poly([0, 0, 1], "z", "coeff");
den1 = poly([-1, 0, 1], "z", "coeff");

zeros1 = roots(num1);
poles1 = roots(den1);

mprintf("\nZeros of H(z):\n");
disp(zeros1);

mprintf("Poles of H(z):\n");
disp(poles1);

// ----------------------------------------------------------------
// Compute h(n): Analytical vs Difference Equation
// ----------------------------------------------------------------

N = 15;
n1 = 0:N;

hTheory = 0.5 * (1 + (-1) .^ n1);

delta = zeros(1, length(n1));
delta(1) = 1;

hSim = zeros(1, length(n1));
for k = 1:length(n1)
    yPrev2 = 0;
    if k > 2 then
        yPrev2 = hSim(k - 2);
    end
    hSim(k) = yPrev2 + delta(k);
end

maxDifference = max(abs(hTheory - hSim));
mprintf("\nMaximum absolute difference = %.12f\n", maxDifference);

if maxDifference < 1d-10 then
    mprintf("PASS: Analytical h(n) matches difference equation.\n");
else
    mprintf("FAIL: Results do not match.\n");
end

// ================================================================
// DISPLAY BOTH PLOTS IN ONE WINDOW
// ================================================================

scf(1);
clf();

f = gcf();
f.name = "Exercise 1 - Impulse Response and Pole-Zero Diagram";
f.figure_size = [1200, 600];

// ================= LEFT: IMPULSE RESPONSE ======================

subplot(1, 2, 1);

a = gca();
a.auto_clear = "off";

plot2d3(n1, hTheory, style=2);
e1 = gce(); e1.children.thickness = 2;
plot(n1, hTheory, "bo");
plot([-0.5, N + 0.5], [0, 0], "k-");

a.auto_clear = "on";
a.data_bounds = [-0.5, -0.2; N + 0.5, 1.3];

xgrid();
xtitle("Impulse Response h(n) = 0.5[1 + (-1)^n]u(n)", "n", "h(n)");

// ================= RIGHT: POLE-ZERO DIAGRAM ====================

subplot(1, 2, 2);

draw_pz_exterior(zeros1, poles1, 1.0, "Exercise 1 - Pole-Zero Diagram (ROC: |z| > 1)");
