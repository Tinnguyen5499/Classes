%MAE 185; CFD, A2.2
%AJM,2024
%periodic=true means periodic bcs
function [d2dy2]=d2dy2(f,dy,periodic) 
    %field sizes
    [nx,ny] = size(f);
    %preallocate
    d2dy2=zeros(nx,ny);
    %get f i,j+1 by removing first 2 col
    fjp1=[f(:,3:ny)];
    %get f i,j-1 by removing last 2 col
    fjm1=[f(:,1:ny-2)];
    %get d2dy2 for j up to but not including boundary on both sides
    d2dy2(:,2:ny-1)=(fjp1-2.*f(:,2:ny-1)+fjm1)./(dy^2);
   
    %if periodic then use central but taking values from the other 
    %side otherwise fill in with first col second order forward second difference and last col
    %with second order backward second difference
    if periodic
        d2dy2(:,1)=(f(:,ny)-2.*f(:,1)+f(:,2))/(dy^2);
        d2dy2(:,ny)=(f(:,1)-2.*f(:,ny)+f(:,ny-1))/(dy^2);
    else
        d2dy2(:,1)=(2.*f(:,1)-5.*f(:,2)+4.*f(:,3)-1.*f(:,4))/(dy^2);
        d2dy2(:,ny)=(2.*f(:,ny)-5.*f(:,ny-1)+4.*f(:,ny-2)-1.*f(:,ny-3))/(dy^2);
    end 
end
