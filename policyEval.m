function u = policyEval(pol, parameters, inputs)
% help: DIY
%
% EM, 26 feb 2014

n_in = length(inputs.mins); 

% put together input points
n_combinations = 1;
for i=1:n_in
    n_combinations = n_combinations * ... 
        (inputs.maxs(i)-inputs.maxs(i))/inputs.step(i);
    input_helper(i).data = inputs.mins(i):inputs.step(i):inputs.maxs(i);
end

input_values = zeros(n_in, n_combinations);
idx_in = 1:n_in;
for j=1:n_combinations
    for i=1:n_in
        input_values(i,j)=input_helper(i).data(idx(i));
    end
    TODOTODOTODO update the damn idx 
end

switch pol.type
    case 'GaussianRBF'
        u =SimGaussianRBF(input_values, pol.n_func, pol.n_out, parameters);
        
    otherwise
        error('policyEval:wrongType', 'Wrong policy type specifier');

end