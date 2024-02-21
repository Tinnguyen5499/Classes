close all;
clear all
clc

%% Input
materialData=readtable("materialData.xlsx");
materialNames=string(materialData.AISINo_);
materialNames_holder=materialNames;
materialNames(~ismissing(materialNames_holder))=strcat(materialNames_holder(~ismissing(materialNames_holder)),' HR');
materialNames(ismissing(materialNames_holder))=strcat(materialNames_holder(find(ismissing(materialNames_holder))-1),' CD');

yieldStrength=materialData.YieldStrength_MPa_kpsi_;
tensileStrength=materialData.TensileStrength_MPa_kpsi_;


for n=1:length(yieldStrength)

    yieldStrength_MPa{n}=yieldStrength{n}(1:find(isspace(yieldStrength{1}))-1);
    yieldStrength_ksi{n}=yieldStrength{n}(find(isspace(yieldStrength{n}))+2:end-1);

    tensileStrength_MPa{n}=tensileStrength{n}(1:find(isspace(tensileStrength{1}))-1);
    tensileStrength_ksi{n}=tensileStrength{n}(find(isspace(tensileStrength{n}))+2:end-1);
    
   
end 

    yieldStrength_MPa=str2double(yieldStrength_MPa);
    yieldStrength_ksi=str2double(yieldStrength_ksi);

    tensileStrength_MPa=str2double(tensileStrength_MPa);
    tensileStrength_ksi=str2double(tensileStrength_ksi);

% Loading (in ksi)

[selectedMaterial]=listdlg('listString',materialNames);




Mm= 3;

Ma= 2;

Tm= 0.9;

Ta= 0.9;




% Material/Limits

%materialType=

Sy= yieldStrength_ksi(selectedMaterial);
Sut= tensileStrength_ksi(selectedMaterial);

%calculate ka
ka= 0.957;

%calculate kb
kb= 0.85;

kc=1;
kd=1;
%choosing ke
ke=0.702;

kf=1;
%Calculate Se Prime
Se_prime=Sy/2;

%Calculating Se
Se= Se_prime *ka *kb *kc *kd *ke;

% Estimate Stress Concentration

Kf= 1.7;
Kfs= 1.5;

n=1.5;


%% Calculation

%DE-Goodman

d= ( (16*n/pi) * ( (2*(Kf*Ma)/Se) + ( (3*(Kfs*Tm)^2)^(1/2) /Sut) ) ) ^ (1/3);

D=d*(1+0.2);
%% Display
r=d/2;
R=D/2;
h=4;

[X1,Y1,Z1]=cylinder(R);
Z1=Z1*h;
surf(X1,Y1,Z1)

hold on

[X2,Y2,Z2]=cylinder(r);
Z2=Z2*h;
surf(X2,Y2,Z2+h)

daspect([1 1 1])

camorbit(90,0)
