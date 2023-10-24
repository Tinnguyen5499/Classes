close all; clear all; clc;

%% Problem 1

% The cam is driven by a constant speed motor rotating counter-clockwise at 500 rpm with these specifications:
% - Harmonic rise (0º < θ < 60º) from 0 mm to 10 mm
% - Dwell (60º < θ < 80º) 
% - Cycloidal rise (80º < θ < 150º) from 10 mm to 25 mm
% - Dwell (150º < θ < 200º) 
% - 3-4-5 Polynomial fall (200º < θ < 300º) from 25 mm to 0 mm 
% - Dwell (300º < θ < 360º) 
% - The radius of the base circle = 30 mm
% - The radius of the follower roller = 5 mm

%part a:

%a. Generate the displacement, velocity, acceleration, and jerk profiles for one revolution of the cam above. 
%If there are any impulses, indicate locations of impulses on your plot. 

%defining regions
re1= 0:60;
re2= 60:80;
re3= 80:150;
re4= 150:200;
re5= 200:300;
re6= 300:360;
re={re1, re2, re3, re4, re5, re6};


L1=(0:10);
L2=(0:0);
L3=(10:25);
L4=(0:0);
L5=flip(0:25);
L6=(0:0);
L_={L1, L2, L3, L4, L5, L6};



syms L beta t y(theta) theta(t) omega 

y_(1)= L/2*(1-cos(pi*theta/beta));
y_(2)= 10 ;
y_(3)= L*((theta/beta)-(1/(2*pi))*sin((2*pi*theta)/beta));
y_(4)= 25;
y_(5)= L*(10/beta^3*theta^3-15/beta^4*theta^4+6/beta^5*theta^5);
y_(6)= 0;


omega_=500*2*pi/60;

for n=1:6
    v_(n)=diff(y_(n),t);
    v_(n)=subs(v_(n),diff(theta(t), t),omega);
    a_(n)=diff(diff(y_(n),t));
    a_(n)=subs(a_(n),diff(theta(t), t),omega);
    j_(n)=diff(diff(diff(y_(n),t)));
    j_(n)=subs(j_(n),diff(theta(t), t),omega);
    displacement{n}=vpa(subs(y_(n), {L,beta,theta(t)}, {L_{n}(end)-L_{n}(1),deg2rad(re{n}(end)-re{n}(1)),deg2rad(0:length(re{n})-1)}));
    velocity{n}=vpa(subs(v_(n), {L,beta,theta(t),omega}, {L_{n}(end)-L_{n}(1),deg2rad(re{n}(end)-re{n}(1)),deg2rad(0:length(re{n})-1),omega_}));
    acceleration{n}=vpa(subs(a_(n), {L,beta,theta(t),omega}, {L_{n}(end)-L_{n}(1),deg2rad(re{n}(end)-re{n}(1)),deg2rad(0:length(re{n})-1),omega_}));
    jerk{n}=vpa(subs(j_(n), {L,beta,theta(t),omega}, {L_{n}(end)-L_{n}(1),deg2rad(re{n}(end)-re{n}(1)),deg2rad(0:length(re{n})-1),omega_}));

end 

%Displacement
figure(1)
hold on

for n=1:6
    plot(re{n},displacement{n}+L_{n}(1))
end

%velocity
figure(2)
hold on

for n=1:6
    plot(re{n},velocity{n})
end

%Acceleration
figure(3)
hold on

for n=1:6
    plot(re{n},acceleration{n})
end

%Jerk
figure(4)
hold on

for n=1:6
    plot(re{n},jerk{n})
end

%% part b
% b. Plot the pressure angle as a function of θ (0º < θ < 360º). You can assume that this is a zero-offset cam, Is 
% this a good cam design?
r_Base_circle=30;
r_Follower_roller=5;
a=r_Base_circle+r_Follower_roller;

for n = 1:6
phi{n}= atan((velocity{n}/omega_)./(a+displacement{n}));
end

%Pressure angle
figure(5)
hold on
for n=1:6
    plot(re{n},phi{n})
end

hold off
%% part c
% Plot the cam contour, pitch curve, prime circle, and base circle for the cam specified above on the same 
% plot. Provide legends and use different colors/markers/lines.

displacement_all=[]
theta_all=[]
%% combining displacement vectors
for n=1:6
    displacement_all=[displacement_all(1:end-1),cast(displacement{n}+L_{n}(1),"double")]
    theta_all=[theta_all(1:end-1), cast(re{n}, "double")]
end


contour= r_Base_circle+displacement_all;
pitch= r_Base_circle+r_Follower_roller+displacement_all;
base=min(contour).*ones(length(theta_all),1);
prime=min(pitch).*ones(length(theta_all),1);
figure(6)
polarplot(deg2rad(theta_all),contour);
hold on
polarplot(deg2rad(theta_all),pitch);
polarplot(deg2rad(theta_all),base);
polarplot(deg2rad(theta_all),prime);
matrixA(1,:)=theta_all
matrixA(2,:)=contour
matrixA(3,:)=ones(length(theta_all),1)


figure(7)
for n=1:10
    subplot(2,5,n)
    rotated= [1 0 -30*(n-1); 0 1 0; 0 0 1] * matrixA;
    polarplot(deg2rad(rotated(1,:)),rotated(2,:))
    hold on
    polarplot(deg2rad(theta_all),prime);
    hold off
end


