%% Problem 2
clear; clc;

EI = 0.001;
L = 2.5;
m = 250;
M = (m/2)*[1 0 0 0;0 (L^2)/12 0 0;0 0 1 0;0 0 0 (L^2)/12];
K = (EI/L)*[12/L^2, 6/L, -12/L^2, 6/L;6/L, 4, -6/L 2; -12/L^2, -6/L, 12/L^2, -6/L;6/L, 2, -6/L, 4];

K1 = zeros(10,10);
K2 = zeros(10,10);
K3 = zeros(10,10);
K4 = zeros(10,10);

K1(1:4,1:4) = K;
K2(3:6,3:6) = K;
K3(5:8,5:8) = K;
K4(7:10,7:10) = K;

% Find the overall stiffness matrix
Kg = K1 + K2 + K3 + K4;


M1 = zeros(10,10);
M2 = zeros(10,10);
M3 = zeros(10,10);
M4 = zeros(10,10);

M1(1:4,1:4) = M;
M2(3:6,3:6) = M;
M3(5:8,5:8) = M;
M4(7:10,7:10) = M;

% Find the overall stiffness matrix
Mg = M1 + M2 + M3 + M4;

[v lam] = eig(inv(Mg)*Kg);

disp("Resonant Frequencies (w^2):");
disp(lam);

disp("Mode Shapes:")
disp(v);