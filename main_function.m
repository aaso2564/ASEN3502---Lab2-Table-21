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




% Plots
x0 = fzero(f_theta1,1);

plot(theta,f_theta1, 'r', 'LineWidth', 2)

text(x0, 0, '  Zero', 'VerticalAlignment', 'bottom')

plot(theta,f_theta2, 'b', 'LineWidth', 2)

plot(theta,f_theta3, 'g', 'LineWidth', 2)

plot(theta,f_theta4, 'y', 'LineWidth', 2)

grid on;

xlabel('Shock Angle in Degrees')

ylabel('Function Angle, Residual')

title('Shock Angle over Theta')

legend('10°', '20°', '30°', '40°');


hold off;