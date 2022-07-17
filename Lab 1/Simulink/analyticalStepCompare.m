clc; clear; close all
% Circuit Parameters
R = 10e3;
C = 10e-6;

% (Step Input) Parameters
stepAmplitude = 4.8; % 5 Volt Input
stepOnTime = 0;
stepSimTime = 1; % s
stepMaxStepSize = 0.05; % s

% Running the simulation
stepSimulinkResult = sim("stepInputModel.slx").simulinkStepResponse;

% Analytical response
timeArrayAnalytical = linspace(0,stepSimTime,10000);
anlyticalSolutionArray = stepAmplitude.*(1-exp(-timeArrayAnalytical./(R*C)));

% Plot (SIMULINK)
figure;
timeArray = stepSimulinkResult.Time;
inputArray = stepAmplitude*ones(size(timeArray));
plot(timeArray, inputArray, "DisplayName","Input Signal"); hold on
plot(stepSimulinkResult,"DisplayName","Output Signal");
xlabel("Time (s)");
ylabel("Voltage Ampltitude (V)");
title("System Step Response, SIMULINK, u = 4.8 V")
legend(Location="best"); grid on; grid minor;

% Plot (Analytical)
figure;
plot(timeArray, inputArray, "DisplayName","Input Signal"); hold on
plot(timeArrayAnalytical,anlyticalSolutionArray, "DisplayName","Output Signal")
xlabel("Time (s)");
ylabel("Voltage Ampltitude (V)");
title("System Step Response, Analytical, u = 4.8 V")
legend(Location="best"); grid on; grid minor;