function shockDerivative = shock_derivative(delta, theta, M)
    gamma = 1.4;
    deg2rad_factor = pi / 180;
    
    N = (M^2 .* sind(2*theta)) - (2 .* cotd(theta));
    D = 2 + (M^2 .* (gamma + cosd(2*theta)));
    
    N_prime = deg2rad_factor * (2*M^2 .* cosd(2*theta) + 2 .* (cscd(theta)).^2);
    D_prime = deg2rad_factor * (-2*M^2 .* sind(2*theta));
    
    shockDerivative = (D .* N_prime - N .* D_prime) ./ (D.^2);
end