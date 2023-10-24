close all; clear all; clc;

input = [ 300 370 400 450 470 600 700 720]
output =[305 376 406 458 477 425 330 303]


figure(1)
hold on
plot (input,output,'-diamond','LineWidth',2,'MarkerSize',4)
plot (ones(1,length(output))*480,output,'--or','LineWidth',2,'MarkerSize',4);
grid on; box on;
set(gca,'FontSize',10,'LineWidth',2);
ylabel('Measured Frequency(Hz)');
xlabel('Input Frequency(Hz)');
legend( 'Measured vs input frequency','predicted aliasing frequency','Location','best')