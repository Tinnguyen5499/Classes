close all; clear all ;clc

%% part A

syms I3 k

% G=tf(1, [1 0 0]);
% % K=tf([1 1], [1 10]);
% Lead=tf([500 500], [1 50])
% Lag=tf([1 10], [1 1])
% L=G*Lead*Lag;

% figure(1)
% rlocus(G);
% 
% figure(2)
% bode(G)
% 
% 
% 
% figure(4)
% bode(K)
% 
% figure(5)
% rlocus(K)
% 
% 
% 
% figure(6)
% bode(L)
% 
% figure(7)
% rlocus(L)

% 
% figure(9)
% bode(Lag)
% 
% figure(8)
% margin(L)


%% Problem 3

G1=tf(1,[1 0 -1])
D1=tf([1 -1],[1 10])
G2= tf([1 0 -1], [1 0 0])
D21= tf(-10, 1)
D22= tf([1 2],[1 5])


L1=G2*D21*D22
figure(1)
bode(L1)

figure(2)
rlocus(L1)

