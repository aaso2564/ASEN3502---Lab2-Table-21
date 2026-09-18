function [x, info] = incremental_search(f, fprime, interval, atol, maxit); %Aarons function

arguments
    f function_handle
    fprime function_handle
    interval (1, 2) double
    atol (1, 1) double {mustBePositive}
    maxit (1, 1) double {mustBeInteger, mustBePositive}
end

for i = 0:interval
    x = interval(1) + i * (interval(2) - interval(1)) / maxit;
    if abs(f(x)) <= atol || abs(fprime(x)) <= atol
        info = struct("iterations", i, "converged", true);
        return
    end

end