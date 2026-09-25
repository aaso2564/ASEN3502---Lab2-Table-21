function [x, info] = newton_raphson(f, fprime, interval, atol, maxit)

    xr = (interval(2)-interval(1))/2;

    for i = 1:maxit
        xr_old = xr;
        xr = xr_old - (f(xr_old)/fprime(xr_old));
        epsilon = abs((xr - xr_old)/xr)*100;

        if epsilon < atol
            break;
        end
    end

    x = xr;
    info = struct();

end