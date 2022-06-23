fileID = fopen('gpio_interrupt_result.txt','r');
formatSpec = '%d %d';
sizeA = [2 Inf];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
n=size(A);
t=A(1,1:n(2))/1000;
x=A(2,1:n(2));
figure()
plot(t,x,'r-')
title('x(red) vs. time, sec')
grid on;
grid minor; 