close all;
clear all;
clc;

load('PART_2_TEST_2.mat')

f_tone = 5E3; % frequency of tone to be generated [Hz]
pointsx=30; % number of points x axis to scan
pointsy=15; % number of points y axis to scan
Navg=1; % number of averages
move=10; % distance per step (spatial resolution) [mm]
TmLong=4; % move time long [s]
TmShort=1; % move time short [s]

%% Question 4
%% Collecting data(already collected)

% for i=1:pointsx
%     % flip the Y-coordinate array if in an odd X row (return zag
% 
%         for k=1:Navg
%             j=7
%             pause(0.1)
%             % plotting
%             subplot(311)
%             plot(t*1e3,wave_ref/max(abs(wave_ref)),'-o',...
%                 t*1e3,wave_sig/max(abs(wave_sig)),'-o',...
%                 'MarkerSize',2)
%             xlabel('time (ms)')
%             ylabel('amp. (A.U.)')
%             ylim([-1.1 1.1])
%             title(['Single Acq. ' num2str(k) ', Position (' num2str(i) ',' num2str(j) ')']);
%             set(gca,'FontSize',20,'LineWidth',2)
% 
%             subplot(312)
%             plot(t*1e3,recMatrix_ref(:,i,j),'-o',...
%                 'MarkerSize',2)
%             xlabel('time (ms)')
%             ylabel('amp. (V)')
%             title('Average ref');
%             set(gca,'FontSize',20,'LineWidth',2)
% 
%             subplot(313)
%             plot(t*1e3,recMatrix_sig(:,i,j),'-o',...
%                 'MarkerSize',2)
%             xlabel('time (ms)')
%             ylabel('amp. (V)')
%             title('Average sig');
%             set(gca,'FontSize',20,'LineWidth',2)
% 
%             set(gcf, 'units', 'normalized'); % set plot sizing to normalized units
%             % set position of figure on screen [distance from left, top, width, height]
%             set(gcf, 'Position', [0.1, 0.1, .6, 0.8]);
%             drawnow;
%             [t_ref(i),amp_ref(i)]=ginput(1)
%             [t_sig(i),amp_sig(i)]=ginput(1)
%             xpos(i)=i
% 
%        
%     end
% end
% 
% 
% 
% save('t_ref.mat','t_ref');
% save('t_sig.mat','t_sig');

%% plot x position vs time delay
load('t_ref.mat');

load('t_sig.mat');

xpos=(1:30)./100;

% [x_ref,t_ref]=ginput(1)
% 
% 
% [x_sig,t_sig]=ginput(1)


timedelay=(t_sig-t_ref).*10^-3

p=polyfit(xpos,timedelay,1);
y1=polyval(p,xpos);
speedofsound = p(1)^(-1) / 100; %m/s

% actualspeedofsound = @(x) -(1/340) * (x-0.3);

yneg=ones(30)*0.000187
xneg=ones(30)*0.0025

linewidth=2
figure(3)
hold on
box on

error_bar= errorbar(xpos, timedelay, yneg, yneg ,xneg, xneg, '.','Color', 'black', 'LineWidth', 1.5);

data_point=plot(xpos, timedelay, 'd', 'LineWidth', linewidth, 'Color', 'black', 'MarkerFaceColor','black');

line_fit=plot(xpos, y1, '--', 'LineWidth', linewidth, 'Color', '#77AC30');

actual=fplot(@(x) -(1/340) * (x-0.3), ':', 'LineWidth', linewidth, 'Color', '#D95319');
xlim([0 0.30])
ylim([0 1*10^-3])
legend_label=[error_bar(1), data_point, line_fit, actual]

legend(legend_label,'error bar', 'Data Points', 'Line of Best Fit to Data', 'Theoretical Speed of Sound Line','Location','best')

xlabel('X Position (m)');
ylabel('Time Delay (s)');
set(gca,'FontSize',15,'LineWidth',2);

xl = xlim;
yl = ylim;
xt = 0.05 * (xl(2)-xl(1)) + xl(1)
yt = 0.3 * (yl(2)-yl(1)) + yl(1)
yt2 = 0.35 * (yl(2)-yl(1)) + yl(1)
caption=sprintf('y = %f * x + %f', p(1), p(2));
caption2=sprintf('line best fit:')

text(xt,yt,caption, 'FontSize', 15, 'Color', '#77AC30', 'FontWeight', 'bold');
text(xt,yt2,caption2, 'FontSize', 15, 'Color', '#77AC30', 'FontWeight', 'bold');

saveas(gcf,'Q4.png')


% % manually record delta t's
% timedelay = [0.00208696 0.00207692 0.00206089 0.00205686 0.00202676 0.0020669 0.00198662 0.00195652 0.00194649 0.00190635 0.00188629 0.00187625 ...
%     0.00186622 0.00181605 0.00180602 0.00179599 0.00178595 0.00174582 0.00173579 0.00171572 0.00170596 ...
%     0.00169565 0.00169500 0.00165552 0.00164548 0.00161538 0.00160535 0.00157525 0.00160535 0.00154515] - 0.0010034;
% 
% format long
% 
% xpos = (1:1:30) * 0.01;
% p = polyfit(xpos, timedelay, 1);
% % x1 = 0:xpos;
% y1 = polyval(p, xpos);
% 
% speedofsound = p(1)^(-1) / 100; %m/s
% 
% actualspeedofsound = @(x) -(1/340) * (x- 0.30);
% 
% yneg = [0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187];
% xneg = [0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025];
% 
% figure(3)
% hold on
% box on
% 
% errorbar(xpos, timedelay, yneg, yneg ,xneg, xneg, '.', 'LineWidth', 1.5);
% plot(xpos, timedelay, 'd', 'LineWidth', linewidth, 'Color', 'black', 'MarkerFaceColor','black');
% plot(xpos, y1, '--', 'LineWidth', linewidth, 'Color', '#77AC30');
% plot(xpos, actualspeedofsound(xpos), ':', 'LineWidth', linewidth, 'Color', '#D95319');
% 
% legend('', 'Data Points', 'Line of Best Fit to Data', 'Theoretical Speed of Sound Line', 'Location', 'northeast')
% 
% xlabel('X Position (cm)');
% ylabel('Time Delay (s)');
% set(gca,'FontSize',22,'LineWidth',2);