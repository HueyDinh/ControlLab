clc; clear; close all
%% Circuit Parameters
R = 10e3;
C = 10e-6;

%% Model 1 (Step Input) Parameters
stepAmplitude = 4.8; % 5 Volt Input
stepOnTime = 0;
stepSimTime = 1; % s
stepMaxStepSize = 0.05; % s

% Running the simulation
stepSimulinkResult = sim("stepInputModel.slx").simulinkStepResponse;

figure;
timeArray = stepSimulinkResult.Time;
inputArray = stepAmplitude*ones(size(timeArray));
plot(timeArray, inputArray, "DisplayName","Input Signal"); hold on
plot(stepSimulinkResult,"DisplayName","Output Signal");
xlabel("Time (s)");
ylabel("Voltage Ampltitude (V)");
title("System Step Response, u = 4.8 V")
legend; grid on; grid minor;

%% Model 2 (Sine Wave) Parameters

% Trial 1: omega = 0.1
sineFreq = 0.1;
sinePeriod = 2*pi/sineFreq;
sineAmplitude = 1;
sineBias = 0;
sineSimTime = 10*sinePeriod;
sineMaxStepSize = 0.01*sinePeriod;
sineSimulinkResult1 = sim("sineInputModel.slx").simulinkSineResponse;

figure;
timeArray = sineSimulinkResult1.Time;
inputArray = sin(sineFreq*timeArray);
plot(timeArray, inputArray, "DisplayName","Input Signal"); hold on;
plot(sineSimulinkResult1,"DisplayName","Output Signal");
xlabel("Time (s)");
ylabel("Voltage Ampltitude (V)");
title("Trial 1: System Frequency Response, \omega = 0.1 rad/s")
legend; grid on; grid minor;


% Trial 2: omega = 1
sineFreq = 1;
sinePeriod = 2*pi/sineFreq;
sineAmplitude = 1;
sineBias = 0;
sineSimTime = 10*sinePeriod;
sineMaxStepSize = 0.01*sinePeriod;
sineSimulinkResult2 = sim("sineInputModel.slx").simulinkSineResponse;

figure;
timeArray = sineSimulinkResult2.Time;
inputArray = sin(sineFreq*timeArray);
plot(timeArray, inputArray, "DisplayName","Input Signal"); hold on;
plot(sineSimulinkResult2,"DisplayName","Output Signal");
xlabel("Time (s)");
ylabel("Voltage Ampltitude (V)");
title("Trial 2: System Frequency Response, \omega = 1 rad/s")
legend; grid on; grid minor;

% Trial 3: omega = 10
sineFreq = 10;
sinePeriod = 2*pi/sineFreq;
sineAmplitude = 1;
sineBias = 0;
sineSimTime = 10*sinePeriod;
sineMaxStepSize = 0.01*sinePeriod;
sineSimulinkResult3 = sim("sineInputModel.slx").simulinkSineResponse;

figure;
timeArray = sineSimulinkResult3.Time;
inputArray = sin(sineFreq*timeArray);
plot(timeArray, inputArray, "DisplayName","Input Signal"); hold on
plot(sineSimulinkResult3,"DisplayName","Output Signal");
xlabel("Time (s)");
ylabel("Voltage Ampltitude (V)");
title("Trial 3: System Frequency Response, \omega = 10 rad/s")
legend; grid on; grid minor;

%% Generation of Bode Plots
s = tf("s");
tfSystem = tf(1, [R*C 1]);

figure;
bode(tfSystem);




