% Physical parameter functions
function [mu,a,k]=Midterm_PhysicalParameters(T,nx,ny,gamma,R,cp,Pr)
    mu=sutherland(T);
    a=ones(nx,ny) .* sqrt(gamma.*R.*T);
    k=cp./Pr .* mu;
end