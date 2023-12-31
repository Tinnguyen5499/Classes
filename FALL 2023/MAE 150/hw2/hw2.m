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
syms r
%part-a
hedgie_Max = 75;
hedgie_Min = 55;

doge_Max = 100;
doge_Min = 90;

hedgie_Nom = (hedgie_Max + hedgie_Min)/2;
doge_Nom = (doge_Max + doge_Min)/2;

hedgie_Dev= hedgie_Max-hedgie_Nom;
doge_Dev= doge_Max-doge_Nom;

hedgie_Rand= (hedgie_Dev*2)*r + (hedgie_Nom-hedgie_Dev)

doge_Rand= (doge_Dev*2)*r + (doge_Nom-doge_Dev)

%part-b

h_Nom= 97;
h_Std= 3;

d_Nom= 95;
d_Std= .5;

syms target;

h_t= (target-h_Nom)/h_Std;
d_t= (target-d_Nom)/d_Std;

h_Prob_norm=erf(h_t/sqrt(2));
d_Prob_norm=erf(d_t/sqrt(2));

target=100;

h_Better_perfect= 1-(subs(h_Prob_norm));
d_Better_perfect= 1-(subs(d_Prob_norm));
p_HD=h_Better_perfect/d_Better_perfect


%part-c
A_hedgie=zeros(1,10^6);
B_hedgie=zeros(1,10^6);
C_hedgie=zeros(1,10^6);
A_doge=zeros(1,10^6);
B_doge=zeros(1,10^6);
C_doge=zeros(1,10^6);
hedgie_Norm_dist=h_Nom+h_Std*sqrt(2)*erfinv(2*r-1);
doge_Norm_dist=d_Nom+d_Std*sqrt(2)*erfinv(2*r-1);

for n=1:10^6
    r=rand();
    A_hedgie(n)=double((hedgie_Dev*2)*rand() + (hedgie_Nom-hedgie_Dev));
    B_hedgie(n)=double(h_Nom+h_Std*sqrt(2)*erfinv(2*rand()-1));
    C_hedgie(n)=(1/4)*(sqrt((hedgie_Dev*2)*rand() + (hedgie_Nom-hedgie_Dev))+sqrt(h_Nom+h_Std*sqrt(2)*erfinv(2*rand()-1)))^2;

    A_doge(n)=(doge_Dev*2)*rand() + (doge_Nom-doge_Dev);
    B_doge(n)=d_Nom+d_Std*sqrt(2)*erfinv(2*rand()-1);
    C_doge(n)=(1/4)*(sqrt((doge_Dev*2)*rand() + (doge_Nom-doge_Dev))+sqrt(d_Nom+d_Std*sqrt(2)*erfinv(2*rand()-1)))^2;
end 

bin_edges=(50:110);
figure(1)

subplot(3,1,1)
hold on
histogram(A_hedgie,bin_edges,'Normalization','pdf')
histogram(A_doge,bin_edges,'Normalization','pdf')
title('Scenario A')
ylabel('Probablity')
legend({'Hedges','Doge','Location','Best'})

subplot(3,1,2)
hold on
histogram(B_hedgie,bin_edges,'Normalization','pdf')
histogram(B_doge,bin_edges,'Normalization','pdf')
title('Scenario B')
ylabel('Probablity')
legend({'Hedges','Doge','Location','Best'})

subplot(3,1,3)
hold on
histogram(C_hedgie,bin_edges,'Normalization','pdf')
histogram(C_doge,bin_edges,'Normalization','pdf')
title('Scenario C')
ylabel('Probablity')
xlabel('Score')
legend({'Hedges','Doge','Location','Best'})

%part c-a

%part c-b

%part c-c

%part c-d

%part c-e

%part c-f



%% Problem 3
%Pre-allocating
x1=zeros(1,1000);
x2=zeros(1,1000);
f1=zeros(1,1000);
f2=zeros(1,1000);
t1=zeros(1,1000);
t2=zeros(1,1000);
%actual values
syms x
f1_act=int(x^2,0,1);
f1_act=repmat(f1_act,1,1000);
f2_act=int(cos(pi*x),0,1);
f2_act=repmat(f2_act,1,1000);
%for-loops for function
for n=1:1000
    for m=1:n
        x1(m)=rand()^2;
        x2(m)=cos(pi*rand());
    end 
     f1(n)=sum(x1())/n;
     f2(n)=sum(x2())/n;
     t1(n)=n;
     t2(n)=n;   
end 
%Graphing
figure(2);
subplot(2,1,1);
hold on
plot(t1,f1);
plot(t1,f1_act);
title('Monte Carlo Estimator of integral x^2')
legend({'Estimate','Actual','Location','Best'})

subplot(2,1,2);
hold on
plot(t2,f2);
plot(t2,f2_act);
title('Monte Carlo Estimator of integral of cos(pi*x)')
legend({'Estimate','ACtual','Location','Best'})