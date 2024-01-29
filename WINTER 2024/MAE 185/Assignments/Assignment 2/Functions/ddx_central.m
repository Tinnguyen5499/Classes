function [dfx] = ddx_central(f,dx)
% This function returns the first derivative of f in x using second-order central difference
% function: [dfx] = ddx_central(f,dx)
% Input: f= an array
%        dx= a grid spacing
% Output: dfx = derivate of f, matrix of the same size as f


% Finding dimension of f
nx=size(f,1);
ny=size(f,2);

% Preallocating dfx
dfx=zeros(nx,ny);

%% Finding derivative at each element by looping through x-direction then y-direction
for y=1:ny %looping through each element in y direction

    for x=2:nx-1%looping through each element in x direction
        dfx(x,y) = (f(x+1,y)-f(x-1,y))/(2*dx); %Second-order central difference
    end 

    %% FIXED BECAUSE CENTRAL DIFFERENCE NEED SECOND ORDER

    %derivative of first elements using first-order forward difference
    dfx(1,y) = (-3*f(1,y)+4*f(2,y)-f(3,y))/2/dx;
    
    %derivative of last elements using first-order backward difference
    dfx(end,y) = (3*f(end,y)-4*f(end-1,y)+f(end-2,y))/2/dx;
end 
end