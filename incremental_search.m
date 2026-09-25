function [x, info] = incremental_search(f, fprime, interval, atol, maxit) %Aarons function

arguments
    f function_handle
    fprime function_handle
    interval (1, 2) double
    atol (1, 1) double {mustBePositive}
    maxit (1, 1) double {mustBeInteger, mustBePositive}
end


for i = (interval(1):atol:interval(2))
    x = i + atol;
    if f(i) * f(x) <= 0 
        info = struct("iterations", i, "converged", true);
        return
    end
end