function dfdy = ddy_central(f,dy,bc)

% turning 3D matrix into 2D matrix
if ~ismatrix(f)==1
f=squeeze(f);
end

% set default value for 'bc'
if nargin<3, bc = 'one-sided'; end

% determine field size
[nx,ny]     = size(f);

% allocate return field
dfdy        = zeros(nx,ny);

% central difference
for i=1:nx
    for j=2:ny-1
        dfdy(i,j) = (f(i,j+1)-f(i,j-1))/2/dy;
    end
end

switch bc
    case 'periodic'
        % assuming periodicity (bottom boundary)
        j = 1;
        for i=1:nx
            dfdy(i,j) = (f(i,j+1)-f(i,ny))/2/dy;
        end
        
        % assuming periodicity (top boundary)
        j = ny;
        for i=1:nx
            dfdy(i,j) = (f(i,1)-f(i,j-1))/2/dy;
        end
        
    otherwise
        
        % forward difference for first point
        j = 1;
        for i=1:nx
            dfdy(i,j) = (-3*f(i,j)+4*f(i,j+1)-f(i,j+2))/2/dy;
        end
        
        % backward difference for last point
        j = ny;
        for i=1:nx
            dfdy(i,j) = (3*f(i,j)-4*f(i,j-1)+f(i,j-2))/2/dy;
        end
        
end
end