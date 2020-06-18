function [ phiM, likelyhood, dataStruct ] = evaluate( model, dataStruct, interp_style, nodeUpdate)

    %first, assign nans if yCell or xCell is all the same number.
    %ScatteredInterpolant uses triangulation and can't operate if points
    %are colinear. 
    
    zVec = dataStruct.zVec;
    
    if nargin < 4
        
        nodeUpdate = model.nodeId;%update all nodes
        
    end
    
     Fq    = scatteredInterpolant(model.xCell(:), model.yCell(:), model.zCell(:), ...
         model.QinvCell(:), interp_style);
%      Fn    = scatteredInterpolant(model.xCell(:), model.yCell(:), model.zCell(:), ...
%          model.nodeId(:), 'nearest');
    
    for k = 1:length(dataStruct.allTS);
    
        %get tS at ray nodes
        rayX = dataStruct.ray(k).x;
        rayY = dataStruct.ray(k).y;
        rayU = dataStruct.ray(k).U;
        rayN = dataStruct.ray(k).nodeId;%prior node
        Qinv = dataStruct.ray(k).Qinv;%for prior node
                
        if ~isempty(nodeUpdate)%if empty, model didn't change
        
            ind = false(size(Qinv));
                        
            for kk = 1:length(rayX)

                if any(rayN(kk) == nodeUpdate) || isnan(rayN(kk))

                    %the node was changed so you need to update
                    ind(kk) = 1;

                end

            end
                
            if any(ind)
                        
                Qinv(ind) = Fq(rayX(ind), rayY(ind), zVec(ind));
                rayN(ind) = Fn(rayX(ind), rayY(ind), zVec(ind));

            end

            dataStruct.ray(k).Qinv = Qinv;
            dataStruct.ray(k).nodeId = rayN;
        
        end
        
        rayL    = zeros(length(rayX)-1,1);
        rayQinv = zeros(length(rayX)-1,1);
        U       = zeros(length(rayX)-1,1);
        
        for kk = 1:(length(rayX) - 1) %hope there's no subloop

            rayL(kk) = sqrt( (rayX(kk) - rayX(kk + 1))^2 + (rayY(kk) - rayY(kk + 1))^2 ...
                + (zVec(kk) - zVec(kk + 1))^2);
            
            rayQinv(kk) = 0.5*(Qinv(kk) + Qinv(kk + 1));
            
            U   (kk) = 0.5*(rayU(kk) + rayU(kk + 1));
            
        end
                
        ptS(k) = sum(rayL.*rayQinv.*U);
                        
    end

    %re-demean. The model may have nonzero mean but that's fine
    for k = 1:length(unique(dataStruct.dataE))

        ptS(dataStruct.dataE==k) = ptS(dataStruct.dataE==k) - mean(ptS(dataStruct.dataE==k));

    end

    C = diag(dataStruct.allSig.^2);
    C = inv(C);
    
    phiM       = ((ptS - dataStruct.allTS))*C*((ptS - dataStruct.allTS))';
    likelyhood = sum(-log(dataStruct.allSig*sqrt(2*pi))*length(dataStruct.allTS) - 0.5*((ptS - dataStruct.allTS)./dataStruct.allSig).^2);
    
%     phiM       = sum(((ptS - dataStruct.allTS)./dataStruct.allSig).^2);
%     likelyhood = sum(-log(dataStruct.allSig)*sqrt(2*pi) - 0.5*((ptS - dataStruct.allTS)./dataStruct.allSig).^2);
        
end