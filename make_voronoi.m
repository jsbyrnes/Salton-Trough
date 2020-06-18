function [m] = make_voronoi(model, dataStruct, TD_parameters, makeplot, demean_layers)

    if nargin < 5
        
        demean_layers = 0;
       
    end

    if isfield(model, 'mQinv')
       
        model.zeta = model.mQinv;
                
    end

    if makeplot
    
        xfine = linspace(dataStruct.xVec(1), dataStruct.xVec(end), 200);
        zfine = linspace(dataStruct.zVec(1), dataStruct.zVec(end), 200);

        [X, Z] = meshgrid(xfine, zfine);
        
    else
       
        [X, Z] = meshgrid(dataStruct.xVec, dataStruct.zVec);
        
    end
 
    dx = X(1, 2) - X(1, 1);
    dz = Z(2) - Z(1);
    
    if max(model.layer) == 1
    
        F = return_interpolant(model, 1:model.nCells, TD_parameters.interp_style); 
        m = F(X, Z); 
                    
    elseif max(model.layer) == 2
        
        m = zeros(size(X));
        
        disc_depth = dataStruct.discontinuity.interpolant_xy(X, zeros(size(X)));
        layerind   = disc_depth >= Z;
        
        F           = return_interpolant(model, model.layer==1, TD_parameters.interp_style);
        m(layerind) = F(X(layerind), Z(layerind));        
        
        F            = return_interpolant(model, model.layer==2, TD_parameters.interp_style);
        m(~layerind) = F(X(~layerind), Z(~layerind));
        
        if demean_layers
           
            m(layerind)  = m(layerind)  - mean(m(layerind));
            m(~layerind) = m(~layerind) - mean(m(~layerind));
            
        end
        
    end
        
    if makeplot
        
        if strcmp(TD_parameters.interp_style, 'nearest')
        
            contourf(X, Z, m, 20, 'LineStyle', 'none'); 
            hold on;
                        
            if max(model.layer) == 1
                            
                [vx,vy] = voronoi(model.xCell, model.zCell); 
                plot(vx,vy, 'k', 'LineWidth', 3); 
                
            elseif max(model.layer) == 2
                
                %first layer
                [vx,vy] = voronoi(model.xCell(model.layer==1), model.zCell(model.layer==1)); 
                index = vy < dataStruct.discontinuity.interpolant_xy(vx, zeros(size(vx)));
                
                for k = 1:length(vx)
                   
                    xvert = vx(:, k);
                    zvert = vy(:, k);
                    
                    xline = linspace(xvert(1), xvert(2), 50);
                    zline = linspace(zvert(1), zvert(2), 50);
                    
                    plotind = zline < dataStruct.discontinuity.interpolant_xy(xline, zeros(size(xline)));
                    
                    if any(plotind)
                    
                        plot(xline(plotind), zline(plotind), 'k', 'LineWidth', 3);
                    
                    end
                    
                end
                                
                %second layer
                [vx,vy] = voronoi(model.xCell(model.layer == 2), model.zCell(model.layer == 2)); 
                index = vy >= dataStruct.discontinuity.interpolant_xy(vx, zeros(size(vx)));
                
                for k = 1:length(vx)
                   
                    xvert = vx(:, k);
                    zvert = vy(:, k);
                    
                    xline = linspace(xvert(1), xvert(2), 500);
                    zline = linspace(zvert(1), zvert(2), 500);
                    
                    plotind = zline >= dataStruct.discontinuity.interpolant_xy(xline, zeros(size(xline)));
                    
                    if any(plotind)
                    
                        plot(xline(plotind), zline(plotind), 'k', 'LineWidth', 3);
                    
                    end
                    
                end
                
            end

        else
           
            contourf(X, Z, m, 20); 
            hold on;
            
        end

        %scatter(model.xCell, model.zCell, 20, model.zeta, 'filled', 'MarkerEdgeColor', 'k');
        
        if max(model.layer) == 2

            disc_z = dataStruct.discontinuity.interpolant_xy(xfine, zeros(size(xfine)));
            plot(xfine, disc_z, 'k-.', 'LineWidth', 3)

        end

        h                = colorbar; 
        h.Label.String   = '\Delta\zeta';
        h.Label.FontSize = 20;

        load('CMfine.mat');
        colormap((cm)); 

        caxis([ min(-abs(m(:))) max(abs(m(:))) ]);
        set(gca, 'YDir', 'reverse');

        axis equal

        xlim([ min(dataStruct.xVec) max(dataStruct.xVec) ]);
        ylim([ min(dataStruct.zVec) max(dataStruct.zVec) ]);

        xlabel('Distance, km');
        ylabel('Depth, km');
    
    end
    
end

