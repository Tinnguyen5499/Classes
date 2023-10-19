%% Problem 6
% You are to analyze the temperature record in San Diego. Download SD temperature.dat
% from CANVAS and load into MATLAB. Let T denote the monthly average temperature in
% all months and all years.
% (a) Create a histogram in figure 1 to show the probability of T. Use a bin width of 1◦F.
% Let E denote cold events in which T < 55◦F. Also, let M1 denote temperature in January,
% M2 denote temperature in February, and so on.
% (b) Find the probabilities of cold events for each of the months, i.e., P(E|M1), P(E|M2),
% ..., P(E|M12). Create a bar plot in figure 2 to show how the probabilities vary from month
% to month.
% (c) Given the occurrence of a cold event, find the probabilities that it occurs in January,
% February, etc. Here, you need to compute P(M1|E), P(M2|E), ..., P(M12|E). Create a bar
% plot in figure 3 to show how the probabilities vary from month to month.
% (d) Comment on the difference and similarity between the results in parts (b) and (c).

clear; close all; clc
load 'SD_temperature.dat';
year = SD_temperature(:,1);
month = 1:12;
tem = SD_temperature(:,2:end);

%% Histogram of temperature distribution in all months and all years

%% Histogram of temperature distribution in all months and all years
figure(1);
histogram(tem(:),'binwidth',1,'normalization','probability');
box on; grid on;
xlabel('temperature (\circF)');
ylabel('probability')
title('Probability distribution of temperature in San Diego')


%% Find the probability of warm events: T >= 70

% tem(:,n) n = temperature in n month







%% Find the conditional probability of warm events in each month?
% P(T >= 70 | M_i) where M_i are the months from Jan to Dec
% Plot the conditional probability distribution

p1b= sum(tem <55)/numel(year);

figure(2);
bar(1:12,p1b);
xlabel('Month');
box on; grid on;
ylabel('P(T < 55|M_i)');
set(gca,'XTickLabel',{'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'})
title('Probability of cold event in different months: P(T<55|M_i)');

%% Given the occurrence of a warm event, what is the probability that 
% it occurs in Jan? in Feb? ... in Dec?
% P(M_i | T >= 70) where M_i are the months from Jan to Dec
% Plot the conditional probability distribution.

p1c = sum(tem<55)./sum(tem <55, 'all');

figure(3);
bar(1:12,p1c);
box on; grid on;
xlabel('Month');
ylabel('P(M_i|T < 55)');
set(gca,'XTickLabel',{'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'})
title('Given a cold event, probability of occuring in different month: P(M_i|T<55)');
