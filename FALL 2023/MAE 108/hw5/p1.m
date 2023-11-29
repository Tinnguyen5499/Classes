close all; clear all; clc;

syms x k
% 
% a =nchoosek(5,3)
% b =nchoosek(3,2)
% c = a*p^3*(1-p)^2
% d = b*p^2*(1-p)
% eqn= c<d



a=symsum(nchoosek(5,k)*x^k*(1-x)^(5-k),k,3,5)
b=symsum(nchoosek(3,k)*x^k*(1-x)^(5-k),k,2,3)

eqn= a<b

x= solve(eqn, x, 'ReturnConditions',true)
