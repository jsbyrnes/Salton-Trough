function [ mQinv ] = GaussianInterpolation_gateway( model, cell_ind, X, Z )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    if isrow(cell_ind)
        
        cell_ind = cell_ind';
        
    end
    
    xCell        = [ model.xCell; zeros(100 - model.nCells,1) ];
    zCell        = [ model.zCell; zeros(100 - model.nCells,1) ];
    angle        = [ model.angle; zeros(100 - model.nCells,1) ];
    width        = [ model.width; zeros(100 - model.nCells,1) ];
    eccentricity = [ model.eccentricity; zeros(100 - model.nCells,1) ];
    mQinv        = [ model.mQinv; zeros(100 - model.nCells,1) ];
    cell_ind     = [ cell_ind; zeros(100 - length(cell_ind),1) ];

    Xs = [ X(:); zeros(1000 - length(X(:)),1) ];
    Zs = [ Z(:); zeros(1000 - length(Z(:)),1) ];
    
    [ mQinv ] = GaussianInterpolation_mex( xCell, zCell, angle, width, eccentricity, ...
        mQinv, cell_ind, Xs, Zs, model.nCells, length(X(:)));
    
    mQinv = reshape(mQinv, size(X));
        
end

