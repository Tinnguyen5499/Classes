close all;
clear all;
clc;

syms F(t) x(t) dxdt(t) t s Y(s) U(s) y0 dydt0 u0 I1 d1 k
% Standard form of second-order system
eqn_t = ((I1)*diff(x(t), t, 2) + (d1)*diff(x(t), t) + k*x(t)) == F(t);
% In Laplace domain
eqn_s = subs(laplace(eqn_t), [laplace(x(t), t, s), laplace(F(t), t, s), diff(x(t), t)], [Y(s), U(s), dxdt(t)])
% Set initial conditions to zero to get transfer function
eqn_s0 = subs(eqn_s, [x(0), dxdt(0)], [0, 0])

G=rhs(eqn_s0) / U(s) / (simplify(lhs(eqn_s0)) / Y(s))

I1_sub=1.4859*10^(-6);
I2_sub=3.79*10^(-6);
k_sub=0.0022;
d1_sub=2.0727*10^(-5);
d2_sub=4.6887*10^(-6);

G_subbed=subs(G,[I1 k d1],[I1_sub k_sub d1_sub]);

[n,d] =numden(G_subbed);

num=sym2poly(n);
den=sym2poly(d);

transfer=tf(num,den)

bode(transfer)


