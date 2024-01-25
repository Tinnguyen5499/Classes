function [dfx] = ddx_bwd(f,dx)
% This function returns the first derivative of f in x using first-order backward difference
% function: [dfx] = ddx_bwd(f,dx)
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

    for x=2:nx %looping through each element in x direction
        dfx(x,y) = (f(x,y)-f(x-1,y))/dx; %first-order backward difference
    end

    %derivative of first elements using first-order forward difference
    dfx(1,y) = (f(2,y)-f(1,y))/dx;
end 
end