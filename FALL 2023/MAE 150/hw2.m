close all; clear all; clc

%% Problem 1
dL_nom= 0.3;
dL_dev= 0.006;
del_dL= dL_dev/dL_nom;


dT_nom= 14.2;
dT_dev= 0.2;
del_dT= dT_dev/dT_nom;

dA_nom= 0.0720;
dA_dev= 0.007;
del_dA= dA_dev/dA_nom;

L_nom = dL_nom/(dT_nom*dA_nom)

worst_case_error=(del_dL+del_dT+del_dA)*L_nom

stastistical_error=sqrt((del_dL)^2+(del_dT)^2+(del_dA)^2)*L_nom





%% Problem 2



%% Problem 3

