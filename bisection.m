function [x, info] = bisection(f, fprime, interval, atol, maxit)

x_l=interval(1);
x_u=interval(2);

x_r=interval(1);

error = 100;

while error > atol

    x_1=x_r;

    x_r = (x_u + x_l)/2;

    if f(x_l)*f(x_r)<0
        x_u = x_r;

    elseif f(x_l)*f(x_r)>0
        x_l=x_r;
    else 
        x=x_r;
    
        return
    end

error = abs((x_r-x_1)/x_r)*100;

end

info=struct();

x=x_r;
