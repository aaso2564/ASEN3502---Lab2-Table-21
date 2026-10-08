function [J] = numjac(f, x, h)

    n = length(x);
    J = zeros(n);
    ident = eye(n);
    fx = f(x); % Evaluate f(x) once outside the loop for efficiency
    
    for j = 1:n
        ej = ident(:, j);
        J(:, j) = (f(x + h*ej) - fx) / h;
    end
end