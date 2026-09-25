clc;
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


f_func = @(theta) shock_residual(delta, theta, M1);




% Plots

x0 = incremental_search(f_func, @x , [0 100], .1, 100);
x1 = Root_Finding_Secant_(f_func, @x , [30 50], .1, 100);
x2 = bisection(f_func, @x , [30 50], .1, 100);
x3 = newton_raphson(f_func, @x , [30 50], .1, 100);

plot(x0, 0, 'ro', 'MarkerFaceColor','auto')
text(x0, 0, '  Root1', 'VerticalAlignment', 'top')

plot(x1, 0, 'ro', 'MarkerFaceColor','auto')
text(x1, 0, '  Root2', 'VerticalAlignment', 'top')

plot(x2, 0, 'ro', 'MarkerFaceColor','auto')
text(x2, 0, '  Root3', 'VerticalAlignment', 'top')

plot(x3, 0, 'ro', 'MarkerFaceColor','auto')
text(x3, 0, '  Root4', 'VerticalAlignment', 'top')

plot(theta, f_theta, 'r', 'LineWidth', 2)



grid on;

xlabel('Shock Angle for 20 Degrees')

ylabel('Function Angle, Residual')

title('Shock Angle over Theta')

legend('Incremental', 'Secant');


hold off;