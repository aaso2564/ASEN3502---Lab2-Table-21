function shockDerivative = shock_derivative(delta, theta, M)
    
    deg2rad = pi / 180;
    
    % Evaluate N and D
    N = (M^2 .* sind(2 .* theta)) - (2 .* cotd(theta));
    D = 2 + (M^2) .* (1.4 + cosd(2 .* theta));
    
    % Analytical derivatives w.r.t. theta in DEGREES
    N_prime = deg2rad * (2 * M^2 .* cosd(2 .* theta) + 2 .* cscd(theta).^2);
    D_prime = deg2rad * (-2 * M^2 .* sind(2 .* theta));
    
    % df/dtheta = - d/dtheta(N/D)
    shockDerivative = -(D .* N_prime - N .* D_prime) ./ (D .^ 2);
end