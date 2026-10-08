clc;
clear;
close all;

% Initial Conditions

gamma = 1.4;
M1 = 3.0;
delta_A = deg2rad(15);
delta_B = deg2rad(10);

% u = upstream
% d = downstream
% Equaion 2: P_d / P_u = 2*gamma*M_u^2 * sin ^2 (theta) - (gamma - 1) / (gamma + 1)

% Equation 3: M_d ^ 2 * sin^2 (theta - gamma) = (gamma - 1)*M_u^2 * sin^2
% (theta) + 2 / (2*gamma*M_u^2 * sin^2 (theta) - (gamma - 1))

% Get Functions of theta from week 1

f_A = @(theta) shock_residual(delta_A, theta, M1);
f_B = @(theta) shock_residual(delta_B, theta, M1);

% Get Weak roots for theta's because there is least resistance there,
% oblique shocks in standard external aerodynamics point to the smaller, 
% weak solution encountered in the real world.

% Conditions to Solve Weak Roots
mu = asin(1/M1);
atol = 1e-6;
maxit = 100;

% Find Weak Roots
[theta_A, ~] = bisection(f_A, [], [mu, pi/4], atol, maxit);
[theta_B, ~] = bisection(f_B, [], [mu, pi/4], atol, maxit);

fprintf('Theta A:\t%g rad\t(%.3f deg)\n', theta_A, rad2deg(theta_A));
fprintf('Theta B:\t%g rad\t(%.3f deg)\n', theta_B, rad2deg(theta_B));

% Find Down Stream of A (M2)

% M1 for normal shock at A
M1_A = M1 * sin(theta_A);

% Pressure Continuity between 2 and 1 p2/p1

p2p1 = (2*gamma*M1_A^2 * sin(theta_A)^2 - (gamma - 1)) / (gamma + 1);

% M2 for normal shock at A
% M_d = sqrt ((gamma - 1)*M_u^2 * sin^2
% (theta) + 2 / (2*gamma*M_u^2 * sin^2 (theta) - (gamma - 1)) / sin^2
% (theta - gamma))

M2_A = sqrt((((gamma - 1)*M1_A^2 * sin(theta_A)^2 + 2) / (2*gamma*M1_A^2 * sin(theta_A)^2 - (gamma - 1))) / (sin(theta_A - gamma)^2));

% Solve for M2 at A

M2 = M2_A / sin(theta_A - delta_A);

% Find down Stream for B (M3)

M1_B = M1*sin(theta_B);

p3p1 = (2*gamma*M1_B^2 * sin(theta_B)^2 - (gamma - 1)) / (gamma + 1);

M2_B = sqrt((((gamma - 1)*M1_B^2 * sin(theta_B)^2 + 2) / (2*gamma*M1_B^2 * sin(theta_B)^2 - (gamma - 1))) / (sin(theta_B - gamma)^2));

M3 = M2_B / sin(theta_B - delta_B);

fprintf('p2/p1:\t%.4f\n', p2p1);

fprintf('p3/p1:\t%.4f\n', p3p1);

fprintf('M2:\t%.4f\n', M2);

fprintf('M3:\t%.4f\n', M3);