close all; clear all; clc
syms w2 x2 x3 x4

EI=0.001
L=10
m=1000

K= [12*EI/L^3      6*EI/L^2     -12*EI /L ^3     6*EI /L ^2;
    6*EI /L ^2       4*EI /L ^1     -6*EI /L ^2      2*EI /L ^1;
    -12*EI /L ^3     -6*EI /L ^2     12*EI /L ^3     -6*EI /L ^2;
    6*EI /L ^2       2*EI /L ^1      -6*EI /L ^2     4*EI /L ^1];    

M=m/2*[1 0 0 0 ;
      0 L^2/12 0 0;
      0 0 1 0;
      0 0 0 L^2/12];
M_inv=inv(M)


I=[ 1 0 0 0;
    0 1 0 0 ;
    0 0 1 0;
    0 0 0 1];

X=M_inv * K-w2 *I

Y=det(X)

S=double(solve(Y==0,w2))

Xnew_1=subs(X,w2,S(4))

x_=[1 x2 x3 x4]

R=solve(det(Xnew_1)*x_==0==0,x2, x3,x4)