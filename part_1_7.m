% Task 1.7 Initial Guess Dependence Script

% Define Mach number and angle parameters
M = 3.0;
gamma = 1.4;
mu = asind(1/M);

% Theta Intervals

theta = linspace(mu, 90, 1000);

% Function of Theta

f_theta1 = @(theta) shock_residual(delta1, theta, M1);

f_theta2 = @(theta) shock_residual(delta2, theta, M1);

f_theta3 = @(theta) shock_residual(delta3, theta, M1);

f_theta4 = @(theta) shock_residual(delta4, theta, M1);


% Sweep range for initial guess theta0
theta0_vec = linspace(mu, 90, 500);
convergence_status = strings(length(theta0_vec), 1);
converged_roots = zeros(length(theta0_vec), 1);

% Identify weak and strong roots independently
[x_weak_ref, ~]   = newton_raphson(f, fprime, [mu, 45], 1e-8, 100);
[x_strong_ref, ~] = newton_raphson(f, fprime, [45, 90], 1e-8, 100);

tol_root = 1e-2; % Absolute tolerance to identify root match

for k = 1:length(theta0_vec)
    x0 = theta0_vec(k);
    
    % Modified custom NR call with explicit x0
    [x_conv, info] = newton_raphson_custom_x0(f, fprime, x0, atol, maxit);
    
    converged_roots(k) = x_conv;
    
    if info.flag ~= 0
        convergence_status(k) = "Failed";
    elseif abs(x_conv - x_weak_ref) < tol_root
        convergence_status(k) = "Weak Root";
    elseif abs(x_conv - x_strong_ref) < tol_root
        convergence_status(k) = "Strong Root";
    else
        convergence_status(k) = "Failed";
    end
end

% Plotting results
figure('Name', 'Newton-Raphson Initial Guess Dependence');
scatter(theta0_vec(convergence_status == "Weak Root"), converged_roots(convergence_status == "Weak Root"), 20, 'blue', 'filled', 'DisplayName', 'Converged to Weak Root'); hold on;
scatter(theta0_vec(convergence_status == "Strong Root"), converged_roots(convergence_status == "Strong Root"), 20, 'red', 'filled', 'DisplayName', 'Converged to Strong Root');
scatter(theta0_vec(convergence_status == "Failed"), zeros(sum(convergence_status == "Failed"), 1), 20, 'black', 'x', 'DisplayName', 'Failed');

grid on;
xlabel('Initial Guess \theta_0 (degrees)');
ylabel('Converged Root (degrees)');
title('Newton-Raphson Convergence vs. Initial Guess \theta_0');
legend('Location', 'best');

% Helper Newton-Raphson function supporting custom x0
function [x, info] = newton_raphson_custom_x0(f, fprime, x0, atol, maxit)
    xr = x0;
    info.flag = -1;
    for i = 1:maxit
        fx = f(xr); dfx = fprime(xr);
        if dfx == 0, x = xr; return; end
        xr_new = xr - fx / dfx;
        if abs(xr_new - xr) < atol
            x = xr_new; info.flag = 0; return;
        end
        xr = xr_new;
    end
    x = xr;
end