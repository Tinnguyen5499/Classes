close all;
clear all;
clc;

addpath("functions")

load("gotritons.mat")
dx=diff(xx);
dx=dx(1);
dy=diff(yy');
dy=dy(1);

alpha=2;

dt_max=(dx^2*dy^2)/(4*(alpha*dy^2+alpha*dx^2));
SF=1;
dt_safe=dt_max/SF;

X(1,:,:)=T;

t_end=0.001;
steps=t_end/dt_safe;
for n= 1:steps
    Y(n,:,:)=(alpha*dt_safe*d2dx2(squeeze(X(n,:,:)),dx)+alpha*dt_safe*d2dy2(squeeze(X(n,:,:)),dy));
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