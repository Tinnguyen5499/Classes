function [TF_z, omega_bar_z] = TIN_C2D_matched(TF, sample_rate,omega_bar);
%Input transfer function in time domain RR_TF function, sample rate, and
%omega_bar
% TF=RR_tf(num)      1 argument  defines an RR_tf object G from a numerator polynomial, setting denominator=1
%TF=RR_tf(num,den)  2 arguments defines an RR_tf object from numerator and denominator polynomials
%TF=RR_tf(z,p,K)    3 arguments defines an RR_tf object from vectors of zeros and poles, z and p, and the gain K
%Output the zeros and poles of z transfer function function

zero_s=RR_roots(TF.num.poly);
pole_s=RR_roots(TF.den.poly);
zero_z=exp(zero_s*sample_rate);
pole_z=exp(pole_s*sample_rate);
pole_infinity =length(pole_s)-length(zero_s);


if  pole_infinity>0
for n=1:pole_infinity
  zero_z(end+1)= -1;

end 
end

%Semi Causal
%Strictly Causal
zero_z(end)=[];
gain_s=RR_evaluate(TF,0);
TF_z_hold= RR_tf([zero_z],[pole_z],1);
%Gain
gain_z=gain_s/RR_evaluate(TF_z_hold,1);
omega_bar_z=RR_evaluate(TF_z_hold,exp(omega_bar*sample_rate));
TF_z=RR_tf(zero_z,pole_z,gain_z);

end