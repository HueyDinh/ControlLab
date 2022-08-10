%% Pole placement 3rd Order System Demo
%% Companion form pole placement demonstration on 3x3 system
clear all; close all; clc;
%% Define a system
A  = [10    14    14;
       9    15    13;
      13     6     3];
B  = [1;2;3];
disp('The system is given by') 
disp('A = ')
disp(A)
disp('B = ')
disp(B)
 
%% Find a similarity transform that converts {A,B} into a companion form
syms s
charpoly=det(s*eye(length(A))-A); % Matrix determinant; to obtain the characteristic equation
disp('Characteristic Equation')
charpoly=expand(charpoly) % Symbolic expansion of polynomials and elementary functions
charpoly_coeff=poly(A) % det(SI-A)=s^n+a_(n-1)*s^(n-1)+...+a1*s+a0
 
a0=charpoly_coeff(4);
a1=charpoly_coeff(3);
a2=charpoly_coeff(2);
t3=B;
t2=A*t3+a2*t3;
t1=A*t2+a1*t3;
disp('Similarity Matrix')
T=[t1,t2,t3] % Similarity Matrix
 
disp('Companion form of system')
Ac=inv(T)*A*T
Bc=inv(T)*B
 
%% Form polynomial from desired pole locations
poly_coef_des = poly([-1,-2,-3]);
Ac_desired = [0,1,0;
              0,0,1;
    -poly_coef_des(4), -poly_coef_des(3), -poly_coef_des(2)];
disp('Desired companion form system')
disp('Ac_desired = ')
disp(Ac_desired)
 
%% Solve system of equations corresponding to equating coefficients (or matrix elements) from Ac and Ac_desired
kc1 = -(-poly_coef_des(4)+charpoly_coeff(4));
kc2 = -(-poly_coef_des(3)+charpoly_coeff(3));
kc3 = -(-poly_coef_des(2)+charpoly_coeff(2));
Kc = [kc1,kc2,kc3];
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
