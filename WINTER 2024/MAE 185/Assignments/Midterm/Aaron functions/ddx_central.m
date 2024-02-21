%MAE 185; CFD, A2.1
%AJM,2022
%periodic=true means periodic bcs
%f can be 2 to 5 dimensional 
%xindex is optional index for x
function [ddx]=ddx_central(f,dx,periodic,xindex)
    % set default value for 'bc'
    if nargin<3, periodic = false; end
    if nargin<4, xindex=ndims(f)-1; end
    %preallocate and flip
    fc=shiftdim(f,xindex-1);
    s=size(fc);
    ddx=zeros(s);
    
    %get f i+1,j by removing first 2 row
    fip1=fc(3:s(1),:,:,:,:);
    %get f i-1,j by removing last 2 row
    fim1=fc(1:s(1)-2,:,:,:,:);
    %get ddx for i up to but not including boundary on both sides
    ddx(2:s(1)-1,:,:,:,:)=(fip1-fim1)./(2*dx);

    %if periodic goto other side for next value otherwise
    %fill in with first row second order forward difference and last row
    %with second order backward difference
    if periodic
        ddx(1,:,:,:,:)=(-1.*fc(s(1),:,:,:,:)+fc(2,:,:,:,:))/(2*dx);
        ddx(s(1),:,:,:,:)=(fc(1,:,:,:,:)-fc(s(1)-1,:,:,:,:))/(2*dx);
    else
        ddx(1,:,:,:,:)=(-3.*fc(1,:,:,:,:)+4.*fc(2,:,:,:,:)-1.*fc(3,:,:,:,:))/(2*dx);
        ddx(s(1),:,:,:,:)=(3.*fc(s(1),:,:,:,:)-4.*fc(s(1)-1,:,:,:,:)+1.*fc(s(1)-2,:,:,:,:))/(2*dx);
    end
    %flip back
    ddx=shiftdim(ddx,ndims(f)-xindex+1);
end