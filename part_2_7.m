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

% Initial Guess 1 vector [phi; theta_C; theta_D] in radians
x1 = [0; deg2rad(30); deg2rad(30)];

% Initial Guess 2 vector [phi; theta_C; theta_D] in radians
x2 = [5; deg2rad(45); deg2rad(45)];

% Initial Guess 3 vector [phi; theta_C; theta_D] in radians
x3 = [-5; deg2rad(75); deg2rad(75)];

% Function handle passing solver vector x = [phi; theta_C; theta_D]
f_sys1 = @(x1) shock_refraction_residual(x1(1), x1(2), x1(3), M2, M3, delta_A, delta_B, p2p1, p3p1);
f_sys2 = @(x2) shock_refraction_residual(x2(1), x2(2), x2(3), M2, M3, delta_A, delta_B, p2p1, p3p1);
f_sys3 = @(x3) shock_refraction_residual(x3(1), x3(2), x3(3), M2, M3, delta_A, delta_B, p2p1, p3p1);

% Jacobian handle evaluating at current state x
J1 = @(x1) numjac(f_sys1, x1, atol); 
J2 = @(x2) numjac(f_sys2, x2, atol); 
J3 = @(x3) numjac(f_sys3, x3, atol); 

% Solve system using Newton's System Method
[x_sol1, info1] = newton_sys(f_sys1, J1, x1, 1e-6, 100);
[x_sol2, info2] = newton_sys(f_sys2, J2, x2, 1e-6, 100);
[x_sol3, info3] = newton_sys(f_sys3, J3, x3, 1e-6, 100);

% Display Results for Initial Guess 1
fprintf('Initial Guess 1: phi: 0 theta_C: 30 theta_D: 30 \n');
fprintf('Phi: %.4f deg\n', rad2deg(x_sol1(1)));
fprintf('Theta C: %.4f deg\n', rad2deg(x_sol1(2)));
fprintf('Theta D: %.4f deg\n', rad2deg(x_sol1(3)));
fprintf('Residual norm: %.6e\n', norm(f_sys1(x_sol1)));

% Display Results for Initial Guess 2
fprintf('Initial Guess 2: phi: 5 theta_C: 45 theta_D: 45 \n');
fprintf('Phi: %.4f deg\n', rad2deg(x_sol2(1)));
fprintf('Theta C: %.4f deg\n', rad2deg(x_sol2(2)));
fprintf('Theta D: %.4f deg\n', rad2deg(x_sol2(3)));
fprintf('Residual norm: %.6e\n', norm(f_sys2(x_sol2)));

% Display Results for Initial Guess 3
fprintf('Initial Guess 3: phi: -5 theta_C: 75 theta_D: 75 \n');
fprintf('Phi: %.4f deg\n', rad2deg(x_sol3(1)));
fprintf('Theta C: %.4f deg\n', rad2deg(x_sol3(2)));
fprintf('Theta D: %.4f deg\n', rad2deg(x_sol3(3)));
fprintf('Residual norm: %.6e\n', norm(f_sys3(x_sol3)));