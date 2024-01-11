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

%% Question 6
size_r=size(recMatrix_sig);
x_axis=1:size_r(2);

z=squeeze(recMatrix_sig(:,:,15));
z=z./max(abs(z));

figure(1)
pcolor(x_axis/100,t,z)'
shading flat
hold on
bar = fplot(@(x) -(1/340) * (x-0.30)+0.0015,'-r','LineWidth',2);

c=colorbar;
set(c,'FontSize',20);

xlabel('X position (m)');
ylabel('time (s)');

legend(bar,'sound speed in air (340m/s)');

saveas(gcf,'Q6.png')

%% Question 7


size_r=size(recMatrix_sig);
x_axis=1:size_r(2);
y_axis=1:size_r(3);

z=squeeze(recMatrix_sig(find(t==0.002),:,:));
z=transpose(z);
z=z./max(abs(z));

figure(2)

pcolor(x_axis/100,y_axis/100,z);

shading flat

c=colorbar

set(c,'FontSize',20);

xlabel('X position (m)');
ylabel('Y position (m)');

saveas(gcf,'Q7.png')

%% Question 8

tic

filename = 'scanning.gif'
for n = 1:length(t);

z=squeeze(recMatrix_sig(n,:,:));
z=transpose(z);
z=z./max(abs(z));

pcolor(x_axis/100,y_axis/100,z);
shading flat;
c=colorbar;
set(c,'FontSize',20);

xlabel('X position (m)');
ylabel('Y position (m)');

caxis([-1 1])
    pause(0.5);
    drawnow;
    frame=getframe(gcf);
    im=frame2im(frame);
    [imind,cm]=rgb2ind(im,256);
    if n==1
        imwrite(imind,cm,filename,'gif','Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end

end

time_scan = toc

save('times_scan','time_scan','-mat')



% %% Question 4
% i = 3;
% j = 1;
% subplot(311)
%            plot(t*1e3,wave_ref/max(abs(wave_ref)),'-o',...
%                t*1e3,wave_sig/max(abs(wave_sig)),'-o',...
%                'MarkerSize',2)
%            xlabel('time (ms)')
%            ylabel('amp. (A.U.)')
%            ylim([-1.1 1.1])
%            title(['Single Acq. ' num2str(k) ', Position (' num2str(i) ',' num2str(j) ')']);
%            set(gca,'FontSize',20,'LineWidth',2)
%           
%            subplot(312)
%            plot(t*1e3,recMatrix_ref(:,i,j),'-o',...
%                'MarkerSize',2)
%            xlabel('time (ms)')
%            ylabel('amp. (V)')
%            title('Average ref');
%            set(gca,'FontSize',20,'LineWidth',2)
%           
%            subplot(313)
%            plot(t*1e3,recMatrix_sig(:,i,j),'-o',...
%                'MarkerSize',2)
%            xlabel('time (ms)')
%            ylabel('amp. (V)')
%            title('Average sig');
%            set(gca,'FontSize',20,'LineWidth',2)
%           
%            set(gcf, 'units', 'normalized'); % set plot sizing to normalized units
%            % set position of figure on screen [distance from left, top, width, height]
%            set(gcf, 'Position', [0.1, 0.1, .6, 0.8]);
%            drawnow;
% 
% 
% 
% 
% 
% %% plot x position vs time delay
% 
% 
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


% %% Question 8
% 
% tic
% 
% filename = 'scanning.gif'
% for n = 1:length(t)
% 
% z=squeeze(recMatrix_ref(n,:,:))
% pcolor(x_axis,y_axis,z)
% caxis([-1 1])
%     pause(0.5);
%     drawnow;
%     frame=getframe(gcf);
%     im=frame2im(frame);
%     [imind,cm]=rgb2ind(im,256);
%     if n==1
%         imwrite(imind,cm,filename,'gif','Loopcount',inf);
%     else
%         imwrite(imind,cm,filename,'gif','WriteMode','append');
%     end
% 
% end
% 
% time_scan = toc




