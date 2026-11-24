// ================================================================
// DIGITAL SIGNAL PROCESSING - LAB 5
// ADDITIONAL EXERCISE 3.13: TIME SCALING (UPSAMPLING & DOWNSAMPLING)
// ================================================================

clear;
clc;

// ----------------------------------------------------------------
// Helper function: closed-form X(z) for test signal x(n) = a^n u(n)
// ----------------------------------------------------------------

function val = eval_X(zVal, aVal)
    val = 1 ./ (1 - aVal ./ zVal);
endfunction

// ----------------------------------------------------------------
// Helper function: draw Pole-Zero diagram + shaded exterior ROC
// ----------------------------------------------------------------

function draw_pz_exterior(zeroLoc, poleLoc, rInner, rocLabel, figureTitle)

    theta = linspace(0, 2*%pi, 500);

    // Dynamic plotting range.
    allValues = [1.2; rInner; abs(real(zeroLoc(:))); abs(imag(zeroLoc(:))); ..
                 abs(real(poleLoc(:))); abs(imag(poleLoc(:)))];
    plotLimit = max(allValues) + 0.3;

    // Fill the entire axes background with light blue (ROC: |z| > rInner).
    a = gca();
    a.background = color("light blue");

    // Draw inner white circle (non-ROC region) without solid border.
    xfpoly(rInner*cos(theta), rInner*sin(theta), color("white"));
    hMask = gce();
    hMask.line_mode = "off";

    // Draw ROC boundary, unit circle, zeros, and poles.
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

    hLeg = legend([hRoc, hUnit, hZero, hPole], ..
                  [rocLabel, "Unit circle (|z|=1)", "Zeros", "Poles"]);
    hLeg.font_size = 1;

endfunction

// ----------------------------------------------------------------
// Helper function: stem plot in Lab 4 style
// ----------------------------------------------------------------

function draw_stem(nVec, xVec, stemStyle, markerStyle, titleStr, yLabelStr)

    a = gca();
    a.auto_clear = "off";

    plot2d3(nVec, xVec, style=stemStyle);
    e = gce(); e.children.thickness = 2;
    plot(nVec, xVec, markerStyle);
    plot([min(nVec) - 0.5, max(nVec) + 0.5], [0, 0], "k-");

    a.auto_clear = "on";

    xgrid();
    xtitle(titleStr, "n", yLabelStr);

endfunction


// ================================================================
// SIGNAL DEFINITION & NUMERICAL VERIFICATION
// ================================================================

mprintf("\n========== EXERCISE 3.13: TIME SCALING IN Z-DOMAIN ==========\n");

// Test signal: x(n) = (0.5)^n * u(n) -> X(z) = z / (z - 0.5), ROC: |z| > 0.5
aVal = 0.5;
N = 50;
n = 0:N;
x = aVal .^ n;

// (a) x1(n) = x(n/2) for even n, 0 for odd n -> X1(z) = X(z^2) = z^2 / (z^2 - 0.5)
//     ROC: |z| > sqrt(0.5) ~= 0.7071
n1 = 0:(2 * N);
x1 = zeros(1, length(n1));
x1(1:2:$) = x;

// (b) x2(n) = x(2n) = (0.25)^n u(n) -> X2(z) = 0.5[X(sqrt(z)) + X(-sqrt(z))] = z / (z - 0.25)
//     ROC: |z| > 0.25
n2 = 0:floor(N / 2);
x2 = x(1:2:$);

// Numerical verification at z0 = 2.0 (inside all ROCs)
z0 = 2.0;

X1Num    = sum(x1 .* (z0 .^ (-n1)));
X1Theory = eval_X(z0^2, aVal);

X2Num    = sum(x2 .* (z0 .^ (-n2)));
X2Theory = 0.5 * (eval_X(sqrt(z0), aVal) + eval_X(-sqrt(z0), aVal));

err1 = abs(X1Num - X1Theory);
err2 = abs(X2Num - X2Theory);

mprintf("Test signal: x(n) = (0.5)^n u(n), evaluated at z0 = %.1f\n", z0);
mprintf("ROC of X(z) : |z| > %.4f\n", aVal);
mprintf("ROC of X1(z): |z| > %.4f (sqrt(0.5))\n", sqrt(aVal));
mprintf("ROC of X2(z): |z| > %.4f (0.5^2)\n", aVal^2);
mprintf("(a) |X1_num - X(z^2)|                       = %.12e\n", err1);
mprintf("(b) |X2_num - 0.5*(X(sqrt(z))+X(-sqrt(z)))| = %.12e\n", err2);

if max([err1, err2]) < 1d-10 then
    mprintf("PASS: Both Z-domain scaling identities verified.\n");
else
    mprintf("FAIL: Verification error exceeds threshold.\n");
end


// ================================================================
// DISPLAY SIGNALS AND ROCs IN ONE WINDOW (3 x 2 GRID)
// ================================================================

scf(313);
clf();

f = gcf();
f.name = "Exercise 3.13 - Time Scaling Signals and ROCs";
f.figure_size = [1300, 920];

// ---------------- Row 1: Original x(n) & ROC --------------------
subplot(3, 2, 1);
draw_stem(0:12, x(1:13), 2, "bo", "Original Signal x(n) = (0.5)^n u(n)", "x(n)");

subplot(3, 2, 2);
draw_pz_exterior([0], [aVal], aVal, "ROC: |z| > 0.5", "Pole-Zero & ROC of X(z)");

// ---------------- Row 2: Upsampled x1(n) & ROC ------------------
subplot(3, 2, 3);
draw_stem(0:24, x1(1:25), 5, "ro", "(a) x1(n) = x(n/2) for even n  <-->  X1(z) = X(z^2)", "x1(n)");

subplot(3, 2, 4);
draw_pz_exterior([0; 0], [sqrt(aVal); -sqrt(aVal)], sqrt(aVal), ..
                 "ROC: |z| > 0.707", "Pole-Zero & ROC of X1(z) = X(z^2)");

// ---------------- Row 3: Downsampled x2(n) & ROC ----------------
subplot(3, 2, 5);
draw_stem(0:12, x2(1:13), 3, "go", "(b) x2(n) = x(2n)  <-->  X2(z) = 0.5[X(sqrt(z)) + X(-sqrt(z))]", "x2(n)");

subplot(3, 2, 6);
draw_pz_exterior([0], [aVal^2], aVal^2, "ROC: |z| > 0.25", "Pole-Zero & ROC of X2(z)");
