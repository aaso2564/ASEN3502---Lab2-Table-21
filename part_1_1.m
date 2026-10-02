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

f_theta1 = @(theta) shock_residual(delta1, theta, M1);

f_theta2 = @(theta) shock_residual(delta2, theta, M1);

f_theta3 = @(theta) shock_residual(delta3, theta, M1);

f_theta4 = @(theta) shock_residual(delta4, theta, M1);


% Plots
weak1 = fzero(f_theta1,mu+1);
weak2 = fzero(f_theta2,mu+1);
weak3 = fzero(f_theta3,40);

strong1 = fzero(f_theta1,80);
strong2 = fzero(f_theta2,80);
strong3 = fzero(f_theta3,80);

plot(theta, f_theta1(theta), 'r', 'LineWidth', 2)

plot(weak1,0,'ro','MarkerEdgeColor','red','MarkerFaceColor','red','MarkerSize',8);
plot(weak2,0,'ro','MarkerEdgeColor','blue','MarkerFaceColor','blue','MarkerSize',8);
plot(weak3,0,'ro','MarkerEdgeColor','green','MarkerFaceColor','green','MarkerSize',8);

plot(strong1,0,'ro','MarkerEdgeColor','red','MarkerFaceColor','red','MarkerSize',8);
plot(strong2,0,'ro','MarkerEdgeColor','blue','MarkerFaceColor','blue','MarkerSize',8);
plot(strong3,0,'ro','MarkerEdgeColor','green','MarkerFaceColor','green','MarkerSize',8);

text(strong1+0.05,0+0.05, sprintf('%.2f', strong1),'Color','red');
text(strong2-1,0.05, sprintf('%.2f', strong2),'Color','blue');
text(strong3+0.05,0+0.05, sprintf('%.2f', strong3),'Color','green');

text(weak1-2,0+0.05, sprintf('%.2f', weak1),'Color','red');
text(weak2-2,0+0.05, sprintf('%.2f', weak2),'Color','blue');
text(weak3-2,0+0.05, sprintf('%.2f', weak3),'Color','green');


plot(theta,f_theta2(theta), 'b', 'LineWidth', 2)

plot(theta,f_theta3(theta), 'g', 'LineWidth', 2)

plot(theta,f_theta4(theta), 'y', 'LineWidth', 2)

grid on;

xlabel('Shock Angle in Degrees')

ylabel('Function Angle, Residual')

title('Shock Angle over Theta')

legend('10°', '20°', '30°', '40°');


hold off;