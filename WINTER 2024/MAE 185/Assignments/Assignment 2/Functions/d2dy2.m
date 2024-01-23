function [d2f] = d2dy2(f,dy)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

nx=size(f,1);
ny=size(f,2);

d2f=zeros(nx,ny);

for x=1:nx
    for y= 2:ny-1
        d2f(x,y) = (f(x,y+1)-2*f(x,y)+f(x,y-1))/dy^2;
    end 
    d2f(x,end) = (2*f(x,end)-5*f(x,end-1)+4*f(x,end-2)-f(x,end-3))/dy^2;
    d2f(x,1)= (2*f(x,1)-5*f(x,1+1)+4*f(x,1+2)-f(x,1+3))/dy^2;
end

end 