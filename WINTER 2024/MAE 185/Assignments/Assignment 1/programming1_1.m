close all;
clear all;
clc;

load('cylinder_Re100.mat')

figure

% find the time step
[nt,nx,ny] = size(u);

%loop over each time step to plot the flow
for ti=1:nt
    %plot u
    subplot(2,1,1)
    pcolor(x,y,squeeze(u(ti,:,:)))
    rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]);
    xlabel('x')
    ylabel('y')
    title('u')
    shading interp
    axis equal tight
    colorbar
    drawnow

    %plot v
    subplot(2,1,2)
    pcolor(x,y,squeeze(v(ti,:,:)))
    rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]);
    xlabel('x')
    ylabel('y')
    title('v')
    shading interp
    axis equal tight
    colorbar
    drawnow
     

end 


