close all
clc

vavg = 5;

A = [0,1;0,(1/m)*(p2+2*p3*vavg)];
C = [0 1];
B = [0;p1/m];
D = 0;

sys = ss(A,B,C,D);
vobs = lsim(sys,angle,t);

velobs = zeros(length(t),2);
for i = 1:length(t)
    velobs(i,1) = t(i);
    velobs(i,2) = vobs(i);
end
%plot(t,vobs)

