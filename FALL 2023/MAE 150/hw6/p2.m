clear; clc;

EI = 0.001;
L = 2.5;
m = 250;

%% Setting up element matrix

for n=1:4
    K{n}= [12*  EI/L^3      6*  EI/L^2     -12*  EI/L^3     6*  EI/L^2;
           6*  EI/L^2       4*  EI/L^1     -6*  EI/L^2      2*  EI/L^1;
           -12*  EI/L^3     -6*  EI/L^2     12*  EI/L^3     -6*  EI/L^2;
           6*  EI/L^2       2*  EI/L^1      -6*  EI/L^2     4*  EI/L^1];           
end 

for n=1:4
    M{n} = (m/2)*[1 0 0 0;
        0 (L^2)/12 0 0;
        0 0 1 0;
        0 0 0 (L^2)/12];           
end 

%% exapand element matrix and forming global matrix

B=zeros(10,10);
Kg=B;
Mg=B;
for n=1:4
    k=n*2-1;
    K_expanded{n}=B;
    K_expanded{n}(k:k+3,k:k+3)=K{n};
    Kg=Kg+K_expanded{n};
end

for n=1:4
    k=n*2-1;
    M_expanded{n}=B;
    M_expanded{n}(k:k+3,k:k+3)=M{n};
    Mg=Mg+M_expanded{n};
end



[v lam] = eig(inv(Mg)*Kg);

disp("Resonant Frequencies (w^2):");
disp(lam);

disp("Mode Shapes:")
disp(v);