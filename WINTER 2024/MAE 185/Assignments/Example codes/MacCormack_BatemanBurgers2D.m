% MacCormack for 2-D Bateman-Burger's Equation
% OTS, 2020

%clear variables
close all
clear all
clc
addpath('functions_periodic')

%load('data/gotritons_uv','u','v','xx','yy');
load('gotritons_uv.mat')

%% PARAMETERS
% Solver parameters
d           = 0.0005;   % diffusion coefficient
t_end       = 2;        % final time

% Grid parameters
[nx,ny]     = size(xx);
dx          = xx(2,1)-xx(1,1);
dy          = yy(1,2)-yy(1,1);

% Time stepping parameters
safety_fac  = 1.1;      % safety factor     

% Caxis limits
caxislims   = [0 2];

% Boundary conditions (Constant value)
u_top       = 0;
v_top       = 0;
u_bottom    = 0;
v_bottom    = 0;

%% MACCORMACK
% INITIAL BC ENFORCEMENT
u(:,1)      = u_bottom;
u(:,end)    = u_top;
v(:,1)      = v_bottom;
v(:,end)    = v_top; 

% TIMESTEP
% determine time step from stability requirenment
c           = [max(max(abs(u))) max(max(abs(v)))];
dt_max      = 1/(c(1)/dx + c(2)/dy);                % maximum time step
dt          = dt_max/safety_fac;                    % timestep

t = 0;
while t < t_end
   
    %%%%%%%%%%%%%%
    % MACCORMACK % 
    %%%%%%%%%%%%%%
    
    % PREDICTOR (forward FD)
    dudx        = ddx_fwd(u,dx,'periodic');
    dudy        = ddy_fwd(u,dy);
    dvdx        = ddx_fwd(v,dx,'periodic');
    dvdy        = ddy_fwd(v,dy);
    
    d2udx2      = d2dx2(u,dx,'periodic');
    d2udy2      = d2dy2(u,dy);
    d2vdx2      = d2dx2(v,dx,'periodic');
    d2vdy2      = d2dy2(v,dy);
    
    u_pre = u + dt*(-u.*dudx - v.*dudy + d*d2udx2 + d*d2udy2);
    v_pre = v + dt*(-u.*dvdx - v.*dvdy + d*d2vdx2 + d*d2vdy2);
    
    % ENFORCE BCS (predictor)
    u(:,1)      = u_bottom;
    u(:,end)    = u_top;
    v(:,1)      = v_bottom;
    v(:,end)    = v_top; 
    
    
    % CORRECTOR (backward FD)
    dudx_pre = ddx_bwd(u_pre,dx,'periodic');
    dudy_pre = ddy_bwd(u_pre,dy);
    dvdx_pre = ddx_bwd(v_pre,dx,'periodic');
    dvdy_pre = ddy_bwd(v_pre,dy);
    
    d2udx2_pre      = d2dx2(u_pre,dx,'periodic');
    d2udy2_pre      = d2dy2(u_pre,dy);
    d2vdx2_pre      = d2dx2(v_pre,dx,'periodic');
    d2vdy2_pre      = d2dy2(v_pre,dy);
    
    u = 0.5*(u + u_pre) + 0.5*dt*(-u_pre.*dudx_pre - v_pre.*dudy_pre + d*d2udx2_pre + d*d2udy2_pre);
    v = 0.5*(v + v_pre) + 0.5*dt*(-u_pre.*dvdx_pre - v_pre.*dvdy_pre + d*d2vdx2_pre + d*d2vdy2_pre);
    
    % ENFORCE BCS (corrector)
    u(:,1)      = u_bottom;
    u(:,end)    = u_top;
    v(:,1)      = v_bottom;
    v(:,end)    = v_top; 
    
      
    % PLOTTING
    figure(2)
    subplot(2,1,1);
    pcolor(xx,yy,u); shading interp; axis equal tight; caxis(caxislims); colorbar;
    title('u');
    
    subplot(2,1,2);
    pcolor(xx,yy,v); shading interp; axis equal tight; caxis(caxislims); colorbar;
    title('v');
    
    title(['t = ' num2str(t)]);
    drawnow
    
    
    % NEXT TIMESTEP
    % determine time step from stability requirenment
    t           = t + dt;                              % time increment
    c           = [max(max(abs(u))) max(max(abs(v)))]; % max u and v values
    dt_max      = 1/(c(1)/dx + c(2)/dy);               % maximum time step
    dt          = dt_max/safety_fac;                   % timestep for next round
 
end