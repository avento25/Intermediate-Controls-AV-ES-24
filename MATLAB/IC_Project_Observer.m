close all
clc

%% make sure to import observer workspace

%% define trajectory
utraj = angle;
ttraj = t;

% create ODEs
ftraj = cell(size(ttraj));
for i = 1:length(ttraj)
    ftraj{i} = @(ttraj, xtraj) [xtraj(2); (1/m)*(p1*utraj(i) + p2*xtraj(2) + p3*xtraj(2)^2)];
end

% initial condidtions
xtraj0 = [0; 0];

% solve ODEs
[ttraj, Xtraj] = ode45(@(ttraj, xtraj) ftraj{find(ttraj >= ttraj, 1)}(ttraj, xtraj), ttraj, xtraj0);

xtraj1 = Xtraj(:, 1);
xtraj2 = Xtraj(:, 2);

xhat = xtraj2;

%%%%%%%%% obtain xhat(t) for new state %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% create observer
Bmat = [0;p1/m];
Amat = zeros(2,2,length(xhat));

for i = 1:length(xhat)
    Amat(:,:,i) = [0,1;0,(1/m)*(p2+2*p3*(v(i)-xhat(i)))];
end

%% use corrupted input in observer
uobs = angle;
tobs = t;

% create ODEs
fobs = cell(size(tobs));
for i = 1:length(xhat)
    fobs{i} = @(tobs, xobs) [xobs(2); (1/m)*xobs(2)*(p2 + 2*p3*(xobs(2)-xhat(i))) + p1/m];
end

% initial conditions
xobs0 = [0; 0];

% solve ODEs
[tobs, Xobs] = ode45(@(tobs, xobs) fobs{find(tobs >= tobs, 1)}(tobs, xobs), tobs, xobs0); 

xobs1 = Xobs(:, 1);
xobs2 = Xobs(:, 2);

plot(t,v,ttraj,xtraj2,tobs,xobs2,'linewidth',1.5)
grid on
xlabel('time (s)')
ylabel('velocity (m/s)')
legend('measured','trajectory','observer','location','northwest')
xlim([0, 17.04])

