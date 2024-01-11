close all; clear all; clc

mu = 90
sigma = 0.15

zeta = sqrt( log(1+sigma.^2))

lamda = log(mu)-(1/2)*zeta.^2

% lamda_s = lamda(2)-lamda(1)
% 
% zeta_s =sqrt(zeta(2)^2+zeta(1)^2)
% 
% 1-logncdf(1,lamda_s,zeta_s)