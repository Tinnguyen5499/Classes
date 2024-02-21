% Boundary Condition Functions
function [u,v,T,p,rho,e,Et]=Midterm_BCs(uu,vv,TT,pp,T0,p0,u0,nx,ny,R,cv,opt) 
    
    if nargin<12, opt=1; end
    u=uu;
    v=vv;
    T=TT;
    p=pp;

    %wall
    u(:,1) = 0;
    v(:,1) = 0;
    if opt==1
        T(:,1) = T0;
    else
        T(:,2) = T(:,3);
        T(:,1) = T(:,2);
    end
    p(:,1) = 2.*p(:,2)-p(:,3);

    %inlet & far-field
    u(1,:)= u0;
    u(:,ny)= u0;
    v(1,:)=0;
    v(:,ny)=0;
    p(1,:)=p0;
    p(:,ny)=p0;
    T(1,:)=T0;
    T(:,ny)=T0;

    %OUTLET:
    u(nx,:)=2.*u(nx-1,:)-u(nx-2,:);
    v(nx,:)=2.*v(nx-1,:)-v(nx-2,:);
    p(nx,:)=2.*p(nx-1,:)-p(nx-2,:);
    T(nx,:)=2.*T(nx-1,:)-T(nx-2,:);

    %Leading Edge
    u(1,1)=0;
    v(1,1)=0;
    p(1,1)=p0;
    T(1,1)=T0;

     %updating rho
     rho=p./(R.*T);

     %updating e & Et
     e=cv .* T;
     Et=rho.*(e+(1/2).*(u.^2+v.^2));
end 