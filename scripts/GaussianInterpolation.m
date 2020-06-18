function [ mQinv ] = GaussianInterpolation(xCell, zCell, angle, width, eccentricity, ...
        dmQinv, cell_ind, X, Z, nCells, npoints)

    mQinv = zeros(npoints,1);
    
    if nCells == 0
        
        return
        
    end
      
    cell_ind = cell_ind(1:nCells);
    X   = X(1:npoints);
    Z   = Z(1:npoints);
      
    for k = 1:npoints
       
        [~, ind] = min((X(k) - xCell(cell_ind)).^2 + (Z(k) - zCell(cell_ind)).^2);
        
        Xr = (X(k) - xCell(cell_ind(ind))).*cosd(angle(cell_ind(ind))) - (Z(k) - zCell(cell_ind(ind))).*sind(angle(cell_ind(ind)));
        Zr = (X(k) - xCell(cell_ind(ind))).*sind(angle(cell_ind(ind))) + (Z(k) - zCell(cell_ind(ind))).*cosd(angle(cell_ind(ind)));
        
        sigb = width(cell_ind(ind)).*sqrt(1 - (eccentricity(cell_ind(ind)).^2));
        
        mQinv(k) = dmQinv(cell_ind(ind)).*exp( -( ( Xr.^2)./(2*width(cell_ind(ind)).^2) ...
            + (Zr.^2)./(2*sigb.^2)));
                
    end
        
end

%     for k = 1:numel(X)
%     
%         d = (model.xCell(cell_ind) - X(k)).^2 + (model.zCell(cell_ind) - Z(k)).^2;
%         [~, ind] = min(d);
%         
%         
%     end
    
%     for k = cell_ind
%                
%         Xr = (X - model.xCell(k))*cosd(model.angle(k)) - (Z - model.zCell(k))*sind(model.angle(k));
%         Zr = (X - model.xCell(k))*sind(model.angle(k)) + (Z - model.zCell(k))*cosd(model.angle(k));
%         
%         sigb = model.width(k)*sqrt(1 - (model.eccentricity(k)^2));
%         
%         mQinv = mQinv + model.dmQinv(k)*exp( -( ( Xr.^2)/(2*model.width(k)^2) ...
%             + (Zr.^2)/(2*sigb^2)));
%         
%     end
