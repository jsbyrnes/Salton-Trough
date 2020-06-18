function [ model, dataStruct, valid ] = evaluate( model, dataStruct, TD_parameters)
    %first, assign nans if yCell or xCell is all the same number.
    %ScatteredInterpolant uses triangulation and can't operate if points
    %are colinear. 
    
    valid            = 1;
    model.phi        = 1;
    model.likelihood = 1;
        
    zeta = zeros(size(dataStruct.rayX));
    
    if ~isfield(dataStruct, 'discontinuity')
    
        if any(dataStruct.yVec)

            %Fq    = scatteredInterpolant(model.xCell(:), model.yCell(:), model.zCell(:), ...
            %    model.zeta(:), TD_parameters.interp_style, 'nearest');
            Fq = return_interpolant(model, 1:model.nCells, TD_parameters.interp_style);
            
            Qtest = Fq(1,1,1);

            Fnode = scatteredInterpolant(model.xCell(:), model.yCell(:), model.zCell(:), ...
                model.id(:), 'nearest', 'nearest');
            
        else

            %Fq    = scatteredInterpolant(model.xCell(:), model.zCell(:), ...
            %    model.zeta(:), TD_parameters.interp_style, TD_parameters.interp_style);
            Fq = return_interpolant(model, 1:model.nCells, TD_parameters.interp_style);

            Qtest = Fq(1,1);

            Fnode = scatteredInterpolant(model.xCell(:), model.zCell(:), ...
                model.id(:), 'nearest', 'nearest');
            
        end
        
        if isempty(Qtest)%not enough nodes, or nodes are colinear. Shouldn't be an issue.

            valid = 0;
            return

        end
             
        if TD_parameters.debug_prior

            return

        end    
        
        zeta = Fq(dataStruct.rayX, dataStruct.rayZ);
        
    elseif isfield(dataStruct, 'discontinuity')
                        
        for n = 1:length(dataStruct.discontinuity) + 1
                            
            layerind = (model.layer == n);
            
            if sum(layerind) == 0
               
                valid = 0;
                return
                
            end
            
            if any(dataStruct.yVec)
                
                %Fq{n} = scatteredInterpolant(model.xCell(layerind), model.yCell(layerind), model.zCell(layerind), ...
                %    model.zeta(layerind), TD_parameters.interp_style, TD_parameters.interp_style);
                Fq{n} = return_interpolant(model, layerind, TD_parameters.interp_style);
                F     = Fq{n};
                Qtest = F(1,1,1);
                
                Fnode{n} = scatteredInterpolant(model.xCell(layerind), model.yCell(layerind), model.zCell(layerind), ...
                    model.id(layerind), 'nearest', 'nearest');
                
            else
                
                %Fq{n} = scatteredInterpolant(model.xCell(layerind), model.zCell(layerind), ...
                %    model.zeta(layerind), TD_parameters.interp_style, TD_parameters.interp_style);
                Fq{n} = return_interpolant(model, layerind, TD_parameters.interp_style);
                F     = Fq{n};
                Qtest = F(1,1);
                
                Fnode{n} = scatteredInterpolant(model.xCell(layerind), model.zCell(layerind), ...
                    model.id(layerind), 'nearest', 'nearest');
                
            end
           
            if isempty(Qtest)%not enough nodes, or nodes are colinear. Shouldn't be an issue.

                valid = 0;
                return

            end
                       
        end

        if TD_parameters.debug_prior

            return

        end    
        
        Fn = Fq{1};
        Fp = Fq{2};
        
        if dataStruct.discontinuity.sign ~= 0
        
            [X, Y] = meshgrid(linspace(min(dataStruct.dataX), max(dataStruct.dataX), max([ 1 range(dataStruct.dataX)/TD_parameters.XYnodeSpacing])), ...
                linspace(min(dataStruct.dataY), max(dataStruct.dataY), max([ 1 range(dataStruct.dataY)/TD_parameters.XYnodeSpacing])));

            zdisc = dataStruct.discontinuity.interpolant_xy(X, Y);

            %not set up in 3d correctly, or for more than one discontinuity
            if any( Fn(X(:), zdisc) > Fp(X(:), zdisc) ) && dataStruct.discontinuity.sign == 1

                valid = 0;
                return

            elseif any( Fn(X(:), zdisc) < Fp(X(:), zdisc) ) && dataStruct.discontinuity.sign == -1

                valid = 0;
                return

            end
        
        end
                
        zeta(dataStruct.ray_layer == 1) = Fn(dataStruct.rayX(dataStruct.ray_layer == 1), ...
            dataStruct.rayZ(dataStruct.ray_layer == 1));
        zeta(dataStruct.ray_layer == 2) = Fp(dataStruct.rayX(dataStruct.ray_layer == 2), ...
            dataStruct.rayZ(dataStruct.ray_layer == 2));
        
    end
                
    [m,n] = size(dataStruct.rayZ);
    
    for k = 1:n
                                                
        for kk = 1:(m - 1) %hope there's no subloop
            
            rayzeta(kk, 1)   = 0.5*(zeta(kk, k) + zeta(kk + 1, k));
            
        end
        
        ptS(k) = sum(dataStruct.rayL(:, k).*dataStruct.rayU(:, k).*(rayzeta/1000));
                        
    end
        
    dtS = dataStruct.dtS;
    
    if TD_parameters.event_statics
        
        ptS = ptS - mean(ptS);
        
        es = e_static(ptS - dtS, dataStruct.dataE);%check the sign!
        
        %adjust the data for the predicted mean offset
        for k = 1:length(unique(dataStruct.dataE))

            dtS(dataStruct.dataE==k) = dtS(dataStruct.dataE==k) + es(k);

        end
        
    else
    
        %re-demean. The model may have nonzero mean; this matches the data
        for k = 1:length(unique(dataStruct.dataE))

            ptS(dataStruct.dataE==k) = ptS(dataStruct.dataE==k) - mean(ptS(dataStruct.dataE==k));

        end
                
    end

    C = diag(1./dataStruct.allSig.^2);%independant data
        
    model.phi         = ((ptS - dtS))*C*((ptS - dtS))';
    model.likelihood  = sum(-log(dataStruct.allSig*sqrt(2*pi))*length(dtS) - 0.5*((ptS - dtS)./dataStruct.allSig).^2);
    model.node_change = zeros(model.nCells, 1);%all changes have been made
    
end




%     if isfield(dataStruct, 'discontinuity')
%     
%         for n = 1:length(dataStruct.discontinuity) + 1
% 
%             if any(dataStruct.yVec)
%             
%                 Fq{n}    = scatteredInterpolant(model.xCell(model.layer == n), model.yCell(model.layer == n), ...
%                     model.zCell(model.layer == n), model.zeta(model.layer == n), interp_style, interp_style);
%                     
%                 %test
%                 Fa = Fq{n};
%                 Qtest = Fa(0,0,0);
%                     
%             else
%                
%                 Fq{n}    = scatteredInterpolant(model.xCell(model.layer == n), ...
%                     model.zCell(model.layer == n), model.zeta(model.layer == n), interp_style, interp_style);
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
%             zeta = zeros(size(rayU));
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
%                         zeta(layerind) = F(rayX(layerind), rayY(layerind), ray_zVec(layerind));
%                         
%                     else
%                        
%                         zeta(layerind) = F(rayX(layerind), ray_zVec(layerind));
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
%                         zeta(layerind) = F(rayX(layerind), rayY(layerind), ray_zVec(layerind));
%                     
%                     else
%                        
%                         zeta(layerind) = F(rayX(layerind), ray_zVec(layerind));
%                         
%                     end
%                         
%                 end
%                 
%             end
%             
%             %not set up for more than 1 discontinuity!!!            
%             %test discontinuity sign
%             Qabove = interp1(ray_zVec, zeta, dataStruct.discontinuity(n-1).rayz(k) - 1);
%             Qbelow = interp1(ray_zVec, zeta, dataStruct.discontinuity(n-1).rayz(k) + 1);
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









%             %get tS at ray nodes
%             
%             ray_zVec            = [dataStruct.zVec (dataStruct.discontinuity.rayz(k) - 1) (dataStruct.discontinuity.rayz(k) + 1) ];%only set up for one discontinuity
%             [ray_zVec, sortind] = sort(ray_zVec);
%             
%             rayX   = [ dataStruct.ray(k).x dataStruct.discontinuity(1).rayX(k) dataStruct.discontinuity(1).rayX(k) ];
%             rayY   = [ dataStruct.ray(k).y dataStruct.discontinuity(1).rayY(k) dataStruct.discontinuity(1).rayY(k) ];
%             rayU   = [ dataStruct.ray(k).U dataStruct.discontinuity(1).rayU(k) dataStruct.discontinuity(1).rayU(k) ];
%             
%             zeta = dataStruct.ray(k).zeta;
% 
%             ind_update = zeros(size(dataStruct.ray(k).id));
%             
%             for ind = 1:length(ind_update)
%             
%                 if any(model.node_change == dataStruct.ray(k).id(ind))
%                 
%                     ind_update(ind) = 1;
%                 
%                 end
%             
%             end
%             
%             ind_update((end+1):(end+2)) = 1;
%             remove                      = zeros(size(ind_update));
%             remove(end-2:end)           = 1;
%             
%             rayX       = rayX(sortind);
%             rayY       = rayY(sortind);
%             rayU       = rayU(sortind);
%             ind_update = logical(ind_update(sortind));
%             
%             for n = 1:length(dataStruct.discontinuity) + 1
%                 
%                 %indicies to ray nodes in layer n
%                 if n == 1
%                     
%                     F = Fq{n};
%                     layerind = (ray_zVec < dataStruct.discontinuity(n).rayz(k)) & ind_update;
%                     
%                     if any(dataStruct.dataY)
%                         
%                         zeta(layerind)                   = F(rayX(layerind), rayY(layerind), ray_zVec(layerind));
%                         dataStruct.ray(k).id(ind_update) = Fnode(rayX(layerind & ~remove), rayY(layerind & ~remove), ...
%                             ray_zVec(layerind & ~remove));
%                         
%                     else
%                         
%                         zeta(layerind)                   = F(rayX(layerind), ray_zVec(layerind));
%                         dataStruct.ray(k).id(ind_update) = Fnode(rayX(layerind & ~remove), ...
%                             ray_zVec(layerind & ~remove));
%                         
%                     end
%                                         
%                 else %replace Q values as you go down
%                     
%                     F = Fq{n};
%                     layerind = (ray_zVec >= dataStruct.discontinuity(n-1).rayz(k)) & ind_update;
%                     
%                     if any(dataStruct.dataY)
%                         
%                         zeta(layerind)                   = F(rayX(layerind), rayY(layerind), ray_zVec(layerind));
%                         dataStruct.ray(k).id(ind_update) = Fnode(rayX(layerind & ~remove), rayY(layerind & ~remove), ...
%                             ray_zVec(layerind & ~remove));
%                         
%                     else
%                         
%                         zeta(layerind)                   = F(rayX(layerind), ray_zVec(layerind));
%                         dataStruct.ray(k).id(ind_update) = Fnode(rayX(layerind & ~remove), ...
%                             ray_zVec(layerind & ~remove));
%                         
%                     end
%                     
%                 end
%                 
%             end

