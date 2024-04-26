

close all;
clear all;
clc
%% Grade
current_point=418;
current_unit =128;
current_GPA= current_point/current_unit;

%% Grade points per unit
A   =4;
A_m =3.7;

B_p =3.3;
B   =3.0;
B_m =2.7;

C_p =2.3;
C   =2;
C_m =1.7;

F   =0;



% prompt = "How many regrade? ";
% regrade = input(prompt)
% 
% prompt = "How classes each quarters? (input vector)";
% number_classes_added = input(prompt);
% 
% 
% prompt = "What are the grades for each quarter ? (input vector)";
% grades_for_classes = input(prompt)


[GPA_final]=GPA_calculator1(418,128,2,[3 3 3 3 3],[2*A+1*A 3*A 3*A 3*A 3*A])

hold on
[GPA_final]=GPA_calculator1(418,128,2,[3 3 3 3 3],[2*A+1*B 3*A 3*A 3*A 3*A])

[GPA_final]=GPA_calculator1(418,128,1,[3 3 3 3 3],[A+A_m+B_p 3*A 3*A 3*A 3*A])
test1=GPA_calculator1(418,128,1,[3 3 3 3 3],[A+A_m+B_p 3*A 3*A 3*A 3*A])

[GPA_final]=GPA_calculator1(418,128,1,[3 4 3 3 3],[A+A_m+B_p 4*A 3*A 3*A 3*A])
test2=GPA_calculator1(418,128,1,[3 4 3 3 3],[A+A_m+B_p 4*A 3*A 3*A 3*A])

[GPA_final]=GPA_calculator1(418,128,1,[3 4 4 3 3],[A+A_m+B_p 4*A 4*A 3*A 3*A])
test3=GPA_calculator1(418,128,1,[3 4 4 3 3],[A+A_m+B_p 4*A 4*A 3*A 3*A])
legend("2A","2B","Test1","Test2","Test3")











function [GPA_final]=GPA_calculator1(current_point,current_GPA,regrade,number_classes_added,grades_for_classes)


%% Grade
current_point=418;
current_unit =128;
current_GPA= current_point/current_unit;

quarter_ahead_GPA(1)= current_point/current_unit;

%% Grade points per unit
A   =4;
A_m =3.7;

B_p =3.3;
B   =3.0;
B_m =2.7;

C_p =2.3;
C   =2;
C_m =1.7;

F   =0;

%% Regrade

regrade_points=4*[F C];
regrade_units=[4 4];


%% 

if regrade==1
current_point=current_point-regrade_points(1);
current_unit=current_unit-regrade_units(1);
end

if regrade==2
current_point=current_point-regrade_points(1)-regrade_points(2);
current_unit=current_unit-regrade_units(1)-regrade_units(2);
end


%% Assuming getting all A's for all class
for n = 1:length(number_classes_added)
    current_unit=current_unit+4*number_classes_added(n);
    current_point=current_point+4*grades_for_classes(n);
quarter_ahead_GPA(n+1)= current_point/current_unit;
end

scatter(1:length(number_classes_added)+1,quarter_ahead_GPA)

drawnow

GPA_final=quarter_ahead_GPA
end




