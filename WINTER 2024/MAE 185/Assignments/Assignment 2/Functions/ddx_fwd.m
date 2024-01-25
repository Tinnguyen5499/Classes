function [dfx] = ddx_fwd(f,dx)
% This function returns the first derivative of f in x using first-order forward difference
% function: [dfx] = ddx_fwd(f,dx)
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

    for x=1:nx-1 %looping through each element in x direction
        dfx(x,y) = (f(x+1,y)-f(x,y))/dx; %first-order forward difference
    end

    %derivative of last elements using first-order backward difference
    dfx(end,y) = (f(end,y)-f(end-1,y))/dx;
end 
end