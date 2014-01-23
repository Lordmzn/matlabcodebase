function eff=computeEfficientSolution(M)
%
% eff=computeEfficientSolution(M)
%
% --------------------------------------------------------------------------
% Find Pareto-efficient solutions of the multi-criteria optimization problem
%
%    min y = f(z)
%
% where y = | y_1, y_2,..., y_q | and z belongs to the finite set
%       Z = { z_1, z_2, ..., z_N }
% --------------------------------------------------------------------------
%
% Input/Output
%
% M = double array of size (N,q)
%   = | y_1(z_1) y_2(z_1) ... y_q(z_1) |
%     | y_1(z_2) y_2(z_2) ... y_q(z_2) |
%     |                   ...          |
%     | y_1(z_N) y_2(z_N) ... y_q(z_N) |
%
% dom = logical array of size (N,1)
%     = | dom_1 |
%       | dom_2 |    dom_i=| 1 if z_i is [semi]dominated
%       |  ...  |          | 0 otherwise
%       | dom_N |
%
% --------------------------------------------------------------------------

eff = [];
[nData, nObj] = size(M);

if any([nData, nObj] <= 1)
    error('computeEfficientSolution:typeChk', 'input M must be a matrix');
    return
end
% exclude duplicate rows (i.e. solutions z_i providing the same objective
% values) 
[M2, i, j] = unique(M, 'rows');
[nData2, nObj]  = size(M2);

% for each obj tuple
for i = 1 : nData2
    Y = repmat(M2(i,:), nData2, 1);
    % check when each obj of the tuple is greater than each of the others
    D = [Y >= M2];
    % then sum that, so that I count how many obj each tuple (i) dominates
    d2(:, i) = sum(D, 2);
end

d2 = [d2 == nObj];
g2 = sum(d2);
eff2 = [g2 == 1]';

eff = eff2(j);
