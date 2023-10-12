function [x] = TIN_polyex(y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
x=RR_poly([1 y(1)]);

for n=1:length(y)-1
    xn= x*RR_poly([1 y(n+1)]);
    x=xn;

end

end