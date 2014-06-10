function [] = PlotParetoFront_Scatter(referenceSet, columns, opt)
% PlotParetoFront_Scatter(referenceSet, columns, opt)
%
% Plot a pareto front
%
% EM, 23 jan 2014

% extract obj
data = referenceSet;
objs = data(:, columns);
    
% 2D case
if (length(columns) == 2)
    
    if isfield(opt, 'onlyParetoDominant') && opt.onlyParetoDominant
        
        paretoEfficiency = ComputeEfficientSolution(objs);
        dataToPlot = data(paretoEfficiency, :);
        
    else
        dataToPlot = data;
    end
    
    scatter(dataToPlot(:, columns), 30, 'full');
    set(gca, 'FontSize', 18);
    
    if isfield(opt, 'labels')
        xlabel(opt.labels.axes{1}, 'FontSize', 18);
        ylabel(opt.labels.axes{2}, 'FontSize', 18);
    end
    
else
    
    if isfield(opt, 'onlyParetoDominant') && opt.onlyParetoDominant
        
        paretoEfficiency = ComputeEfficientSolution(objs);
        dataToPlot = data(paretoEfficiency, :);
        
        paretoEfficiency_1vs2 = ComputeEfficientSolution(objs(:,1:2));
        dataToPlot12 = data(paretoEfficiency_1vs2, :);
        
        paretoEfficiency_1vs3 = ComputeEfficientSolution(objs(:,1:3));
        dataToPlot13 = data(paretoEfficiency_1vs3, :);
        
        paretoEfficiency_2vs3 = ComputeEfficientSolution(objs(:,2:3));
        dataToPlot23 = data(paretoEfficiency_2vs3, :);
        
    else
        
        dataToPlot = data;
        dataToPlot12 = data;
        dataToPlot13 = data;
        dataToPlot23 = data;
        
    end
    
    % 3D case
    figure; subplot(2,2,1);
    scatter3(dataToPlot(:, columns(1)), dataToPlot(:, columns(2)), ...
        dataToPlot(:, columns(3)), 30, 'full');
    set(gca, 'FontSize', 18);
        
    if isfield(opt, 'labels')
        xlabel(opt.labels.axes{1}, 'FontSize', 18);
        ylabel(opt.labels.axes{2}, 'FontSize', 18);
        zlabel(opt.labels.axes{3}, 'FontSize', 18);
    end
    
    subplot(2,2,2);
    scatter(dataToPlot12(:, columns(1)), dataToPlot12(:, columns(2)), 30, 'full');
    set(gca, 'FontSize', 18);
        
    if isfield(opt, 'labels')
        xlabel(opt.labels.axes{1}, 'FontSize', 18);
        ylabel(opt.labels.axes{2}, 'FontSize', 18);
    end
    
    subplot(2,2,3);
    scatter(dataToPlot13(:, columns(1)), dataToPlot13(:, columns(3)), 30, 'full');
    set(gca, 'FontSize', 18);
        
    if isfield(opt, 'labels')
        xlabel(opt.labels.axes{1}, 'FontSize', 18);
        ylabel(opt.labels.axes{3}, 'FontSize', 18);
    end
    
    subplot(2,2,4);
    scatter(dataToPlot23(:, columns(2)), dataToPlot23(:, columns(3)), 30, 'full');
    set(gca, 'FontSize', 18);
    
    if isfield(opt, 'labels')
        xlabel(opt.labels.axes{2}, 'FontSize', 18);
        ylabel(opt.labels.axes{3}, 'FontSize', 18);
    end
    
end