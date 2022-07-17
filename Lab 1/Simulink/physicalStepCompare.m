clc; clear; close all
%% Circuit Parameters
R = 10.03e3;
C = 10.27e-6;

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
stepAmplitude = 4.707; % 5 Volt Input
stepSimTime = 10; % s
stepOnTime = 5; % s
stepMaxStepSize = 0.05; % s

% Running the simulation
stepSimulinkResult = sim("stepInputModel.slx").simulinkStepResponse;

figure;
plot(t, x, "DisplayName","Input Signal"); hold on
plot(stepSimulinkResult,"DisplayName","Output Signal, Simulink");
plot(t, Vc, "DisplayName","Output Signal, Hardware");
xlabel("Time (s)");
ylabel("Voltage Ampltitude (V)");
title("System Step Response, u = 4.707 V")
xlim([4,6]);
legend(Location="best"); grid on; grid minor;




