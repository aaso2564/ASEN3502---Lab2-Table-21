function [x, info] = newton_raphson(f, fprime, init_val, atol, maxit)
    % Accept either a 2-element interval [a, b] OR a scalar initial guess x0
    if numel(init_val) == 1
        xr = init_val;
    else
        xr = (init_val(1) + init_val(2)) / 2;
    end
    
    info = struct();
    info.flag = -1;
    info.history.funcCount = zeros(maxit, 1);
    info.history.x = zeros(maxit, 1);
    
    func_evals = 0;
    
    for i = 1:maxit
        fx = f(xr);
        dfx = fprime(xr);
        
        fx = fx(1);
        dfx = dfx(1);
        
        func_evals = func_evals + 2;
        
        % Safeguard against zero derivative or NaNs
        if dfx == 0 || isnan(dfx) || isnan(fx)
            info.flag = -2;
            info.iter = i - 1;
            info.fval = fx;
            info.history.funcCount = info.history.funcCount(1:max(1, i-1));
            info.history.x = info.history.x(1:max(1, i-1));
            x = xr;
            return;
        end
        
        xr_new = xr - (fx / dfx);
        xr_new = xr_new(1);
        
        info.history.funcCount(i) = func_evals;
        info.history.x(i) = xr_new;
        
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