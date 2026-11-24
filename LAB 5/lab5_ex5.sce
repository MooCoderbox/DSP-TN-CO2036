// ================================================================
// DIGITAL SIGNAL PROCESSING - LAB 5
// EXERCISE 5: IMPULSE, ZERO-INPUT AND ZERO-STATE RESPONSES
// ================================================================

clear;
clc;

mprintf("\n========== EXERCISE 5: LTI SYSTEM RESPONSES ==========\n");

// System: y(n) = 2*y(n-1) - 3*y(n-2) + x(n) + x(n-1)
N = 10;
n = 0:N;

theta = atan(sqrt(2));
p1 = 1 + %i * sqrt(2);
p2 = 1 - %i * sqrt(2);

// ================================================================
// METHOD 1: ANALYTICAL SOLUTIONS (Z-TRANSFORM & ONE-SIDED Z+)
// ================================================================

hTheory   = (sqrt(3) .^ (n + 1)) .* cos((n - 1) * theta);
yziTheory = real((-0.5 + %i * sqrt(2)) * (p1 .^ n) + (-0.5 - %i * sqrt(2)) * (p2 .^ n));
yzsTheory = (2 .^ (n + 1)) - (sqrt(3) .^ (n + 1)) .* cos((n + 1) * theta);

// ================================================================
// METHOD 2: DIRECT DIFFERENCE EQUATION RECURSION
// ================================================================

hSim   = zeros(1, length(n));
yziSim = zeros(1, length(n));
yzsSim = zeros(1, length(n));

delta = bool2s(n == 0);
xIn   = 2 .^ n; // x(n) = 2^n * u(n)

for k = 1:length(n)
    // 1. Impulse response h(n): x(n) = delta(n), zero initial conditions
    hPrev1 = 0; hPrev2 = 0; dPrev1 = 0;
    if k > 1 then
        hPrev1 = hSim(k - 1);
        dPrev1 = delta(k - 1);
    end
    if k > 2 then
        hPrev2 = hSim(k - 2);
    end
    hSim(k) = 2 * hPrev1 - 3 * hPrev2 + delta(k) + dPrev1;

    // 2. Zero-input response y_zi(n): x(n) = 0, y(-1) = 1, y(-2) = 1
    if k == 1 then
        ziPrev1 = 1;
        ziPrev2 = 1;
    elseif k == 2 then
        ziPrev1 = yziSim(1);
        ziPrev2 = 1;
    else
        ziPrev1 = yziSim(k - 1);
        ziPrev2 = yziSim(k - 2);
    end
    yziSim(k) = 2 * ziPrev1 - 3 * ziPrev2;

    // 3. Zero-state response y_zs(n): x(n) = 2^n u(n), zero initial conditions
    zsPrev1 = 0; zsPrev2 = 0; xPrev1 = 0;
    if k > 1 then
        zsPrev1 = yzsSim(k - 1);
        xPrev1  = xIn(k - 1);
    end
    if k > 2 then
        zsPrev2 = yzsSim(k - 2);
    end
    yzsSim(k) = 2 * zsPrev1 - 3 * zsPrev2 + xIn(k) + xPrev1;
end

// ================================================================
// DISPLAY & VERIFY RESULTS
// ================================================================

mprintf("\nAll samples n = 0..%d (Table 1 verification):\n", N);
mprintf("  n |    h(n) |   y_zi(n) |   y_zs(n)\n");
mprintf("----|---------|-----------|----------\n");
for k = 1:length(n)
    mprintf(" %2d | %7.2f | %9.2f | %8.2f\n", n(k), hSim(k), yziSim(k), yzsSim(k));
end

errH   = max(abs(hTheory - hSim));
errYzi = max(abs(yziTheory - yziSim));
errYzs = max(abs(yzsTheory - yzsSim));

mprintf("\nMax absolute error h(n)   = %.12f\n", errH);
mprintf("Max absolute error y_zi   = %.12f\n", errYzi);
mprintf("Max absolute error y_zs   = %.12f\n", errYzs);

if max([errH, errYzi, errYzs]) < 1d-10 then
    mprintf("PASS: All analytical formulas match difference equation.\n");
else
    mprintf("FAIL: Results do not match.\n");
end

// ================================================================
// DISPLAY ALL RESPONSES IN ONE WINDOW
// ================================================================

scf(5);
clf();

f = gcf();
f.name = "Exercise 5 - System Responses (h, y_zi, y_zs)";
f.figure_size = [1000, 820];

// ---------------- Plot 1: h(n) ----------------------------------
subplot(3, 1, 1);
a = gca(); a.auto_clear = "off";
plot2d3(n, hTheory, style=2);
e1 = gce(); e1.children.thickness = 2;
plot(n, hTheory, "bo");
plot([-0.5, N + 0.5], [0, 0], "k-");
a.auto_clear = "on";
xgrid();
xtitle("Impulse Response h(n)", "n", "h(n)");

// ---------------- Plot 2: y_zi(n) -------------------------------
subplot(3, 1, 2);
a = gca(); a.auto_clear = "off";
plot2d3(n, yziTheory, style=5);
e2 = gce(); e2.children.thickness = 2;
plot(n, yziTheory, "ro");
plot([-0.5, N + 0.5], [0, 0], "k-");
a.auto_clear = "on";
xgrid();
xtitle("Zero-Input Response y_zi(n) with y(-1) = y(-2) = 1", "n", "y_zi(n)");

// ---------------- Plot 3: y_zs(n) -------------------------------
subplot(3, 1, 3);
a = gca(); a.auto_clear = "off";
plot2d3(n, yzsTheory, style=3);
e3 = gce(); e3.children.thickness = 2;
plot(n, yzsTheory, "go");
plot([-0.5, N + 0.5], [0, 0], "k-");
a.auto_clear = "on";
xgrid();
xtitle("Zero-State Response y_zs(n) for x(n) = 2^n u(n)", "n", "y_zs(n)");
