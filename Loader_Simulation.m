function [stuff, column_headers] = Loader_Simulation(prefix, idxs, postfix)
% Loads multiple simulation files using importdata matlab built-in.
%
% EM, 6 6 2014

for i=1:length(idxs)
    full_name = [prefix int2str(idxs(i)) postfix];
    data = importdata(full_name);
    stuff{i} = data.data;
end
column_headers = data.colheaders;