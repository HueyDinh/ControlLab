%% SETUP_ROTPEN
%
% Sets the necessary parameters to run the SRV02 Single Inverted Pendulum 
% laboratory.
% 
% Copyright (C) 2011 Quanser Consulting Inc.
%
% Revised for Drexel University MEM 351
% D. Hartman, 2016
clear all; close all; clc;


%% Lab Configuration
% Type of controller: set it to 'INSTRUCTOR', 'STUDENT'
 LAB_CONFIG = 'STUDENT';
% LAB_CONFIG = 'INSTRUCTOR';

%% SRV02 Configuration (for ROTPEN)
% External Gear Configuration: set to 'HIGH' or 'LOW'
EXT_GEAR_CONFIG = 'HIGH';
% Encoder Type: set to 'E' or 'EHR'
ENCODER_TYPE = 'E';
% Is SRV02 equipped with Tachometer? (i.e. option T): set to 'YES' or 'NO'
TACH_OPTION = 'YES';
% Type of Load: set to 'NONE', 'DISC', or 'BAR' (set to NONE when using
% module)
LOAD_TYPE = 'NONE';
% Amplifier Gain used: 
% VoltPAQ-X1 users: set to K_AMP to 1 and Gain switch on amplifier to 1
% VoltPAQ-X2 users: set to K_AMP 3
K_AMP = 1;
% Power Amplifier Type: set to 'VoltPAQ', 'UPM_1503', 'UPM_2405', or 'Q3'
AMP_TYPE = 'VoltPAQ';


%% Load Model
% Sets model variables according to the user-defined SRV02 configuration
[ Rm, kt, km, Kg, eta_g, Beq, Jm, Jeq, eta_m, K_POT, K_TACH, K_ENC, VMAX_AMP, IMAX_AMP ] = config_srv02( EXT_GEAR_CONFIG, ENCODER_TYPE, TACH_OPTION, AMP_TYPE, LOAD_TYPE );
% Load rotary arm parameters
[ g, Mr, Lr, lr, Jr, Dr ] = config_sp( 'ROTARY_ARM', 'ROTPEN-E' );
% Load medium 12-inch pendulum parameters
[ g, Mp, Lp, lp, Jp, Dp ] = config_sp( 'MEDIUM_12IN', 'ROTPEN-E' );
% Set open-loop state-space model of rotary single-inverted pendulum (SIP)
if strcmp(LAB_CONFIG,'STUDENT')
    ROTPEN_ABCD_eqns_student_351; % YOU NEED TO EDIT THIS SCRIPT!
else
    ROTPEN_ABCD_eqns_instructor_351;
end


%% Balance Control
% Balance control enable range (rad)
epsilon = 15.0 * pi / 180;
% Control Specifications
zeta = 0.7;
wn = 4;
p3 = -30;
p4 = -40;
% State-feedback gain
% Complete script below to find K based on specifications
if strcmp(LAB_CONFIG,'STUDENT')
    d_pole_placement_student_351;  % YOU NEED TO EDIT THIS SCRIPT!
else
    d_pole_placement_instructor_351;
end


%% Observer Filter Parameters (DO NOT MODIFY)
% SRV02 High-pass filter in PD control used to compute velocity
% Cutoff frequency (rad/s)
wcf_1 = 2 * pi * 10.0;
% Pendulum High-pass filter in PD control used to compute velocity
% Cutoff frequency (rad/s)
wcf_2 = 2 * pi * 10.0;


%% Display Results
disp('A = ')
disp(A)
disp('B = ')
disp(B)
disp( ' ' );
disp( 'Balance control gain: ' );
disp( 'K = ' );
disp(K)
disp( 'Closed loop (or Open-loop if K=0) eigenvalues:')
disp(eig(A-B*K))
