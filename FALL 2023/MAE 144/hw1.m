%%Problem 1
%Part a

a= RR_poly([1 0 -45 0 369 0 -324]);

b= RR_poly([1 0 -29 0 100]);

f= RR_poly([1 8 23 36 45]);

[x,y,r,t]= RR_diophantine(a,b,f);

test= a*x+b*y;

%Part b


%%Problem 2
