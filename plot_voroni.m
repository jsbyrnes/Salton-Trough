function [h] = plot_voroni(model, dataStruct)

    if isfield(model, 'mQinv')
       
        model.zeta = model.mQinv;
        
    end

    F      = return_interpolant(model, 1:model.nCells, 'nearest'); 
    
    xfine = linspace(dataStruct.xVec(1), dataStruct.xVec(end), 200);
    zfine = linspace(dataStruct.zVec(1), dataStruct.zVec(end), 200);
    
    [X, Z] = meshgrid(xfine, zfine);
    m      = F(X, Z); 
    
    contourf(X, Z, m, sort([model.zeta]), 'LineStyle', 'none'); 
    hold on;
    
    [vx,vy] = voronoi(model.xCell, model.zCell); 
    plot(vx,vy, 'k', 'LineWidth', 3); 
    
    scatter(model.xCell, model.zCell, 20, model.zeta, 'filled', 'MarkerEdgeColor', 'k');
    
    h                = colorbar; 
    h.Label.String   = '\Delta\zeta';
    h.Label.FontSize = 20;
    
    load('CMfine.mat');
    colormap((cm)); 
    
    caxis([ min(-abs(model.zeta)) max(abs(model.zeta)) ]);
    set(gca, 'YDir', 'reverse');
    
    axis equal
    
    xlim([ min(dataStruct.xVec) max(dataStruct.xVec) ]);
    ylim([ min(dataStruct.zVec) max(dataStruct.zVec) ]);

    xlabel('Distance, km');
    ylabel('Depth, km');
    
    h = [];
    
end

