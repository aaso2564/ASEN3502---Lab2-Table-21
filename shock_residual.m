function residual = shock_residual(delta, theta, M)

gamma = 1.4;

numerator = M^2 * sind(2*theta) - 2*cotd(theta);
denominator = 2+(M^2 * (gamma + cosd(2*theta)));
    
    residual = - tand(delta) + (numerator ./ denominator);

end