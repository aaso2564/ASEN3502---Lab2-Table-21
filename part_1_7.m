clc;
clear;
close all;

% Mach number and angle parameters
M1 = 3.0;
gamma = 1.4;
mu = asind(1/M1);

% Deflection angles
delta1 = 10;
delta2 = 20;
delta3 = 30;
delta4 = 40;

% Shock residual function handles
f_theta1 = @(theta) shock_residual(delta1, theta, M1);
f_theta2 = @(theta) shock_residual(delta2, theta, M1);
f_theta3 = @(theta) shock_residual(delta3, theta, M1);
f_theta4 = @(theta) shock_residual(delta4, theta, M1);

% Select target deflection angle function (delta1 = 10 deg)
f = f_theta1;

% Numerical derivative fprime handle
h = 1e-6;
fprime = @(theta) (f(theta + h) - f(theta - h)) / (2 * h);

% Solver settings
atol = 1e-8;
maxit = 100;

% Reference weak and strong roots found using interval inputs
[x_weak_ref, ~]   = newton_raphson(f, fprime, [mu, 45], atol, maxit);
[x_strong_ref, ~] = newton_raphson(f, fprime, [45, 90], atol, maxit);
tol_root = 1e-2;

% Initial guess sweep across theta0
theta0_vector = linspace(mu, 90, 500);
convergence_status = strings(length(theta0_vector), 1);
converged_roots = zeros(length(theta0_vector), 1);

for k = 1:length(theta0_vector)
    x0 = theta0_vector(k);
    
    % Pass scalar initial guess x0 directly into newton_raphson
    [x_converge, info] = newton_raphson(f, fprime, x0, atol, maxit);
    
    converged_roots(k) = x_converge;
    
    % Categorize root result
    if info.flag ~= 0
        convergence_status(k) = "Failed";
    elseif abs(x_converge - x_weak_ref) < tol_root
        convergence_status(k) = "Weak Root";
    elseif abs(x_converge - x_strong_ref) < tol_root
        convergence_status(k) = "Strong Root";
    else
        convergence_status(k) = "Failed";
    end
end

% Plotting results
figure('Name', 'Newton-Raphson Initial Guess Dependence');
scatter(theta0_vector(convergence_status == "Weak Root"), converged_roots(convergence_status == "Weak Root"), 20, 'blue', 'filled', 'DisplayName', 'Converged to Weak Root'); hold on;
scatter(theta0_vector(convergence_status == "Strong Root"), converged_roots(convergence_status == "Strong Root"), 20, 'red', 'filled', 'DisplayName', 'Converged to Strong Root');
scatter(theta0_vector(convergence_status == "Failed"), zeros(sum(convergence_status == "Failed"), 1), 20, 'yellow', 'x', 'DisplayName', 'Failed');

grid on;
xlabel('Initial Guess theta_0 (degrees)');
ylabel('Converged Root (degrees)');
title('Newton-Raphson Convergence vs. Initial Guess theta_0');
legend('Location', 'best');