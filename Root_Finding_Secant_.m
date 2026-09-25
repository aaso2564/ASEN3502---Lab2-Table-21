function [xr, info] = Root_Finding_Secant_(f, fprime, interval, atol, maxit)
    % Extract starting guesses from the provided interval
    x0 = interval(1); % First initial guess
    x1 = interval(2); % Second initial guess
    
    % Evaluate f at both initial points (counts as 2 function evaluations)
    func_evals = 2;
    f0 = f(x0);
    f1 = f(x1);
    
    % Initialize output struct
    info = struct();
    info.flag = -1; % Default flag: -1 means max iterations reached without convergence
    
    % Preallocate history vectors to store data for up to maxit iterations
    info.history.funcCount = zeros(maxit, 1); % Cumulative f and fprime calls
    info.history.x = zeros(maxit, 1);         % Best root estimate at each step
    
    for i = 1:maxit
        % Safeguard: Prevent division by zero if f(x1) == f(x0)
        if (f1 - f0) == 0
            info.flag = -2; % Flag -2 indicates slope is flat / zero division
            % Trim history vectors down to only the iterations completed so far
            info.history.funcCount = info.history.funcCount(1:i-1);
            info.history.x = info.history.x(1:i-1);
            info.iter = i - 1;
            info.fval = f1;
            return;
        end
        
        % Secant update formula: finds x-intercept of secant line through x0 and x1
        x2 = x1 - f1 * (x1 - x0) / (f1 - f0);
        
        % Evaluate function at the new estimate and increment function call counter
        f2 = f(x2);
        func_evals = func_evals + 1;
        
        % Save history metrics for this iteration step
        info.history.funcCount(i) = func_evals; % Total function evaluations used so far
        info.history.x(i) = x2;                 % Store current root estimate
        
        % Check convergence using absolute step size |x_new - x_old|
        if abs(x2 - x1) < atol
            xr = x2;        % Set final root output
            info.flag = 0;   % Flag 0 indicates successful convergence
            info.iter = i;   % Record total iterations performed
            info.fval = f2;  % Record residual value f(xr)
            
            % Trim unused trailing zeros from preallocated history vectors
            info.history.funcCount = info.history.funcCount(1:i);
            info.history.x = info.history.x(1:i);
            return;
        end
        
        % Shift points forward for the next iteration step: x0 <- x1, x1 <- x2
        x0 = x1;
        f0 = f1;
        x1 = x2;
        f1 = f2;
    end
    
    % Executed only if loop finishes all maxit steps without hitting atol
    xr = x1;
    info.iter = maxit;
    info.fval = f1;
end