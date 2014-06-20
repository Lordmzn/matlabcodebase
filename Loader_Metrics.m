function [stuff, column_headers] = Loader_Metrics(prefix, idxs, postfix)
% Loads multiple simulation files using importdata matlab built-in.
%
% EM, 6 6 2014

delimiter = ' ';
startRow = 2;
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f';

for i=1:length(idxs)
    full_name = [prefix int2str(idxs(i)) postfix];
    fileID = fopen(full_name,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, ...
        'MultipleDelimsAsOne', true, 'HeaderLines' ,startRow-1, ...
        'ReturnOnError', false);
    fclose(fileID);
    stuff{i} = cell2mat(dataArray);
end
column_headers = {'NFE', 'SBX', 'DE', 'PCX', 'SPX', 'UNDX', 'UM', ...
    'Improvements', 'Restarts', 'PopulationSize', 'ArchiveSize', ...
    'Hypervolume', 'GenerationalDistance', 'ArchiveEIndicator'};