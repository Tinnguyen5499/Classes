function [U] = prim2cons(rho,u,v,T,cv)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

e=cv.*T;
Et=rho.*(e+(u.^2+v.^2)./2);
U(1,:,:)=rho;
U(2,:,:)=rho.*u;
U(3,:,:)=rho.*v;
U(4,:,:)=Et;

end

