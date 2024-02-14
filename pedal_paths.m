close all
clear
clc

%% givens
r1 = 0.8;
r2 = 0.5;
r3 = 0.8;
r4 = 0.8;
r5 = 0.9;
a = 117/360*2*pi;

N = 1000;
theta2 = linspace(0,2*pi,N);

%% initialize vectors
alpha = [];
theta3 = [];
theta4 = [];
theta5 = [];
Px = [];
Py = [];

for ix = 1:N


    %% angle equations
    alpha(1,ix) = 0 - r2*cos(theta2(ix));
    alpha(2,ix) = r1 - r2*sin(theta2(ix));   

    A = 2*alpha(1,ix)*r4;
    B = 2*alpha(2,ix)*r4;
    C = dot(alpha(:,ix),alpha(:,ix)) + r4^2 - r3^2;

    theta4(ix) = atan2(B,A) + acos((-1*C)/(sqrt(A^2+B^2)));
    theta3(ix) = atan2(r1 - r2*sin(theta2(ix)) + r4*sin(theta4(ix)),-1*r2*cos(theta2(ix)) + r4*cos(theta4(ix)));
    theta5(ix) = theta3(ix) + a;
    
    %% locate point P
    Px(ix) = r2*cos(theta2(ix)) + r5*cos(theta5(ix));
    Py(ix) = r2*sin(theta2(ix)) + r5*sin(theta5(ix));
end

%% plot the path of point P
% plot(Px,Py,'linewidth',2)
% grid on
% axis equal
% axis([-1.5 1.5 -1.5 1.5])
figure(1)
plot(theta2,Px);
grid on
xlabel('angle of motor shaft (rad)')
ylabel('horizontal position of pedal tip (in)')
axis([0 2*pi -1.5 1.5])

figure(2)
plot(theta2,Py);
grid on

xlabel('angle of motor shaft (rad)')
ylabel('vertical position of pedal tip (in)')
axis([0 2*pi -1.4 0])

