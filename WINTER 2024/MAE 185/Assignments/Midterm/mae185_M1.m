close all;
clear all;
clc;

addpath('Functions')

% initializaion
    % Define physical parameters and simulation parameters
    p0= 101300;%Pa
    T0= 288.15;%K
    rho0=1.225;%kg/m^3
    R=287;
    cp=1005;
    cv=718;
    gamma=1.4;
    mu0=1.735*10^-5;
    S1=110.4;
    Pr=0.71;
    a0=sqrt(gamma*R*T0);
    M=4;
    u0=M.*a0;
    n=0;
    dt=2.35*10^-11;
    time_step=1500;
    t=0;
    convdata=zeros(1,time_step);
   
    % Initialize grid (use ndgrid)
    nx = 75;
    ny = 80;
    L= 1*10^-5;
    H= 8*10^-6;
    dx=L/(nx-1);
    dy=H/(ny-1);
    [xx,yy]=ndgrid(0:dx:L,0:dy:H); 
    
    % Initialize primitive variables and apply BCs
    u=ones(nx,ny).*u0;
    v=zeros(nx,ny);
    T=ones(nx,ny).*T0;
    p=ones(nx,ny).*p0;
    [u,v,T,p,rho,~,Et]=BCs(u,v,T,p,T0,p0,u0,nx,ny,R,cv);

    % Initialize conservative variables
    U=prim2cons(rho,u,v,T,cv);

    % Preallocate other arrays with zeros (E,F,U_bar,etc.)
    E=zeros(4,nx,ny);
    F=zeros(4,nx,ny);
    var_prev=zeros(nx,ny);
    U_bar=zeros(4,nx,ny);
%End of intialization 

% time loop
while n<time_step+1
    % Optional: Compute based on stability requirement and most recent solution fields
    % Update t
    var_prev=u;
     
    %%%%%%%%%%%%%%%%%%
    % Predictor Step %
    %%%%%%%%%%%%%%%%%%
    
    % Update all necessary physical parameters
    [mu,~,k]=PhysicalParameters(T,nx,ny,gamma,R,cp,Pr);
    
    % Get partial derivatives for predictor step
        [dudx_BW,dudy_BW,dudx_central,dudy_central,...
            dvdx_BW,dvdy_BW,dvdx_central,dvdy_central,...
            dTdx_BW,dTdy_BW] =PDs2(u,v,T,dx,dy,'predictor');
    %Update E & F
        %Tau and q dot for E
        tauxx=2.*mu.*(dudx_BW - (1/3).* (dudx_BW+dvdy_central));
        tauxy=mu.*(dudy_central+dvdx_BW);
        q_dot_x=-k.*dTdx_BW;
        
        %Calculate E bar
        E(1,:,:)=     (squeeze(U(2,:,:)));
        E(2,:,:)=     (rho.* u.^2 + p - tauxx);
        E(3,:,:)=     (squeeze(U(2,:,:)).* v - tauxy);
        E(4,:,:)=     ((Et+p).*u-u.*tauxx-v.*tauxy+q_dot_x);
        
        %Tau and q dot for F
        tauyy=2.*mu.*(dvdy_BW - (1/3).* (dudx_central+dvdy_BW));
        tauxy=mu.*(dudy_BW+dvdx_central);
        q_dot_y=-k.*dTdy_BW;
        
        %Calculate F bar
        F(1,:,:)=   (squeeze(U(3,:,:)));
        F(2,:,:)=   (squeeze(U(2,:,:)).* v - tauxy); 
        F(3,:,:)=   (rho.* v.^2 + p - tauyy);
        F(4,:,:)=   ((Et+p).*v-v.*tauyy-u.*tauxy+q_dot_y);
    % E bar and F bar have been calculated
    
    % Compute U_bar (using forward differences for derivatives of E and F)
    U_bar(:,:,:)= U-dt.*(ddx_fwd(E,dx)+ddy_fwd(F,dy));

    %Update primitive variables to predicted t+1
    [~,u,v,T,p,~,~] = cons2prim(U_bar,R,cv);
    
    %Enforce BCs on predicted primitive variables
    [u,v,T,p,rho,~,Et]=BCs(u,v,T,p,T0,p0,u0,nx,ny,R,cv);
    
    %Update  U_bar with BCs
    U_bar=prim2cons(rho,u,v,T,cv);

    
    %%%%%%%%%%%%%%%%%%
    % Corrector Step %
    %%%%%%%%%%%%%%%%%%
    
    % Update all necessary physical parameters
    [mu,~,k]=PhysicalParameters(T,nx,ny,gamma,R,cp,Pr);
    
    % Get partial derivatives for corrector step
        % [dudx_FW,dudy_FW,dudx_central,dudy_central,...
        %     dvdx_FW,dvdy_FW,dvdx_central,dvdy_central,...
        %     dTdx_FW,dTdy_FW] =PDs2(u,v,T,dx,dy,'corrector');
          [dudx_FW,~,dudy_FW,~,dudx_central,dudy_central,...
          dvdx_FW,~,dvdy_FW,~,dvdx_central,dvdy_central,...
          dTdx_FW,~,dTdy_FW,~,~,~]=PDs(u,v,T,dx,dy);
    %Update E & F
        %Tau and q dot for E
        tauxx=2.*mu.*(dudx_FW - (1/3).* (dudx_FW+dvdy_central));
        tauxy=mu.*(dudy_central+dvdx_FW);
        q_dot_x=-k.*dTdx_FW;
        
        %Calculate E 
        E(1,:,:)=   (squeeze(U_bar(2,:,:)));
        E(2,:,:)=   (rho.* u.^2 + p - tauxx);
        E(3,:,:)=   (squeeze(U_bar(2,:,:)).* v - tauxy);
        E(4,:,:)=   ((Et+p).*u-u.*tauxx-v.*tauxy+q_dot_x);
        
        %Tau and q dot for F
        tauyy=2.*mu.*(dvdy_FW - (1/3).* (dudx_central+dvdy_FW));
        tauxy=mu.*(dudy_FW+dvdx_central);
        q_dot_y=-k.*dTdy_FW;
        
        %Calculate F 
        F(1,:,:)=   (squeeze(U_bar(3,:,:)));
        F(2,:,:)=   (squeeze(U_bar(2,:,:)).* v - tauxy); 
        F(3,:,:)=   (rho.* v.^2 + p - tauyy);
        F(4,:,:)=   ((Et+p).*v-v.*tauyy-u.*tauxy+q_dot_y);
    % E and F have been calculated
    
    %Compute U (using backward differences for derivatives of E and F)
    U(:,:,:)= (1/2)* (U+U_bar-dt.*(ddx_bwd(E,dx)+ddy_bwd(F,dy)));
    
    %Update primitive variables
    [~,u,v,T,p,~,~] = cons2prim(U,R,cv);
    
    % Enforce BCs on primitive variables
    [u,v,T,p,rho,e,Et]=BCs(u,v,T,p,T0,p0,u0,nx,ny,R,cv);
    
    % Update U with BCs
    U=prim2cons(rho,u,v,T,cv);
    
    % Data output/visualization
    convdata(n+1)=rms(u-var_prev,'all');
    %convdata(n+1)=rms(rho-var_prev,'all');
    %convdata(n+1)=rms(T-var_prev,'all');
    if mod(n,50)==0 
        plottingM1(xx,yy,rho,u,v,e,p,T,n,dt,convdata)
    end
    t=t+dt;
    n=n+1;
end

% %% Part 2
% 
% % Numerial Schlieren
% 
% DeltaRho=sqrt(ddx_central(rho,dx).^2+ddy_central(rho,dy).^2);
% 
% 
% S=0.8.*exp(-10.*(DeltaRho./max(DeltaRho,[],'all')));
% 
% figure(1)
% pcolor(xx,yy,S)
% title(['t = ' num2str(t)])
% xlabel('x')
% ylabel('y')
% colormap(gray(256))
% colorbar
% clim([0 1])
% shading interp
% axis equal tight
% drawnow
% 
% % Mach Angle
% 
% theta= asind(1/M);
% 
% 
% 
% % Adiabatic wall (10pts)






%%%%%%%%%%%%%%%%%%
%    FUNCTIONS   %
%%%%%%%%%%%%%%%%%%

% Boundary Condition Functions
function [u,v,T,p,rho,e,Et]=BCs(uu,vv,TT,pp,T0,p0,u0,nx,ny,R,cv) 
    u=uu;
    v=vv;
    T=TT;
    p=pp;

    %wall
    u(:,1) = 0;
    v(:,1) = 0;
    T(:,1) = T0;
    p(:,1) = 2.*p(:,2)-p(:,3);

    %inlet & far-field
    u(1,:)= u0;
    u(:,ny)= u0;
    v(1,:)=0;
    v(:,ny)=0;
    p(1,:)=p0;
    p(:,ny)=p0;
    T(1,:)=T0;
    T(:,ny)=T0;

    %OUTLET:
    u(nx,:)=2.*u(nx-1,:)-u(nx-2,:);
    v(nx,:)=2.*v(nx-1,:)-v(nx-2,:);
    p(nx,:)=2.*p(nx-1,:)-p(nx-2,:);
    T(nx,:)=2.*T(nx-1,:)-T(nx-2,:);

    %Leading Edge
    u(1,1)=0;
    v(1,1)=0;
    p(1,1)=p0;
    T(1,1)=T0;

     %updating rho
     rho=p./(R.*T);

     %updating e & Et
     e=cv .* T;
     Et=rho.*(e+(1/2).*(u.^2+v.^2));
end 

% Physical parameter functions
function [mu,a,k]=PhysicalParameters(T,nx,ny,gamma,R,cp,Pr)
    mu=sutherland(T);
    a=ones(nx,ny) .* sqrt(gamma.*R.*T);
    k=cp./Pr .* mu;
end

% Partial Derivative Function
function [dudx_FW,dudx_BW,dudy_FW,dudy_BW,dudx_central,dudy_central,...
          dvdx_FW,dvdx_BW,dvdy_FW,dvdy_BW,dvdx_central,dvdy_central,...
          dTdx_FW,dTdx_BW,dTdy_FW,dTdy_BW,dTdx_central,dTdy_central] =PDs(u,v,T,dx,dy)

        dudx_FW= ddx_fwd(u,dx);
        dudx_BW= ddx_bwd(u,dx);
        dudy_FW= ddy_fwd(u,dy);
        dudy_BW= ddy_bwd(u,dy);
        dudx_central= ddx_central(u,dx);
        dudy_central= ddy_central(u,dy);
        
        dvdx_FW= ddx_fwd(v,dx);
        dvdx_BW= ddx_bwd(v,dx);
        dvdy_FW= ddy_fwd(v,dy);
        dvdy_BW= ddy_bwd(v,dy);
        dvdx_central= ddx_central(v,dx);
        dvdy_central= ddy_central(v,dy);
        
        dTdx_FW= ddx_fwd(T,dx);
        dTdx_BW= ddx_bwd(T,dx);
        dTdy_FW= ddy_fwd(T,dy);
        dTdy_BW= ddy_bwd(T,dy);
        dTdx_central= ddx_central(T,dx);
        dTdy_central= ddy_central(T,dy);
end 
function [dudx_W,dudy_W,dudx_central,dudy_central,...
          dvdx_W,dvdy_W,dvdx_central,dvdy_central,...
          dTdx_W,dTdy_W] =PDs2(u,v,T,dx,dy,opt)
% [dudx_BW,dudy_BW,dudx_central,dudy_central,...
%             dvdx_BW,dvdy_BW,dvdx_central,dvdy_central,...
%             dTdx_BW,dTdy_BW] =PDs2(u,v,T,dx,dy,'predictor');
% [dudx_FW,dudy_FW,dudx_central,dudy_central,...
%             dvdx_FW,dvdy_FW,dvdx_central,dvdy_central,...
%             dTdx_FW,dTdy_FW] =PDs2(u,v,T,dx,dy,'corrector');

    dudx_central= ddx_central(u,dx);
    dudy_central= ddy_central(u,dy);
    dvdx_central= ddx_central(v,dx);
    dvdy_central= ddy_central(v,dy);
    switch opt
        case 'predictor'
            dudx_W= ddx_fwd(u,dx);
            dudy_W= ddy_fwd(u,dy);
            dvdx_W= ddx_fwd(v,dx);
            dvdy_W= ddy_fwd(v,dy);
            dTdx_W= ddx_fwd(T,dx);
            dTdy_W= ddy_fwd(T,dy);
        case 'corrector'
            dudx_W= ddx_bwd(u,dx);
            dudy_W= ddy_bwd(u,dy);
            dvdx_W= ddx_bwd(v,dx);
            dvdy_W= ddy_bwd(v,dy);
            dTdx_W= ddx_bwd(T,dx);
            dTdy_W= ddy_bwd(T,dy);
    end
end

%plotting function
function plottingM1(xx,yy,rho,u,v,e,p,T,n,dt,convdata)
    figure(1)
    ax(1)=subplot(3,3,1);
    pcolor(xx,yy,rho)
    title(['rho [kg/m^3]' num2str(n)])
    xlim([0 1e-5]);ylim([0 8e-6])
    xlabel('x');ylabel('y')
    colorbar
    colormap(ax(1),turbo)
    shading interp
    axis equal tight
    
    ax(2)=subplot(3,3,2);
    pcolor(xx,yy,u)
    title('u [m/s]')
    xlim([0 1e-5]);ylim([0 8e-6])
    xlabel('x');ylabel('y')
    colorbar
    colormap(ax(2),turbo)
    shading interp
    axis equal tight
    
    ax(3)=subplot(3,3,3);
    pcolor(xx,yy,v)
    title('v [m/s]')
    xlim([0 1e-5]);ylim([0 8e-6])
    xlabel('x');ylabel('y')
    colorbar
    colormap(ax(3),turbo)
    shading interp
    axis equal tight

    ax(4)=subplot(3,3,4);
    pcolor(xx,yy,e)
    title('e [J/kg]')
    xlim([0 1e-5]);ylim([0 8e-6])
    xlabel('x');ylabel('y')
    colorbar
    colormap(ax(4),turbo)
    shading interp
    axis equal tight
    
    ax(5)=subplot(3,3,5);
    pcolor(xx,yy,p)
    title('P [Pa]')
    xlim([0 1e-5]);ylim([0 8e-6])
    xlabel('x');ylabel('y')
    colorbar
    colormap(ax(5),turbo)
    shading interp
    axis equal tight
    
    ax(6)=subplot(3,3,6);
    pcolor(xx,yy,T)
    title('T [K]')
    xlim([0 1e-5]);ylim([0 8e-6])
    xlabel('x');ylabel('y')
    colorbar
    colormap(ax(6),hot)
    shading interp
    axis equal tight

    ax(7)=subplot(3,3,[7,9]);
    x=linspace(0,dt*1500,1500);
    plot(x,convdata(1:1500))
    title('Convergence of u')
    %xlim([0 1500]);%ylim([0 2.5])
    xlabel('Time Step');ylabel('RMS of u residual')
    drawnow
end