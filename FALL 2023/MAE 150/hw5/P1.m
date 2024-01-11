close all;
clear all;
clc;

%% Setting up variables
DOF = 2*4;
E= 210 * 10^9;
A= 19.5 * 10^(-4);

nodes(1,:)=[0 0];
nodes(2,:)=[0 4];
nodes(3,:)=[-3 4];
nodes(4,:)=[-6 0];
nodes(5,:)=[0 0];
nodes(6,:)=[-3 4];
nodes_x=nodes(:,1);
nodes_y=nodes(:,2);

L=sqrt((diff(nodes_x)).^2+(diff(nodes_y)).^2);
beta=atan2d(diff(nodes_y),diff(nodes_x));
beta(3)=beta(3)+360;
beta(4)=beta(4)+180;


plot(nodes(:,1),nodes(:,2),'k-','LineWidth',2)
hold on
%% Element stiffness matrix

for n = 1: length(L)
    k(n)= E*A/L(n);
    c(n)=cosd(beta(n));
    s(n)=sind(beta(n));
    K{n}=k(n)*[c(n)^2       c(n)*s(n)      -c(n)^2     -c(n)*s(n);
               c(n)*s(n)    s(n)^2        -c(n)*s(n)  -s(n)^2;
               -c(n)^2      -c(n)*s(n)      c(n)^2     c(n)*s(n);
               -c(n)*s(n)    -s(n)^2        c(n)*s(n)  s(n)^2  ];  
    eval(sprintf('Trace_local_K%d = trace(K{n})', n))
end

%% Expanding local matrix stiffness to size and find K global

N=DOF;

order= [1 2 3 4;
        3 4 5 6;
        5 6 7 8;
        1 2 7 8;
        1 2 5 6];
B=zeros(N,N);
K_global=B;
for n=1:5
     K_expanded{n}=B;
    for i= 1:4
        for j=1:4
            
             K_expanded{n}(order(n,i),order(n,j))=K{n}(i,j);
        end
    end
    K_expanded{n};
    
    K_global=K_global+K_expanded{n};
end 
trace_global_K=trace(K_global)
%% reducing K global

remove =[3 4 8];
K_global_reduced=K_global;
K_global_reduced(remove,:)=[];
K_global_reduced(:,remove)=[];

%% Force vector

F_known=[40 0 0 -100 0]*10^3;
F_known=transpose(F_known);

%% Solve for unknown displacement

d_unknown=inv(K_global_reduced)*F_known;

%% Solve for unknown force
K_for_F_unknown= K_global(remove,:);
d=[d_unknown(1) d_unknown(2) 0 0 d_unknown(3) d_unknown(4) d_unknown(5) 0];
d=transpose(d);
F_unknown= K_for_F_unknown*d;
F=[40000 0 F_unknown(1) F_unknown(2) 0 -100000 0 F_unknown(3)];
Reaction_force_x=F(1:2:end)'
Reaction_force_y=F(2:2:end)'


%% Graphing solution
d_x=d(1:2:end);
d_y=d(2:2:end);
nodes_x_new=nodes_x(1:4)+d_x*200;
nodes_y_new=nodes_y(1:4)+d_y*200;


nodes_x_to_graph=[transpose(nodes_x_new) transpose(nodes_x_new([1 3]))];
nodes_y_to_graph=[transpose(nodes_y_new) transpose(nodes_y_new([1 3]))];

plot(nodes_x_to_graph,nodes_y_to_graph,'r--','LineWidth',2)

legend("original","deformed")


displacement_x=d(1:2:end)
displacement_y=d(2:2:end)


