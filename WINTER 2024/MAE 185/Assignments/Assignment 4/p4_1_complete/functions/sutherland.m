function [mu] = sutherland(T)
%SUTHERLAND Summary of this function goes here
%   Detailed explanation goes here

S1=110.4;
<<<<<<< HEAD:WINTER 2024/MAE 185/Assignments/Assignment 4/Submission Files/p4_1_final/functions/sutherland.m
T_ref=288.0;
mu_ref=1.735*10^(-5);
=======
mu0=1.735*10^(-5);
>>>>>>> parent of 774ed9e (adfs):WINTER 2024/MAE 185/Assignments/Assignment 4/p4_1_complete/functions/sutherland.m

mu=mu0*(T./T(1)).^(3/2) * (T(1)+S1)./(T+S1);

end

