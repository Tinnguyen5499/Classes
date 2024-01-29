Sclose all;
clear all;
clc;

%% Access folder with all the functions
addpath("Functions");

%% Load data
load('cylinder_RE100.mat');

%% find the time step
[nt,nx,ny] = size(u);
dx=diff(x);
dx=dx(1);
dy=diff(y');
dy=dy(1);

%% Looping through all time step and calculate vorticity for each time step
for ti=1:nt

    wz=ddx_fwd(squeeze(v(ti,:,:)),dx)-ddy_fwd(squeeze(u(ti,:,:)),dy); %calculating vorticity

    %% Plotting
    pcolor(x,y,wz)
    rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]);
    xlabel('x')
    ylabel('y')
    title('Vorticity')
    shading interp
    axis equal tight
    colorbar
    drawnow

end 

