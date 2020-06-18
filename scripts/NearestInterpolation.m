function [ zeta ] = NearestInterpolation(xCell, zCell, zetaCell, cell_ind, X, Z, nCells, npoints)
%replaces scattered interp, this can handle zero cells
    
    zeta = zeros(npoints,1);
    
    if nCells == 0
        
        return
        
    end
      
    %cell_ind = cell_ind(1:nCells);
    X   = X(1:npoints);
    Z   = Z(1:npoints);
      
    xCell = xCell(cell_ind);
    zCell = zCell(cell_ind);
    zetaCell  = zetaCell(cell_ind);
    
    for k = 1:npoints
       
        [~, ind] = min((X(k) - xCell).^2 + (Z(k) - zCell).^2);
        zeta(k)  = zetaCell(ind);
                   
    end
    
end

