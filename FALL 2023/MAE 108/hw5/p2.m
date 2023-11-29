close all; clear all; clc;

n=100
p=0.9
a=binocdf(95,100,0.9)-binocdf(83,100,0.9)
b=binocdf(85,100,0.9)

mu=n*p
sigma=sqrt(n*p*(1-p))

c=normcdf(95.5,mu,sigma)-normcdf(83.5,mu,sigma)
d=normcdf(85.5,mu,sigma)
