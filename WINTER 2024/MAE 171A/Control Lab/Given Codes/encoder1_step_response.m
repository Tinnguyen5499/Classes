close all;
clear all;
clc


load('encoder1_step_response_data.mat');

load('avg_data.mat');
%%
figure(1)
l=plot(tstep,ystep,t,y,'r');
set(l,'linewidth',3);
lgd=legend('Simulated Step Response','Average Measured Step Response')
   xlabel('time [sec]');

          ylabel('encoder 1 [counts]')


          ax=gca;
    ax.FontSize=20;
    fontsize(lgd,16,'points')

x_final_rescaled=t;
y_final_rescaled=y;

    fs = 1 / (x_final_rescaled(2) - x_final_rescaled(1)); % Sampling frequency

window_size=20;
y_final_rescaled = movmean(y_final_rescaled, window_size);


Y_exp=fft(y_final_rescaled);
L=length(y_final_rescaled);
P2_exp = abs(Y_exp/L);
P1_exp = P2_exp(1:L/2+1);
P1_exp(2:end-1) = 2*P1_exp(2:end-1);
f_exp = fs*(0:(L/2))/L;

% Step 4: Theoretical Frequency Response
[H_theoretical, f_theoretical] = freqresp(G, 2*pi*f_exp); % Theoretical frequency response

% Step 5: Plot Frequency Response
figure(2);
subplot(2,1,1);
plot(f_exp, 20*log10(P1_exp), 'b', f_theoretical, 20*log10(abs(squeeze(H_theoretical))), 'r');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Frequency Response');
legend('Experimental', 'Theoretical');
grid on;

subplot(2,1,2);
plot(f_exp, angle(Y_exp(1:L/2+1))*180/pi, 'b', f_theoretical, angle(squeeze(H_theoretical))*180/pi, 'r');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
title('Phase Response');
legend('Experimental', 'Theoretical');
grid on;



