function [x, info] = bisection(f, fprime, interval, atol, maxit)
    x_l = interval(1);
    x_u = interval(2);
    x_r = x_l;
    
    % Initialize info structure and history pre-allocations
    info = struct();
    info.flag = -1;
    info.history.funcCount = zeros(maxit, 1);
    info.history.x = zeros(maxit, 1);
    
    % Initial function calls at interval bound
    f_l = f(x_l);
    f_u = f(x_u);
    func_evals = 2;
    
    for i = 1:maxit
        x_1 = x_r;
        x_r = (x_u + x_l) / 2;
        
        % Evaluate function once per iteration
        f_r = f(x_r);
        func_evals = func_evals + 1;
        
        % Store history
        info.history.funcCount(i) = func_evals;
        info.history.x(i) = x_r;
        
        % Calculate percent relative error
        if x_r ~= 0
            error = abs((x_r - x_1) / x_r) * 100;
        else
            error = abs(x_r - x_1);
        end
        
        % Check convergence criteria
        if error <= atol || f_r == 0
            x = x_r;
            info.flag = 0;
            info.iter = i;
            info.fval = f_r;
            info.history.funcCount = info.history.funcCount(1:i);
            info.history.x = info.history.x(1:i);
            return;
        end
        
        % Update bracket bounds using stored evaluations
        if f_l * f_r < 0
            x_u = x_r;
            f_u = f_r;
        else
            x_l = x_r;
            f_l = f_r;
        end
    end
    
    % Return state if maxit is reached without fully converging
    x = x_r;
    info.iter = maxit;
    info.fval = f(x);
end