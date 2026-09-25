function [xr, info] = secant(f, fprime, interval, atol, maxit)
    
    info = struct();
    info.flag = -1;
    
    % Extract initial points
    xprev = interval(1);
    xr = interval(2);
    
    % Initial function evaluations
    fxprev = f(xprev);
    fxr = f(xr);
    
    for i = 1:maxit
        diff_f = fxr - fxprev;
        
        % Prevent division by zero
        if diff_f == 0
            info.flag = -2; % Derivative approximation is zero
            info.iter = i - 1;
            info.fval = fxr;
            return;
        end
        
        % Secant step calculation
        step = (fxr * (xr - xprev)) / diff_f;
        xnew = xr - step;
        
        % Check convergence using absolute step size
        if abs(xnew - xr) < atol
            xr = xnew;
            info.flag = 0; % Success
            info.iter = i;
            info.fval = f(xr);
            return;
        end
        
        % Update state for next iteration
        xprev = xr;
        fxprev = fxr;
        xr = xnew;
        fxr = f(xr);
    end
    
    info.iter = maxit;
    info.fval = fxr;
end