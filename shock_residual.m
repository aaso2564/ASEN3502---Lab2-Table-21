function residual = shock_residual(delta, theta, M)

% Inital Conditions
gamma = 1.4;

numerator = M^2 * sin(2*theta) - 2*cot(theta);
denominator = 2+(M^2 * (gamma + cos(2*theta)));
    
    residual = - tand(delta) + (numerator ./ denominator);

end
