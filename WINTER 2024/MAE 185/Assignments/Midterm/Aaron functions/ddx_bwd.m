%MAE 185; CFD, A2.1
%AJM,2022
%periodic=true means periodic bcs
%f can be 2 to 5 dimensional 
%xindex is optional index for x
function [ddx]=ddx_bwd(f,dx,periodic,xindex)
    % set default value for 'bc'
    if nargin<3, periodic = false; end
    if nargin<4, xindex=ndims(f)-1; end
    %preallocate and flip
    fc=shiftdim(f,xindex-1);
    s=size(fc);
    ddx=zeros(s);
    %get f i-1,j by removing last row
    fim1=[fc(1:s(1)-1,:,:,:,:)];
    %get ddx for i up to but not including boundary
    ddx(2:s(1),:,:,:,:)=(fc(2:s(1),:,:,:,:)-fim1)./dx;
    %if periodic goto other side for next value otherwise 
    % fill in first row y with forward difference
    if periodic
        ddx(1,:,:,:,:)=(-1.*fc(s(1),:,:,:,:)+fc(1,:,:,:,:))/dx;
    else
        ddx(1,:,:,:,:)=(fc(2,:,:,:,:)-fc(1,:,:,:,:))/dx;
    end
    %flip back
    ddx=shiftdim(ddx,ndims(f)-xindex+1); 
end
