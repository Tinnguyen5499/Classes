close all;
clear all;
clc;

load('cylinder_Re100.mat')

%% find the temperal mean of u and v, while discarding the first 150 time instances
u_bar=squeeze(mean(u(150:end,:,:)));
v_bar=squeeze(mean(v(150:end,:,:)));

figure

%% plot u_bar

pcolor(x,y,u_bar)
rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]);
xlabel('x')
ylabel('y')
title('streamline overlay on the plot of u bar')
shading interp
axis equal tight

hold on

%% plot streamline

% Fixed the number of streamline as the example code for visibility

streamline(x',y',u_bar',v_bar', -4*ones(10,1), [-4 -3 -2 -1 -0.01 0.01 1 2 3 4])