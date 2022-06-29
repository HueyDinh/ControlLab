fileID = fopen('interrupt_data.txt','r');
formatSpec = '%d %d';
sizeA = [2 Inf];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
n=size(A);
t=A(1,1:n(2))/1000;
x=A(2,1:n(2));
figure()
plot(t,x,'r-')
title("Time History of Pin 7's Digital State, Delay Based")
xlabel("Time (sec)")
ylabel("Digital State (High/Low)")
grid on;
grid minor; 
axis padded;