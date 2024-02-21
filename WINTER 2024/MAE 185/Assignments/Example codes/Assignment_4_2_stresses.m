clear variables
close all
clc

addpath('functions_periodic')
load('supersonicJetLES_xyPlane.mat')

% grid spacing
dx = xx(2,1)-xx(1,1);
dy = yy(1,2)-yy(1,1);

% viscosity
mu  = sutherland(T);

% compute velocity gradients using different FDs
dudx_fwd    = ddx_fwd(u,dx);
dudx_bwd    = ddx_bwd(u,dx);
dudx_central= ddx_central(u,dx);
dudy_fwd    = ddy_fwd(u,dy);
dudy_bwd    = ddy_bwd(u,dy);
dudy_central= ddy_central(u,dy);

dvdx_fwd    = ddx_fwd(v,dx);
dvdx_bwd    = ddx_bwd(v,dx);
dvdx_central= ddx_central(v,dx);
dvdy_fwd    = ddy_fwd(v,dy);
dvdy_bwd    = ddy_bwd(v,dy);
dvdy_central= ddy_central(v,dy);

figure
tau_xx      = 2*mu.*(dudx_fwd - 1/3*(dudx_fwd + dvdy_fwd));


% top row: forward differences in x, central in y
subplot(2,3,1)
tau_xx      = 2*mu.*(dudx_fwd - 1/3*(dudx_fwd + dvdy_central));
pcolor(xx,yy,tau_xx), shading interp, axis equal tight
title('\tau_x_x')
xlabel('x'); ylabel('y')
cb = colorbar; ylabel(cb,'\tau_x_x [kg/m/s^2]')
caxis([-0.5 0.5])

subplot(2,3,2)
tau_yy      = 2*mu.*(dvdy_central - 1/3*(dudx_fwd + dvdy_central));
pcolor(xx,yy,tau_yy), shading interp, axis equal tight
title('\tau_y_y')
xlabel('x'); ylabel('y')
cb = colorbar; ylabel(cb,'\tau_y_y [kg/m/s^2]')
caxis([-0.5 0.5])

subplot(2,3,3)
tau_xy      = mu.*(dudy_central + dvdx_fwd);
pcolor(xx,yy,tau_xy), shading interp, axis equal tight
title('\tau_x_y')
xlabel('x'); ylabel('y')
cb = colorbar; ylabel(cb,'\tau_x_y [kg/m/s^2]')
caxis([-0.5 0.5])

% bottom row: central differences in x, backward in y
subplot(2,3,4)
tau_xx      = 2*mu.*(dudx_central - 1/3*(dudx_central + dvdy_bwd));
pcolor(xx,yy,tau_xx), shading interp, axis equal tight
title('\tau_x_x')
xlabel('x'); ylabel('y')
cb = colorbar; ylabel(cb,'\tau_x_x [kg/m/s^2]')
caxis([-0.5 0.5])

subplot(2,3,5)
tau_yy      = 2*mu.*(dvdy_bwd - 1/3*(dudx_central + dvdy_bwd));
pcolor(xx,yy,tau_yy), shading interp, axis equal tight
title('\tau_y_y')
xlabel('x'); ylabel('y')
cb = colorbar; ylabel(cb,'\tau_y_y [kg/m/s^2]')
caxis([-0.5 0.5])

subplot(2,3,6)
tau_xy      = mu.*(dudy_bwd + dvdx_central);
pcolor(xx,yy,tau_xy), shading interp, axis equal tight
title('\tau_x_y')
xlabel('x'); ylabel('y')
cb = colorbar; ylabel(cb,'\tau_x_y [kg/m/s^2]')
caxis([-0.5 0.5])


%%
%%%%%%%%%%%%%
% FUNCTIONS %
%%%%%%%%%%%%%

function [mu] = sutherland(T)
% Sutherland's law
% (standard air values)
S1     = 110.4;                 % Sutherland temperature
T_ref  = 280.0;                 % reference temperature
mu_ref = 1.735e-5;              % reference dynamic viscosity

% viscosity
mu              = mu_ref*(T_ref+S1)./(T+S1).*(T/T_ref).^(3/2);
end