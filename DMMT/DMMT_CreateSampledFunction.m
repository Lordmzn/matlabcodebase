function sampled_function_obj = DMMT_CreateSampledFunction(yNames, yData, xNames, xData, interpolator)
% 
%
% Emanuele Mason, 17 october 2014

% argument checking - very poor
if nargin < 5
    interpolator = 'none';
end

if length(yData) ~= length(yNames) || ...
        length(xData) ~= length(xNames)
    get mad
end
    
    
% build the structure

sampled_function_obj.Y = yNames;

sampled_function_obj.X = xNames;

sampled_function_obj.f = 'SampledFunction';

if ~strcmp(interpolator, 'none')
    sampled_function_obj.interpolator = interpolator;
end

sampled_function_obj.yData = cell2mat(yData);

sampled_function_obj.xData = xData;