% N. Boechler 2/06/24
% Example for 2DOF rectilinear system; fixed-free, onsite dampers
% kp controller sweep

clc;
clear all;
close all;

% simulation duration
cycles_open=2; % number of cycles of characteristic time open loop
cycles_closed=10; % number of cycles of characteristic time closed loop
close_loop_step_target=2000; % closed loop step target [counts]

% system parameters
wn1=1; % rad/s
wn2=1; % rad/s
B1=0.1; % beta
B2=0.1;  % beta
k2=0.01; % V/m

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

Tp=2*pi/wn2; % characteristic period [s]
dt=Tp*1E-3; % timestep [s]
T = Tp*cycles_open; % simulated time [s]
t=[0:dt:T];

% motor gains only relevant to controller
mysys_siso_tf=tf(mysys_siso)
[num0 den0]=tfdata(mysys_siso_tf,'v');
mysys_siso_tf2=tf(num0*m1*m2,den0*m1*m2)

deng=[1/209 1]; % dynamics of the DC-motor (actuator)
Khw=9.7656e-3; % hardware gain
numg=Khw;
Ghdw=tf(numg,deng)

G=mysys_siso_tf2*Ghdw % add hardware transfer function


kp_vec=[50:-10:20]; % control values to test
N=length(kp_vec);
T_cont = Tp*cycles_closed;
t_control=[0:dt:T_cont];
y_control=zeros(N,length(t_control));

figure(02)
hold on

for i=1:N
    Kp=kp_vec(i);
    Ki=0;
    Kd=0;
    %[C_pi,info] = pidtune(G,'PID') % PID tune
    C_pi = pid(Kp,Ki,Kd);

    C_pi_tf=tf(C_pi); % convert controller to transfer function form
    totalsys=feedback(G*C_pi_tf,1);  % combine controller and plant

    % controlled step response
    opts = stepDataOptions('StepAmplitude',close_loop_step_target);
    y_control(i,:)=step(totalsys,t_control,opts);

plot(t_control,y_control(i,:),'LineWidth',2);

end

% plot closed loop step response
plot([0 T_cont],[close_loop_step_target close_loop_step_target],'--k',...
    'LineWidth',2)
set(gca,'FontSize',20,'LineWidth',2);
xlabel('time [s]');
ylabel('x_1 [counts]')
ylim(0.9*[min(y_control(1,:)) 1.2*max(y_control(1,:))])

hold off


