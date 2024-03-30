close all;
clear all;
clc;


for n=1:5
    data=readecp("OpenLoop_1DOF_TopHold_Run"+n+".txt",'Sample','Time','Commanded Pos','Encoder 1 Pos','Encoder 2 Pos','Control Effort')
    commandedPos(:,n)=data(:,3);
    encoder1Pos(:,n)=data(:,4);
    encoder2Pos(:,n)=data(:,5);
    controlEffort(:,n)=data(:,6);
end 

Commanded_Pos=mean(commandedPos,2);

Encoder_1_Pos=mean(encoder1Pos,2);
Encoder_2_Pos=mean(encoder2Pos,2);
Control_Effort=mean(controlEffort,2);
Time=data(:,2);

% 
% 
% T=table(Time,Commanded_Pos,Encoder_1_Pos,Encoder_2_Pos,Control_Effort);
% 
% writetable(T,'dataAverage.txt')

t=Time;
u=Control_Effort;
y=Encoder_1_Pos;



%% Writing Result

