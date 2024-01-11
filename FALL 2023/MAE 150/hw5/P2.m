close all;;
clear all;
clc;

%% Set up variables

l = 5;
F = 100;
Q = 30;
M = 2000;
E = 200*10^9;

%% set up length vector

l1=l/4;
l2=2*l/8;
l3=l/4;
L1=ones(1,4)*l1;
L2=ones(1,8)*l2;
L3=ones(1,4)*l3;
L=[L1 L2 L3];


%% set up I vector
d1=.1;
r2=.03;
r3=.015;

i1=d1^4/12;
i2=(pi/64)*(r2*2)^4;
i3=(pi/64)*(r3*2)^4;
I1=ones(1,4)*i1;
I2=ones(1,8)*i2;
I3=ones(1,4)*i3;
I=[I1 I2 I3];

%% Setting up element stiffness matrix

for n=1:length(L)
    K{n}= [12*E*I(n)/L(n)^3      6*E*I(n)/L(n)^2     -12*E*I(n)/L(n)^3     6*E*I(n)/L(n)^2;
           6*E*I(n)/L(n)^2       4*E*I(n)/L(n)^1     -6*E*I(n)/L(n)^2      2*E*I(n)/L(n)^1;
           -12*E*I(n)/L(n)^3     -6*E*I(n)/L(n)^2     12*E*I(n)/L(n)^3     -6*E*I(n)/L(n)^2;
           6*E*I(n)/L(n)^2       2*E*I(n)/L(n)^1      -6*E*I(n)/L(n)^2     4*E*I(n)/L(n)^1];           
end 

%% expand element stiffness matrix and forming global matrix
B=zeros(34,34);
Kg=B;
for n=1:length(L)
    k=n*2-1;
    K_expanded{n}=B;
    K_expanded{n}(k:k+3,k:k+3)=K{n};
    Kg=Kg+K_expanded{n};
end

%% Reducing global matrix

Kr = Kg(3:end,3:end);
norm_Kg=norm(Kg);
cond_Kr=cond(Kr);

%% Force matrix
% v1

% F_force(1:3)=0
% F_force(4)=Q*l2/2
% F_force(5:11)=0
% F_force(12)=-Q*l2/2-F
% F_force(13:16)=0

% F_moment(1:3)=0;
% F_moment(4)=-Q*l2^2/12;
% F_moment(5:11)=-Q*l2^2/12-Q*l2^2/12;
% F_moment(12)=-Q*l2^2/12
% F_moment(13:15)=0;
% F_moment(16)= -M;
% F_reduced=[F_force;F_moment]
% F_reduced= F_reduced(:)

% v2

F_force(1:3)=0;
F_force(4)=Q*l2/2;
F_force(5:11)=Q*l2;
F_force(12)=Q*l2/2-F;
F_force(13:16)=0;

F_moment(1:3)=0;
F_moment(4)=-Q*l2^2/12;
F_moment(5:11)=0;
F_moment(12)=-Q*l2^2/12;
F_moment(13:15)=0;
F_moment(16)= -M;

F_reduced=[F_force;F_moment];
F_reduced= F_reduced(:);



%% Solve for unknown displacement
d_unknown=inv(Kr)*F_reduced;
d=[[0 0] d_unknown'];
d_d=d(1:2:end);
d_a=d(2:2:end);

length_=(0:l1:20);
figure(1)
plot(length_,d_d,'b-','LineWidth',1.5);
title('vertical deflection versus length')
xlabel('length(m)')
ylabel('vertical deflection(m)')
figure(2)
plot(length_,rad2deg(d_a),'b-','LineWidth',1.5)
title('angle in degree versus length')
xlabel('length(m)')
ylabel('rotation angle(degree)')

%% Determining the reaction force and moment at the fixed end

K_F_unknown= Kg(1:2,:);

F_unknown=K_F_unknown*d';


%% answer
fprintf("Part a\n\n")

Area_moment_inertia_1=i1
Area_moment_inertia_2=i2
Area_moment_inertia_3=i3

fprintf("Part b\n\n")

norm_Kg
cond_Kr

fprintf("Part c\n\n")

displacement_at_node=d_d
rotation_at_node=d_a

fprintf("part d\n\n")

fprintf("see figure(1)\n")

fprintf("part e\n\n")

fprintf("see figure(2)\n")

fprintf("part f\n\n")

Force_at_fixed_end=F_unknown(1)
Moment_at_fixed_end=F_unknown(2)

