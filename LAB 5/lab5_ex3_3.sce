// ================================================================
// DIGITAL SIGNAL PROCESSING - LAB 5
// ADDITIONAL EXERCISE 3.3: Z-TRANSFORM AND ROC SKETCH
// ================================================================

clear;
clc;

// ----------------------------------------------------------------
// Helper function: draw Pole-Zero diagram + shaded ROC
// rocType: "annulus"  (rInner < |z| < rOuter)
//          "exterior" (|z| > rInner)
// ----------------------------------------------------------------

function draw_roc(zeroLoc, poleLoc, rInner, rOuter, rocType, figureTitle)

    theta = linspace(0, 2*%pi, 500);

    // Dynamic plotting range.
    rMax = 1.2;
    if rInner < %inf then rMax = max(rMax, rInner); end
    if rOuter < %inf then rMax = max(rMax, rOuter); end

    allValues = [rMax; abs(real(zeroLoc(:))); abs(imag(zeroLoc(:))); ..
                 abs(real(poleLoc(:))); abs(imag(poleLoc(:)))];
    plotLimit = max(allValues) + 0.6;

    a = gca();

    // Shade ROC region and draw dashed ROC boundaries.
    if rocType == "annulus" then
        a.background = color("white");

        xfpoly(rOuter*cos(theta), rOuter*sin(theta), color("light blue"));
        hOuter = gce(); hOuter.line_mode = "off";

        xfpoly(rInner*cos(theta), rInner*sin(theta), color("white"));
        hInner = gce(); hInner.line_mode = "off";

        plot(rOuter*cos(theta), rOuter*sin(theta), "b--");
        hRoc = gce().children(1);
        plot(rInner*cos(theta), rInner*sin(theta), "b--");

    else // "exterior"
        a.background = color("light blue");

        xfpoly(rInner*cos(theta), rInner*sin(theta), color("white"));
        hMask = gce(); hMask.line_mode = "off";

        plot(rInner*cos(theta), rInner*sin(theta), "b--");
        hRoc = gce().children(1);
    end

    // Draw unit circle, zeros, and poles (capture handles for legend).
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
                  ["ROC boundary", "Unit circle (|z|=1)", "Zeros", "Poles"]);
    hLeg.font_size = 1;

endfunction


// ================================================================
// DISPLAY ALL 4 ROC PLOTS IN ONE WINDOW
// ================================================================

mprintf("\n========== EXERCISE 3.3: Z-TRANSFORM AND ROC ==========\n");
mprintf("(a) X1(z) = (5z/3) / ((z - 1/3)*(2 - z)),       ROC: 1/3 < |z| < 2\n");
mprintf("(b) X2(z) = (-5z/3) / ((z - 1/3)*(z - 2)),      ROC: |z| > 2\n");
mprintf("(c) X3(z) = (5z^5/3) / ((z - 1/3)*(2 - z)),     ROC: 1/3 < |z| < 2\n");
mprintf("(d) X4(z) = 5z / ((3 - z)*(2z - 1)),            ROC: 1/2 < |z| < 3\n");

scf(303);
clf();

f = gcf();
f.name = "Exercise 3.3 - ROC Diagrams";
f.figure_size = [1100, 950];

subplot(2, 2, 1);
draw_roc([0], [1/3; 2], 1/3, 2, "annulus", "(a) X1(z) - ROC: 1/3 < |z| < 2");

subplot(2, 2, 2);
draw_roc([0], [1/3; 2], 2, %inf, "exterior", "(b) X2(z) - ROC: |z| > 2");

subplot(2, 2, 3);
draw_roc([0], [1/3; 2], 1/3, 2, "annulus", "(c) X3(z) = z^4 X1(z) - ROC: 1/3 < |z| < 2");

subplot(2, 2, 4);
draw_roc([0], [1/2; 3], 1/2, 3, "annulus", "(d) X4(z) = X1(z^-1) - ROC: 1/2 < |z| < 3");
