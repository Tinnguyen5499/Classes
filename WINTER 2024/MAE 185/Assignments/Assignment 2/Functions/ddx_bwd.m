function [dfx] = ddx_bwd(f,dx)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
nx=size(f,1);
ny=size(f,2);

dfx=zeros(nx,ny);
for y=1:ny
    for x=2:nx
        dfx(x,y) = (f(x,y)-f(x-1,y))/dx;
    end 
    dfx(1,y) = (f(2,y)-f(1,y))/dx;
end 
end