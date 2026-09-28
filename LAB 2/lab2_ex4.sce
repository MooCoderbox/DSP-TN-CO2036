clf;
n = -5:5;
// u_r(n) = n * u(n)
ur = n .* bool2s(n >= 0);

// Vẽ đồ thị
plot2d3(n, ur);
title("Unit Ramp Signal u_r(n)");
xlabel("n");
ylabel("u_r(n)");
