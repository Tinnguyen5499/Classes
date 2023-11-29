%% Scripts for video editing using ffmpeg
% go back to the orignal directory
cd
% navigate to folder

cd 'Downloads/School/Fall 2023/MADLAB/Meetings:Data/Usable data/10-8-23/Testing data analysis/test8/frames'

%cut video

ffmpeg -i 77Mhz_2.MOV -ss 00:00:2 -t 00:00:25 -c copy 77Mhz_2_cut.MOV


%turn video to .png

ffmpeg -i 77Mhz_2_cut.MOV image%4d.png
