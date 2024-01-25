function [dfy] = ddy_central(f,dy)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
nx=size(f,1);
ny=size(f,2);

dfy=zeros(nx,ny);
for x=1:nx
    for y=2:ny-1
        dfy(x,y) = (f(x,y+1)-f(x,y-1))/(2*dy);
    end 
    dfy(1,y) = (f(x,2)-f(x,1))/dy;
    dfy(end,y) = (f(x,end)-f(x,end-1))/dy;
end 
end