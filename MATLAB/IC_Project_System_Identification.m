close all

angle = timetable2table(pedalOrientation(:,2));
angle = table2array(angle(:,2));
acceleration = timetable2table(Acceleration(:,1));
a = table2array(acceleration(:,2));
phi = timetable2table(carOrientation(:,3));
phi = -1*table2array(phi(:,2));

dt = 1/100;
v = integrate_acceleration_to_velocity(a,dt);

a = a(1:1704)-0.45;
v = v(1:1704);
angle = -1*angle(11:1714)-46;
phi = phi(1:1704) - phi(1);

tf = length(a)*dt;
t = linspace(0,tf,length(a));

figure(1)
plot(angle,v,'linewidth',1.5)
hold on
xlabel('pedal angle of depression, θ [degrees]')
ylabel('car speed, v [m/s]')
grid on

%% parameters
m = 1340+145;

%% least squares
g = zeros(length(a),1);
R = zeros(length(a),4);
for i = 1:length(a)
    R(i,1) = angle(i);
    R(i,2) = v(i);
    R(i,3) = v(i)^2;
    R(i,4) = sind(phi(i));
    g(i) = m*a(i);
end

p = R\g;

p1 = p(1); p2 = p(2); p3 = p(3); p4 = p(4);
thetamodel = (1/p1)*(m*a + p2*v + p3*v.^2 + p4*sind(phi));

plot(smooth(thetamodel),v)
legend('experimental data','simulation data','location','best')
axis([0 14 0 20])

%% plot model output
tmodelspan = [0 40];
v0 = 0;
inputangle = [5,10,15];
f1 = @(tmodel,vmodel) (1/m)*(p1*inputangle(1) + p2*vmodel + p3*vmodel^2);
f2 = @(tmodel,vmodel) (1/m)*(p1*inputangle(2) + p2*vmodel + p3*vmodel^2);
f3 = @(tmodel,vmodel) (1/m)*(p1*inputangle(3) + p2*vmodel + p3*vmodel^2);
%f = @(tmodel,vmodel) (1/m)*(p1*inputangle - m*9.81*0.01*vmodel - 0.5*1.3*0.32*2.4*vmodel^2);
[tmodel1,vmodel1] = ode45(f1,tmodelspan,v0);
[tmodel2,vmodel2] = ode45(f2,tmodelspan,v0);
[tmodel3,vmodel3] = ode45(f3,tmodelspan,v0);

figure(2)
plot(tmodel1,vmodel1,tmodel2,vmodel2,tmodel3,vmodel3,'linewidth',2)
grid on
xlabel('time [s]')
ylabel('car velocity [m/s]')
legend('θ = 5°','θ = 10°','θ = 15°','location','southeast')


function velocity = integrate_acceleration_to_velocity(acceleration, time_step)
    
    % Initialize velocity vector with zeros
    velocity = zeros(size(acceleration));
    
    % Numerically integrate acceleration to find velocity
    for i = 2:length(acceleration)
        velocity(i) = velocity(i-1) + acceleration(i-1) * time_step;
    end
end

