function [x, info] = newton_raphson(f, fprime, interval, atol, maxit)
    % Set initial guess to the midpoint of interval

        xr = (interval(1) + interval(2)) / 2; 
    
    info = struct();
    info.flag = -1;
    info.history.funcCount = zeros(maxit, 1);
    info.history.x = zeros(maxit, 1);
    
    func_evals = 0;
    
    for i = 1:maxit
        fx = f(xr);
        dfx = fprime(xr);
        
        % Ensure fx and dfx are strictly scalars
        fx = fx(1);
        dfx = dfx(1);
        
        func_evals = func_evals + 2;
        
        % Safeguard against zero derivative
        if dfx == 0
            info.flag = -2;
            info.iter = i - 1;
            info.fval = fx;
            info.history.funcCount = info.history.funcCount(1:i-1);
            info.history.x = info.history.x(1:i-1);
            x = xr;
            return;
        end
        
        % Calculate new estimate as a scalar
        xr_new = xr - (fx / dfx);
        xr_new = xr_new(1); % Enforce scalar output
        
        % Store history
        info.history.funcCount(i) = func_evals;
        info.history.x(i) = xr_new;
        
        % Check absolute step convergence
        if abs(xr_new - xr) < atol
            x = xr_new;
            info.flag = 0;
            info.iter = i;
            info.fval = f(x);
            info.history.funcCount = info.history.funcCount(1:i);
            info.history.x = info.history.x(1:i);
            return;
        end
        
        xr = xr_new;
    end
    
    x = xr;
    info.iter = maxit;
    info.fval = f(x);
end