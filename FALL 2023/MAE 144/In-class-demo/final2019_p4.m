clear; syms s R3 R4 C1 C2 Vin % <- symbolics & input
syms I1 I2 I3 I4 Vin Va Vout % <- unknown

eqn1 = I3 == I4 +I2; % KCl1
eqn2 = I4 == I1; %KCL2
eqn3 = (Vin-Va) == I3*R3; %R3 eqn
eqn4 = C2 *s *(Va-Vout) == I2; %R4 eqn
eqn5 = C1*s* (Vout)== I1; %C2 eqn
eqn6 = (Va-Vout)==I4*R4; %C1 eqn

solve(eqn1, eqn2, eqn3, eqn4,eqn5,eqn6)

sol=solve(eqn1,eqn2,eqn3,eqn4,eqn5,eqn6, I1,I2,I3,I4, Va, Vout);

Vout_simplified=simplify(sol.Vout/Vin)