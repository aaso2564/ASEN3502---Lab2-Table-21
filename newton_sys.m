function [x, info] = newton_sys(f, J, x0, atol, maxit)
    xr = x0;
    n = length(x0);
    info.history.funcCount = [];
    info.history.x = [];
    cumFuncCall = 0;
    
    for i = 1:maxit
        fx = f(xr);
        Jx = J(xr);
        
        cumFuncCall = cumFuncCall + 1 + (n + 1); % updates total func calls to this point
        
        dx = gauss_pivot(Jx, -fx);
        xr = xr + dx;
        
        info.history.funcCount(i) = cumFuncCall; % appends the total cumulative func calls to this point to a new element in a vector contained within info struct
        info.history.x(:, i) = xr;
        
        % Check absolute tolerance on step magnitude or residual norm
        if norm(dx) < atol
            x = xr;
            return;
        end
    end
    
    x = xr;
    disp('Did not converge within maxit');
end