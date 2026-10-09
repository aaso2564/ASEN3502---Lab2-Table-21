clc
clear
close all

% Equation 4: tan(delta_C) = ((M2^2 * sin(2*theta_C)) - 2*cot(theta_C)) /
% (2+M_2^2 * (gamma + cos(2*theta_C))

% Equation 5: tan(delta_D) = ((M3^2 * sin(2*theta_D)) - 2*cot(theta_D)) /
% (2+M_3^2 * (gamma + cos(2*theta_D))

% Initial Conditions
delta_A = deg2rad(15);
delta_B = deg2rad(10);
gamma = 1.4;
atol = 1e-6;

% Mach numbers and pressure ratios from step 2.5
M2 = 2.2549;
M3 = 2.5050;
p2p1 = 2.8216;
p3p1 = 2.0545;

% Initial Guess vector [phi; theta_C; theta_D] in radians
x0 = [0; deg2rad(35); deg2rad(35)];

% Function handle passing solver vector x = [phi; theta_C; theta_D]
f_sys = @(x) shock_refraction_residual(x(1), x(2), x(3), M2, M3, delta_A, delta_B, p2p1, p3p1);

% Jacobian handle evaluating at current state x
J = @(x) numjac(f_sys, x, atol); 

% Solve system using Newton's System Method
[x_sol, info] = newton_sys(f_sys, J, x0, 1e-6, 100);

% Extract solutions
phi_deg = rad2deg(x_sol(1));
theta_C_deg = rad2deg(x_sol(2));
theta_D_deg = rad2deg(x_sol(3));

% Calculate pressure ratios using x_sol(2)
p4p2 = 1 + (2*gamma/(gamma+1))*(M2^2 * sin(x_sol(2))^2 - 1);
p4p1 = p2p1 * p4p2;

fprintf('Phi:\t%.3f deg\n', phi_deg);

fprintf('Theta C:\t%.3f deg\n', theta_C_deg);

fprintf('Theta D:\t%.3f deg\n', theta_D_deg);

fprintf('p4/p1:\t%.4f\n', p4p1);