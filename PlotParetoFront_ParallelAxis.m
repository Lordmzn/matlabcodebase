function [] = PlotParetoFront_ParallelAxis(referenceSet, columns, opt)
% PlotParetoFront_Axis(referenceSet, columns, opt)
%
% Plot a pareto front
%
% EM, 23 jan 2014

% extract obj
if nargin < 2
    error('Too few parameters');
    return
end

if nargin < 3
    opt = [];
end

data = referenceSet;
objs = data(:, columns);
    
m = min( objs ); 
M = max( objs );

Z = ( objs - repmat( m, size( objs,1 ),1 ) ) ./ ...
    ( repmat( M, size( objs,1 ),1 ) - repmat( m, size( objs,1 ),1 ) );

% sorting
Y = Z ;
if isfield(opt, 'sort')
    
    idx = opt.sort.idx;
    if idx > length(columns)
        idx = find(opt.sort.idx == columns);
        if isempty(idx)
            error('Cannot find the column to perform the sorting against')
            idx = 1;
        end
    end
    
    Y = sortrows( Z,idx ) ;
end

N = size( Z,1 );

% cbrewer stuff
ctype = 'seq';
cname = 'Reds';

if isfield( opt, 'cbrewer' ) && ~isfield( opt, 'color' )
    
    if isfield( opt.cbrewer, 'ctype' )
        ctype = opt.cbrewer.ctype;
    end
    
    if isfield( opt.cbrewer, 'cname' )
        cname = opt.cbrewer.cname;
    end
    
    c = cbrewer( ctype, cname, N, 'pchip' );

elseif isfield( opt, 'color' )
    
    c = repmat( opt.color, N, 1 );
   
else
    c = winter(N);
end
    
for i=1:N
        
    hold all; parallelcoords( Y( i,: ), 'Color', c( i,: ) );

end

colormap(c);
colorbar;

if isfield(opt, 'labels') 
    set(gca, 'XTick', 1:length(columns) );
    set(gca, 'XTickLabel', opt.labels.axes );
end