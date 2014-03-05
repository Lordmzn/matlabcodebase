function y = SimGaussianRBF(M, n_func, n_out, theta)
% y = SimGaussianRBF(M, n_func, n_out, theta)
% evaluates Gaussian RBF given parameter values
% y = sum( w * BF(M) )
% BF(M) = exp( - sum( (M - c)^2 / b^2 ) )
% inputs
% M - matrix of data to evaluate; 
%      [r,N] = size(M); r = # of input, N = # of data
% n_func - scalar number of functions;
% n_out - scalar number of outputs;
% theta - matrix of parameters; each column is a basis function:
%       [c11 b11 ... c1r b1r w1 ... wk ]'
%           i.e. centers and radiuses coordinates of 1st funct + weights
%
% Emanuele Mason, 2 jan 2014

% get parameters
[n_in, N] = size(M); % n_in = # of input, N = # of data
n_par = size(theta);
if (n_par(2) ~= (2 * n_in + n_out) * n_func)
    warning('ANN:wrongParameters', 'Theta wrong number');
end

c = zeros(n_in, n_func);
b = zeros(n_in, n_func);
w = zeros(n_out, n_func);
idx_th = 1;
for j = 1:n_func
    for i = 1:n_in
        c(i, j) = theta(idx_th);
        idx_th = idx_th + 1;
        b(i, j) = theta(idx_th);
        idx_th = idx_th + 1;
    end
    if n_out == 1
        w(j) = theta(idx_th);
    else
        w(j,:) = theta(idx_th:idx_th + n_out);
    end
    idx_th = idx_th + n_out;
end

% scale weights so that they are between 0 and 1
w_sums = sum(w, 2);
w = w ./ repmat(w_sums, size(w));

% make space for stuff
y = zeros(n_out, N); % n_outputs * n_data
BF_values = zeros(n_func, N); % guess what? -.-"

% eval function values
for i = 1:n_func
    BF_values(i, :) = exp ( - sum( (M - repmat(c(:, i), 1, N)).^2 ./ ...
        repmat(b(:, i), 1, N).^2 , 1) );
end

% eval outputs
y = w * BF_values;