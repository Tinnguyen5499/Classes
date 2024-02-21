function dfdx = ddx_central(f,dx,bc)

% turning 3D matrix into 2D matrix
if ~ismatrix(f)==1
f=squeeze(f);
end

% set default value for 'bc'
if nargin<3, bc = 'one-sided'; end

% determine field size
[nx,ny]     = size(f);

% allocate return field
dfdx        = zeros(nx,ny);

% central difference
for i=2:nx-1
    for j=1:ny
        dfdx(i,j) = (f(i+1,j)-f(i-1,j))/2/dx;
    end
end

switch bc
    case 'periodic'
        
        % assuming periodicity (left boundary)
        i = 1;
        for j=1:ny
            dfdx(i,j) = (f(i+1,j)-f(end,j))/2/dx;
        end
        
        % assuming periodicity (right boundary)
        i = nx;
        for j=1:ny
            dfdx(i,j) = (f(1,j)-f(i-1,j))/2/dx;
        end
        
    otherwise
        
        % forward difference for first point
        i = 1;
        for j=1:ny
            dfdx(i,j) = (-3*f(i,j)+4*f(i+1,j)-f(i+2,j))/2/dx;
        end
        
        % backward difference for last point
        i = nx;
        for j=1:ny
            dfdx(i,j) = (3*f(i,j)-4*f(i-1,j)+f(i-2,j))/2/dx;
        end
        
end

end