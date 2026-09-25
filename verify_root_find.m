% Starter code for the root-finder verification script (Task 1.4).
% Fill in every TODO. Running this script should print "All root finders
% verified." if every solver works, or stop with an error at the first
% solver that fails.

% Call the test once for each solver your team implemented, e.g.
% test_root_find(@bisection). The @ makes a handle to the function so it can
% be passed as an argument.

<<<<<<< HEAD
test_root_find(@Root_Finding_Secant_)
% TODO: add a call for each of your other solvers
=======
%test_root_find(@bisection)
%test_root_find(@newton_raphson)

% TODO: add a call for each of your other solvers
test_root_find(@incremental_search)


>>>>>>> 65004de41004dddae7b1b4cd344ee6ee0300bbc4

disp('All root finders verified.')

% A subfunction: defined at the bottom of the script and only callable from
% this script.
function test_root_find(solver)
    % Choose a test function whose root you know exactly.
<<<<<<< HEAD
    f = @(x) x.^2 - 4;             % TODO
    fprime = @(x) 2.*x;        % TODO
    interval = [1 3];       % TODO
    atol = 1e-6;
    true_root = 2;
=======
    f = @(x) x^2 - 1;             % TODO
    fprime = @(x) 2*x;        % TODO
    interval = [0 3];       % TODO
    atol = 1e-6;
>>>>>>> 65004de41004dddae7b1b4cd344ee6ee0300bbc4
    maxit = 100;

    % solver is a function handle, so it can be called like any function
    x = solver(f, fprime, interval, atol, maxit);

    % TODO: compute the error between x and the true root, and use assert
<<<<<<< HEAD
    % to raise an error if it is larger than atol. func2str(solver) gives
    % the solver's name for the error message.
    error_in_x = abs(x-true_root);
=======
  
    % to raise an error if it is larger than atol. func2str(solver) gives
    % the solver's name for the error message.
    error_in_x = abs(x - 1); %root = 1
>>>>>>> 65004de41004dddae7b1b4cd344ee6ee0300bbc4
    assert(error_in_x <= atol, '%s failed', func2str(solver))
end
