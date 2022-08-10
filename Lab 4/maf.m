%% Pole placement 4rd Order System
%% Companion form pole placement demonstration on 3x3 system
clear all; close all; clc;

zeta = 0.7;
omega_n = 4;
perf_poles = roots([1 2*omega_n*zeta omega_n^2])';
diminished_poles = [-30, -40];
poly_coef_des = poly([perf_poles, diminished_poles])
%% Define a system
A= [0   0       1       0;
    0   0       0       1;
    0   80.615 -0.9632 -0.9231;
    0   120.92 -0.9231 -1.385];

B = [ 0; 0; 401.3; 384.6];
disp('The system is given by') 
disp('A = ')
disp(A)
disp('B = ')
disp(B)
 
%% Find a similarity transform that converts {A,B} into a companion form
syms s
charpoly=det(s*eye(length(A))-A); % Matrix determinant; to obtain the characteristic equation
disp('Characteristic Equation')
charpoly = expand(charpoly) % Symbolic expansion of polynomials and elementary functions
charpoly_coeff = poly(A) % det(SI-A)=s^n+a_(n-1)*s^(n-1)+...+a1*s+a0
 
a0 = charpoly_coeff(5);
a1 = charpoly_coeff(4);
a2 = charpoly_coeff(3);
a3 = charpoly_coeff(2);
t4 = B;
t3 = A*t4+a3*t4;
t2 = A*t3+a2*t4;
t1 = A*t2+a1*t4;

disp('Similarity Matrix')
T=[t1, t2, t3, t4] % Similarity Matrix
 
disp('Companion form of system')
Ac= inv(T)*A*T
Bc= inv(T)*B
 
%% Form polynomial from desired pole locations
Ac_desired = [0,1,0,0;
              0,0,1,0;
              0,0,0,1;
    -poly_coef_des(5), -poly_coef_des(4), -poly_coef_des(3), -poly_coef_des(2)];
disp('Desired companion form system')
disp('Ac_desired = ')
disp(Ac_desired)
 
%% Solve system of equations corresponding to equating coefficients (or matrix elements) from Ac and Ac_desired
kc1 = -(-poly_coef_des(5)+charpoly_coeff(5));
kc2 = -(-poly_coef_des(4)+charpoly_coeff(4));
kc3 = -(-poly_coef_des(3)+charpoly_coeff(3));
kc4 = -(-poly_coef_des(2)+charpoly_coeff(2));
Kc = [kc1,kc2,kc3,kc4];
K = Kc*inv(T);
eigenvalue_cl = eig(A-B*K);
disp('Solving for the necessary state feedback gains, we obtain')
disp('Kc = ')
disp(Kc)
disp('Transformed into original state space this is')
disp('K = ')
disp(K)
disp('The eigenvalues of the close-loop system with this state feedback are now')
disp(eigenvalue_cl)
disp('as desired.')