close all;
clear all;
clc;

load('cylinder_Re100.mat')

u_bar=squeeze(mean(u(150:end,:,:)));
v_bar=squeeze(mean(v(150:end,:,:)));

figure

subplot(2,1,1)
pcolor(x,y,u_bar)
rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]);
xlabel('x')
ylabel('y')
title('u')
shading interp
axis equal tight
colorbar

subplot(2,1,2)
pcolor(x,y,v_bar)
rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]);
xlabel('x')
ylabel('y')
title('v')
shading interp
axis equal tight
colorbar

figure(2)
streamline(x,y,u_bar,v_bar,squeeze(u(1,:,:)),squeeze(v(1,:,:)))


