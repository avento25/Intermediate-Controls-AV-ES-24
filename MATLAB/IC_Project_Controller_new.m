%close all
clc

%% make sure to import controller workspace
vel = zeros(length(t),2);
for i = 1:length(t)
    vel(i,1) = t(i);
    vel(i,2) = v(i);
end

eigs = [-0.1,-0.2];
K = acker(A,B,eigs);
kf = -1/(C*inv(A-B*K)*B);

w = [A A*B];
rank(w);
% rank(w) = 1, so therefore not controllable

%% PI controller
ref = 10;

Nstep = 500;
tstep = linspace(0,60,Nstep);
ustep = ones(Nstep,1);
ustep = 1*ustep;
 
sys = ss(A,B,C,D);
lsim(sys,ustep,tstep);

tau = 0.8;
T63 = 7.59;
Kpi = 1.4;
T = T63-tau;

% FOTM
kp = (0.15*tau+0.35*T)/(Kpi*tau);
ki = (0.46*tau + 0.02*T)/(Kpi*tau^2);

% Z-N
% kp = (0.9*T)/(Kpi*tau);
% ki = (0.27*T)/(Kpi*tau^2);

