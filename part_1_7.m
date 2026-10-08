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

% Theta Intervals

theta = linspace(mu, 90, 1000);

% Shock residual
f_theta1 = @(theta) shock_residual(delta1, theta, M1);

% Select Angle for Function (delta1 = 10 deg)
f = f_theta1;

% Derivative of f
h = 1e-6;
fprime = @(theta) (f(theta + h) - f(theta - h)) / (2 * h);

% Conditions
atol = 1e-8;
maxit = 100;

% Reference weak and strong roots found using interval inputs
[x_weak_ref, ~]   = newton_raphson(f, fprime, [0, 60], atol, maxit);
[x_strong_ref, ~] = newton_raphson(f, fprime, [60, 90], atol, maxit);
tol_root = 1e-2;

% Initial guess sweep across theta0
theta0_vector = linspace(mu, 90, 500);
convergence_status = strings(length(theta0_vector), 1);
converged_roots = zeros(length(theta0_vector), 1);

for k = 1:length(theta0_vector)
    x0 = theta0_vector(k);
    
    % Pass initial guess x0 directly into newton_raphson
    [x_converge, info] = newton_raphson(f, fprime, [x0,x0], atol, maxit);
    
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

% Plot
fig = figure('Name', 'Newton-Raphson Initial Guess Dependence');
ax = axes('Parent', fig);
hold(ax, 'on'); grid(ax, 'on'); box(ax, 'on');

% Logical indexing masks
idx_weak   = (convergence_status == "Weak Root");
idx_strong = (convergence_status == "Strong Root");
idx_failed = (convergence_status == "Failed");

% Reference root horizontal lines
yline(x_weak_ref, '--', 'Weak Shock Root (\theta_{weak})', 'Color', 'red');
yline(x_strong_ref, '--', 'Strong Shock Root (\theta_{strong})', 'Color', 'blue', 'LabelHorizontalAlignment', 'left');

% Scatter convergence results
scatter(theta0_vector(idx_weak), converged_roots(idx_weak), 25, 'red', 'filled', 'DisplayName', 'Converged to Weak Root');
scatter(theta0_vector(idx_strong), converged_roots(idx_strong), 25, 'blue', 'filled', 'DisplayName', 'Converged to Strong Root');

if any(idx_failed)
    scatter(theta0_vector(idx_failed), zeros(sum(idx_failed), 1), 35, 'yellow', 'x', 'LineWidth', 1.5, 'DisplayName', 'Diverged / Exceeded Max Iterations');
end

% Axes labels
xlabel('Initial Guess \theta_0 (degrees)', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('Converged Root \theta (degrees)', 'FontSize', 11, 'FontWeight', 'bold');
title('Newton-Raphson Convergence vs. Initial Guess \theta_0 (M_1 = 3.0, \delta = 10^\circ)', 'FontSize', 12);
xlim([mu, 90]);
ylim([-5, 95]);
legend('Location', 'southwest', 'FontSize', 9);