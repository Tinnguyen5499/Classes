function d2fdx2 = d2dx2(f,dx)

    % determine field size
    [nx,ny]     = size(f);

    % allocate return field
    d2fdx2      = zeros(nx,ny);
    
    dx2         = dx^2;
    
    % central difference
    for i=2:nx-1
        for j=1:ny
            d2fdx2(i,j) = (f(i+1,j)-2*f(i,j)+f(i-1,j))/dx2;
        end
    end
    
%     % forward difference for first point
%     i = 1;
%     for j=1:ny
%         d2fdx2(i,j) = (2*f(i,j)-5*f(i+1,j)+4*f(i+2,j)-f(i+3,j))/dx2;
%     end
%     
%     % backward difference for last point
%     i = nx;
%     for j=1:ny
%         d2fdx2(i,j) = (2*f(i,j)-5*f(i-1,j)+4*f(i-2,j)-f(i-3,j))/dx2;
%     end

% Assuming periodic boundary at the first point

i=1;
for j=i:ny
    d2fdx2(i,j) = (f(2,j)-2*f(i,j)+f(end,j))/dx2;
end

% Assuming periodic bounrady at the last point
i=nx;
for j=1:ny
    d2fdx2(i,j) = f(i,j)-2*f(1,j)+f(end-1,j);
end


end 