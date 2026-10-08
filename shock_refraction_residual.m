function [zero_vector] = shock_refraction_residual(phi, thetaC, thetaD, M2, M3, deltaA, deltaB, p2p1, p3p1)
    gamma = 1.4;
    
    % Shock angle relations
    a = ((M2^2)*sin(2*thetaC) - 2*cot(thetaC)) / (2 + M2^2*(gamma + cos(2*thetaC))) - tan(deltaA - phi);
    b = ((M3^2)*sin(2*thetaD) - 2*cot(thetaD)) / (2 + M3^2*(gamma + cos(2*thetaD))) - tan(deltaB + phi);
    
    % Pressure ratio relations across refracted shocks
    p4p2 = 1 + (2*gamma/(gamma+1)) * (M2^2 * sin(thetaC)^2 - 1);
    p4primep3 = 1 + (2*gamma/(gamma+1)) * (M3^2 * sin(thetaD)^2 - 1);
    
    % Pressure continuity across slip line (p4 = p4')
    c = (p2p1 * p4p2) - (p3p1 * p4primep3);
    
    %returns a three element vector of zeroes if the eqns are satisfied

    zero_vector = [a; b; c];
end