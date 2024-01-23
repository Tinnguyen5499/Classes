function [dfx] = ddx_fwd(f,dx)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

nx=size(f,1);
ny=size(f,2);

dfx=zeros(nx,ny);
for y=1:ny
    for x=1:nx-1
        dfx(x,y) = (f(x+1,y)-f(x,y))/dx;
    end 
    dfx(end,y) = (f(end,y)-f(end-1,y))/dx;
end 
end