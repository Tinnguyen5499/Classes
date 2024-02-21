%MAE 185; CFD, A2.2
%AJM,2024ny
%periodic=true means periodic bcs
function [d2dx2]=d2dx2(f,dx,periodic) 
    %field sizes
    [nx,ny] = size(f);
    %preallocate
    d2dx2=zeros(nx,ny);
    %get f i+1,j by removing first 2 row
    fip1=[f(3:nx,:)];
    %get f i-1,jby removing last 2 row
    fim1=[f(1:nx-2,:)];
    %get d2dx2 for i up to but not including boundary on both sides
    d2dx2(2:nx-1,:)=(fip1-2.*f(2:nx-1,:)+fim1)./(dx^2);
    
    %if periodic then use central but taking values from the other 
    %side otherwise fill in with first row second order forward second 
    %difference and lastrow with second order backward second difference
    if periodic
        d2dx2(1,:)=(f(nx,:)-2.*f(1,:)+f(2,:))/(dx^2);
        d2dx2(nx,:)=(f(1,:)-2.*f(nx,:)+f(nx-1,:))/(dx^2);
    else
        d2dx2(1,:)=(2.*f(1,:)-5.*f(2,:)+4.*f(3,:)-1.*f(4,:))/(dx^2);
        d2dx2(nx,:)=(2.*f(nx,:)-5.*f(nx-1,:)+4.*f(nx-2,:)-1.*f(nx-3,:))/(dx^2);
    end 
end
