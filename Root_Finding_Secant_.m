function [xr, info] = secant(f, fprime, interval, atol, maxit)
    % Extract bounds from interval
    xprev = interval(1);
    xr = interval(2);
    
    % Track status (0 = success, -1 = max iterations)
    info.flag = -1;
    
    for i = 1:maxit
        xrold = xr;
        
        % Evaluate function at current and previous estimates
        fxrold = f(xrold);
        fxprev = f(xprev);
        
        % Secant formula update
        xr = xrold - (fxrold * (xprev - xrold)) / (fxprev - fxrold);
        xprev = xrold;
        
        % Calculate percent relative error
        ea = abs((xr - xrold) / xr) * 100;
        
        info.iter = i;
        
        % Convergence check
        if ea < atol
            info.flag = 0;
            return
        end
    end
end