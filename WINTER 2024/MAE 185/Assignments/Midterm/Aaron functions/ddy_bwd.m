%MAE 185; CFD, A2.1
%AJM,2022
%periodic=true means periodic bcs
%f can be 2 to 5 dimensional 
%yindex is optional index for y
function [ddy]=ddy_bwd(f,dy,periodic,yindex) 
    % set default value for 'bc'
    if nargin<3, periodic = false; end
    if nargin<4, yindex=ndims(f); end
    %preallocate and flip
    fc=shiftdim(f,yindex-1);
    s=size(fc);
    ddy=zeros(s);

    %get f i,j-1 by removing last col
    fjm1=[fc(1:s(1)-1,:,:,:,:)];
    %get ddy for j up to but not including boundary
    ddy(2:s(1),:,:,:,:)=(fc(2:s(1),:,:,:,:)-fjm1)./dy;
    %if periodic go to other side for next value otherwise
    %fill in first col with forward difference
    if periodic
        ddy(1,:,:,:,:)=(-1.*fc(s(1),:,:,:,:)+fc(1,:,:,:,:))/dy;
    else
        ddy(1,:,:,:,:)=(fc(2,:,:,:,:)-fc(1,:,:,:,:))/dy;
    end
    %flip back
    ddy=shiftdim(ddy,ndims(f)-yindex+1);
end
