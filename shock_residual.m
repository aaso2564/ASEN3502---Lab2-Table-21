function shock_residual(delta, theta, M)

gamma = 1.4;

mu = asind(1/M);

   if mu <= theta && theta <= 90
        shock_residual = NaN; 
        return;
    end

shock_residual = tand(delta) - (M.^2 * sind(2*theta) - 2*cotd(theta)) / (2+(M.^2 * (gamma + cosd(2*theta))));


end