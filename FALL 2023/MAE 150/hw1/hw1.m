close all; clear all; clc

%% Operation

%uses functions 
% Tfr(theta) for rotating clockwise in "theta" angle
% Tt (tx,ty) for translating in x-direction(tx) and y-direction(ty)
% Ts (Sx,Sy) for scaling in x-direction(Sx) and y-direction(Sy)
% Tfx for reflecting over x-axis
% Tfy for reflectin over y_axis
% plotf (A) to plot figure in matrix A

A= [ 3 3 4 4 5 5 6 6 3;
     2 4 4 3 3 4 4 2 2;
     1 1 1 1 1 1 1 1 1];

figure (1)
xlim([-10 10])
ylim([-10 10])
xline(0)
yline(0)
box on; grid on;
hold on

plotf(A)

%moving A to 6,3

A1=Tt(6-3,3-2)*A;
plotf(A1)

A2=Tfy*A1;

plotf(A2)

A3=Tt(6,-3)*Ts(0.6,0.6)*Tt(-6,3)*A2;

plotf(A3)

A4=Tt(7,-2)*Tr(315)*Tt(-7,2)*A3;

plotf(A4)