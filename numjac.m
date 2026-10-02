function [J] = numjac(f,x,h)

n = length(x);
J = zeros(n);
ident=eye(n);

for j = 1:n
        ej= ident(:,j);
        J(:,j) = (f(x+h*ej)-f(x))/h;
end

end
