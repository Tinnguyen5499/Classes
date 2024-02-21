close all; clear all; clc

load('data.mat')

%% samples=[ string("/0.1_0.1") string("/0.1_0.2") string("/35Mhz") string("/35Mhz(2)") string("/77Mhz") string("/77Mhz(2)")];
samples=[ string("/0.1_0.1") string("/35Mhz") string("/77Mhz")];
%% Plotting the data

for ii = 1:length(samples) % for every sample


relative_standard_deviation(:,ii)= standard_deviation(:,ii)./standard_deviation(1,ii);

figure(length(samples))

hold on

x=plot(1:length(relative_standard_deviation(:,ii)),relative_standard_deviation(:,ii),'LineWidth',2)

[a(ii),b(ii)]=ginput(1)
delete(x)

range_adjusted_time=(1:length(relative_standard_deviation(:,ii))-round(a(ii)))/60; %% x-axis
range_adjusted_normalized_std = relative_standard_deviation(round(a(ii)):length(relative_standard_deviation(:,ii))-1,ii); %% y-axisd
diff_range_adjusted_normalized_std=diff(range_adjusted_normalized_std);

%% Plotting Std Overtime
c(ii)=plot(range_adjusted_time,... %% x-axis in frame -> second (60 frames per second)
      smoothdata(range_adjusted_normalized_std),... %% y-axis
      'LineWidth',3);

% %% Plotting Rate of Change over time
% c(ii)=plot(range_adjusted_time(1:end-1),... %% x-axis in frame -> second (60 frames per second)
%       diff_range_adjusted_normalized_std,... %% y-axis
%       'LineWidth',3);

drawnow
end


legend("Alternating", "35Mhz", "77Mhz",'Location','best')

xlim([0 16])

grid on; box on

set(gca,'FontSize',24,'LineWidth',1,'FontName','Trebuchet MS');

%xlabel('Time(s)','Interpreter','latex'); % x-axis label name

%ylabel('Normalized Standard Deviation','Interpreter','latex'); % y-axis label name

xlabel('Time(s)','FontName','Trebuchet MS');

ylabel('Normalized Standard Deviation','FontName','Trebuchet MS'); % y-axis label name


%% title('Standard Deviation of Brightness over Time','Interpreter','latex')






