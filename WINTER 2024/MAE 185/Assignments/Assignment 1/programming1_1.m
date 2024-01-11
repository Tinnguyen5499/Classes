close all;
clear all;
clc;

load('cylinder_Re100.mat')

figure

[nt,nx,ny] = size(u);

for ti=1:nt

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


