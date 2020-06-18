function [ F ] = return_interpolant( model, cell_ind, interp_style )

    if strcmp(interp_style, 'nearest') %This script is faster

        F = @( X, Z ) NearestInterpolation_gateway(model, cell_ind, X, Z);
        
    elseif strcmp(interp_style, 'Gaussian')
        
        %F = @( X, Z ) GaussianInterpolation(model, cell_ind, X, Z);
        F = @( X, Z ) GaussianInterpolation_gateway(model, cell_ind, X, Z);
    
    else
        
        if isfield(model, 'mQinv')

            F = scatteredInterpolant(model.xCell(cell_ind), model.zCell(cell_ind), ...
                model.mQinv(cell_ind), interp_style, 'nearest');

        elseif isfield(model, 'zeta')

            F = scatteredInterpolant(model.xCell(cell_ind), model.zCell(cell_ind), ...
                model.zeta(cell_ind), interp_style, 'nearest');
            
        elseif isfield(model, 'Vp')

            F = scatteredInterpolant(model.xCell(cell_ind), model.yCell(cell_ind), ...
                model.Vp(cell_ind), interp_style, 'nearest');

        end
        
    end
    
    
    
end

%     if ~strcmp(interp_style, 'Gaussian')
%        
%         if any(model.yCell)
%            
%             F    = scatteredInterpolant(model.xCell(cell_ind), ...
%                 model.yCell(cell_ind), model.zCell(cell_ind), ...
%                 model.dmQinv(cell_ind), interp_style);
% 
%         else
%             
%             F    = scatteredInterpolant(model.xCell(cell_ind), ...
%                 model.zCell(cell_ind), ...
%                 model.dmQinv(cell_ind), interp_style);
%             
%         end
%         