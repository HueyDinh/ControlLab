clc; clear; close all
%% Experimental Result Visualization (Square Wave)
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

figure;
plot(t,x,"DisplayName","Input Signal"); hold on
plot(t,Vc,"DisplayName","Output Signal");
title("Capacitor Charging-Discharging Voltage Profile")
xlabel("Time (s)");
ylabel("Voltage (V)");
legend(Location = "best"); grid on; grid minor