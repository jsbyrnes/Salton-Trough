function [ zeta ] = NearestInterpolation_gateway( model, cell_ind, X, Z )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    if isrow(cell_ind)
        
        cell_ind = cell_ind';
        
    end

    xCell        = [ model.xCell; zeros(100 - model.nCells,1) ];
    
    if ~isfield(model, 'zCell') && isfield(model, 'yCell')
    
        zCell        = [ model.yCell; zeros(100 - model.nCells,1) ];
        
    else
        
        zCell        = [ model.zCell; zeros(100 - model.nCells,1) ];
        
    end
    
    if ~isfield(model, 'zeta') && isfield(model, 'Vp')
    
        zeta        = [ model.Vp; zeros(100 - model.nCells,1) ];
        
    else
        
        zeta        = [ model.zeta; zeros(100 - model.nCells,1) ];
        
    end

    cell_ind     = logical([ cell_ind; zeros(100 - length(cell_ind),1) ]);

    Xs = [ X(:); zeros(5e4 - length(X(:)),1) ];%5e4 is to guess. This line is ~2.6% of the script time
    Zs = [ Z(:); zeros(5e4 - length(Z(:)),1) ];
   
    [ zeta ] = NearestInterpolation( xCell, zCell, ...
            zeta, cell_ind, Xs, Zs, model.nCells, length(X(:)));    
    
    zeta = reshape(zeta, size(X));
        
end

