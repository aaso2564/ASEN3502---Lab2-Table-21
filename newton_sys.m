function [x, info] = newton_sys(f, J, x0, atol, maxit)

    xr = x0;
    ea = 10e6; % intialize apprx error to a big number
    info.history.funcCount = [];
    cumFuncCall = 0;

    for i = 1:maxit
        x_old = xr;
        dx = gauss_pivot(J(x_old),-f(x_old));
        xr = x_old+dx;
        ea = norm(xr-x_old)/norm(xr) *100;
        
        cumFuncCall = cumFuncCall + 2; % updates total func calls to this point
        info.history.funcCount(i) = cumFuncCall; % appends the total cumulative func calls to this point to a new element in a vector contained within info struct

        if ea<atol
            x = xr;
            return
        end
    end

    if i == maxit
        disp('Did not converge')
    end

end

