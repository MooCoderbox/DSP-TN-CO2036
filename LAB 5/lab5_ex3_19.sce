// ================================================================
// DIGITAL SIGNAL PROCESSING - LAB 5
// ADDITIONAL EXERCISE 3.19: INVERSE Z-TRANSFORM BY DIFFERENTIATION
// ================================================================

clear;
clc;

mprintf("\n========== EXERCISE 3.19: DIFFERENTIATION PROPERTY ==========\n");

// ================================================================
// PART A: X(z) = log(1 - 2z), |z| < 1/2
// x_a(n) = [(1/2)^n / n] * u(-n - 1)
// ================================================================

nA = -15:5;
xA = zeros(1, length(nA));
idxA = find(nA <= -1);
xA(idxA) = ((0.5) .^ nA(idxA)) ./ nA(idxA);

// Numerical verification at z0 = 0.25 (|z0| < 0.5)
kA = -80:-1;
z0A = 0.25;
XaNum    = sum((((0.5) .^ kA) ./ kA) .* (z0A .^ (-kA)));
XaTheory = log(1 - 2 * z0A);
errA     = abs(XaNum - XaTheory);

mprintf("(a) X(z) = log(1 - 2z) at z0 = 0.25: error = %.12e\n", errA);

// ================================================================
// PART B: X(z) = log(1 - z^-1), |z| > 1
// x_b(n) = -(1/n) * u(n - 1)
// ================================================================

nB = -5:15;
xB = zeros(1, length(nB));
idxB = find(nB >= 1);
xB(idxB) = -1 ./ nB(idxB);

// Numerical verification at z0 = 2.0 (|z0| > 1)
kB = 1:80;
z0B = 2.0;
XbNum    = sum((-1 ./ kB) .* (z0B .^ (-kB)));
XbTheory = log(1 - 1 / z0B);
errB     = abs(XbNum - XbTheory);

mprintf("(b) X(z) = log(1 - z^-1) at z0 = 2.00: error = %.12e\n", errB);

if max([errA, errB]) < 1d-10 then
    mprintf("PASS: Both inverse Z-transforms verified numerically.\n");
else
    mprintf("FAIL: Verification error exceeds threshold.\n");
end

// ================================================================
// DISPLAY BOTH SIGNALS IN ONE WINDOW
// ================================================================

scf(319);
clf();

f = gcf();
f.name = "Exercise 3.19 - Inverse Z-Transform via Differentiation";
f.figure_size = [1000, 680];

// ---------------- Plot 1: Part (a) ------------------------------
subplot(2, 1, 1);
a = gca(); a.auto_clear = "off";
plot2d3(nA, xA, style=2);
e1 = gce(); e1.children.thickness = 2;
plot(nA, xA, "bo");
plot([min(nA) - 0.5, max(nA) + 0.5], [0, 0], "k-");
a.auto_clear = "on";
xgrid();
xtitle("(a) x(n) = [(1/2)^n / n] u(-n-1)  (ROC: |z| < 1/2)", "n", "x(n)");

// ---------------- Plot 2: Part (b) ------------------------------
subplot(2, 1, 2);
a = gca(); a.auto_clear = "off";
plot2d3(nB, xB, style=5);
e2 = gce(); e2.children.thickness = 2;
plot(nB, xB, "ro");
plot([min(nB) - 0.5, max(nB) + 0.5], [0, 0], "k-");
a.auto_clear = "on";
xgrid();
xtitle("(b) x(n) = -(1/n) u(n-1)  (ROC: |z| > 1)", "n", "x(n)");
