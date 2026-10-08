clc
clear
close all

% Equation 4: tan(delta_C) = ((M2^2 * sin(2*theta_C)) - 2*cot(theta_C)) /
% (2+M_2^2 * (gamma + cos(2*theta_C))

% Equation 5: tan(delta_D) = ((M3^2 * sin(2*theta_D)) - 2*cot(theta_D)) /
% (2+M_3^2 * (gamma + cos(2*theta_D))

% Initial Conditions

M2 = 2.4317;
M3 = 4.6976;

delta_A = deg2rad(15);
delta_B = deg2rad(30);




% Use Newton System to find phi, theta_C, theta_D, p4/pi

Function4 = ((M2^2 * sin(2*theta_C)) - 2*cot(theta_C)) / (2+M_2^2 * (gamma + cos(2*theta_C))) - tan(delta_C); 
Funciton5 = ((M3^2 * sin(2*theta_D)) - 2*cot(theta_D)) / (2+M_3^2 * (gamma + cos(2*theta_D))) - tan(delta_D)

[x, ~] = newton_sys(Function4)




delta_C = delta_A - phi;
delta_D = delta_B + phi;