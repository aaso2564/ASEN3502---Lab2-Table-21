function [xr, info] = secant(f, fprime, interval, atol, maxit)
    xprev = interval(1);
    xr = interval(2);
    
    % Initialize info structure and history
    info = struct();
    info.flag = -1;
    info.history.funcCount = zeros(maxit, 1);
    info.history.x = zeros(maxit, 1);
    
    for i = 1:maxit
        xrold = xr;
        
        fxrold = f(xrold);
        fxprev = f(xprev);
        
        % Secant update
        xr = xrold - (fxrold * (xprev - xrold)) / (fxprev - fxrold);
        xprev = xrold;
        
        % Store history
        info.history.funcCount(i) = 2 * i;
        info.history.x(i) = xr;
        
        ea = abs((xr - xrold) / xr) * 100;
        info.iter = i;
        
        if ea < atol
            info.flag = 0;
            % Truncate history arrays to actual iterations run
            info.history.funcCount = info.history.funcCount(1:i);
            info.history.x = info.history.x(1:i);
            return
        end
    end
    
    % Truncate if loop finishes at maxit
    info.history.funcCount = info.history.funcCount(1:i);
    info.history.x = info.history.x(1:i);
end