close all;
clear all;
clc;
syms k s I1 I2 d1 d2 theta1(s) theta2(s) Tau(s)


T=[-k-s*d1-s^2*I1 k;
    -k-s*d2 k-s^2*I2];


Gx=[1 0]*transpose(T)* [1;0];

Gy=[0 1]*transpose(T)* [1;0];


% eqn1= Tau(s)==k*theta2(s)-k*theta1(s)-s*d1*theta1(s)-s^2*I1*theta1(s);
% eqn2= 0==k*theta2(s)-k*theta1(s)-s*d2*theta2(s)-s^2*I2*theta2(s);

eqn1= Tau==I1*s^2*theta1+d1*s*theta1+k*(theta1-theta2);

eqn2= 0==I2*s^2*theta2+d2*s*theta2+k*(theta2-theta1);


%Isolate theta2 from eqn2 and plug theta2 into eqn1 and solve for theta1
%from both equations

theta2_new=isolate(eqn2,theta2);
theta2_new=rhs(theta2_new); %Isolate theta2 from eqn2

eqn1_new= subs(eqn1,theta2,theta2_new); %plug theta2 into eqn1

theta1_isolated_both_eqn=isolate(eqn1_new,theta1); %Isolate theta1 from both equations

G1=theta1_isolated_both_eqn/Tau(s);
G1=simplifyFraction(rhs(G1)); %Solve and simplify transfer function of theta1/Tau

%Isolate theta1 from eqn1 and plug theta1 into eqn2 and solve for theta2
%from both equations

theta1_new=isolate(eqn1,theta1);
theta1_new=rhs(theta1_new); %Isolate theta1 from eqn1

eqn2_new= subs(eqn2,theta1,theta1_new); %plug theta1 into eqn2

theta2_isolated_both_eqn=isolate(eqn2_new,theta2); %Isolate theta2 from both equations

G2=theta2_isolated_both_eqn/Tau(s);
G2=simplifyFraction(rhs(G2)); %Solve and simplify transfer function of theta2/Tau





% % Define symbolic variables
% syms s Y(s) U(s)
% 
% % Example ODE: my'' + cy' + ky = F(t), where m=mass, c=damping coefficient, k=spring constant, F(t)=input force
% % Laplace transform variables: L{y''} = s^2Y(s), L{y'} = sY(s), L{y} = Y(s), L{F(t)} = U(s)
% 
% 
% % Convert ODE to Laplace domain
% ODE = Tau(s)==k*theta2-k*theta1-s*d1*theta1-s^2*I1*theta1;
% 
% % Solve for Y(s)/U(s)
% TF = solve([eqn1 eqn2], theta1(s) / Tau(s));
% 
% % Display transfer function
% TF = simplify(TF)


% % Define symbolic variables
% syms s Y(s) U(s)
% 
% % Example ODE: my'' + cy' + ky = F(t), where m=mass, c=damping coefficient, k=spring constant, F(t)=input force
% % Laplace transform variables: L{y''} = s^2Y(s), L{y'} = sY(s), L{y} = Y(s), L{F(t)} = U(s)
% m = 1; % mass
% c = 2; % damping coefficient
% k = 3; % spring constant
% 
% % Convert ODE to Laplace domain
% ODE = m*s^2*Y(s) + c*s*Y(s) + k*Y(s) == U(s);
% 
% % Solve for Y(s)/U(s)
% TF = solve(ODE, Y(s)) / U(s);
% 
% % Display transfer function
% TF = simplify(TF)
