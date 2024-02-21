function [mu] = sutherland(T)
%SUTHERLAND Summary of this function goes here
%   Detailed explanation goes here

S1=110.4;
<<<<<<< HEAD
T_ref=288.0;
mu_ref=1.735*10^(-5);
mu  = mu_ref*(T_ref+S1)./(T+S1).*(T/T_ref).^(3/2);
=======
mu0=1.735*10^(-5);

mu=mu0*(T./T(1)).^(3/2) * (T(1)+S1)./(T+S1);
>>>>>>> parent of 774ed9e (adfs)


end

