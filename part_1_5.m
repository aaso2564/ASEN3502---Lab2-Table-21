clear;
close all;

% Inital Condition

M1 = 3;

delta = 20;


mu = asind(1/M1);

% Theta Intervals

theta = linspace(mu, 90, 1000);

% Function of Theta

f_theta = shock_residual(delta, theta, M1);
f_prime = shock_derivative(delta, theta, M1);


f_func = @(theta) shock_residual(delta, theta, M1);
f_func_prime = @(theta) shock_derivative(delta, theta, M1);



weak = incremental_search(f_func, f_func_prime , [mu 45], .000001, 1000000);
strong = incremental_search(f_func, f_func_prime , [weak+1, 90], .000001, 1000000);
fprintf('Incremental search: \n weak = %.3f\n strong = %.3f\n\n', weak, strong);

weak = bisection(f_func, f_func_prime , [mu 45], .000001, 1000000);
strong = bisection(f_func, f_func_prime , [weak+10, 90], .000001, 1000000);
fprintf('Bisection: \n weak = %.3f\n strong = %.3f\n\n', weak, strong);

weak = newton_raphson(f_func, f_func_prime , [mu 45], .000001, 1000000);
strong = newton_raphson(f_func, f_func_prime , [weak+10, 90], .000001, 1000000);
fprintf('Newton_Raphson: \n weak = %.3f\n strong = %.3f\n\n', weak, strong);

weak = Root_Finding_Secant_(f_func, f_func_prime , [mu 45], .000001, 1000000);
strong = Root_Finding_Secant_(f_func, f_func_prime , [weak+10, 90], .000001, 1000000);
fprintf('Secant: \n weak = %.3f\n strong = %.3f\n\n', weak, strong);
