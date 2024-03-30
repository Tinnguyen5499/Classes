clear all; clc; close all;
% Remove simcolons from file
% Specify the file path
file_path = '1DOF_TopHold_SineSweep_Trial2.txt';

% Read the content of the text file
file_content = fileread(file_path);

% Remove semicolons
file_content_no_semicolon = strrep(file_content, ';', '');

% Write the modified content back to the file
fid = fopen(file_path, 'w');
fprintf(fid, '%s', file_content_no_semicolon);
fclose(fid);

disp('Semicolons removed successfully!');

%%
clear all; close all; clc;
T = readmatrix(['1DOF_TopHold_SineSweep_Trial2.txt']);

%%
close all
t = T(:,3);
control = T(:,6);
freq = linspace(.1,20,round(height(T)/2));
mag_enc2 = abs(fft(T(:,5)));
mag_enc1 = abs(fft(T(:,4)));

dB_enc2 = 20*log10(mag_enc2/max(mag_enc2));
dB_enc2 = dB_enc2(1:round(length(dB_enc2)/2));
% dB_enc2 = 20*log10(mag_enc2/max(mag_enc2));
dB_enc1 = 20*log10(mag_enc1/max(mag_enc1));
dB_enc1 = dB_enc1(1:round(length(dB_enc1)/2));

figure(1)
tiledlayout(2,2)
nexttile
plot(freq,dB_enc1)
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Gain (dB)')


nexttile
plot(freq,dB_enc2)
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Gain (dB)')
title('encoder 2')

nexttile
plot(freq,smooth(dB_enc1,5))
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Gain (dB)')


nexttile
plot(freq,smooth(dB_enc2,5))
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Gain (dB)')
title('encoder 2 smoothed')

figure(2)
tiledlayout(1,2)
nexttile
plot(t,control)
xlabel('time(s)')
ylabel('control signal (V)')

nexttile
mag_control = abs(fft(control));
%mag_control = mag_control(1:round(length(mag_control)/2));
dB_control = 20*log10(mag_control/max(mag_control));
dB_control = dB_control(1:round(length(mag_control)/2));
plot(freq,dB_control)
xlabel('freq(Hz)')
ylabel('mag(dB)')
set(gca, 'XScale', 'log')
title('control signal')
%% nonlinear fit
%Use fminunc, objective function is sum of square error between frequency
%response plots (above) and bode plots (from state-space or maelab code). 