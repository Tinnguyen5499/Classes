close all;
clear all;
clc;

%% Define System (Partial Differential Equations Form)
%syms F(t) x1(t) x2(t) dxdt(t) t s Y1(s) Y2(s) U(s) y0 dydt0 u0 I1 I2 d1 d2 k

% Standard form of second-order system
%eqn_t1 = ((I1)*diff(x1(t), t, 2) + (d1)*diff(x1(t), t) + k*(x1(t)-x2(t))) == F(t);
%eqn_t2 = ((I2)*diff(x2(t), t, 2) + (d2)*diff(x2(t), t) + k*(x2(t)-x1(t))) == 0;

syms x(t) u(t) y(t) k1 k2 m1 m2 b

eqn_t1= -k2*(x(t)-y(t))-k1*(x(t)-u(t))-b*(diff(x(t),t)-diff(y(t),t)) == m1*diff(x(t),t,2)
eqn_t2= -k2*(y(t)-x(t))-b*(diff(y(t),t)-diff(x(t),t)) == m2*diff(y(t),t,2)


%% Use created function to find transfer function in symbolic form

%[G1,G2] = transfer_find_1in_2out(eqn_t1,eqn_t2,F,x1,x2);
[G1,G2] = transfer_find_1in_2out(eqn_t1,eqn_t2,u,x,y);

%% Define parameters
% I1_sub=1.4859*10^(-6);
% I2_sub=3.79*10^(-6);
% k_sub=0.0022;
% d1_sub=2.0727*10^(-5);
% d2_sub=4.6887*10^(-6);
% 
% 
% parameters=[I1 I2 k d1 d2];
% parameters_sub=[I1_sub I2_sub k_sub d1_sub d2_sub];

m1_sub=1;
m2_sub=1;
k1_sub=5;
k2_sub=5;
b_sub=1;


parameters=[m1 m2 k1 k2 b];
parameters_sub=[m1_sub m2_sub k1_sub k2_sub b_sub];

%% plug in parameters 

input1_output1_subbed_in=subs(G1,parameters,parameters_sub);
input1_output2_subbed_in=subs(G2,parameters,parameters_sub);


%% Put it in transfer function fractional form

G1=simplifyFraction(input1_output1_subbed_in);
G2=simplifyFraction(input1_output2_subbed_in);


%% put it in transfer function MATLAB form
[n1,d1]=numden(G1);
num1=sym2poly(n1);
den1=sym2poly(d1);


[n2,d2]=numden(G2);
num2=sym2poly(n2);
den2=sym2poly(d2);

%% Transfer function

transfer1=tf(num1,den1)
transfer2=tf(num2,den2)

figure(1)
bode(transfer1)

figure(2)
bode(transfer2)

