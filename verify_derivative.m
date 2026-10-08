% VERIFY_DERIVATIVE (Task 1.2)
clear; clc;

M = 3;
delta = deg2rad(20);                     % Wedge angle in radians
theta_vals = deg2rad([25, 45, 65, 80]); % Test shock angles in radians
h = 1e-6;                                % Step size for finite difference
atol = 1e-4;                             % Tolerance for derivative agreement

% Anonymous function handles
f = @(theta) shock_residual(delta, theta, M);
df_exact = @(theta) shock_derivative(delta, theta, M);

for theta = theta_vals
    % Analytical derivative
    df_analytical = df_exact(theta);
    
    % Central finite difference approximation
    df_fd = (f(theta + h) - f(theta - h)) / (2 * h);
    
    % Absolute error
    err = abs(df_analytical - df_fd);
    
    % Print values for debugging
    fprintf('theta = %5.1f deg | Analytical: %10.6f | Finite Diff: %10.6f | Err: %e\n', ...
        rad2deg(theta), df_analytical, df_fd, err);
    
    % Assert tolerance
    assert(err <= atol, 'Derivative failed at theta = %.2f deg', rad2deg(theta));
end

disp('Shock derivative verified successfully.')