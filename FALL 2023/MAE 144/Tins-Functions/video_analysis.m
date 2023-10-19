function [values] = video_analysis(samples,pathway)
%% VIDEO_ANALYSIS
% takes frames from a video and returns the standard deviation of the
% Fourier analyses of the frames with respect to the first frame
% INPUTS
% samples - list of sample names (strings), should correspond to file
%           folders within the pathway
% pathway - file pathway to sample folders
% OUTPUTS 
% values - array of 1D Fourier transform frame intensities
% pathway = '/Users/lmh-d/Documents/MATLAB/';
% samples = '7-5-2023 9.79MHz_1wv_0.25V_2.4W_static0009';

for ii = 1:length(samples) % for every sample
    sample = samples(ii); % assign sample name
    source = strcat(pathway,sample,'/frames/'); % assign pathway to frames
    destination = strcat(pathway,sample,'/output/'); % assign output pathway
    frames = dir(strcat(source,'/*.png')); % assign list of frames
    numframes = length(frames); % number of frames
    angle = golden_section_angle(source,frames); % angle of rotation
    for jj = 1:numframes % for every frame
        frame = strcat(source,frames(jj).name); % name the frame
        profile = fourier_1D(frame, angle); % compute 1D intensity profile
        values(:,jj,ii) = profile'/max(profile); % save normalized intensity profile
        percent = jj/numframes*100;
        fprintf('%f%%, %i/%i frames, Sample %s\n',percent,jj,numframes,sample)
    end

    std_dev = sqrt(sum((repmat(values(:,1,ii),1,numframes)-values(:,:,ii)).^2,1)/size(values,1)); % calculate the standard deviation
    writematrix(std_dev',strcat(destination,sample,'std_dev.csv')); % save as a csv

    for kk = 1:numframes
        figure(1)
        hold on;
        plot(kk,std_dev(kk),'.r')
        exportgraphics(gcf,strcat(destination,sample,'std_dev.gif'),'Append',true);
    end
    hold off;
    close all;
end

end

function [rec_angle] = golden_section_angle(source,frames)
%% GOLDEN_SECTION_ANGLE
% computes the angle at which the Fourier transform is maximized for a
% random set of frames to determine the angle of rotation
% INPUTS
% source - pathway to frames
% frames - directory of frames
% OUTPUTS
% rec_angle - the recommended angle of rotation

numtrials = 10; % number of trial frames
trial_frame = randi([10,length(frames)],numtrials); % randomly selected trial frames
angles = zeros(1,numtrials); % preallocating

for ii = 1:numtrials % for every frame
    frame = strcat(source,frames(trial_frame(ii)).name); % name the frame

    epsilon = 0.1; % threshold
    iter = 50; % maximum number of iterations
    phi = (sqrt(5)+1)/2; % golden proportion coefficient
    k = 0; % number of iterations

    x1 = -10; % min angle
    x4 = 10; % max angle
    x2 = x4 - (x4 - x1)/phi; % guess 1
    x3 = x1 + (x4 - x1)/phi; % guess 2

    while ((abs(x4 - x1) > epsilon && (k < iter))) % iterative conditions
        k = k + 1; % counter
        if max(fourier_1D(frame,x2)) > max(fourier_1D(frame,x3)) % comparing guesses
            x4 = x3; % reassigning for next calculation
        else
            x1 = x2; % reassigning for next calculation
        end
        x2 = x4 - (x4 - x1)/phi; % recalculating
        x3 = x1 + (x4 - x1)/phi; % recalculating
    end
    
    angles(ii) = (x1 + x4)/2; % average
    fprintf("The recommended angle for frame %i is %f\n",trial_frame(ii),angles(ii))
end

rec_angle = mean(angles);
fprintf("The overall recommended angle is %f\n",rec_angle)
end

function [profile] = fourier_1D(frame, angle)
%% FOURIER_1D
% computes the 1D profile of the Fourier transform of a frame
% INPUTS
% frame - the frame for evaluation
% angle - angle of rotation
% OUTPUTS
% profile - the 1D intensity profile fo the Fourier transform

greyscale = rgb2gray(imread(frame)); % convert to greyscale
contrast = imadjust(greyscale); % adjust contrast
rotated = imrotate(contrast,angle,"nearest","crop"); % rotate
transformed = xcorr2(rotated); % Fourier transform
profile = sum(transformed); % 1D intensity profile
end