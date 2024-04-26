% N. Boechler 1/15/24
% Example for 2DOF rotational system; free-free, onsite dampers

clc;
clear all;
close all;

% simulation duration
cycles_open=2; % number of cycles of characteristic time open loop
cycles_closed=10; % number of cycles of characteristic time closed loop
close_loop_step_target=2000; % closed loop step target [counts]

% system parameters
wn1=38.1780; % rad/s
wn2=24.2116; % rad/s
B1=0.1824; % beta
B2=0.0255;  % beta
k2=0.022; % V/m

m1=k2/wn1^2; % Vs^2/counts
m2=k2/wn2^2; % Vs^2/counts
d1=k2*2*B1/wn1; % Vs/count
d2=k2*2*B2/wn2; % Vs/count

% setup state space
A=[0 1 0 0; ...
    -k2/m1 -d1/m1 k2/m1 0; ...
    0 0 0 1; ...
    k2/m2 0 -k2/m2 -d2/m2];

B = zeros(4,1);
B(2,1) = 1/m1; % select input
C = zeros(2,4);
C(1,1)=1; % select outputs
C(2,3)=1; % select outputs
C_siso=zeros(1,4);
C_siso(1,1)=1; % choose encoder 1 for feedback
D = zeros(2,1);
D_siso=0;

mysys=ss(A,B,C,D);
mysys_siso=ss(A,B,C_siso,D_siso);

% step response
Tp=2*pi/wn2; % characteristic period [s]
dt=Tp*1E-3; % timestep [s]
T = Tp*cycles_open; % simulated time [s]
t=[0:dt:T];
y=step(mysys,t);

% plot open loop response
figure(01)
subplot(221)
plot(t,y(:,1),'LineWidth',2);
set(gca,'FontSize',20,'LineWidth',2);
xlabel('time [s]');
ylabel('x_1/U [counts/Volts]')
ylim(1.1*[min(y(:,1)) max(y(:,1))])
title('Open loop Step response')

subplot(223)
plot(t,y(:,2),'LineWidth',2);
set(gca,'FontSize',20,'LineWidth',2);
xlabel('time [s]');
ylabel('x_2/U [counts/Volts]')
ylim(1.1*[min(y(:,2)) max(y(:,2))])

% calculate and plot open loop Bode
subplot(2,2,[2,4])
bode(mysys_siso);
set(findall(gcf,'-property','FontSize'),'FontSize',20)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)


% motor gains only relevant to controller
mysys_siso_tf=tf(mysys_siso)
[num0 den0]=tfdata(mysys_siso_tf,'v');
mysys_siso_tf2=tf(num0*m1*m2,den0*m1*m2)

deng=[1/209 1]; % dynamics of the DC-motor (actuator)
Khw=9.7656e-3; % hardware gain 
numg=Khw; 
Ghdw=tf(numg,deng)

G=mysys_siso_tf2*Ghdw % add hardware transfer function

[C_pi,info] = pidtune(G,'PID') % PID tune

C_pi_tf=tf(C_pi) % convert controller to transfer function form
totalsys=feedback(G*C_pi_tf,1);  % combine controller and plant

% controlled step response
T_cont = Tp*cycles_closed;
t_control=[0:dt:T_cont];
opts = stepDataOptions('StepAmplitude',close_loop_step_target)
y_control=step(totalsys,t_control,opts);

% plot closed loop step response
figure(02)
plot(t_control,y_control,[0 T_cont],mean(y_control)*[1 1],'LineWidth',2);
set(gca,'FontSize',20,'LineWidth',2);
xlabel('time [s]');
ylabel('x_1 [counts]')
ylim(0.9*[min(y_control) 1.2*max(y_control)])

figure(03)
% calculate and plot Nyquist
subplot(221)
nyquist(totalsys);
set(findall(gcf,'-property','FontSize'),'FontSize',20)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

% calculate and plot Root locus 
subplot(223)
rlocus(totalsys);
set(findall(gcf,'-property','FontSize'),'FontSize',20)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

% calculate and plot closed loop Bode
subplot(2,2,[2,4])
bode(totalsys);
set(findall(gcf,'-property','FontSize'),'FontSize',20)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

