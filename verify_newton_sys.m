% verify_newton_sys

f = @(x) [x(1)^2+x(2)^2 - 4; x(2) - 3*x(1)];

J = @(x) [2*x(1), 2*x(2); -3, 1];


x0 = [0.5; 2];
atol = 10e-6;
maxit = 25;

[x, info] = newton_sys(f,J,x0,atol,maxit);

x_exact = [0.63246; 1.89737]; % citation: desmos lol


if norm(x - x_exact)<atol
    disp(x)
    disp('success!')
else 
    disp('fail')
end
