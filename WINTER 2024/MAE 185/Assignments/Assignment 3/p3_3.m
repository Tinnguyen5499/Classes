close all;
clear all;
clc;

addpath("functions")

load("gotritons.mat")
dx=diff(xx);
dx=dx(1);
dy=diff(yy');
dy=dy(1);
cx=1;
cy=1;

dt_max=(dx*dy)/(cx*dy+cy*dx);
SF=1;
dt_safe=dt_max/SF;
X=T;
clearvars T
T(1,:,:)=X;

t_end=2;
steps=t_end/dt_safe;


for n= 1:steps
    R(n,:,:)=cx*ddx_fwd(squeeze(T(n,:,:)),dx)+cy*ddy_fwd(squeeze(T(n,:,:)),dy);
    predictor(n+1,:,:)=T(n,:,:)-dt_safe*(R(n,:,:));
    Y(n+1,:,:)=cx*ddx_bwd(squeeze(predictor(n+1,:,:)),dx)  + cy*ddy_bwd(squeeze(predictor(n+1,:,:)),dy);
    T(n+1,:,:)=(1/2)*( (T(n,:,:)+predictor(n+1,:,:)) - dt_safe*( Y(n+1,:,:)));

    %% Plotting
    pcolor(xx,yy,squeeze(T(n,:,:)));
    xlabel('x')
    ylabel('y')
    title(['t=',num2str(n*dt_safe),'s'])
    shading interp
    axis equal tight
    colorbar
    drawnow


end