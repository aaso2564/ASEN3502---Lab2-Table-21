clear;
close all;

% Inital Condition

M1 = 3;

delta = 20;


mu = asind(1/M1);

figure;
hold on;

% Theta Intervals

theta = linspace(mu, 90, 1000);

% Function of Theta

f_theta = shock_residual(delta, theta, M1);
f_prime = shock_derivative(delta, theta, M1);


f_func = @(theta) shock_residual(delta, theta, M1);
f_func_prime = @(theta) shock_derivative(delta, theta, M1);




% Plots

x0 = incremental_search(f_func, f_func_prime , [0 100], .1, 100);
x1 = incremental_search(f_func, f_func_prime , [x0+1, 100], .1, 100);

plot(x0, 0, 'ro', 'MarkerFaceColor','auto', 'Marker','o')
plot(x1, 0, 'ro', 'MarkerFaceColor','auto', 'Marker','o')

text(x0, 0, sprintf('x = %g*', x0), 'VerticalAlignment', 'top')
text(x1, 0, sprintf('x = %g*', x1), 'VerticalAlignment', 'bottom')

x1 = Root_Finding_Secant_(f_func, f_func_prime , [30 50], .1, 100);
x2 = bisection(f_func, f_func_prime , [0 100], .1, 100);
x3 = newton_raphson(f_func, f_func_prime , [0 100], .1, 100);

plot(x0, 0, 'ro', 'MarkerFaceColor','auto')
text(x0, 0, 'Incrimental', 'VerticalAlignment', 'top')

plot(x1, 0, 'ro', 'MarkerFaceColor','auto')
text(x1, 0, 'Secant', 'VerticalAlignment', 'top')

plot(x2, 0, 'ro', 'MarkerFaceColor','auto')
text(x2, 0, 'Bisection', 'VerticalAlignment', 'top')

plot(x3, 0, 'ro', 'MarkerFaceColor','auto')
text(x3, 0, 'Newton Raphson', 'VerticalAlignment', 'top')

plot(theta, f_theta, 'r', 'LineWidth', 2)



grid on;

xlabel('Shock Angle for 20 Degrees')

ylabel('Function Angle, Residual')

title('Shock Angle over Theta')

legend('Incremental', 'Secant', 'Bisection', 'Newton Raphson');


hold off;