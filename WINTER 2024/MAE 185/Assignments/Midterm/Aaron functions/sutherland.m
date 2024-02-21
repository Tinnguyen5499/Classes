%MAE 185; CFD, A4.1
%AJM,2024
%primitive to conservative variables for air, a calorically perfect gas
function [mu] = sutherland(T)
   %referene values
   S1=110.4; %K
   T0=288; %K
   mu0=1.735e-5; %Ns/m^2

   %get mu
   mu=mu0.*(T./T0).^(3/2).*(T0+S1)./(T+S1);
end

