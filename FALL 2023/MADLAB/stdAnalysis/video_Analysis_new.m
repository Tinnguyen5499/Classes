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

pathway='/Users/tinnguyen/Downloads/School/Fall 2023/MADLAB/Meetings:Data/Usable data/10-8-23/Testing data analysis'
samples=[ string("/test1") string("/test2") string("/test3")];



for ii = 1:length(samples) % for every sample
    sample = samples(ii); % assign sample name
    source = strcat(pathway,sample,'/frames/'); % assign pathway to frames
    destination = strcat(pathway,sample,'/output/'); % assign output pathway
    frames = dir(strcat(source,'/*.png')); % assign list of frames
    numframes = length(frames); % number of frames
    binary_Mask=makingMask(pathway,samples(ii),200,ii);
    
     for jj = 1:numframes % for every frame
         frame = strcat(source,frames(jj).name);
         originalImage= im2gray(imread(frame));
     standard_deviation(jj,ii)=std2(originalImage(binary_Mask));

     end 
    figure(length(samples)+1)
    plot(1:numframes,standard_deviation(:,ii))
    

end 



