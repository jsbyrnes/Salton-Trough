function [ mQinv ] = GaussianInterpolation_mfile( model, cell_ind, X, Z )

    if model.nCells == 0
        
        mQinv = zeros(size(X));
        return
        
    end
        
    ind = knnsearch([model.xCell(cell_ind) model.zCell(cell_ind)], [ X(:) Z(:) ]);

    ind = reshape(ind, size(X));
    
    mX = reshape(model.xCell(cell_ind(ind)), size(X));
    mZ = reshape(model.zCell(cell_ind(ind)), size(X));
    mA = reshape(model.angle(cell_ind(ind)), size(X));
    mW = reshape(model.width(cell_ind(ind)), size(X));
    mE = reshape(model.eccentricity(cell_ind(ind)), size(X));
    mQ = reshape(model.dmQinv(cell_ind(ind)), size(X));
    
    Xr = (X - mX).*cosd(mA) - (Z - mZ).*sind(mA);
    Zr = (X - mX).*sind(mA) + (Z - mZ).*cosd(mA);
    
    sigb = mW.*sqrt(1 - (mE.^2));
    
    mQinv = mQ.*exp( -( ( Xr.^2)./(2*mW.^2) ...
        + (Zr.^2)./(2*sigb.^2)));
    
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
