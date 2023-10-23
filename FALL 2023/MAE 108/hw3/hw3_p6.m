close all; clear all; clc;
load 'SD_temperature.dat';
load 'SD_rainfall.dat';
T= SD_temperature(:, [2:end]);
R= SD_rainfall(:, [2:end]);
M=(1:12);
histogram(T,'BinWidth', 0.1)
C = T<55;
W= R >= 1;
temp_Rainy= sum(sum(W))/numel(W)
temp_Cold= sum(sum(C))/numel(C)
CnW=C+W;
CnW=CnW==2;
rain_Given_cold= sum(CnW,'all')/sum(C,'all')

cold_Given_rain= sum(CnW,'all')/sum(W,'all')



