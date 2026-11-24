// ================================================================
// DIGITAL SIGNAL PROCESSING - LAB 5
// ADDITIONAL EXERCISE 3.7: CONVOLUTION VIA Z-TRANSFORM
// ================================================================

clear;
clc;

mprintf("\n========== EXERCISE 3.7: CONVOLUTION VIA Z-TRANSFORM ==========\n");

// Use a wide window [-M, M] to avoid truncation error in numerical convol().
M = 35;
nFull = -M:M;

uPos = bool2s(nFull >= 0);
uNeg = bool2s(nFull <= -1);

x1 = ((1/3) .^ nFull) .* uPos + ((1/2) .^ (-nFull)) .* uNeg;
x2 = ((1/2) .^ nFull) .* uPos;

// ================================================================
// METHOD 1: ANALYTICAL RESULT FROM INVERSE Z-TRANSFORM
// ROC: 1/2 < |z| < 2
// x(n) = [-2*(1/3)^n + (10/3)*(1/2)^n]*u(n) + (4/3)*2^n*u(-n-1)
// ================================================================

xTheory = (-2 * ((1/3) .^ nFull) + (10/3) * ((1/2) .^ nFull)) .* uPos + ..
          (4/3) * (2 .^ nFull) .* uNeg;

// ================================================================
// METHOD 2: NUMERICAL DISCRETE CONVOLUTION
// ================================================================

xConvFull = convol(x1, x2);

// Extract plotting and verification range n in [-10, 10].
nPlot = -10:10;
idxTheory = nPlot + M + 1;
idxConv   = nPlot + 2 * M + 1;

x1Plot     = x1(idxTheory);
x2Plot     = x2(idxTheory);
xTheorySub = xTheory(idxTheory);
xConvSub   = xConvFull(idxConv);

maxDifference = max(abs(xTheorySub - xConvSub));
mprintf("Maximum absolute difference on [-10, 10] = %.12f\n", maxDifference);

if maxDifference < 1d-6 then
    mprintf("PASS: Z-transform result matches numerical convolution.\n");
else
    mprintf("FAIL: Results do not match.\n");
end

// ================================================================
// DISPLAY PLOTS IN ONE WINDOW
// ================================================================

scf(307);
clf();

f = gcf();
f.name = "Exercise 3.7 - Convolution via Z-Transform";
f.figure_size = [1000, 820];

// ---------------- Plot 1: x1(n) ---------------------------------
subplot(3, 1, 1);
a = gca(); a.auto_clear = "off";
plot2d3(nPlot, x1Plot, style=2);
e1 = gce(); e1.children.thickness = 2;
plot(nPlot, x1Plot, "bo");
plot([-10.5, 10.5], [0, 0], "k-");
a.auto_clear = "on";
xgrid();
xtitle("Two-sided Signal x1(n)", "n", "x1(n)");

// ---------------- Plot 2: x2(n) ---------------------------------
subplot(3, 1, 2);
a = gca(); a.auto_clear = "off";
plot2d3(nPlot, x2Plot, style=3);
e2 = gce(); e2.children.thickness = 2;
plot(nPlot, x2Plot, "go");
plot([-10.5, 10.5], [0, 0], "k-");
a.auto_clear = "on";
xgrid();
xtitle("Causal Signal x2(n) = (1/2)^n u(n)", "n", "x2(n)");


// ---------------- Plot 3: Comparison ----------------------------
subplot(3, 1, 3);
a = gca();
a.auto_clear = "off";

plot2d3(nPlot, xTheorySub, style=5);
e3 = gce();
e3.children.thickness = 2;

plot(nPlot, xConvSub, "bx");

plot([-10.5, 10.5], [0, 0], "k-");

a.auto_clear = "on";
xgrid();

xtitle("Convolution Result x(n) = x1(n) * x2(n)", "n", "x(n)");
legend("Analytical (Z-transform)", "Numerical (convol)", 1);
