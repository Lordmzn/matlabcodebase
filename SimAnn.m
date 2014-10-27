function y = SimAnn(M,n,theta,n_type)
% y = SimAnn(M,n,theta,n_type)
% evaluates ANN given parameter values
% y = a + sum( b * n_type(c * M + d) )
% inputs
% M - matrix of data to evaluate; 
%      [r,N] = size(M); r = # of input, N = # of data
% n - scalar number of neurons;
% theta - matrix of parameters, each column defining k-th output
%       theta(1:n,k)        -> d parameters
%       theta(n+1,k)        -> a parameter
%       theta(n+1:2n+1,k)   -> b parameters
%       theta(2n+2:end,k)   -> c parameters
%       theta(2n+2:2n+r+1,k) -> c parameters for first neuron
% n_type - string representing the activation function of hidden_layer
%
% Emanuele Mason, 25 oct 2013
% based on Someone Else. Thank you Someone!
    
if (length(size(theta)) ~= 2)
    warning('ANN:wrongParameters', 'Theta must be a matrix');
end

[r,N] = size(M); % r = # of input, N = # of data

y_temp = zeros(n, N);
y = zeros(size(theta,2), N); % n_outputs * n_data
for k = 1:size(theta, 2)
    b1 = theta(1:n, k) ; % (n,1) n is ~ of neuron
    i  = n+1 ;
    b2 = theta(i, k)   ; % (1,1)
    i  = i+1 ;
    LW = theta(i:i+n-1, k) ;
    LW = LW'        ; % (1,n)
    i  = i+n;
    IW = theta(i:i+n*r-1, k) ;
    IW = reshape( IW, n, r ) ; % (n,r)
    % compute the network output:
    % n_type is activation fuction (e.g. 'tansig')
    y_temp = feval(n_type, IW * M + repmat(b1, 1, N) ) ;
    y(k, :) = feval('purelin', LW * y_temp + repmat(b2, 1, N) ) ; 
end