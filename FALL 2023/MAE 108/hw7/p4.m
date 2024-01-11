close all; clear all; clc

mu=[1.8 2.3*10^-3 120];

sigma= [0.2 0.1 0.45];


zeta= sqrt( log(1+sigma.^2))

lamda= log(mu)-(1/2)*zeta.^2

lamda_p= log(1/2)+ lamda(1)+lamda(2)+2*lamda(3)

zeta_p=sqrt(zeta(1)^2+zeta(2)^2+(2*zeta(3))^2)

