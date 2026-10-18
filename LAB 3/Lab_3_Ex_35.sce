// Bai 2.35: h = h1*[h2 + h3*h4]
clc; clear;

L  = 30;
h1 = [0.5 0.25 0.5];          // n = -1, 0, 1
h2 = (0:L) + 1;               // (n+1)u(n), n = 0..L
h3 = h2;
h4 = [0 0 1];                 // delta(n-2), n = 0..2

// (a),(b): tong the
h34 = convol(h3, h4);                         // bat dau tai n = 0
g   = [h2, zeros(1, length(h34)-length(h2))] + h34;
h   = convol(h1, g);                          // bat dau tai n = -1
nh  = -1 + (0:length(h)-1);

// Cong thuc ly thuyet cho n = -1..10
nn = -1:10;
he = 2.5*nn.*bool2s(nn>=2) + 0.5*bool2s(nn==-1) + 1.25*bool2s(nn==0) ..
     + 3*bool2s(nn==1);
disp("h(n), n = -1..10:"); disp(h(1:12));
if max(abs(h(1:12) - he)) > 1e-10 then
    error("Cau (b) khong khop");
end

// (c): dap ung voi x(n) = delta(n+2) + 3delta(n-1) - 4delta(n-3)
x  = [1 0 0 3 0 -4];          // n = -2..3
y  = convol(x, h);            // bat dau tai n = -3
ny = -3 + (0:length(y)-1);

m  = -3:10;
ye = 0.5*bool2s(m==-3) + 1.25*bool2s(m==-2) + 3*bool2s(m==-1) ..
   + 6.5*bool2s(m==0) + 11.25*bool2s(m==1) + 17*bool2s(m==2) ..
   + 22.5*bool2s(m==3) + 25.5*bool2s(m==4) + 27.5*bool2s(m>=5);
disp("y(n), n = -3..10:"); disp(y(1:14));
if max(abs(y(1:14) - ye)) > 1e-10 then
    error("Cau (c) khong khop");
end
disp("Bai 2.35: kiem tra thanh cong");

// Ve do thi
scf(); clf();
subplot(2,1,1);
plot2d3(nh(1:12), h(1:12), 2); plot2d(nh(1:12), h(1:12), -9, "000");
xgrid(); xtitle("h(n)", "n", "h(n)");
subplot(2,1,2);
plot2d3(ny(1:14), y(1:14), 5); plot2d(ny(1:14), y(1:14), -9, "000");
xgrid(); xtitle("y(n) voi x(n) = d(n+2) + 3d(n-1) - 4d(n-3)", "n", "y(n)");
