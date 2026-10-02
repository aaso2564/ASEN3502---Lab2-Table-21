function [zero_vector] = shock_refraction_residual(phi, thetaC, thetaD, M2, M3, deltaA, deltaB, p2p1, p3p1)

    a = ((M2^2)*sind(2*thetaC) - (2*cotd(thetaC)))/(2+((M2^2)*(1.4+cosd(2*thetaC)))) - (tand(deltaA - phi));
    b = ((M3^2)*sind(2*thetaD) - (2*cotd(thetaD)))/(2+((M3^2)*(1.4+cosd(2*thetaD)))) - (tand(deltaB + phi));
    
    p4p2 = ((2*1.4*M2^2)*(sind(thetaC)^2) - (1.4-1))/(1.4+1);
    p4primep3 = ((2*1.4*M3^2)*(sind(thetaD)^2) - (1.4-1))/(1.4+1);
    
    c = (p2p1*p4p2) - (p3p1*p4primep3);

    %returns a three element vector of zeroes if the eqns are satisfied
    
    zero_vector = [a;b;c];

end


