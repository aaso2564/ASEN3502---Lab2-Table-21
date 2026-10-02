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




figure; 

true = fzero(f_func, 20);

[~, info] = incremental_search(f_func, f_func_prime , [mu 45], .000001, 1000000);
x = (info.history.funcCount);
y = abs(info.history.x - true);
semilogx(x,y,'r', 'LineWidth', 2);

hold on;


[~, info] = bisection(f_func, f_func_prime , [mu 45], .000001, 1000000);
x = info.history.funcCount;
y = abs(info.history.x - true);
semilogx(x,y,'g', 'LineWidth', 2);

[~, info] = newton_raphson(f_func, f_func_prime , [mu 45], .000001, 1000000);
x = info.history.funcCount;
y = abs(info.history.x - true);
semilogx(x,y,'b', 'LineWidth', 2);

[~, info] = Root_Finding_Secant_(f_func, f_func_prime , [mu 45], .000001, 1000000);
x = info.history.funcCount;
y = abs(info.history.x - true);
semilogx(x,y,'y', 'LineWidth', 2);

grid on;
legend('Increment', 'Bisection', 'Newton Raphson', 'Secant')
title('Function Count vs Absolute Error for Each Method'); 
xlabel('Function Count'); ylabel('|x - x_{true}|');

hold off;