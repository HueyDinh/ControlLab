%% Rotary Inverted Pendulum Simulation Script
% Script to setup workspace, run simulation, and call plotting functions
% for the Rotary Inverted Pendulum Nonlinear Simulation
% D. Hartman

% Open Model
 open('ROTPEN_Sim_R2015a')
 
%%
clear all; close all; clc;

% Setup parameter values (Can be found in "Rotary Inverted Pendulum - User
% Manual" in "User Manual" folder)
% A setup script (from Quanser) could be used to populate these automatically.
% note however that their script calls Br -> Dr and Bp -> Dp
g = 9.8100;
Mp = 1.2700*10^-1;
Lp = 3.3655*10^-1;
Lr = 2.1590*10^-1;
Jr = 9.982910141666664*10^-4;
Jp = 1.198730801458333*10^-3;
eta_g = 9.0000*10^-1;
eta_m = 6.899999999999999*10^-1;
Kg = 70;
kt = 7.682969729279999*10^-3;
Rm = 2.6000; 
km = 7.677634454753032*10^-3;
Bp = 2.4000*10^-3;
Br = 2.4000*10^-3;
% High pass filter parameters
wcf_1 = 62.831853071795862; % this is 20*pi
wcf_2 = wcf_1;

% Enter linear model here:

A =  [ 0         0    1.0000         0;
          0         0         0    1.0000;
          0   80.6150  -28.6670   -0.9231;
          0  120.9200  -27.4741   -1.3850 ]
B = [     0;
          0;
    51.5483;
    49.4032 ]


C = [eye(2),zeros(2,2)];
D = zeros(2,1);

%__________________________________________________________________________
% State Feedback Controller Gains 
% (YOU WILL NEED TO REPLACE THESE WITH YOUR CALCULATED VALUES!)
 K = [-8.5311, 45.7674, -4.1375, 5.2391];  % zeta = 0.7
% K = [-5.2612, 28.1568, -2.7576, 3.2190];
% K = [-5.2612, 28.1568, -2.7576, 3.2190]; % Original 
% K = [-5.2612   30.6590   -3.5467    4.0690]; % Critically damped zeta = 1;
% K = [-5.2612   23.1523   -1.1792    1.5190]; % zeta = 0.1;
% K     = [0, 0, 0, 0];
%__________________________________________________________________________

% Setup parameter vector
Parameters = [Mp,Lr,Lp,Jr,Jp,Br,Bp,g].'; % Note: other parameters are also used by simulation

% Setup initial conditions
IC = [0,0,0,0]*pi/180.'; % Resulting vector must be in radians

% Setup Controller Threshold (max & min alpha values within which control
% is attempted.)
control_threshold = 12*pi/180; % Radians

% Setup desired position signal (we only pick theta, OTHER VALUES MUST BE ZERO)
square_amp = 10*pi/180; % Radians
square_freq = 1/5; % Hz

% Max and min slew rate (infinite for simulation of "actual system")
slew_rise = inf*pi/180;  % Radians per second
slew_fall = -inf*pi/180; % Radians per second

% Length of simulation
tfinal = 10; % seconds

% Clear out workspace a bit
clearvars -except Parameters IC xd K eta_g eta_m Kg kt Rm square_amp ...
   km  square_freq slew_rise slew_fall control_threshold A B C D wcf_1 wcf_2 tfinal
%clearvars -except Parameters IC xd K eta_g eta_m Kg kt Rm km square_amp square_freq slew_rise slew_fall control_threshold A B C D wcf_1 wcf_2 tfinal


% Simulate model
sim('ROTPEN_Sim_R2015a')

%% Simulation Result Plotting
close all
ROTPEN_Sim_Plot(the,alp,dthe,dalp,voltage,...
    the_lin,alp_lin,dthe_lin,dalp_lin,voltage_lin,xd,tout)

%% 3D Animation
ROTPEN_Sim_Animation(the, alp, the_lin, alp_lin, control_threshold, tout)

