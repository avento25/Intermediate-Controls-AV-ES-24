figure(1)
plot(out.contAngle,'linewidth',1.8)
hold on
plot(t,angle,'linewidth',1.8)
legend('controller input angle','measured input angle','location','southeast')
grid on
title(' ')
axis([0 11.4 0 13])
xlabel("time [s]")
ylabel("pedal angle [degrees]")

figure(2)
plot(out.contV,'linewidth',1.8)
hold on
plot(t,v,'linewidth',1.8)
legend('controller output velocity','reference velocity','location','southeast')
grid on
title(' ')
axis([0 11.4 0 12])
xlabel("time [s]")
ylabel("velocity [m/s]")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
% figure(1)
% plot(out.contAngle,'linewidth',1.8)
% hold on
% plot(t,angle,'linewidth',1.8)
% legend('controller input angle','measured input angle','location','southeast')
% grid on
% title(' ')
% axis([0 11.4 0 13])
% xlabel("time [s]")
% ylabel("pedal angle [degrees]")
% 
% figure(2)
% plot(out.contV,'linewidth',1.8)
% hold on
% plot(t,vobs,'linewidth',1.8)
% legend('controller output velocity','reference velocity (filtered)','location','southeast')
% grid on
% title(' ')
% axis([0 11.4 0 10])
% xlabel("time [s]")
% ylabel("velocity [m/s]")
