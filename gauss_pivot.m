%gauss_pivot

function x = gauss_pivot(A,b)

    %% Initialize
    n = length(b); %set number of iterations to the length of row vector b
    aug = [A,b]; %create augmented matrix to use for Gauss elim
    
    %% Forward Elimination
    
    for c = 1:n % increments through # of columns
        %% Partial Pivoting
        [best, r] = max(abs(aug(c:n,c)));
        check = r+c-1;
        if check ~= c
            aug([c,check],:) = aug([check,c],:);
        end
            
        for r = (c+1):n % increments through rows, starting at row 2
            f = aug(r,c)./aug(c,c); % finds elimination factor
            aug(r,c:(size(aug,2))) = aug(r, c:(size(aug,2))) - f*aug(c,c:(size(aug,2)));
        end
    end
    
    %% Back Substitution
    
    x = zeros(n,1); % generates an empty vector of the same size as b
    x(n) = aug(n,size(aug,2))/aug(n,n); % solves for our nth variable
    
    for j = n-1:-1:1
        bj = aug(j, size(aug,2)); % takes current b value that we are using to solve for the corresponding x
        x(j) = ((bj -  ( aug( j,( j+1 ):n )*( x( (j+1):n) ) ) )/aug(j,j) ); % algebraic procedure to solve for x value
    end

end