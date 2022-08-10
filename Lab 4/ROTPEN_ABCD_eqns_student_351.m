%% State Space Linear Model
% Modify these to produce the correct result.
% Replace the following A, B by the values of A, B in Eq. 14
A = zeros(4);  % Modify to produce the correct result
B = zeros(4,1); % Modify to produce the correct result

C = eye(2,4); % DO NOT MODIFY
D = zeros(2,1); % DO NOT MODIFY

% Add A, B matrices of Eq. 14 below:

A= [0   0       1       0;
    0   0       0       1;
    0   80.615 -0.9632 -0.9231;
    0   120.92 -0.9231 -1.385]


B = [ 0; 0; 401.3; 384.6]



% Add actuator dynamics (DO NOT MODIFY THIS SECTION!)
%A(3,3) = A(3,3) - Kg^2*kt*km/Rm*B(3);
%A(4,3) = A(4,3) - Kg^2*kt*km/Rm*B(4);
%B = Kg * kt * B / Rm;

% The following modifications convert the torque input to voltage input
% Add actuator dynamics (DO NOT MODIFY THIS SECTION!)
A(3,3) = A(3,3) - Kg^2*kt*km*eta_g*eta_m/Rm*B(3);
A(4,3) = A(4,3) - Kg^2*kt*km*eta_g*eta_m /Rm*B(4);
B = Kg * kt * eta_g * eta_m * B / Rm;
