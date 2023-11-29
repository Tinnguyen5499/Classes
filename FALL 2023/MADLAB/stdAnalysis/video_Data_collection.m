clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures.
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.


%% access data
% 
% pathway='/Users/tinnguyen/Downloads/School/Fall 2023/MADLAB/Meetings:Data/Usable data/10-8-23/Testing data analysis'
% samples=[string('/test1') string('/test2') string('/test3') ]
% x=video_analysis(samples,pathway)

pathway='/Users/tinnguyen/Downloads/School/Fall 2023/MADLAB/Meetings:Data/Usable data/10-25-23/data_Analysis'
samples=[ string("/0.1_0.1") string("/0.1_0.2") string("/35Mhz") string("/35Mhz(2)") string("/77Mhz") string("/77Mhz(2)")];



for ii = 1:length(samples) % for every sample
    sample = samples(ii); % assign sample name
    source = strcat(pathway,sample,'/frames/'); % assign pathway to frames
    destination = strcat(pathway,sample,'/output/'); % assign output pathway
    frames = dir(strcat(source,'/*.png')); % assign list of frames
    numframes = length(frames); % number of frames
    binary_Mask=makingMask(pathway,samples(ii),300,ii);
    
     for jj = 1:numframes % for every frame
         frame = strcat(source,frames(jj).name);
         originalImage= im2gray(imread(frame));
     standard_deviation(jj,ii)=std2(originalImage(binary_Mask));

     end 


%      %% Plotting the data
%     figure(length(samples)+1)
%     hold on
%     x=plot(1:length(standard_deviation(:,ii)),standard_deviation(:,ii),'LineWidth',2)
%     xlabel('frames'); % x-axis label name
%     ylabel('std'); % y-axis label name
%     [a(ii),b(ii)]=ginput(1)
%     delete(x)
%     plot(1:length(standard_deviation(:,ii))-round(a(ii)),standard_deviation(round(a(ii)):length(standard_deviation(:,ii))-1,ii),'LineWidth',2)
%     drawnow
%     legend('35Mhz','77Mhz','Alternating')


end 

save('data','standard_deviation');

% close(5)
% clear figure(5)
% figure(5)
% hold on
% plot(1:length(standard_deviation(:,1))-round(a(1)),standard_deviation(round(a(1)):length(standard_deviation(:,1))-1,1),'LineWidth',2)
% plot(1:length(standard_deviation(:,1))-round(a(2)),standard_deviation(round(a(2)):length(standard_deviation(:,2))-1,2),'LineWidth',2)
% plot(1:length(standard_deviation(:,1))-round(a(3)),standard_deviation(round(a(3)):length(standard_deviation(:,3))-1,3),'LineWidth',2)
% legend('35Mhz','77Mhz','Alternating')




