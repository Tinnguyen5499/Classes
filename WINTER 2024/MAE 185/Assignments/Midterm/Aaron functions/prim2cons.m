%MAE 185; CFD, A4.1
%AJM,2024
%primitive to conservative variables for air, a calorically perfect gas
function [U]=prim2cons(rho,u,v,T,cv) 
   U=zeros(4,size(rho,1),size(rho,2));
   e=cv.*T;
   U(1,:,:)=rho; %rho
   U(2,:,:)=rho.*u;%rho*u
   U(3,:,:)=rho.*v;%rho*v
   U(4,:,:)=rho.*(e+(u.^2+v.^2)./2);%Et
end

