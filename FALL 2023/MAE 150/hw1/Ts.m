function [Ts] = Ts(Sx,Sy)
%Input (Sx,Sy), 
%Sx= scaling in x-direction
%Sy= scaling in y-direction
%Output= scaling matrix

Ts= [Sx 0  0;
     0  Sy  0;
     0  0  1]; %scaling


end