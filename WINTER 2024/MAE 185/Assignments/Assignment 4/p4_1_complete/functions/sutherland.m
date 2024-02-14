function [mu] = sutherland(T)
%SUTHERLAND Summary of this function goes here
%   Detailed explanation goes here

S1=110.4;
mu0=1.735*10^(-5);

mu=mu0*(T./T(1)).^(3/2) * (T(1)+S1)./(T+S1);


end

