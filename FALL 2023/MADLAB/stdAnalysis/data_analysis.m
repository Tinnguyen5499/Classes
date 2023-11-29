close all; clear all; clc

load('data.mat')

samples=[ string("/0.1_0.1") string("/0.1_0.2") string("/35Mhz") string("/35Mhz(2)") string("/77Mhz") string("/77Mhz(2)")];

%% Plotting the data

for ii = 1:length(samples) % for every sample


standard_deviation(:,ii)= standard_deviation(:,ii)./standard_deviation(1,ii);

figure(length(samples))

hold on

x=plot(1:length(standard_deviation(:,ii)),standard_deviation(:,ii),'LineWidth',2)

xlabel('frames'); % x-axis label name

ylabel('std'); % y-axis label name

[a(ii),b(ii)]=ginput(1)

delete(x)

c(ii)=plot(1:length(standard_deviation(:,ii))-round(a(ii)),standard_deviation(round(a(ii)):length(standard_deviation(:,ii))-1,ii),'LineWidth',2)

drawnow

legend(samples)

end

