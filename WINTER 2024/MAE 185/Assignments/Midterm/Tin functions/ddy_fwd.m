function dfdy = ddy_fwd(f,dy,bc)

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

% forward difference
for i=1:nx
    for j=1:ny-1
        dfdy(i,j) = (f(i,j+1)-f(i,j))/dy;
    end
end

switch bc
    case 'periodic'
        
        % assuming periodicity (top boundary)
        j = ny;
        for i=1:nx
            dfdy(i,j) = (f(i,1)-f(i,j))/dy;
        end
        
    otherwise
        
        % backward difference for last point
        j = ny;
        for i=1:nx
            dfdy(i,j) = (f(i,j)-f(i,j-1))/dy;
        end
end
end