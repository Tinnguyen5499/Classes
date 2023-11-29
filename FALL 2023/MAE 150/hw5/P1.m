close all;
clear all;
clc;

%Consider the truss structure in Fig. 1. The truss members are made out
%of steel with an elastic modulus of E = 210 GPa and the cross-sectional 
%area of the members is 19.5 cm2. The truss is simply supported and loaded as 
%indicated in the figure. Address the following prompts. 

%% Part a

% In MATLAB, determine the stiffness matrices for each element and the global stiffness matrix. Use the
% node ordering given in the figure with the origin at the node (1). Display the traces of all stiffness
% matrices (element and global) and clearly indicate which is which in the output (use the element
% numbers indicated in the figure).

DOF = 2*4;
E= 210 * 10^6;
A= 19.5 * 10^(-4);
L1= 

% Assembling local stiffness matrix
% node 1

k1= (A*E)/L1
K1= k1 * ()



