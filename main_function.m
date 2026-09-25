clc;
clear;
close all;

% Inital Condition

M1 = 3;

delta1 = 10;
delta2 = 20;
delta3 = 30;
delta4 = 40;

mu = asind(1/M1);

figure;
hold on;

% Theta Intervals

theta = linspace(mu, 90, 1000);

% Function of Theta

f_theta1 = shock_residual(delta1, theta, M1);

f_theta2 = shock_residual(delta2, theta, M1);

f_theta3 = shock_residual(delta3, theta, M1);

f_theta4 = shock_residual(delta4, theta, M1);

% Find root using a function handle and a valid initial guess
f_func2 = @(theta) shock_residual(delta2, th, M1);
x0_2 = Root_Finding_Secant_(f_theta2, 0, [30, 50], 0.0001, 100);

% Find roots for the remaining deflection angles if need be
% f_func1 = @(theta) shock_residual(delta1, th, M1);
% f_func3 = @(theta) shock_residual(delta3, th, M1);
% f_func4 = @(theta) shock_residual(delta4, th, M1);



% Plots

plot(theta,f_theta1, 'r', 'LineWidth', 2)

plot(theta,f_theta2, 'b', 'LineWidth', 2)

plot(theta,f_theta3, 'g', 'LineWidth', 2)

plot(theta,f_theta4, 'y', 'LineWidth', 2)

grid on;

xlabel('Shock Angle in Degrees')

ylabel('Function Angle, Residual')

title('Shock Angle over Theta')

% Mark the zero on the plot
plot(x0_2, 0, 'ro', 'MarkerFaceColor', 'k');

text(x0_2, 0, sprintf('  x0 = %.2f°', x0_2), 'VerticalAlignment', 'bottom')

legend('10°', '20°', '30°', '40°', 'Root for 20 Degrees');

hold off;