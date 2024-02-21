function [mu] = sutherland(T)
%SUTHERLAND Summary of this function goes here
%   Detailed explanation goes here

S1=110.4;
T_ref=288.0;
mu_ref=1.735*10^(-5);

mu  = mu_ref*(T_ref+S1)./(T+S1).*(T/T_ref).^(3/2);

end

