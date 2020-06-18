function [ phiM, likelyhood, dataStruct, valid ] = evaluate_Pn( model, dataStruct, TD_parameters)
    %first, assign nans if yCell or xCell is all the same number.
    %ScatteredInterpolant uses triangulation and can't operate if points
    %are colinear. 
    
    valid      = 1;
    phiM       = 1;
    likelyhood = 1;
    
    if TD_parameters.debug_prior
        
        return
        
    end
    
    Fq    = scatteredInterpolant(model.xCell(:), model.yCell(:), ...
        model.Vp(:), TD_parameters.interp_style, 'nearest');
    Qtest = Fq(1,1);
    
    if isempty(Qtest)%not enough nodes, or nodes are colinear. Shouldn't be an issue.
        
        valid = 0;
        return
        
    end
        
    for k = 1:length(dataStruct.arrivalTime)
        
        %get tS at ray nodes
        rayX     = dataStruct.ray(k).x;
        rayY     = dataStruct.ray(k).y;
        Vp       = Fq(rayX, rayY);
        
        rayL       = zeros(length(rayX)-1,1);
        rayVp      = zeros(length(rayX)-1,1);
        
        for kk = 1:(length(rayX) - 1) %hope there's no subloop
            
            rayL(kk)      = sqrt( (rayX(kk) - rayX(kk + 1))^2 + (rayY(kk) - rayY(kk + 1))^2);
            rayVp(kk)     = 0.5*(Vp(kk) + Vp(kk + 1));%convert from Vp to dQinv
            
        end
        
        pt(k) = sum(rayL./rayVp);
        
    end
            
    C = diag(1./dataStruct.allSig.^2);%independant data
            
    phiM       = ((pt - dataStruct.arrivalTime'))*C*((pt - dataStruct.arrivalTime'))';
    likelyhood = sum(-log(dataStruct.allSig'*sqrt(2*pi))*length(dataStruct.arrivalTime) - 0.5*((pt - dataStruct.arrivalTime')./dataStruct.allSig').^2);
        
end

%     if isfield(dataStruct, 'discontinuity')
%     
%         for n = 1:length(dataStruct.discontinuity) + 1
% 
%             if any(dataStruct.yVec)
%             
%                 Fq{n}    = scatteredInterpolant(model.xCell(model.layer == n), model.yCell(model.layer == n), ...
%                     model.zCell(model.layer == n), model.Vp(model.layer == n), interp_style, interp_style);
%                     
%                 %test
%                 Fa = Fq{n};
%                 Qtest = Fa(0,0,0);
%                     
%             else
%                
%                 Fq{n}    = scatteredInterpolant(model.xCell(model.layer == n), ...
%                     model.zCell(model.layer == n), model.Vp(model.layer == n), interp_style, interp_style);
%                 
%                 %test
%                 Fa = Fq{n};
%                 Qtest = Fa(0,0);
%                 
%             end
%                         
%             if isempty(Qtest)%not enough nodes, or nodes are colinear
%                 
%                 valid = 0;
%                 return
%                 
%             end
%                                              
%         end
%         
%     else
%         
%         
%     end
% 

%         if isfield(dataStruct, 'discontinuity')
% 
%             %get tS at ray nodes
%             
%             ray_zVec = [zVec dataStruct.discontinuity.rayz(k) ];%only set up for one discontinuity
%                         
%             rayX   = [ dataStruct.ray(k).x interp1(zVec, dataStruct.ray(k).x, dataStruct.discontinuity.rayz(k)) ];
%             rayY   = [ dataStruct.ray(k).y interp1(zVec, dataStruct.ray(k).y, dataStruct.discontinuity.rayz(k)) ];
%             rayU   = [ dataStruct.ray(k).U interp1(zVec, dataStruct.ray(k).U, dataStruct.discontinuity.rayz(k)) ];
%             Vp = zeros(size(rayU));
%             
%             [ray_zVec, sortind] = sort(ray_zVec);
%             
%             rayX = rayX(sortind);
%             rayY = rayY(sortind);
%             rayU = rayU(sortind);
% 
%             for n = 1:length(dataStruct.discontinuity) + 1
% 
%                 %indicies to ray nodes in layer n
%                 if n == 1
%                 
%                     F = Fq{n};
%                     layerind = ray_zVec < dataStruct.discontinuity(n).rayz(k);
%                     
%                     if any(dataStruct.yVec)
%                     
%                         Vp(layerind) = F(rayX(layerind), rayY(layerind), ray_zVec(layerind));
%                         
%                     else
%                        
%                         Vp(layerind) = F(rayX(layerind), ray_zVec(layerind));
%                         
%                     end
%                     
%                 else %replace Q values as you go down
%                     
%                     F = Fq{n};
%                     layerind = ray_zVec >= dataStruct.discontinuity(n-1).rayz(k);
%                     
%                     if any(dataStruct.yVec)
%                     
%                         Vp(layerind) = F(rayX(layerind), rayY(layerind), ray_zVec(layerind));
%                     
%                     else
%                        
%                         Vp(layerind) = F(rayX(layerind), ray_zVec(layerind));
%                         
%                     end
%                         
%                 end
%                 
%             end
%             
%             %not set up for more than 1 discontinuity!!!            
%             %test discontinuity sign
%             Qabove = interp1(ray_zVec, Vp, dataStruct.discontinuity(n-1).rayz(k) - 1);
%             Qbelow = interp1(ray_zVec, Vp, dataStruct.discontinuity(n-1).rayz(k) + 1);
%             
%             if sign(Qbelow - Qabove) ~= dataStruct.discontinuity(n-1).sign
%                 
%                 valid = 0;
%                 return
%                 
%             end
%             
%         else
% 

%     %minimize absolute misfit with event statics
%     dtS    = dataStruct.dtS;
%     [ es ] = e_static( ptS - dtS, dataStruct.dataE );
%   
%     for k = 1:length(dtS)
%        
%         dtS(k) = dtS(k) + es(dataStruct.dataE(k));
%         
%     end
