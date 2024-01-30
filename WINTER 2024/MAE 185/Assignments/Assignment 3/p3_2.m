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

X(1,:,:)=T;

t_end=2;
steps=t_end/dt_safe;

for n= 1:steps
    Y(n,:,:)=(-cx*ddx_bwd(squeeze(X(n,:,:)),dx)-cy*ddy_bwd(squeeze(X(n,:,:)),dy))*dt_safe;
    X(n+1,:,:)=X(n,:,:)+Y(n,:,:);

    %% Plotting
    pcolor(xx,yy,squeeze(X(n,:,:)));
    xlabel('x')
    ylabel('y')
    title(['t=',num2str(n*dt_safe),'s'])
    shading interp
    axis equal tight
    colorbar
    drawnow


end
