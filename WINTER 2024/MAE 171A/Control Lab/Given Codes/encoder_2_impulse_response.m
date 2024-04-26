load('encoder2_impulse_response_data.mat');

thisCross=299;
    x1 = avg_adjDX(thisCross-1); % before-crossing x-value
    x2 = avg_adjDX(thisCross); % after-crossing x-value
    y1 = avg_adjDY(thisCross-1); % before-crossing y-value
    y2 = avg_adjDY(thisCross); % after-crossing y-value
    
    ratio = (0-y1) / (y2-y1); % interpolate between to find 0
    x_wanted = x1 + (ratio*(x2-x1)); % estimate of x-value
    y_wanted = 0;

 

%     plot(x_wanted,y_wanted,'-o','MarkerSize',10,...
%     'MarkerEdgeColor','red',...
%     'MarkerFaceColor',[1 .6 .6])

    x_final=[x_wanted avg_adjDX(thisCross:end)']-x_wanted;
    y_final=[y_wanted avg_adjDY(thisCross:end)'];

    space=x_final(end)/(length(x_final));

    x_final_rescaled=(0:space:x_final(end));


    F=griddedInterpolant(x_final,y_final);


    x_final_rescaled=x_final_rescaled(1:end-1);

    y_final_rescaled=F(x_final_rescaled);

%     steps
% 
%     step(G,[0])


    %plot(x_final,y_final,'-r','LineWidth',4);
    


 

    [y,x]=impulse(G,x_final_rescaled);
figure(1)
    plot(x,y,'b','LineWidth',3)
   hold on
        plot(x_final_rescaled,y_final_rescaled,'-r','LineWidth',3);


    x_label=xlabel('Time(seconds)');
    y_label=ylabel('encoder 2 [Counts]');
    ax=gca;
    ax.FontSize=20;


    xlim([0 3.3]);

    lgd=legend('Simulated Impulse Response','Average Measured Impulse Response');

    fontsize(lgd,16,'points')

    rmse = sqrt(mean((y_final_rescaled - y).^2));

hold off

    % Step 3: Frequency Response Estimation
fs = 1 / (x_final_rescaled(2) - x_final_rescaled(1)); % Sampling frequency
window_size=10;
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
