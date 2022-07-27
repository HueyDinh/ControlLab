% ReadTxt_Motor_DL_speedfdbk_A.m
fileID = fopen('file_Motor_DL_speedfdbk_A.txt','r');
formatSpec = '%d %d %f %f';
sizeA = [4 Inf];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
n=size(A);
t=A(1,1:n(2));
x=A(2,1:n(2));
duty=A(3,1:n(2));
rpm=A(4,1:n(2));

figure(351)
plot(t/1000000,duty,'r.')
title('duty cycle(red) vs. time, sec')
grid on;
grid minor;

figure(353)
plot(t/1000000,rpm,'b.')
title('rpm(blue) vs. time, sec')
grid on;
grid minor;




