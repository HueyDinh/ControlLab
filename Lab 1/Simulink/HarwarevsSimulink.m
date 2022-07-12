clc; clear; close all
%% Circuit Parameters
R = 10e3;
C = 11.65e-6;

%% Experimental Result (Square Wave)
fileID = fopen('file_1aRCstep.txt','r');
formatSpec = '%d %d %d';
sizeA = [3 Inf];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
n=size(A);
t=A(1,1:n(2));
t=t/1000;
x=A(2,1:n(2));
Vc=A(3,1:n(2));
Vc=Vc*5/1023;
x=x*max(Vc);

%% Model 1 (Square Input) Parameters
stepAmplitude = 4.701; % 5 Volt Input
stepSimTime = 4; % s
stepOnTime = 2; % s
stepMaxStepSize = 0.05; % s

% Running the simulation
stepSimulinkResult = sim("stepInputModel.slx").simulinkStepResponse;

figure;
plot(t, x, "DisplayName","Input Signal"); hold on
plot(stepSimulinkResult,"DisplayName","Output Signal, Simulink");
plot(t, Vc, "DisplayName","Output SIgnal, Hardware");
xlabel("Time (s)");
ylabel("Voltage Ampltitude (V)");
title("System Step Response, u = 4.701 V")
xlim([0,4]);
legend(Location="best"); grid on; grid minor;

%% Model 2 (Sine Wave) Parameters

%% Hardware Data 6 rad/s
fileID = fopen('rad6.txt','r');
formatSpec = '%d %d %d';
sizeA = [3 Inf];
A = fscanf(file_object,formatSpec,sizeA);
fclose(file_object);
n=size(A);
t=A(1,1:n(2))/1000;
% 10-bit DAC conversion resolution is 1/1023
Vc=5*A(2,1:n(2))/1023;
% duty cycle count 255 (2^8 – 1) = 100% duty cycle of 5V
x=5*A(3,1:n(2))/255;

%% Trial 1: omega = 6
sineFreq = 6; % rad/s
sinePeriod = 2*pi/sineFreq; % s
sineAmplitude = 2.5;
sineBias = 2.5;
sineSimTime = 10*sinePeriod;
sineMaxStepSize = 0.01*sinePeriod;
sineSimulinkResult1 = sim("sineInputModel.slx").simulinkSineResponse;

figure;
timeArray = sineSimulinkResult1.Time;
inputArray = sin(sineFreq*timeArray).*2.5 + 2.5;
plot(timeArray, inputArray, "DisplayName","Input Signal"); hold on;
plot(sineSimulinkResult1,"DisplayName","Output Signal, Simulink");
plot(t,Vc, "DisplayName","Output Signal, Hardware");
xlabel("Time (s)");
ylabel("Voltage Ampltitude (V)");
title("Trial 1: System Frequency Response, \omega = 0.1 rad/s")
legend; grid on; grid minor;


%% Hardware Data 22 rad/s

%% Trial 2: omega = 1
sineFreq = 22; % rad/s
sinePeriod = 2*pi/sineFreq; % s
sineAmplitude = 2.5;
sineBias = 2.5;
sineSimTime = 10*sinePeriod;
sineMaxStepSize = 0.01*sinePeriod;
sineSimulinkResult2 = sim("sineInputModel.slx").simulinkSineResponse;

figure;
timeArray = sineSimulinkResult2.Time;
inputArray = sin(sineFreq*timeArray).*2.5 + 2.5;
plot(timeArray, inputArray, "DisplayName","Input Signal"); hold on;
plot(sineSimulinkResult2,"DisplayName","Output Signal");
xlabel("Time (s)");
ylabel("Voltage Ampltitude (V)");
title("Trial 2: System Frequency Response, \omega = 1 rad/s")
legend; grid on; grid minor;





