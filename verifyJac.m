
%We are using the provided f matrix and x vector

x1=2;
x2=3;
x= [x1;
    x2];

f= @(x)[x(1)^2*x(2)-1;
    x(1)+x(2)^3-1];

n=size(f,1);

numjac(f,x, 0.0000000000001)


J1 = [2*x1*x2, x1^2;
    1, 3*x2^2];

J = numjac(f,x, 0.0000000000001);

for i = 1:n
    for j=1:n
        if abs(J1(i,j)-J(i,j))>0.1
            disp("Verification failed")
            return 
        end
    end
end

disp("Verification Success")
return 

