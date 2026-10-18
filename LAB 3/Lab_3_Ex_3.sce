function [yn, yorigin] = fold(xn, xorigin)
    // Folding operation: y(n) = x(-n)
    // xn      : vector representing x(n)
    // xorigin : index of the origin in xn
    // yn      : folded signal vector
    // yorigin : index of the origin in yn

    if argn(2) < 2 then
        error("Usage: fold(xn, xorigin)");
    end

    if size(xn, 1) > 1 & size(xn, 2) > 1 then
        error("xn must be a 1-D vector");
    end

    if xorigin < 1 | xorigin > length(xn) | floor(xorigin) <> xorigin then
        error("xorigin must be an integer index inside xn");
    end

    xn = matrix(xn, 1, length(xn));
    N  = length(xn);

    yn      = xn($:-1:1);          // reverse the samples
    yorigin = N - xorigin + 1;     // origin moves to the mirrored position

    // n-values of each signal
    xaxis = (1 - xorigin):(N - xorigin);
    yaxis = (1 - yorigin):(N - yorigin);

    // Common axis limits (same n scale, integer ticks)
    nmin = min(xaxis(1), yaxis(1)) - 1;
    nmax = max(xaxis($), yaxis($)) + 1;
    amax = ceil(max([xn yn 1])) + 1;
    amin = floor(min([xn yn 0]));
    if amin < 0 then amin = amin - 1; end
    rect = [nmin, amin, nmax, amax];
    nax  = [1, nmax - nmin + 1, 1, amax - amin + 1];

    // One figure, two graphs
    scf(); clf();

    subplot(2, 1, 1);
    plot2d3(xaxis, xn, 2, "011", " ", rect, nax);
    plot2d(xaxis, xn, -9, "000");
    xgrid();
    a = gca(); a.x_location = "origin"; a.y_location = "origin";
    xtitle("x(n)", "", "Amplitude");

    subplot(2, 1, 2);
    plot2d3(yaxis, yn, 5, "011", " ", rect, nax);
    plot2d(yaxis, yn, -9, "000");
    xgrid();
    a = gca(); a.x_location = "origin"; a.y_location = "origin";
    xtitle("y(n) = x(-n)", "n", "Amplitude");
endfunction

// ---------- Test ----------
testXn = [0 0 2 1 3];      // n = -2 -1 0 1 2
testXorigin = 3;
[testYn, testYorigin] = fold(testXn, testXorigin);

nx = (1:length(testXn)) - testXorigin;
ny = (1:length(testYn)) - testYorigin;

// y(n) must equal x(-n) at every n
ok = %t;
for i = 1:length(ny)
    j = find(nx == -ny(i));
    if isempty(j) | testYn(i) <> testXn(j) then
        ok = %f;
    end
end

if ~ok then
    error("Fold test failed");
end
disp(testYn)
disp(testYorigin)
disp("Fold test passed");
