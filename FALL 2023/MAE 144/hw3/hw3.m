close all; clear all; clc
s= tf('s');
Ku= 3.33;
G_without_delay= 0.1/(s+0.1)
G_with_delay=exp(-6*s)*0.1/(s+0.1);
G_pade_approx=pade(G_with_delay,2)

figure(1)
bode(G_without_delay)
title('G without delay')

figure(2)
bode(G_with_delay)
title('G with delay')

figure(3)
bode(G_pade_approx)
title('G pade approx')
% 
% figure(4)
% G_delay_matlab= tf(1, [1 1], 'InputDelay',1)
% bode(G_delay_matlab)
% title('G with delay using MATLAB function')

figure(5)

D2= 0.6*Ku

G_with_D2= G_with_delay*D2

margin(G_with_delay)

figure(6)

margin(G_with_D2)

% 
% D3= 0.6*3.2*(1+1/(0.5*(1/0.3)*s)+(0.125*(1/0.3)*s))
% 
% figure (7)
% G_with_D3 = G_with_delay*D3
% bode(G_with_D3)
% margin(G_with_D3)
% 
% D_PID= (1+1/s+s)

figure (7)

rlocus(G_pade_approx)

Ku= 3.33;
wu= 0.317;
Tu=1/wu;
alpha = 0.6;
beta=0.5;
gamma=0.125;

Kp=alpha*Ku;
TI=beta*Tu
TD=gamma*Tu;

D_4a=Kp*(1+(1/(TI*s))+TD*s);



G4= G_with_delay*D_4a

figure(8)

bode(G4)

figure(9)

step(G4)

