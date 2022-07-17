M = 0.1;
B = 1;
tau = M/B;
s = tf('s');
linearSystem = 1/(tau*s + 1);

opt = stepDataOptions('StepAmplitude',4.8);

figure;
step(linearSystem,opt);
title("Mass-Damper System Step Reponse to 4.8 N Force")
ylabel("Velocity (m/s)")
grid on; grid minor;

figure;
bode(linearSystem);
title("Mass-Damper System Frequency Response (Bode Plots)")
grid on; grid minor;