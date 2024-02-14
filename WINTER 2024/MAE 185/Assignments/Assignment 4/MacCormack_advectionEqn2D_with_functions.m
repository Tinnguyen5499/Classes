% MacCormack for 2-D advection equations with constant bulk velocity
% OTS, 2020

clear variables
close all
clc
%addpath('functions_periodic')

load('mae190','T','xx','yy');

% Solver parameters
c           = [1 1];        % bulk velocity
t_end       = 2;            % final time

% Grid parameters
[nx,ny]     = size(xx);
dx          = xx(2,1)-xx(1,1);
dy          = yy(1,2)-yy(1,1);

% determine time step from stability requirenment
safety_fac  = 1.1;                                % safety factor
dt_max      = 1/(c(1)/dx + c(2)/dy);              % maximum time step
nt          = ceil(t_end/(dt_max/safety_fac));    % number of time steps
dt          = t_end/nt;                           % time step that gets us right to t_end

%%
figure
for ti = 1:nt
   
    %%%%%%%%%%%%%%
    % MACCORMACK % 
    %%%%%%%%%%%%%%
    
    % PREDICTOR (forward FD)
    dTdx        = ddx_fwd(T,dx,'periodic');
    dTdy        = ddy_fwd(T,dy,'periodic');
    
    T_pre       = T - c(1)*dt*dTdx - c(2)*dt*dTdy;
    
    % CORRECTOR (backward FD)
    dT_predx    = ddx_bwd(T_pre,dx,'periodic');
    dT_predy    = ddy_bwd(T_pre,dy,'periodic');    
    
    T           = 0.5*( (T+T_pre) - c(1)*dt*dT_predx - c(2)*dt*dT_predy);
     
    % Plot temperature at time t
    pcolor(xx,yy,T); shading interp, caxis([0 1]); axis equal tight;
    title(['T @ t=' num2str(dt*ti)])
    xlabel('x');
    ylabel('y');
    colorbar;
    
    drawnow    
end


%%%%%%%%%%%%%%%%%%
%    FUNCTIONS   %
%%%%%%%%%%%%%%%%%%

% First-order backward difference difference function in x
function dfdx = ddx_bwd(f,dx,bc)

    % set default value for 'bc'
    if nargin<3, bc = 'one-sided'; end

    % determine field size
    [nx,ny]     = size(f);

    % allocate return field
    dfdx        = zeros(nx,ny);

    % backward difference
    for i=2:nx
        for j=1:ny
            dfdx(i,j) = (f(i,j)-f(i-1,j))/dx;
        end
    end

    switch bc
        case 'periodic'

            % assuming periodicity (left boundary)
            i = 1;
            for j=1:ny
                dfdx(i,j) = (f(i,j)-f(end,j))/dx;
            end

        otherwise

            % forward difference for first point
            i = 1;
            for j=1:ny
                dfdx(i,j) = (f(i+1,j)-f(i,j))/dx;
            end      
    end
end

% First-order backward difference difference function in y
function dfdy = ddy_bwd(f,dy,bc)

    % set default value for 'bc'
    if nargin<3, bc = 'one-sided'; end

    % determine field size
    [nx,ny]     = size(f);

    % allocate return field
    dfdy        = zeros(nx,ny);

    % backward difference
    for i=1:nx
        for j=2:ny
            dfdy(i,j) = (f(i,j)-f(i,j-1))/dy;
        end
    end

    switch bc
        case 'periodic'

            % assuming periodicity (bottom boundary)
            j = 1;
            for i=1:nx
                dfdy(i,j) = (f(i,j)-f(i,ny))/dy;
            end

        otherwise

            % forward difference for first point
            j = 1;
            for i=1:nx
                dfdy(i,j) = (f(i,j+1)-f(i,j))/dy;
            end
    end
end

% First-order forward difference difference function in x
function dfdx = ddx_fwd(f,dx,bc)

    % set default value for 'bc'
    if nargin<3, bc = 'one-sided'; end

    % determine field size
    [nx,ny]     = size(f);

    % allocate return field
    dfdx        = zeros(nx,ny);

    % forward difference
    for i=1:nx-1
        for j=1:ny
            dfdx(i,j) = (f(i+1,j)-f(i,j))/dx;
        end
    end

    switch bc
        case 'periodic'

            % assuming periodicity (right boundary)
            i = nx;
            for j=1:ny
                dfdx(i,j) = (f(1,j)-f(i,j))/dx;
            end

        otherwise        

            % backward difference for last point
            i = nx;
            for j=1:ny
                dfdx(i,j) = (f(i,j)-f(i-1,j))/dx;
            end      
    end
end


% First-order forward difference difference function in y
function dfdy = ddy_fwd(f,dy,bc)

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