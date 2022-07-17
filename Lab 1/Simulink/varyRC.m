clc; clear; close all;

% (Step Input) Parameters
stepAmplitude = 4.8; % 5 Volt Input
stepOnTime = 0;
stepSimTime = 1; % s
stepMaxStepSize = 0.005; % s

figure;
C = 10e-6;
R_array = [1e3 5e3 10e3 5e4 1e5];

for i = 1:length(R_array)
    R = R_array(i);
    stepSimulinkResult = sim("stepInputModel.slx").simulinkStepResponse;
    plot(stepSimulinkResult, "DisplayName",sprintf("R = %.3e", R)); hold on
end

xlabel("Time (s)")
ylabel("Voltage (V)")
title("RC-filter System Reponse Speed with Varying Resistance, $C = 10\mu F$", Interpreter="latex");
legend(Location="best"); grid on; grid minor

figure;
R = 10e3;
C_array = [1e-6 5e-6 10e-6 5e-5 1e-4];

for i = 1:length(C_array)
    C = C_array(i);
    stepSimulinkResult = sim("stepInputModel.slx").simulinkStepResponse;
    plot(stepSimulinkResult, "DisplayName",sprintf("C = %.3e", C)); hold on
end

xlabel("Time (s)")
ylabel("Voltage (V)")
title("RC-filter System Reponse Speed with Varying Capacitance, $R = 10k\Omega$", Interpreter="latex");
legend(Location="best"); grid on; grid minor