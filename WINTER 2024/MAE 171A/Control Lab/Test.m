close all;
clear all;
clc;

%syms F(t) x1(t) x2(t) dxdt(t) t s Y1(s) Y2(s) U(s) y0 dydt0 u0 I1 I2 d1 d2 k

%eqn1= Tau==k*theta2-k*theta1-s*d1*theta1-s^2*I1*theta1;
%eqn2= 0==k*theta2-k*theta1-s*d2*theta2-s^2*I2*theta2;

%eqn1= Tau==I1*s^2*theta1+d1*s*theta1+k*(theta1-theta2);

%eqn2= 0==I2*s^2*theta2+d2*s*theta2+k*(theta2-theta1);

%[input1_output1,input1_output2] = transfer_find_1in_2out(eqn1,eqn2,Tau,theta1,theta2);

% Standard form of second-order system
%eqn_t1 = ((I1)*diff(x1(t), t, 2) + (d1)*diff(x1(t), t) + k*(x1(t)-x2(t))) == F(t);
%eqn_t2 = ((I2)*diff(x2(t), t, 2) + (d2)*diff(x2(t), t) + k*(x2(t)-x1(t))) == 0;


syms x(t) u(t) y(t) k1 k2 m1 m2 b


eqn_t1= -k2*(x(t)-y(t))-k1*(x(t)-u(t))-b*(diff(x(t),t)-diff(y(t),t)) == m1*diff(x(t),t,2)
eqn_t2= -k2*(y(t)-x(t))-b*(diff(y(t),t)-diff(x(t),t)) == m2*diff(y(t),t,2)


% % In Laplace domain
% eqn_s1 = subs(laplace(eqn_t1), [laplace(x1(t), t, s), laplace(x2(t), t, s), laplace(F(t), t, s), diff(x1(t), t)], [Y1(s), Y2(s), U(s), dxdt(t)])
% eqn_s2 = subs(laplace(eqn_t2), [laplace(x1(t), t, s), laplace(x2(t), t, s), laplace(F(t), t, s), diff(x2(t), t)], [Y1(s), Y2(s), U(s), dxdt(t)])
% 
% % Set initial conditions to zero to get transfer function
% eqn_s01 = subs(eqn_s1, [x1(0), dxdt(0)], [0, 0])
% eqn_s02 = subs(eqn_s2, [x2(0), dxdt(0)], [0, 0])

%G1=rhs(eqn_s01) / U(s) / (simplify(lhs(eqn_s01)) / Y1(s));
%G2=rhs(eqn_s02) / U(s) / (simplify(lhs(eqn_s02)) / Y2(s));

%[G1,G2] = transfer_find_1in_2out(eqn_t1,eqn_t2,F(t),x1(t),x2(t));
[G1,G2] = transfer_find_1in_2out(eqn_t1,eqn_t2,u,x,y);

%% parameters
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






input1_output1_subbed_in=subs(G1,parameters,parameters_sub);
input1_output2_subbed_in=subs(G2,parameters,parameters_sub);



G1=simplifyFraction(input1_output1_subbed_in);
G2=simplifyFraction(input1_output2_subbed_in);


[n1,d1]=numden(G1);
num1=sym2poly(n1);
den1=sym2poly(d1);


[n2,d2]=numden(G2);
num2=sym2poly(n2);
den2=sym2poly(d2);


transfer1=tf(num1,den1)
transfer2=tf(num2,den2)

figure(1)
bode(transfer1)

figure(2)
bode(transfer2)

