clc; clear; close all;
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
figure(111)
plot(t,x,'b-',t,Vc,'r-')
title('x(blue) Vc(red) vs. time, sec')
grid on;
grid minor;