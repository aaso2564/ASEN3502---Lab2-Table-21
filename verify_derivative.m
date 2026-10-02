clc;
clear;
close all;

% Initial Condition

M = 3.0;
gamma = 1.4;
mu = asind(1/M);

% Step size for finite difference
h = 1e-7;

% Test values for delta and theta (degrees converted to radians)
delta_test_deg = [10, 20, 30];
theta_test_deg = [25, 45, 65, 80];

fprintf('%-12s %-12s %-18s %-18s %-15s\n', 'delta (deg)', 'theta (deg)', 'Analytical', 'Finite Diff', 'Abs Error');
fprintf('%s\n', repmat('-', 1, 78));

for d_deg = delta_test_deg
    delta = deg2rad(d_deg);
    for t_deg = theta_test_deg
        theta = deg2rad(t_deg);
        
        if theta <= mu
            continue; % Ensure theta is above Mach angle
        end
        
        % Analytical derivative
        df_exact = shock_derivative(delta, theta, M);
        
        % Finite difference derivative
        f_curr = shock_residual(delta, theta, M);
        f_plus = shock_residual(delta, theta + h, M);
        df_fd   = (f_plus - f_curr) / h;
        
        % Absolute error
        err = abs(df_exact - df_fd);
        
        fprintf('%-12.1f %-12.1f %-18.10f %-18.10f %-15.4e\n', ...
            d_deg, t_deg, df_exact, df_fd, err);
    end
end