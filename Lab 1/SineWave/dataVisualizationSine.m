fileID_omega6 = fopen('omega6.txt','r');
fileID_omega0_1 = fopen('omega0_1.txt','r');
fileID_omega1 = fopen('omega1.txt','r');
fileID_omega10 = fopen('omega10.txt','r');

figID_omega6 = plot_input_output(fileID_omega6);
figID_omega0_1 = plot_input_output(fileID_omega0_1);
figID_omega1 = plot_input_output(fileID_omega1);
figID_omega10 = plot_input_output(fileID_omega10);

function handle = plot_input_output(file_object)
    formatSpec = '%d %d %d';
    sizeA = [3 Inf];
    A = fscanf(file_object,formatSpec,sizeA);
    fclose(file_object);
    n=size(A);
    t=A(1,1:n(2))/1000;
    % 10-bit DAC conversion resolution is 1/1023
    Vc=5*A(2,1:n(2))/1023;
    % duty cycle count 255 (2^8 – 1) = 100% duty cycle of 5V
    Vs=5*A(3,1:n(2))/255;
    handle = figure();
    plot(t,Vc,'b-',t,Vs,'r-')
    grid on;
    grid minor;
end