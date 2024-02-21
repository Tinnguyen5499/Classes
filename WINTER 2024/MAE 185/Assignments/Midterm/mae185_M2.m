close all;
clear all;
clc;

addpath('Functions')

%% PART I (Numerical Schlieren)

% Initialization
p0= 101300;
T0= 288.15;
nx=75;
ny=80;
M=4;
[xx,yy,u4,v4,T4,p4,rho4,e4,~,~,dx,dy,n,dt,convdata4,a4]=Midterm_runsimulation(M); %Running the simulation to get necessary variables
Midterm_plottingM1(xx,yy,rho4,u4,v4,e4,p4,T4,n,dt,convdata4) % Plot results from part I

DeltaRho=sqrt(ddx_central(rho4,dx).^2+ddy_central(rho4,dy).^2); %Calculating Density Gradient

S=0.8.*exp(-10.*(DeltaRho./max(DeltaRho,[],'all')));  %Calcualting Scaled quantity 

figure(1)
ax(1)=subplot(3,3,1); % Plot the Numerical Schlieren
pcolor(xx,yy,S)
title('Schlieren')
xlabel('x')
ylabel('y')
colormap(ax(1),gray(256))
colorbar
clim([0 1])
shading interp
axis equal tight
drawnow

%% PART II (Mach Angle)


[~,~,u3,v3,T3,p3,rho3,e3,Et3,U3,~,~,~,~,convdata3,a3]=Midterm_runsimulation(3);

[xx,yy,u5,v5,T5,p5,rho5,e5,Et5,U5,dx,dy,~,~,convdata5,a5]=Midterm_runsimulation(5);

% Checking Mach Condition
Mach4= sqrt(u4.^2+v4.^2)./a4;   %Finding the Mach Number of the field
M4_less=Mach4 < 3.8;            %Finding the Mach Number in the field that is less than initial condition
M4_less=double(M4_less);        %Conversion from logical value to integer
M4_change=double(ischange(M4_less,2));  %Finding the position where value changes from 0 to 1 (Mach cone positions)

Mach5=sqrt(u5.^2+v5.^2)./a5;
M5_less=Mach5 < 4.8;
M5_less=double(M5_less);
M5_change=double(ischange(M5_less,2));

Mach3=sqrt(u3.^2+v3.^2)./a3;
M3_less=Mach3 < 2.8;
M3_less=double(M3_less);
M3_change=double(ischange(M3_less,2));

% Mach3

figure(2)

subplot(1,3,1) % plotting Mach field with M=3 
pcolor(xx,yy,Mach3)
colorbar
xlabel('x')
ylabel('y')
shading interp
axis equal tight
drawnow

[row,column]=find(M3_change==1);    % Finding x,y coordinate of where Mach value changes from the initial condition (coordiate of the mach cone)  
x_position=row(end-10:end)*dx;      % Getting the last 10 x positions
y_position=column(end-10:end)*dy;   % Getting the last 10 y positions
p=polyfit(x_position,y_position,1); % Fitting a line through the last 10 points that is on the Mach cone
theta_exp_M3= atand(p(1))           % Finding Mach angle with the line best fit through the 10 points that we found 
theta_theo_M3= asind(1/3)           % Finding the theoretical Mach angle with the Mach number

x1=linspace(0,1*10^-5);             % Preparing the x coordinate to plot the line best fit
y1=polyval(p,x1);                   % Plot the line best fit through the 10 points at the end of the Mach cone 
title("Mach angle (M=3)")
hold on
plot(x1,y1,"-r",'LineWidth',5)
hold off



% Mach4

subplot(1,3,2)
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

subplot(1,3,3)
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



%% PART III (Adiabatic Wall)
[~,~,u4,v4,T4,p4,rho4,e4,Et4,U4,~,~,~,~,convdata4,a4]=Midterm_runsimulation(M,1,2.2e-11);
[xx,yy,u_a,v_a,T_a,p_a,rho_a,e_a,Et_a,U_a,dx,dy,n,dt,convdata_a,a_a]=Midterm_runsimulation(M,2,2.2e-11);
%Variable Calculations

quarter_L_T=T4(round(0.25*nx),:)/T0;
quarter_L_T_a=T_a(round(0.25*nx),:)/T0;

half_L_T=T4(round(0.5*nx),:)/T0;
half_L_T_a=T_a(round(0.5*nx),:)/T0;

quarter3_L_T=T4(round(0.75*nx),:)/T0;
quarter3_L_T_a=T_a(round(0.75*nx),:)/T0;



quarter_L_P=p4(round(0.25*nx),:)/p0;
quarter_L_P_a=p_a(round(0.25*nx),:)/p0;

half_L_P=p4(round(0.5*nx),:)/p0;
half_L_P_a=p_a(round(0.5*nx),:)/p0;

quarter3_L_P=p4(round(0.75*nx),:)/p0;
quarter3_L_P_a=p_a(round(0.75*nx),:)/p0;


%Plotting Temperature Profiles

figure(3)

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
h1=plot(xx,T4(:,1),'-r','LineWidth',5);
hold on
h2=plot(xx,T_a(:,1),'-b','LineWidth',5);
legend([h1(1) h2(1)],'Non-adiabatic','Adiabatic')
title('Wall Temperature Comparison')
xlabel('x(m)');ylabel('Temperature(K)')
hold off
