function [d2f] = d2dy2(f,dy)
% This function returns the second derivative of f in y using second-order central difference
% function: [d2f] = d2dy2(f,dy)
% Input: f= an array
%        dy= a grid spacing
% Output: d2f = second derivate of f, matrix of the same size as f

% Finding dimension of f
nx=size(f,1);
ny=size(f,2);

% Preallocating d2f
d2f=zeros(nx,ny);

%% Finding derivative at each element by looping through x-direction then y-direction

for x=1:nx %looping through each element in x direction

    for y= 2:ny-1 %looping through each element in y direction
        d2f(x,y) = (f(x,y+1)-2*f(x,y)+f(x,y-1))/dy^2;  %Se cond derivative using second-order central difference
    end 

    %2nd derivative of last elements using second-order backward difference
    d2f(x,end) = (2*f(x,end)-5*f(x,end-1)+4*f(x,end-2)-f(x,end-3))/dy^2;
    %2nd derivative of first elements using second-order forward difference
    d2f(x,1)= (2*f(x,1)-5*f(x,1+1)+4*f(x,1+2)-f(x,1+3))/dy^2;

end

end 