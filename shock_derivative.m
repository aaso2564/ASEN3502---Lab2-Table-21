function [shockDerivative] = shock_derivative(delta, theta, M)
    
    mu = asind(1/M);

    theta = mu:0.5:theta;
    
    N = ((M^2).*sind(2.*theta)) - (2.*cotd(theta));
    D = 2 + (M^2).*(1.4 + cosd(2.*theta));
    N_prime = (2*M^2).*cosd(2.*theta)+(2.*cscd(theta).^2);
    D_prime = (-2*M^2).*sind(2.*theta);

    shockDerivative = (D.*N_prime - N.*D_prime)./D.^2;

end