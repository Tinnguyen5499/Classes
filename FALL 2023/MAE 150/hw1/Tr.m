function [Tr] = Tr(theta)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

Tr= [cosd(theta) sind(theta) 0 ;
     -sind(theta) cosd(theta) 0 ;
     0           0          1  ]; %rotation

end