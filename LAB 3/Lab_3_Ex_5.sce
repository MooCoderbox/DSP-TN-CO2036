function [yn, yorigin] = multi(x1n, x1origin, x2n, x2origin)
    // Multiplication operation: y(n) = x1(n) * x2(n)
    // x1n, x2n          : vectors representing x1(n), x2(n)
    // x1origin, x2origin: index of the origin in x1n, x2n
    // yn                : product signal vector
    // yorigin           : index of the origin in yn

    if argn(2) < 4 then
        error("Usage: multi(x1n, x1origin, x2n, x2origin)");
    end

    if (size(x1n, 1) > 1 & size(x1n, 2) > 1) | (size(x2n, 1) > 1 & size(x2n, 2) > 1) then
        error("x1n and x2n must be 1-D vectors");
    end

    if x1origin < 1 | x1origin > length(x1n) | floor(x1origin) <> x1origin then
        error("x1origin must be an integer index inside x1n");
    end
    if x2origin < 1 | x2origin > length(x2n) | floor(x2origin) <> x2origin then
        error("x2origin must be an integer index inside x2n");
    end

    x1n = matrix(x1n, 1, length(x1n));
    x2n = matrix(x2n, 1, length(x2n));

    // n-values of each input signal
    n1 = (1 - x1origin):(length(x1n) - x1origin);
    n2 = (1 - x2origin):(length(x2n) - x2origin);

    // Common n range covering both signals
    nmin = min(n1(1), n2(1));
    nmax = max(n1($), n2($));
    n    = nmin:nmax;
    L    = length(n);

    // Zero-pad both signals onto the common range
    x1e = zeros(1, L);  x1e(n1 - nmin + 1) = x1n;
    x2e = zeros(1, L);  x2e(n2 - nmin + 1) = x2n;

    // Multiply sample by sample
    yn      = x1e .* x2e;
    yorigin = 1 - nmin;            // index of n = 0 in yn

    // Common axis limits (same n scale, integer ticks)
    pmin = nmin - 1;
    pmax = nmax + 1;
    amax = ceil(max([x1e x2e yn 1])) + 1;
    amin = floor(min([x1e x2e yn 0]));
    if amin < 0 then amin = amin - 1; end
    rect = [pmin, amin, pmax, amax];
    nax  = [1, pmax - pmin + 1, 1, amax - amin + 1];

    // One figure, three graphs
    scf(); clf();

    subplot(3, 1, 1);
    plot2d3(n, x1e, 2, "011", " ", rect, nax);
    plot2d(n, x1e, -9, "000");
    xgrid();
    a = gca(); a.x_location = "origin"; a.y_location = "origin";
    xtitle("x1(n)", "", "Amplitude");

    subplot(3, 1, 2);
    plot2d3(n, x2e, 3, "011", " ", rect, nax);
    plot2d(n, x2e, -9, "000");
    xgrid();
    a = gca(); a.x_location = "origin"; a.y_location = "origin";
    xtitle("x2(n)", "", "Amplitude");

    subplot(3, 1, 3);
    plot2d3(n, yn, 5, "011", " ", rect, nax);
    plot2d(n, yn, -9, "000");
    xgrid();
    a = gca(); a.x_location = "origin"; a.y_location = "origin";
    xtitle("y(n) = x1(n) . x2(n)", "n", "Amplitude");
endfunction

// ---------- Test ----------
x1 = [1 2 3 4];      x1o = 2;    // n = -1 0 1 2
x2 = [2 1 3 1 2];    x2o = 3;    // n = -2 -1 0 1 2
[testYn, testYorigin] = multi(x1, x1o, x2, x2o);

// Common range n = -2..2:
// x1(n) = [0 1 2 3 4], x2(n) = [2 1 3 1 2]  ->  y(n) = [0 1 6 3 8]
expectedYn = [0 1 6 3 8];
expectedYorigin = 3;

if or(testYn <> expectedYn) | testYorigin <> expectedYorigin then
    error("Multi test failed");
end
disp(testYn)
disp(testYorigin)
disp("Multi test passed");
