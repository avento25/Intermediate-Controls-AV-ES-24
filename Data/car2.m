close all

angle = timetable2table(pedalOrientation(:,2));
angle = table2array(angle(:,2));
acceleration = timetable2table(Acceleration(:,1));
a = table2array(acceleration(:,2));

dt = 1/100;
v = integrate_acceleration_to_velocity(a,dt);

% v = v(571:2275);
% angle = angle(571:2275);

plot(-1*angle(11:1714)-46,v(1:1704))
xlabel('pedal angle (degrees)')
ylabel('car speed (m/s)')
grid on


function velocity = integrate_acceleration_to_velocity(acceleration, time_step)
    
    % Initialize velocity vector with zeros
    velocity = zeros(size(acceleration));
    
    % Numerically integrate acceleration to find velocity
    for i = 2:length(acceleration)
        velocity(i) = velocity(i-1) + acceleration(i-1) * time_step;
    end
end

