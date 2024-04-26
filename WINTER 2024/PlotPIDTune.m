close all; 
clear all;
clc;

%% Read Data: Trial 1
S1T1 = readmatrix('2DOF_PIDTuner_Trial6E.txt');
S1T2 = readmatrix('2DOF_PIDTuner_Trial2E.txt');
S1T3 = readmatrix('2DOF_PIDTuner_Trial3E.txt');
S1T4 = readmatrix('2DOF_PIDTuner_Trial4E.txt');
S1T5 = readmatrix('2DOF_PIDTuner_Trial5E.txt');

%Trial 1
S1T1X = S1T1(:,3); %Time of Sample
S1T1L = length(S1T1X); %Length of vector
S1T1XC = S1T1X(1:floor(S1T1L/2)); %Cropped Time sample
S1T1Y1 = S1T1(:,4); %Encoder1 Pos
S1T1Y1C = S1T1Y1(1:floor(S1T1L/2)); %%Encoder1 Pos Cropped

%Trial 2
S1T2X = S1T2(:,3); %Time of Sample
S1T2L = 451; %Length of vector
S1T2XC = S1T2X(1:floor(S1T2L/2)); %Cropped Time sample
S1T2Y1 = S1T2(:,4); %Encoder1 Pos
S1T2Y1C = S1T2Y1(1:floor(S1T2L/2)); %%Encoder1 Pos Cropped

%Trial 3
S1T3X = S1T3(:,3); %Time of Sample
S1T3L = length(S1T3X); %Length of vector
S1T3XC = S1T3X(1:floor(S1T3L/2)); %Cropped Time sample
S1T3Y1 = S1T3(:,4); %Encoder1 Pos
S1T3Y1C = S1T3Y1(1:floor(S1T3L/2)); %%Encoder1 Pos Cropped

%Trial 4
S1T4X = S1T4(:,3); %Time of Sample
S1T4L = length(S1T4X); %Length of vector
S1T4XC = S1T4X(1:floor(S1T4L/2)); %Cropped Time sample
S1T4Y1 = S1T4(:,4); %Encoder1 Pos
S1T4Y1C = S1T4Y1(1:floor(S1T4L/2)); %%Encoder1 Pos Cropped

%Trial 5
S1T5X = S1T5(:,3); %Time of Sample
S1T5L = length(S1T5X); %Length of vector
S1T5XC = S1T5X(1:floor(S1T5L/2)); %Cropped Time sample
S1T5Y1 = S1T5(:,4); %Encoder1 Pos
S1T5Y1C = S1T5Y1(1:floor(S1T5L/2)); %%Encoder1 Pos Cropped

%Average for SetUp1:
avg_T1 = (S1T1Y1C + S1T2Y1C + S1T3Y1C + S1T4Y1C + S1T5Y1C)/5 ;

%Plots
figure(01)
hold on;
plot(S1T1XC,S1T1Y1C)
plot(S1T2XC,S1T2Y1C)
plot(S1T3XC,S1T3Y1C)
plot(S1T4XC,S1T4Y1C)
plot(S1T5XC,S1T5Y1C)

figure(02)
plot(S1T1XC,avg_T1,'LineWidth',3)

%% Trial 2

%Setup 2
S2T1 = readmatrix('2DOF_PIDTuner_MovedMass_Trial1E.txt');
S2T2 = readmatrix('2DOF_PIDTuner_MovedMass_Trial2E.txt');
S2T3 = readmatrix('2DOF_PIDTuner_MovedMass_Trial3E.txt');
S2T4 = readmatrix('2DOF_PIDTuner_MovedMass_Trial4E.txt');
S2T5 = readmatrix('2DOF_PIDTuner_MovedMass_Trial5E.txt');

%Trial 1
S2T1X = S2T1(:,3); %Time of Sample
S2T1L = length(S2T1X); %Length of vector
S2T1XC = S2T1X(1:floor(S2T1L/2)); %Cropped Time sample
S2T1Y1 = S2T1(:,4); %Encoder1 Pos
S2T1Y1C = S2T1Y1(1:floor(S2T1L/2)); %%Encoder1 Pos Cropped

%Trial 2
S2T2X = S2T2(:,3); %Time of Sample
S2T2L = 451; %Length of vector
S2T2XC = S2T2X(1:floor(S2T2L/2)); %Cropped Time sample
S2T2Y1 = S2T2(:,4); %Encoder1 Pos
S2T2Y1C = S2T2Y1(1:floor(S2T2L/2)); %%Encoder1 Pos Cropped

%Trial 3
S2T3X = S2T3(:,3); %Time of Sample
S2T3L = length(S2T3X); %Length of vector
S2T3XC = S2T3X(1:floor(S2T3L/2)); %Cropped Time sample
S2T3Y1 = S2T3(:,4); %Encoder1 Pos
S2T3Y1C = S2T3Y1(1:floor(S1T3L/2)); %%Encoder1 Pos Cropped

%Trial 4
S2T4X = S2T4(:,3); %Time of Sample
S2T4L = length(S2T4X); %Length of vector
S2T4XC = S2T4X(1:floor(S2T4L/2)); %Cropped Time sample
S2T4Y1 = S2T4(:,4); %Encoder1 Pos
S2T4Y1C = S2T4Y1(1:floor(S2T4L/2)); %%Encoder1 Pos Cropped

%Trial 5
S2T5X = S2T5(:,3); %Time of Sample
S2T5L = length(S2T5X); %Length of vector
S2T5XC = S2T5X(1:floor(S2T5L/2)); %Cropped Time sample
S2T5Y1 = S2T5(:,4); %Encoder1 Pos
S2T5Y1C = S2T5Y1(1:floor(S2T5L/2)); %%Encoder1 Pos Cropped

%Average for SetUp1:
avg_T2 = (S2T1Y1C + S2T2Y1C + S2T3Y1C + S2T4Y1C + S2T5Y1C)/5 ;

figure(03)
plot(S1T1XC,avg_T2,'LineWidth',3)

%% Trial 3

S3T1 = readmatrix('2DOF_PIDTuner_MovedMass2_Trial1E.txt');
S3T2 = readmatrix('2DOF_PIDTuner_MovedMass2_Trial2E.txt');
S3T3 = readmatrix('2DOF_PIDTuner_MovedMass2_Trial3E.txt');
S3T4 = readmatrix('2DOF_PIDTuner_MovedMass2_Trial4E.txt');
S3T5 = readmatrix('2DOF_PIDTuner_MovedMass2_Trial5E.txt');

%Trial 1
S3T1X = S3T1(:,3); %Time of Sample
S3T1L = length(S3T1X); %Length of vector
S3T1XC = S3T1X(1:floor(S3T1L/2)); %Cropped Time sample
S3T1Y1 = S3T1(:,4); %Encoder1 Pos
S3T1Y1C = S3T1Y1(1:floor(S2T1L/2)); %%Encoder1 Pos Cropped

%Trial 2
S3T2X = S3T2(:,3); %Time of Sample
S3T2L = 451; %Length of vector
S3T2XC = S3T2X(1:floor(S3T2L/2)); %Cropped Time sample
S3T2Y1 = S3T2(:,4); %Encoder1 Pos
S3T2Y1C = S3T2Y1(1:floor(S3T2L/2)); %%Encoder1 Pos Cropped

%Trial 3
S3T3X = S3T3(:,3); %Time of Sample
S3T3L = length(S3T3X); %Length of vector
S3T3XC = S3T3X(1:floor(S3T3L/2)); %Cropped Time sample
S3T3Y1 = S3T3(:,4); %Encoder1 Pos
S3T3Y1C = S3T3Y1(1:floor(S1T3L/2)); %%Encoder1 Pos Cropped

%Trial 4
S3T4X = S3T4(:,3); %Time of Sample
S3T4L = length(S3T4X); %Length of vector
S3T4XC = S3T4X(1:floor(S3T4L/2)); %Cropped Time sample
S3T4Y1 = S3T4(:,4); %Encoder1 Pos
S3T4Y1C = S3T4Y1(1:floor(S3T4L/2)); %%Encoder1 Pos Cropped

%Trial 5
S3T5X = S3T5(:,3); %Time of Sample
S3T5L = length(S3T5X); %Length of vector
S3T5XC = S3T5X(1:floor(S3T5L/2)); %Cropped Time sample
S3T5Y1 = S3T5(:,4); %Encoder1 Pos
S3T5Y1C = S3T5Y1(1:floor(S3T5L/2)); %%Encoder1 Pos Cropped

%Average for SetUp1:
avg_T3 = (S3T1Y1C + S3T2Y1C + S3T3Y1C + S3T4Y1C + S3T5Y1C)/5 ;

figure(04)
plot(S1T1XC,avg_T3,'LineWidth',3)



%% Overshoot:


% Find the steady-state value (assumed to be the mean of the last portion of the response)
ss_T1 = mean(avg_T1(end-20:end));
peak_T1 = max(avg_T1);
ss_T2 = mean(avg_T2(end-20:end));
peak_T2 = max(avg_T2);
ss_T3 = mean(avg_T3(end-20:end));
peak_T3 = max(avg_T3);

% Calculate overshoot as a percentage
Overshoot_T3 = ((peak_T1 - ss_T1) / ss_T1) * 100;
Overshoot_T2 = ((peak_T2 - ss_T2) / ss_T2) * 100;
Overshoot_T1 = ((peak_T3 - ss_T3) / ss_T3) * 100;

%
figure(05)
hold on;
plot(S1T1XC,avg_T1,'LineWidth',3)
plot(S1T1XC,avg_T2,'LineWidth',3)
plot(S1T1XC,avg_T3,'LineWidth',3)
yline( ss_T1*0.25+ss_T1, '--r','LineWidth',2)
xlabel('Time (s)')
ylabel('Encoder 2 Position (Counts) ')

legend('Setup3','Setup2','Baseline','25% Overshoot of Baseline','Location','best')
axis([0 2 0 1400])


%Change in overshoot
Overshoot_base = Overshoot_T1;
Overshoot_new1 = Overshoot_T2;
Overshoot_new2 = Overshoot_T3;

change_overshoot1 = ( (Overshoot_new1 - Overshoot_base)/Overshoot_base ) * 100
change_overshoot2 = ( (Overshoot_new2 - Overshoot_base)/Overshoot_base ) * 100

%% Settling time 
%Setup 1
% Define the threshold for settling (2% of the final value)
threshold1 = 0.02 * ss_T1;
% Find the index where the response first crosses the threshold
settling_index = find(abs(avg_T1 - ss_T1) <= threshold1, 1, 'first');
% Get the time corresponding to the settling index
settling_time1 = S1T1XC(settling_index);

%Setup 2
% Define the threshold for settling (2% of the final value)
threshold2 = 0.02 * ss_T2;
% Find the index where the response first crosses the threshold
settling_index2 = find(abs(avg_T2 - ss_T2) <= threshold2, 1, 'first');
% Get the time corresponding to the settling index
settling_time2 = S1T1XC(settling_index2);

%Setup 3
% Define the threshold for settling (2% of the final value)
threshold3 = 0.02 * ss_T3;
% Find the index where the response first crosses the threshold
settling_index3 = find(abs(avg_T3 - ss_T3) <= threshold3, 1, 'first');
% Get the time corresponding to the settling index
settling_time3 = S1T1XC(settling_index3);


