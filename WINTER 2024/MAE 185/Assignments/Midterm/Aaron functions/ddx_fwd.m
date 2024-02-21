%MAE 185; CFD, A2.1
%AJM,2022
%periodic=true means periodic bcs
%f can be 2 to 5 dimensional 
%xindex is optional index for x
function [ddx]=ddx_fwd(f,dx,periodic,xindex) 
    % set default value for 'bc'
    if nargin<3, periodic = false; end
    if nargin<4, xindex=ndims(f)-1; end%fc or f
    %preallocate and flip
    fc=shiftdim(f,xindex-1);
    s=size(fc);
    ddx=zeros(s);
    %get f i+1,j by removing first row
    fip1=[fc(2:s(1),:,:,:,:)];
    %get ddx for i up to but not including boundary
    ddx(1:s(1)-1,:,:,:,:)=(fip1-fc(1:s(1)-1,:,:,:,:))./dx;
    %if periodic goto other side for next value otherwise
    %fill in last row with backward difference
    if periodic
        ddx(s(1),:,:,:,:)=(fc(1,:,:,:,:)-fc(s(1),:,:,:,:))/dx;
    else
        ddx(s(1),:,:,:,:)=(fc(s(1),:,:,:,:)-fc(s(1)-1,:,:,:,:))/dx;
    end
    %flip back
    ddx=shiftdim(ddx,ndims(f)-xindex+1);
end


