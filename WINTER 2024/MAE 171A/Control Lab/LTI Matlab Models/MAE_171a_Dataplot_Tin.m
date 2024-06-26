close all;
clear all;
clc;

%Experiment 1 holding the top plate/encoder 2 with 0.5 input voltage
Test1 = readmatrix('OL_1DOF_E2Hold_1.txt');
Test2 = readmatrix('OL_1DOF_E2Hold_2.txt');
Test3 = readmatrix('OL_1DOF_E2Hold_3.txt');
Test4 = readmatrix('OL_1DOF_E2Hold_4.txt');
Test5 = readmatrix('OL_1DOF_E2Hold_5.txt');


TX1 = Test1(:,3);
TY1 = Test1(:,5);
TX2 = Test2(:,3);
TY2 = Test2(:,5);
TX3 = Test3(:,3);
TY3 = Test3(:,5);
TX4 = Test4(:,3);
TY4 = Test4(:,5);
TX5 = Test5(:,3);
TY5 = Test5(:,5);


cropped_point=find(TX1<2);
cropped_point=cropped_point(end);


TX1=TX1(1:cropped_point);
TY1=TY1(1:cropped_point);
TX2=TX2(1:cropped_point);
TY2=TY2(1:cropped_point);
TX3=TX3(1:cropped_point);
TY3=TY3(1:cropped_point);
TX4=TX4(1:cropped_point);
TY4=TY4(1:cropped_point);
TX5=TX5(1:cropped_point);
TY5=TY5(1:cropped_point);


figure (1);
hold on;

plot (TX1,TY1);
plot (TX2,TY2);
plot (TX3,TY3);
plot (TX4,TY4);
plot (TX5,TY5);
xlabel('time')
ylabel('counts')

TX = [TX1 TX2 TX3 TX4 TX5]';
avgTX = mean(TX,1);
TY = [TY1 TY2 TY3 TY4 TY5]';
avgTY = mean(TY,1);

figure(2);
plot(avgTX,avgTY,'-b',LineWidth=1)
xlabel('time')
ylabel('counts')

[pks1,locs1] = findpeaks(TY1,TX1);
[pks2,locs2] = findpeaks(TY2,TX2);
[pks3,locs3] = findpeaks(TY3,TX3);
[pks4,locs4] = findpeaks(TY4,TX4);
[pks5,locs5] = findpeaks(TY5,TX5);

yo1 = [pks1(1) pks2(1) pks3(1) pks4(1) pks5(1)];% position/angle of the first peak encoder #1
to1 = [locs1(1) locs2(1) locs3(1) locs4(1) locs5(1)]; % number of seconds for first peak
yn1 = [pks1(3) pks2(3) pks3(3) pks4(3) pks5(3)];  % Don't rly know what n is?
tn1 = [locs1(3) locs2(3) locs3(3) locs4(3) locs5(3)]; % position/angle for n
yinf1 = [TY1(end) TY2(end) TY3(end) TY4(end) TY5(end)];
n = 3; % number of oscillations between tn and to by countng number of peaks
U= 0.5; %the step input?

wd_1 = 2*pi*n./(tn1-to1);
avgwd_1 = mean(wd_1);
Bwn_1 = (1./(tn1-to1)) .*log((yo1-yinf1)./(yn1-yinf1));
wn_1 = sqrt(wd_1.^2 + Bwn_1.^2);
avgwn_1 = mean(wn_1);
B_1 = Bwn_1./wn_1 ; 
avgB_1 = mean(B_1);
k = U./yinf1;
avgk = mean(k);
m_1 = k .* (1./wn_1.^2);
d_1 = k .* (2.*B_1)./wn_1;

avgk = mean(k);
avgm_1 = mean(m_1);
avgd_1 = mean(d_1);



%% Experiment 2 Data holding encoder 1/plate 1

data1 = readmatrix('OL_1DOF_E1Hold_1.txt');
data2 = readmatrix('OL_1DOF_E1Hold_2.txt');
data3 = readmatrix('OL_1DOF_E1Hold_3.txt');
data4 = readmatrix('OL_1DOF_E1Hold_4.txt');
data5 = readmatrix('OL_1DOF_E1Hold_5.txt');

DX1 = data1(:,3);
DY1 = data1(:,5);
DX2 = data2(:,3);
DY2 = data2(:,5);
DX3 = data3(:,3);
DY3 = data3(:,5);
DX4 = data4(:,3);
DY4 = data4(:,5);
DX5 = data5(:,3);
DY5 = data5(:,5);

DX = [DX1 DX2 DX3 DX4 DX5]';
avgDX = mean(DX,1);
DY = [DY1 DY2 DY3 DY4 DY5]';
avgDY = mean(DY,1);

% Store the vectors in cell arrays for easier processing
DX = {DX1, DX2, DX3, DX4, DX5};
DY = {DY1, DY2, DY3, DY4, DY5};

% Determine the first non-zero y-value for each line and its corresponding x-value
xStarts = zeros(size(DX));
for i = 1:length(DX)
    yStartIdx = find(DY{i} > 0, 1, 'first');
    xStarts(i) = DX{i}(yStartIdx);
end

% Determine the maximum of these x-values to use as a common starting point
commonXStart = max(xStarts);

% Adjust each line's x-coordinates to align starts
adjustedDX = cell(size(DX));
for i = 1:length(DX)
    xShift = commonXStart - xStarts(i);
    adjustedDX{i} = DX{i} + xShift;
end

% Optional: Plot the adjusted lines for visualization
figure(5);
hold on;
colors = lines(numel(DX)); % Get some distinct colors for plotting
for i = 1:numel(adjustedDX)
    plot(adjustedDX{i}, DY{i}, 'LineWidth', 1, 'Color', colors(i,:));
end
title('Adjusted Graph Lines');
xlabel('X-coordinate');
ylabel('Y-coordinate');
legend('Line 1', 'Line 2', 'Line 3', 'Line 4', 'Line 5');
hold off;

%Add mean graph 

figure(3);
hold on;

Start_index1=find(DX1==xStarts(1));
Start_index2=find(DX2==xStarts(2));
Start_index3=find(DX3==xStarts(3));
Start_index4=find(DX4==xStarts(4));
Start_index5=find(DX5==xStarts(5));

DX1_want=DX1(Start_index1:end);
DX2_want=DX2(Start_index2:end);
DX3_want=DX3(Start_index3:end);
DX4_want=DX4(Start_index4:end);
DX5_want=DX5(Start_index5:end);

DY1_want=DY1(Start_index1:end);
DY2_want=DY2(Start_index2:end);
DY3_want=DY3(Start_index3:end);
DY4_want=DY4(Start_index4:end);
DY5_want=DY5(Start_index5:end);




plot(DX1_want,DY1_want);
plot(DX2_want,DY2_want);
plot(DX3_want,DY3_want);
plot(DX4_want,DY4_want);
plot(DX5_want,DY5_want);
[pos1,time1] = findpeaks(DY1_want,DX1_want);
[pos2,time2] = findpeaks(DY2_want,DX2_want);
[pos3,time3] = findpeaks(DY3_want,DX3_want);
[pos4,time4] = findpeaks(DY4_want,DX4_want);
[pos5,time5] = findpeaks(DY5_want,DX5_want);   

xlabel('time')
ylabel('counts/position(theta)')

yo_2 = [ pos1(1) pos2(1) pos3(1) pos4(1) pos5(1)];
to_2 = [ time1(1) time2(1) time3(1) time4(1) time5(1)];
yn_2 = [ pos1(end) pos2(end) pos3(end) pos4(end) pos5(end)];
tn_2 = [ time1(end) time2(end) time3(end) time4(end) time5(end)];
yinf_2 = [DY1(end) DY2(end) DY3(end) DY4(end) DY5(end)];
n= 12;
% k2=k(1:5);
k2 = U./yinf_2;


wd_2 = 2*pi*n./(tn_2-to_2);
avgwd_2 = mean(wd_2);
Bwn_2 = (1./(tn_2-to_2)) .*log((yo_2-yinf_2)./(yn_2-yinf_2));
wn_2 = sqrt(wd_2.^2 + Bwn_2.^2);
avgwn_2 = mean(wn_2);

B_2 = Bwn_2./wn_2 ; 
m_2 = k2 .* (1./wn_2.^2);
d_2 = k2 .* (2.*B_2)./wn_2;



avgk2 = mean(k2)
std_k2= std(k2)
avgm_2 = mean(m_2)
std_m2=std(m_2)
avgd_2 = mean(d_2)
std_d2=std(d_2)
avgB_2 = mean(B_2);
std_B2=std(B_2)



%Calculate Step Response
phi_1=atand(sqrt(1 - avgB_1^2)/avgB_1);
phi_2=atand(sqrt(1 - avgB_2^2)/avgB_2);
y1 = (U/avgk) .*(1 - exp(-avgB_1.*avgwn_1.*(TX1)) .* sin(avgwd_1.*(TX1) + phi_1));
y2 = -230+(U/avgk) .*(1 - exp(-avgB_2.*avgwn_2.*(DX1-2)) .* sin(avgwd_2.*(DX1-2) + phi_2));

% figure(3);
% hold on;
% plot(avgTX,y1);
% plot(avgTX,avgTY);

xlabel('time')
ylabel('counts')
title('1 DOF Plate/Enc 1 ')

% figure(4);
% hold on;
% plot(avgDX,y2);
% plot(avgDX,avgDY);
% xlabel('time')
% ylabel('counts')
% title('1 DOF Plate/Enc 2 ')


%stuff = readmatrix('PID_Pd_0.124_enc2.txt');
%SX1 = stuff(:,3);
%SY1 = stuff(:,5);
%figure(4);
%plot(SX1,SY1);
%drawnow;
%[buss,papi] = findpeaks(SY1,SX1);

