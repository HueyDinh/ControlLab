function ROTPEN_Sim_Plot(the,alp,dthe,dalp,voltage,the_lin,alp_lin,dthe_lin,dalp_lin,voltage_lin,xd,tout)
%
% Basic plotting function for Rotary Inverted Pendulum Nonlinear Simulation
% D. Hartman, 2016
%
figure
% subplot(3,1,1)
plot(tout, the*180/pi, tout, alp*180/pi,tout,...
    the_lin*180/pi,tout,alp_lin*180/pi,tout,xd*180/pi,'g--')
grid on
legend({'$\theta$','$\alpha$','$\theta_{lin}$','$\alpha_{lin}$','$\theta_{desired}$'},'Interpreter','latex',...
    'Location','Best')
xlabel('Time (s)')
ylabel('Degrees')
title('Joint Angles')

figure
%subplot(3,1,2)
plot(tout,dthe*180/pi,tout,dalp*180/pi,tout,dthe_lin*180/pi,...
    tout,dalp_lin*180/pi)
grid on
legend({'$\dot{\theta}$','$\dot{\alpha}$',...
    '$\dot{\theta}_{lin}$','$\dot{\alpha}_{lin}$'},'Interpreter','latex',...
    'Location','Best')
xlabel('Time (s)')
ylabel('Degrees Per Second')
title('Angular Rates')

figure
% subplot(3,1,3)
plot(tout,voltage,tout,voltage_lin)
grid on
legend({'$Voltage$','$Voltage_{lin}$'},'Interpreter','latex','Location','Best')
xlabel('Time (s)')
ylabel('Volts')
title('Applied Voltage')
end