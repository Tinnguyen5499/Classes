%MAE 185; CFD, A2.1
%AJM,2024
%periodic=true means periodic bcs
%f can be 2 to 5 dimensional 
%yindex is optional index for y
function [ddy]=ddy_central(f,dy,periodic) 
    % set default value for 'bc'
    if nargin<3, periodic = false; end
    if nargin<4, yindex=ndims(f); end
    %preallocate and flip
    fc=shiftdim(f,yindex-1);
    s=size(fc);
    ddy=zeros(s);

    %get f i,j+1 by removing first 2 col
    fjp1=[fc(3:s(1),:,:,:,:)];
    %get f i,j-1 by removing last 2 col
    fjm1=[fc(1:s(1)-2,:,:,:,:)];
    %get ddy for j up to but not including boundary on both sides
    ddy(2:s(1)-1,:,:,:,:)=(fjp1-fjm1)./(2*dy);
    %if periodic go to other side for next value otherwise
    %fill in with first col second order forward difference and last col
    %with second order backward difference
    if periodic
        ddy(1,:,:,:,:)=(-1.*fc(s(1),:,:,:,:)+fc(2,:,:,:,:))/(2*dy);
        ddy(s(1),:,:,:,:)=(fc(1,:,:,:,:)-fc(s(1)-1,:,:,:,:))/(2*dy);
    else
        ddy(1,:,:,:,:)=(-3.*fc(1,:,:,:,:)+4.*fc(2,:,:,:,:)-1.*fc(3,:,:,:,:))/(2*dy);
        ddy(s(1),:,:,:,:)=(3.*fc(s(1),:,:,:,:)-4.*fc(s(1)-1,:,:,:,:)+1.*fc(s(1)-2,:,:,:,:))/(2*dy);
    end
    %flip back
    ddy=shiftdim(ddy,ndims(f)-yindex+1);
end