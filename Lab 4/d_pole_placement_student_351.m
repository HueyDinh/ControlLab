% IMPORTANT: Make sure you run setup_rotpen.m first. You need the (A,B)
% state-space matrices.
%
%% Find Tranformation Matrix T
% Characteristic equation: s^4 + a_3*s^3 + a_2*s^2 + a_1*s + a_0
poly_coef = poly(A);

% 
% Companion matrices (Ac, Bc)
Ac = [  0 1 0 0;
        0 0 1 0;
        0 0 0 1;
        -poly_coef(5) -poly_coef(4) -poly_coef(3) -poly_coef(2)];
%
Bc = [0; 0; 0; 1];
%
% Controllability matrix
%Cont = 0; % Modify this to produce the correct result
Cont = ctrb(A,B);

% Controllability matrix of companion form
%Cont_c = 0; % Modify this to produce the correct result
Cont_c = ctrb(Ac,Bc);

% Similarity transformation matrix
%T = 0; % Modify this to produce the correct result
T = Cont/Cont_c;  % T = Cont*inv(Cont_c)

%
%% Find state feedback gain to place poles
% Companion state-feedback control gain
% Modify this as required. You may use your result from Question 6 from the

% Desired poles
syms s
z = 0.7;
wn = 4;
sigma = z*wn;
wd = wn*sqrt(1-z^2);
p1 = -sigma+wd*j;
p2 = -sigma-wd*j;
p3 = -30;
p4 = -40;

% Form polynomial from desired pole locations
poly_coef_des = poly([p1,p2,p3,p4]);
desired_cf = [0,1,0,0;
              0,0,1,0;
              0,0,0,1;
    -poly_coef_des(5), -poly_coef_des(4), -poly_coef_des(3), -poly_coef_des(2)];

% Solve system of equations corresponding to equating coeficients (or
% matrix elements) from Ac and desired_cf
   
Kc = [1.9200    0.7882    0.1728    0.0073]*1.0e+04;

% Convert back from companion form
K = [-1.0958    5.8789   -0.4624    0.6730]; % Modify this to produce the correct result



%% Closed-loop System Poles
% Find the poles of closed-loop system in order to
% verify that they are the same as the desired poles!
cls_poles = eig(A-B*K);
% cls_poles = [0 0 0 0]; % Modify this to produce the correct result
disp('Closed loop poles are:')
disp(cls_poles)
