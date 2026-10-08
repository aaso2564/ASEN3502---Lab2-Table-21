function [J] = numjac(f, x, h)
    n = length(x);
    J = zeros(n);
    fx = f(x);
    
    for j = 1:n
        x_pert = x;
        x_pert(j) = x_pert(j) + h;
        J(:, j) = (f(x_pert) - fx) / h;
    end
end