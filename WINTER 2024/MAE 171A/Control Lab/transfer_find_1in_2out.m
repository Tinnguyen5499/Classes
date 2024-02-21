function [input1_output,input2_output,eqn_s1,eqn_s2] = transfer_find_1in_2out(eqn_t1,eqn_t2,input_t,output_t1,output_t2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%Isolate theta2 from eqn2 and plug theta2 into eqn1 and solve for theta1
%from both equations

syms dxdt(t) t s output_s1(s) output_s2(s) input_s(s)

% In Laplace domain


eqn_s1 = subs(laplace(eqn_t1), [laplace(output_t1(t), t, s), laplace(output_t2(t), t, s), laplace(input_t(t), t, s), diff(output_t1(t), t)], [output_s1(s), output_s2(s), input_s(s), dxdt(t)]);
eqn_s2 = subs(laplace(eqn_t2), [laplace(output_t1(t), t, s), laplace(output_t2(t), t, s), laplace(input_t(t), t, s), diff(output_t2(t), t)], [output_s1(s), output_s2(s), input_s(s), dxdt(t)]);


% Set initial conditions to zero to get transfer function
eqn_s01 = subs(eqn_s1, [output_t1(0), output_t2(0), dxdt(0)], [0, 0, 0])
eqn_s02 = subs(eqn_s2, [output_t1(0), output_t2(0), dxdt(0)], [0, 0, 0])

eqn1 =eqn_s01;
eqn2 =eqn_s02;

%%
theta2_new=isolate(eqn2,output_s2);
theta2_new=rhs(theta2_new); %Isolate theta2 from eqn2

eqn1_new= subs(eqn1,output_s2,theta2_new); %plug theta2 into eqn1

theta1_isolated_both_eqn=isolate(eqn1_new,output_s1); %Isolate theta1 from both equations

input1_output=theta1_isolated_both_eqn/input_s;
input1_output=simplifyFraction(rhs(input1_output)); %Solve and simplify transfer function of theta1/Tau

%Isolate theta1 from eqn1 and plug theta1 into eqn2 and solve for theta2
%from both equations

theta1_new=isolate(eqn1,output_s1);
theta1_new=rhs(theta1_new); %Isolate theta1 from eqn1

eqn2_new= subs(eqn2,output_s1,theta1_new); %plug theta1 into eqn2

theta2_isolated_both_eqn=isolate(eqn2_new,output_s2); %Isolate theta2 from both equations

input2_output=theta2_isolated_both_eqn/input_s;
input2_output=simplifyFraction(rhs(input2_output)); %Solve and simplify transfer function of theta2/Tau

end