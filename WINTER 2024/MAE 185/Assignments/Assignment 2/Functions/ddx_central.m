function [dfx] = ddx_central(f,dx)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
nx=size(f,1);
ny=size(f,2);

dfx=zeros(nx,ny);
for y=1:ny
    for x=2:nx-1
        dfx(x,y) = (f(x+1,y)-f(x-1,y))/(2*dx);
    end 
    dfx(1,y) = (f(2,y)-f(1,y))/dx;
    dfx(end,y) = (f(end,y)-f(end-1,y))/dx;
end 
end