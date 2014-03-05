function [] = plotParetoFront(data, opt)
% plotParetoFront(data, opt)
%
% Plot a pareto front
%
% EM, 23 jan 2014

% extract obj
objs = data(:, opt.indexesObj);

if opt.onlyParetoDominant

    paretoEfficiency = computeEfficientSolution(objs);
    dataToPlot = data(paretoEfficiency, :);
    
else
    dataToPlot = data;
end
    
% 2D case
if (length(opt.indexesObj) == 2)
    
    plot(dataToPlot(:, opt.indexesObj(1)), ...
        dataToPlot(:, opt.indexesObj(2)), ...
        opt.plotOptions, 'markersize', opt.markSize);
    
    xlabel(opt.legend.x);
    ylabel(opt.legend.y);
    
else
    % 3D case
    plot3(dataToPlot(:, opt.indexesObj(1)), ...
        dataToPlot(:, opt.indexesObj(2)), ...
        dataToPlot(:, opt.indexesObj(3)), ...
        opt.plotOptions, 'markersize', opt.markSize);
    
    xlabel(opt.legend.x);
    ylabel(opt.legend.y);
    zlabel(opt.legend.z);
    
end