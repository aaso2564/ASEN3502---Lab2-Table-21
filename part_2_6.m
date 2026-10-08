clc
clear
close all

% Equation 4: tan(delta_C) = ((M2^2 * sin(2*theta_C)) - 2*cot(theta_C)) /
% (2+M_2^2 * (gamma + cos(2*theta_C))

% Equation 5: tan(delta_D) = ((M3^2 * sin(2*theta_D)) - 2*cot(theta_D)) /
% (2+M_3^2 * (gamma + cos(2*theta_D))

% Initial Conditions

delta_A = deg2rad(15);
delta_B = deg2rad(30);

gamma = 1.4;

% From 2.5

M2 = 2.4317;
M3 = 4.6976;
p2p1 = 6.1333;
p3p1 = 6.1333;

% Inital Guess to use newton_sys

phi = 0;
delta_C = 0;
delta_D = 0;

% Set up function for Newton System

f_sys = @(x) shock_refraction_residual(phi, delta_C, delta_D, M2, M3, delta_A, delta_B, p2p1, p3p1);

% Set up Jacobian

J = 

% Use Newton System to find phi, theta_C, theta_D, p4/pi

Function4 = ((M2^2 * sin(2*theta_C)) - 2*cot(theta_C)) / (2+M_2^2 * (gamma + cos(2*theta_C))) - tan(delta_C); 
Funciton5 = ((M3^2 * sin(2*theta_D)) - 2*cot(theta_D)) / (2+M_3^2 * (gamma + cos(2*theta_D))) - tan(delta_D)

[x, ~] = newton_sys(Function4)




delta_C = delta_A - phi;
delta_D = delta_B + phi;