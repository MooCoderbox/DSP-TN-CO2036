function [yn, yorigin] = delay(xn, xorigin, k)
    // Delay operation: y(n) = x(n - k), where k > 0
    // xn      : vector representing x(n)
    // xorigin : index of the origin in xn
    // k       : delay value
    // yn      : delayed signal vector
    // yorigin : index of the origin in yn

    if argn(2) < 3 then
        error("Usage: delay(xn, xorigin, k)");
    end

    if floor(k) <> k | k <= 0 then
        error("k must be a positive integer");
    end

    if size(xn, 1) > 1 & size(xn, 2) > 1 then
        error("xn must be a 1-D vector");
    end

    xn = matrix(xn, 1, length(xn));
    yn = xn;                       // samples are unchanged...
    yorigin = xorigin - k;         // ...only the origin moves

    // Sample indices (n values) of each signal
    xaxis = (1 - xorigin):(length(xn) - xorigin);
    yaxis = (1 - yorigin):(length(yn) - yorigin);

    // Common axis limits so both plots are aligned on the same n scale
    nmin = min(xaxis(1), yaxis(1)) - 1;
    nmax = max(xaxis($), yaxis($)) + 1;
    amax = ceil(max([xn yn 1])) + 1;       // integer amplitude limits
    amin = floor(min([xn yn 0]));
    if amin < 0 then amin = amin - 1; end
    rect = [nmin, amin, nmax, amax];
    nax  = [1, nmax - nmin + 1, 1, amax - amin + 1];   // labels = intervals + 1

    // One figure, two stacked graphs
    scf(); clf();

    subplot(2, 1, 1);
    plot2d3(xaxis, xn, 2, "011", " ", rect, nax);
    plot2d(xaxis, xn, -9, "000");      // dots on stem tops
    xgrid();
    a = gca(); a.x_location = "origin"; a.y_location = "origin";
    xtitle("x(n)", "n", "Amplitude");

    subplot(2, 1, 2);
    plot2d3(yaxis, yn, 5, "011", " ", rect, nax);
    plot2d(yaxis, yn, -9, "000");
    xgrid();
    a = gca(); a.x_location = "origin"; a.y_location = "origin";
    xtitle("y(n) = x(n - " + string(k) + ")", "n", "Amplitude");
endfunction

// Test: y(n) = x(n - k) means every sample moves k positions to the right on the n-axis
testXn = [1,  -2,  3,  6];
testXorigin = 3;
testK = 1;
[testYn, testYorigin] = delay(testXn, testXorigin, testK);

nx = (1:length(testXn)) - testXorigin;   // n-values of x(n): -2 -1 0 1 2
ny = (1:length(testYn)) - testYorigin;   // n-values of y(n):  0  1 2 3 4

if or(testYn <> testXn) | or(ny <> nx + testK) | testYorigin <> testXorigin - testK then
    error("Delay test failed");
end
disp(testYn)
disp(testYorigin)
disp("Delay test passed");
