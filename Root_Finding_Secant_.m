function [xr, info] = secant(f, fprime, interval, atol, maxit)
    % Initialize x0 and x1 from interval
    x0 = interval(1);
    x1 = interval(2);
    
    % Default output info assuming non-convergence
    info = struct('flag', -1, 'iter', maxit, 'fval', f(x1));
    
    for i = 1:maxit
        f0 = f(x0);
        f1 = f(x1);
        
        % Secant formula
        x2 = x1 - f1 * (x1 - x0) / (f1 - f0);
        
        
        % Check if step size is within absolute tolerance
        if abs(x2 - x1) < atol
            xr = x2;
            info.flag = 0; % Success
            info.iter = i;
            info.fval = f(xr);
            return;
        end
        
        % Advance variables for next step
        x0 = x1;
        x1 = x2;
    end
    
    xr = x1;
end