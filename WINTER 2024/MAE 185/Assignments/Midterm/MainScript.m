close all;
clear all;
clc;


addpath('Functions')

%Initialize Variables and Simulation

p0= 101300;
T0= 288.15;
nx=75;
ny=80;
M=4;

[xx,yy,u4,v4,T,p,rho4,e4,Et4,U4,dx,dy,n,dt,convdata4,a4]=runsimulation(M);
[xx,yy,u_a,v_a,T_a,p_a,rho_a,e_a,Et_a,U_a,dx,dy,n,dt,convdata_a,a_a]=runsimulation(M,2);

%% PART III (Adiabatic Wall)

%Variable Calculations

quarter_L_T=T(round(0.25*nx),:)/T0;
quarter_L_T_a=T_a(round(0.25*nx),:)/T0;

half_L_T=T(round(0.5*nx),:)/T0;
half_L_T_a=T_a(round(0.5*nx),:)/T0;

quarter3_L_T=T(round(0.75*nx),:)/T0;
quarter3_L_T_a=T_a(round(0.75*nx),:)/T0;



quarter_L_P=p(round(0.25*nx),:)/p0;
quarter_L_P_a=p_a(round(0.25*nx),:)/p0;

half_L_P=p(round(0.5*nx),:)/p0;
half_L_P_a=p_a(round(0.5*nx),:)/p0;

quarter3_L_P=p(round(0.75*nx),:)/p0;
quarter3_L_P_a=p_a(round(0.75*nx),:)/p0;


%Plotting Temperature Profiles

subplot(3,3,1)
h1=plot(quarter_L_T,yy,'r');
hold on
h2=plot(quarter_L_T_a,yy,'b');hold off
legend([h1(1) h2(1)],'Non-adiabatic','Adiabatic')
title('Temperature Profiles at x/L=0.25')
xlabel('Normalized Temperature');ylabel('Height(m)')

subplot(3,3,2)
h1=plot(half_L_T,yy,'-r');
hold on
h2=plot(half_L_T_a,yy,'-b');
legend([h1(1) h2(1)],'Non-adiabatic','Adiabatic')
title('Temperature Profiles at x/L=0.50')
xlabel('Normalized Temperature');ylabel('Height(m)')
hold off

subplot(3,3,3)
h1=plot(quarter3_L_T,yy,'-r');
hold on
h2=plot(quarter3_L_T_a,yy,'-b');
legend([h1(1) h2(1)],'Non-adiabatic','Adiabatic')
title('Temperature Profiles at x/L=0.75')
xlabel('Normalized Temperature');ylabel('Height(m)')
hold off

%Plotting Pressure Profiles

subplot(3,3,4)
h1=plot(quarter_L_P,yy,'-r');
hold on
h2=plot(quarter_L_P_a,yy,'-b');
legend([h1(1) h2(1)],'Non-adiabatic','Adiabatic')
title('Pressure Profiles at x/L=0.25')
xlabel('Normalized Temperature');ylabel('Height(m)')
hold off


subplot(3,3,5)
h1=plot(half_L_P,yy,'-r');
hold on
h2=plot(half_L_P_a,yy,'-b');
legend([h1(1) h2(1)],'Non-adiabatic','Adiabatic')
title('Pressure Profiles at x/L=0.50')
xlabel('Normalized Temperature');ylabel('Height(m)')
hold off

subplot(3,3,6)
h1=plot(quarter3_L_P,yy,'-r');
hold on
h2=plot(quarter3_L_P_a,yy,'-b');
legend([h1(1) h2(1)],'Non-adiabatic','Adiabatic')
title('Pressure Profiles at x/L=0.75')
xlabel('Normalized Temperature');ylabel('Height(m)')
hold off

%Plotting Wall Temperature Comparison Between Adiabatic and Non-Adiabitic
%Conditions

subplot(3,3,[7,9])
h1=plot(xx,T(:,1),'-r','LineWidth',5);
hold on
h2=plot(xx,T_a(:,1),'-b','LineWidth',5);
legend([h1(1) h2(1)],'Non-adiabatic','Adiabatic')
title('Wall Temperature Comparison')
xlabel('x(m)');ylabel('Temperature(K)')
hold off

%% Mach Angle
[xx,yy,u3,v3,T3,p3,rho3,e3,Et3,U3,dx,dy,n,dt,convdata3,a3]=runsimulation(3);

[xx,yy,u5,v5,T5,p5,rho5,e5,Et5,U5,dx,dy,n,dt,convdata5,a5]=runsimulation(5);
%%
Mach4= sqrt(u4.^2+v4.^2)./a4;
M4_less=Mach4 < 3.8;
M4_less=double(M4_less);
M4_change=double(ischange(M4_less,2));
M4_find=(find(M4_change==1));

Mach5=sqrt(u5.^2+v5.^2)./a5;
M5_less=Mach5 < 4.8;
M5_less=double(M5_less);
M5_change=double(ischange(M5_less,2));
M5_find=(find(M5_change==1));

Mach3=sqrt(u3.^2+v3.^2)./a3
M3_less=Mach3 < 2.8;
M3_less=double(M3_less);
M3_change=double(ischange(M3_less,2));
M3_find=(find(M3_change==1));

% Mach3

subplot(1,3,3)
pcolor(xx,yy,Mach3)
colorbar
xlabel('x')
ylabel('y')
shading interp
axis equal tight
drawnow

[row,column]=find(M3_change==1);
x_position=row(end-10:end)*dx;
y_position=column(end-10:end)*dy;
p=polyfit(x_position,y_position,1);
theta_exp_M3= atand(p(1))
theta_theo_M3= asind(1/3)

x1=linspace(0,1*10^-5);
y1=polyval(p,x1);
title("Mach angle (M=3)")
hold on
plot(x1,y1,"-r",'LineWidth',5)
hold off



% Mach4
figure(1)
subplot(1,3,1)
pcolor(xx,yy,Mach4)
colorbar
xlabel('x')
ylabel('y')
shading interp
axis equal tight
drawnow

[row,column]=find(M4_change==1);
x_position=row(end-10:end)*dx;
y_position=column(end-10:end)*dy;
p=polyfit(x_position,y_position,1);
theta_exp_M4= atand(p(1))
theta_theo_M4= asind(1/M)

x1=linspace(0,1*10^-5);
y1=polyval(p,x1);
title("Mach angle (M=4)")
hold on
plot(x1,y1,"-r",'LineWidth',5)
hold off

% Mach5

subplot(1,3,2)
pcolor(xx,yy,Mach5)
colorbar
xlabel('x')
ylabel('y')
shading interp
axis equal tight
drawnow

[row,column]=find(M5_change==1);
x_position=row(end-10:end)*dx;
y_position=column(end-10:end)*dy;
p=polyfit(x_position,y_position,1);
theta_exp_M5= atand(p(1))
theta_theo_M5= asind(1/5)

x1=linspace(0,1*10^-5);
y1=polyval(p,x1);
title("Mach angle (M=5) ")
hold on
plot(x1,y1,"-r",'LineWidth',5)
hold off






% 
% subplot(1,2,2)
% pcolor(xx,yy,Test)
% colorbar
% xlabel('x')
% ylabel('y')
% shading interp
% axis equal tight
% drawnow

% 
% figure(2)
% pcolor(xx,yy,Test2)
% colorbar
% xlabel('x')
% ylabel('y')
% drawnow









%%%%%%%%%%%%%%%%%%
%    FUNCTIONS   %
%%%%%%%%%%%%%%%%%%

function [xx,yy,u,v,T,p,rho,e,Et,U,dx,dy,n,dt,convdata,a]=runsimulation(M,BC_opt)
%% initializaion

if nargin<2, BC_opt=1; end

% Define physical parameters and simulation parameters

p0= 101300;
T0= 288.15;
rho0=1.225;
R=287;
cp=1005;
cv=718;
gamma=1.4;
mu0=1.735*10^-5;
S1=110.4;
Pr=0.71;
a0=sqrt(gamma*R*T0);
u0=M.*a0;
n=0;
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
dt=2.35*10^-11;
time_step=1500;
t=0;

   
[xx,yy]=ndgrid(0:dx:L,0:dy:H); %Create ndgrid

% Initialize primitive variables

u=ones(nx,ny).*u0;
v=zeros(nx,ny);
T=ones(nx,ny).*T0;
rho=ones(nx,ny).*rho0;
e=ones(nx,ny).*(cv.*T0);
p=ones(nx,ny).*p0;
Et=rho.*(e+(1/2).*(u.^2+v.^2));



%% boundary conditions

[u,v,T,p,rho,e,Et]=BCs(u,v,T,p,T0,p0,u0,nx,ny,R,cv,BC_opt);

% Initialize conservative variables

U=prim2cons(rho,u,v,T,cv);

% Preallocate other arrays with zeros (E,F,U_bar,etc.)

E=zeros(4,nx,ny);
F=zeros(4,nx,ny);
U_bar=zeros(4,nx,ny);


% Compute initial physical parameters (speed of sound, viscosity, etc)

e=cv .* T;


%% time loop

while n<time_step+1
    var_prev=u;

% Make sure conservative and primitive variables are up to date
% Optional: Compute based on stability requirement and most recent solution fields
% Update t

%%%%%%%%%%%%%%%%%%
% Predictor Step %
%%%%%%%%%%%%%%%%%%

% 1. Update all necessary physical parameters
[mu,a,k]=PhysicalParameters(T,nx,ny,gamma,R,cp,Pr);

% 2. Compute partial derivatives of primitive variables needed to assemble
% flux array E
         [dudx_FW,dudx_BW,dudy_FW,dudy_BW,dudx_central,dudy_central,...
          dvdx_FW,dvdx_BW,dvdy_FW,dvdy_BW,dvdx_central,dvdy_central,...
          dTdx_FW,dTdx_BW,dTdy_FW,dTdy_BW,dTdx_central,dTdy_central] =PDs(u,v,T,dx,dy);



% - Be sure to maintain overall accuracy by properly biasing x- and y- derivatives! (See lecture notes Download lecture notes)
% 3. Update E & F

%Tau for E
tauxx=2.*mu.*(dudx_BW - (1/3).* (dudx_BW+dvdy_central));
tauyy=2.*mu.*(dvdy_central - (1/3).* (dudx_BW+dvdy_central));
tauxy=mu.*(dudy_central+dvdx_BW);
q_dot_x=-k.*dTdx_BW;
q_dot_y=-k.*dTdy_central;


E(1,:,:)=     (squeeze(U(2,:,:)));
E(2,:,:)=     (rho.* u.^2 + p - tauxx);
E(3,:,:)=     (squeeze(U(2,:,:)).* v - tauxy);
E(4,:,:)=     ((Et+p).*u-u.*tauxx-v.*tauxy+q_dot_x);

%Tau for F
tauxx=2.*mu.*(dudx_central - (1/3).* (dudx_central+dvdy_BW));
tauyy=2.*mu.*(dvdy_BW - (1/3).* (dudx_central+dvdy_BW));
tauxy=mu.*(dudy_BW+dvdx_central);
q_dot_x=-k.*dTdx_central;
q_dot_y=-k.*dTdy_BW;

F(1,:,:)=   (squeeze(U(3,:,:)));
F(2,:,:)=   (squeeze(U(2,:,:)).* v - tauxy); 
F(3,:,:)=   (rho.* v.^2 + p - tauyy);
F(4,:,:)=   ((Et+p).*v-v.*tauyy-u.*tauxy+q_dot_y);

% 6. Compute U_bar (using forward differences for derivatives of E and F)

for i=1:4

U_bar(i,:,:)= squeeze(U(i,:,:))-dt.*( ddx_fwd(E(i,:,:),dx)+ddy_fwd(F(i,:,:),dy) );

end

% 7. Update primitive variables

[rho,u,v,T,p,e,Et] = cons2prim(U_bar,R,cv);


% 8. Enforce BCs on primitive variables

[u,v,T,p,rho,e,Et]=BCs(u,v,T,p,T0,p0,u0,nx,ny,R,cv,BC_opt);

% 9. Update  U_bar

U_bar=prim2cons(rho,u,v,T,cv);



%%%%%%%%%%%%%%%%%%
% Corrector Step %
%%%%%%%%%%%%%%%%%%

% 1. Follow predictor steps 1-4, but using values from U_bar

% Update all necessary physical parameters
[mu,a,k]=PhysicalParameters(T,nx,ny,gamma,R,cp,Pr);

% Compute partial derivatives of primitive variables needed to assemble
% flux array E & F

         [dudx_FW,dudx_BW,dudy_FW,dudy_BW,dudx_central,dudy_central,...
          dvdx_FW,dvdx_BW,dvdy_FW,dvdy_BW,dvdx_central,dvdy_central,...
          dTdx_FW,dTdx_BW,dTdy_FW,dTdy_BW,dTdx_central,dTdy_central] =PDs(u,v,T,dx,dy);

% - Be sure to maintain overall accuracy by properly biasing x- and y- derivatives! (See lecture notes Download lecture notes)
% 3. Update E & F

%Tau for E
tauxx=2.*mu.*(dudx_FW - (1/3).* (dudx_FW+dvdy_central));
tauyy=2.*mu.*(dvdy_central - (1/3).* (dudx_FW+dvdy_central));
tauxy=mu.*(dudy_central+dvdx_FW);
q_dot_x=-k.*dTdx_FW;
q_dot_y=-k.*dTdy_central;


E(1,:,:)=   (squeeze(U_bar(2,:,:)));
E(2,:,:)=   (rho.* u.^2 + p - tauxx);
E(3,:,:)=   (squeeze(U_bar(2,:,:)).* v - tauxy);
E(4,:,:)=   ((Et+p).*u-u.*tauxx-v.*tauxy+q_dot_x);

%Tau for F
tauxx=2.*mu.*(dudx_central - (1/3).* (dudx_central+dvdy_FW));
tauyy=2.*mu.*(dvdy_FW - (1/3).* (dudx_central+dvdy_FW));
tauxy=mu.*(dudy_FW+dvdx_central);
q_dot_x=-k.*dTdx_central;
q_dot_y=-k.*dTdy_FW;

F(1,:,:)=   (squeeze(U_bar(3,:,:)));
F(2,:,:)=   (squeeze(U_bar(2,:,:)).* v - tauxy); 
F(3,:,:)=   (rho.* v.^2 + p - tauyy);
F(4,:,:)=   ((Et+p).*v-v.*tauyy-u.*tauxy+q_dot_y);


% ,and with the proper biasing needed to maintain overall accuracy in the corrector step!
% 2. Compute U (using backward differences for derivatives of and)

for i=1:4

U(i,:,:)= (1/2)* ( squeeze(U(i,:,:))+squeeze(U_bar(i,:,:))  -dt.*(ddx_bwd(E(i,:,:),dx)+ddy_bwd(F(i,:,:),dy)) );

end

% 3. Update primitive variables
[rho,u,v,T,p,e,Et] = cons2prim(U,R,cv);

% 4. Enforce BCs on primitive variables

[u,v,T,p,rho,e,Et]=BCs(u,v,T,p,T0,p0,u0,nx,ny,R,cv,BC_opt);
% 5. Update U

U=prim2cons(rho,u,v,T,cv);

[rho,u,v,T,p,e,Et] = cons2prim(U,R,cv);

% Data output/visualization

% test

% if mod(n,10)==0
% 
% 
% figure(1)
% pcolor(xx,yy,u)
% title(['t = ' num2str(t)])
% xlabel('x')
% ylabel('y')
% colorbar
% shading interp
% axis equal tight
% drawnow
% 
% end

t=t+dt;
n=n+1;

% convdata(n)=rms(u-var_prev,'all');
%     if mod(n,100)==0 
%         plottingM1(xx,yy,rho,u,v,e,p,T,n,convdata)
%     end
    [mu,a,k]=PhysicalParameters(T,nx,ny,gamma,R,cp,Pr);


end
% time loop





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


%plotting function
function plottingM1(xx,yy,rho,u,v,e,p,T,n,convdata)
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
    plot(1:1500,convdata)
    title('Convergence of u')
    xlim([0 1500]);
    xlabel('Time Step');ylabel('RMS of u residual')
    drawnow
end


% Boundary Condition Functions

function [u,v,T,p,rho,e,Et]=BCs(uu,vv,TT,pp,T0,p0,u0,nx,ny,R,cv,opt) 
    
    if nargin<12, opt=1; end
   

    u=uu;
    v=vv;
    T=TT;
    p=pp;

    %wall
    u(:,1) = 0;
    v(:,1) = 0;
    if opt==1
    T(:,1) = T0;
    else
    T(:,2) = T(:,3);
    T(:,1) = T(:,2);
   
    end
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

