clc; clear; close all

%% Circuit Parameters
R = 10.03e3;
C = 10.27e-6;

% Generation of Bode Plots
s = tf("s");
tfSystem = tf(1, [R*C 1]);

figure;
bode(tfSystem); hold on;
bode(tfSystem,"*", [6,22]);
grid on

%% Hardware Data 6 rad/s
fileID = fopen('rad6.txt','r');
formatSpec = '%d %d %d';
sizeA = [3 Inf];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
n=size(A);
t=A(1,1:n(2))/1000;
% 10-bit DAC conversion resolution is 1/1023
Vc=5*A(2,1:n(2))/1023;
% duty cycle count 255 (2^8 – 1) = 100% duty cycle of 5V
x=5*A(3,1:n(2))/255;

%% Trial 1: omega = 6
sineFreq = 6; % rad/s
sinePeriod = 2*pi/sineFreq; % s
sineAmplitude = 4.707/2;
sineBias = 4.707/2;
sineSimTime = 10*sinePeriod;
sineMaxStepSize = 0.001*sinePeriod;
sineSimulinkResult1 = sim("sineInputModel.slx").simulinkSineResponse;

figure;
timeArray = sineSimulinkResult1.Time;
inputArray = sin(sineFreq*timeArray).*sineAmplitude + sineBias;
plot(timeArray, inputArray, "DisplayName","Input Signal"); hold on;
plot(sineSimulinkResult1,"DisplayName","Output Signal, Simulink");
plot(t,Vc, "DisplayName","Output Signal, Hardware");
xlabel("Time (s)");
ylabel("Voltage Ampltitude (V)");
title("Trial 1: System Frequency Response, \omega = 6 rad/s")
legend; grid on; grid minor; axis padded


%% Hardware Data 22 rad/s
fileID = fopen('rad22.txt','r');
formatSpec = '%d %d %d';
sizeA = [3 Inf];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
n=size(A);
t=A(1,1:n(2))/1000;
% 10-bit DAC conversion resolution is 1/1023
Vc=5*A(2,1:n(2))/1023;
% duty cycle count 255 (2^8 – 1) = 100% duty cycle of 5V
x=5*A(3,1:n(2))/255;

%% Trial 2: omega = 22
sineFreq = 22; % rad/s
sinePeriod = 2*pi/sineFreq; % s
sineAmplitude = 4.707/2;
sineBias = 4.707/2;
sineSimTime = 10*sinePeriod;
sineMaxStepSize = 0.001*sinePeriod;
sineSimulinkResult2 = sim("sineInputModel.slx").simulinkSineResponse;

figure;
timeArray = sineSimulinkResult2.Time;
inputArray = sin(sineFreq*timeArray).*sineAmplitude + sineBias;
plot(timeArray, inputArray, "DisplayName","Input Signal"); hold on;
plot(sineSimulinkResult2,"DisplayName","Output Signal, Simulink");
plot(t,Vc, "DisplayName","Output Signal, Hardware");
xlabel("Time (s)");
ylabel("Voltage Ampltitude (V)");
title("Trial 2: System Frequency Response, \omega = 22 rad/s")
legend; grid on; grid minor; axis padded

