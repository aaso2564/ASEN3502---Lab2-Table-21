function [x, info] = newton_sys(f, J, x0, atol, maxit)
    xr = x0;
    n = length(x0);
    info.history.funcCount = [];
    info.history.x = [];
    cumFuncCall = 0;
    
    for i = 1:maxit
        fx = f(xr);
        Jx = J(xr);
        
        cumFuncCall = cumFuncCall + 1 + (n + 1);
        
        dx = gauss_pivot(Jx, -fx);
        xr = xr + dx;
        
        info.history.funcCount(i) = cumFuncCall;
        info.history.x(:, i) = xr;
        
        if norm(dx) < atol
            x = xr;
            return;
        end
    end
    
    x = xr;
    disp('Did not converge within maxit');
end