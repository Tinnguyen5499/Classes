close all;
clear all;
clc;

load("supersonicJetLES_xyPlane.mat");
addpath("functions");

cp=1005;
cv=718;
mu0=1.735*10^(-5);
S1=110.4;
R=cp-cv;

U=prim2cons(rho,u,v,T,cv);
[rho,u,v,T,p,e,Et] = cons2prim(U,R,cv);
[mu] = sutherland(T);

%% Plotting

variables={squeeze(U(1,:,:));squeeze(U(2,:,:));squeeze(U(3,:,:));T;p;e;Et;mu};
titles={'\rho';'\rhou';'\rhov';'T';'p';'e';'E_{t}';'\mu' };
symbol_units={'\rho [kg/m^3]';'\rhou [kg/s/m^2]';'\rhou [kg/s/m^2]';'T [K]';'p [kg/m/s]';'e [J/kg]';'E_{t} [kg/m/s^2]';'\mu [kg/m/s]' };

for n=1:8
subplot(2,4,n)
    pcolor(xx,yy,variables{n});
    xlabel('x')
    ylabel('y')
    colorbar
    cb = colorbar; 
    ylabel(cb,symbol_units{n})
    title(titles{n})
    shading interp
    axis equal tight

end
    

