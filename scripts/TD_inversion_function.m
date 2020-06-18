function [ model_hist ] = TD_inversion_function(TD_parameters, dataStruct, chain)

    %This line is needed to make sure that the chains are different from
    %one another
    rng(chain*round(mod(now*1e12,1e3)))%seed down to less than the milisecond

    if TD_parameters.individual_noise
       
        dataStruct.dtS = normrnd(dataStruct.dtS, TD_parameters.individual_noise);
        
        for k = 1:length(unique(dataStruct.dataE))
               
           dataStruct.dtS(dataStruct.dataE==k) = dataStruct.dtS(dataStruct.dataE==k) - mean(dataStruct.dtS(dataStruct.dataE==k));
               
        end
        
    end
    
    %convert the jump sigmas to real numbers instead of percentages
    TD_parameters.sig_zeta = TD_parameters.zeta_scale*TD_parameters.sig/100;
        
    xVec = dataStruct.xVec;
    yVec = dataStruct.yVec;
    zVec = dataStruct.zVec;
        
    n  = length(dataStruct.dataX);
    xr = (TD_parameters.sig/100)*(max(xVec(:)) - min(xVec));
    yr = (TD_parameters.sig/100)*(max(yVec(:)) - min(yVec));
    zr = (TD_parameters.sig/100)*(max(zVec(:)) - min(zVec));
    
    TD_parameters.sig_sig = TD_parameters.max_sig*TD_parameters.sig/100;
    
    if ~TD_parameters.enforce_discon && isfield(dataStruct, 'discontinuity')
    
        dataStruct = rmfield(dataStruct, 'discontinuity');
        
    end
            
    %preallocate into matricies for interpolation
    for k = 1:length(dataStruct.ray)
       
        dataStruct.rayX(:, k) = dataStruct.ray(k).x;
        dataStruct.rayY(:, k) = dataStruct.ray(k).y;
        dataStruct.rayZ(:, k) = dataStruct.zVec;
        U(:, k)               = dataStruct.ray(k).U;
        
    end
    
    %now, if doing the discontinuity, add a point RIGHT above and RIGHT
    %below the discontinuity
    if TD_parameters.enforce_discon
       
        old_len = length(dataStruct.rayX(:, 1));
        
        for k = 1:length(dataStruct.ray)
            
            rayz = dataStruct.discontinuity.interpolant_xy(...
                dataStruct.rayX(1:old_len, k), dataStruct.rayY(1:old_len, k));
            
            discx = interp1(rayz - dataStruct.rayZ(1:old_len, k), dataStruct.rayX(1:old_len, k), 0);
            discy = interp1(rayz - dataStruct.rayZ(1:old_len, k), dataStruct.rayY(1:old_len, k), 0);
            
            dataStruct.rayX((old_len + 1):(old_len + 2), k) = discx;
            dataStruct.rayY((old_len + 1):(old_len + 2), k) = discy;
            
            dataStruct.rayZ((old_len + 1), k) = dataStruct.discontinuity.interpolant_xy(discx, discy) - 1e-3;%small, but not so small that matlab rounds you off
            dataStruct.rayZ((old_len + 2), k) = dataStruct.discontinuity.interpolant_xy(discx, discy) + 1e-3;
            
            U((old_len + 1):(old_len + 2), k) = dataStruct.discontinuity.rayU(k);
            
            [dataStruct.rayZ(:, k), ind] = sort(dataStruct.rayZ(:, k));
            
            dataStruct.rayX(:, k) = dataStruct.rayX(ind, k);
            dataStruct.rayY(:, k) = dataStruct.rayY(ind, k);
            U(:, k)               = U(ind, k);
            
        end
        
    end
    
    %now preallocate ray length, its takes maybe ~10% of the time if done
    %on the fly. Matters, not a ton.
    %These will be shorter, see evaluate for why
    
    [m,n] = size(dataStruct.rayX);
    
    for k = 1:n
                                                
        for kk = 1:(m - 1) %hope there's no subloop
            
            dataStruct.rayL(kk, k)      = sqrt( (dataStruct.rayX(kk, k) - dataStruct.rayX(kk + 1, k))^2 ...
                + (dataStruct.rayY(kk, k) - dataStruct.rayY(kk + 1, k))^2 ...
                + (dataStruct.rayZ(kk, k) - dataStruct.rayZ(kk + 1, k))^2);%could be done ahead of time
            dataStruct.rayU(kk, k)      = 0.5*(U(kk, k) + U(kk + 1, k));
            
        end
                                
    end
    
    %and now, preallocate the layer for ray paths
    if TD_parameters.enforce_discon
       
        for k = 1:numel(dataStruct.rayX)
           
            zdisc = dataStruct.discontinuity.interpolant_xy(dataStruct.rayX(k), dataStruct.rayZ(k));
            
            if dataStruct.rayZ(k) < zdisc
                
                dataStruct.ray_layer(k) = 1;
                
            else
               
                dataStruct.ray_layer(k) = 2;
                
            end
            
        end
        
        dataStruct.ray_layer = reshape(dataStruct.ray_layer, size(dataStruct.rayX));
        
    end
    
    valid = 0;    
    while ~valid
    
        [ model, dataStruct, valid ] = build_starting(TD_parameters, dataStruct);
                
    end
            
    valid      = 1;
    alpha      = 0;
    
    for iter = 1:TD_parameters.n_iter

        %pick birth, death, move, change, or noise        
        if TD_parameters.sig_sig > 0

            action = randi([1 5],1);
            %action = randi([1 2],1);

        else

            action = randi([1 4],1);

        end

        model.action = action;
        model.accept = 0;

        switch action

            case 1 %birth

                if model.nCells < TD_parameters.max_cells
                
                    xNew   = rand(1)*range(xVec) + min(xVec);
                    yNew   = rand(1)*range(yVec) + min(yVec);
                    zNew   = rand(1)*range(zVec) + min(zVec);
                                                                                                                   
                    if isfield(dataStruct, 'discontinuity')
                        
                        %get discontinity depth at this point
                        %not set up for more than one discontinuity
                        if zNew >= dataStruct.discontinuity.interpolant_xy(xNew, yNew)
                            
                            layer_n    = [ model.layer 2 ];
                            node_index = (model.layer == 2);
                            
                        else
                            
                            layer_n    = [ model.layer 1 ];
                            node_index = (model.layer == 1);
                            
                        end
                        
                    else

                        layer_n    = [ model.layer; 1 ];
                        node_index = 1:model.nCells;
                        
                    end
                    
                    F    = return_interpolant(model, node_index, TD_parameters.interp_style);
                    
                    if any(yVec)
                        
                        czeta   = F(xNew, yNew, zNew);
                        
                    else
                        
                        czeta   = F(xNew, zNew);
                        
                    end
                    
                    zetanew = normrnd(czeta, TD_parameters.sig_zeta);
                    
                    xCell_n    = [ model.xCell; xNew ];
                    yCell_n    = [ model.yCell; yNew ];
                    zCell_n    = [ model.zCell; zNew ];
                    zeta_n     = [ model.zeta; zetanew ];
                    id_n       = [ model.id; (max(model.id) + 1) ];
                    
                    modeln               = model;
                    modeln.xCell         = xCell_n;
                    modeln.yCell         = yCell_n;
                    modeln.zCell         = zCell_n;
                    modeln.zeta          = zeta_n;
                    modeln.layer         = layer_n;
                    modeln.nCells        = modeln.nCells + 1;
                    modeln.id            = id_n;            
                    
                    %now pick which ones should be updated
                    %vn                 = voronoi_neighbor(modeln);
                    %modeln.node_change = full(vn(end, :));%update everything bordering the new node
                    
                    if strcmp(TD_parameters.prior, 'Normal')
                        
                        [modeln, dataStructn, valid] = evaluate(modeln, dataStruct, TD_parameters);

%                         alpha = min([1 (TD_parameters.sig_zeta/(TD_parameters.zeta_scale))*...
%                             exp(-(zetanew)^2/(2*TD_parameters.zeta_scale^2)...
%                             + (czeta - zetanew)^2/(2*TD_parameters.sig_zeta^2) - (modeln.phi - model.phi)/2) ]);
                        alpha = min([1 ((model.nCells)/(model.nCells + 1))*...
                            (TD_parameters.sig_zeta/(TD_parameters.zeta_scale))*...
                            exp(-(zetanew)^2/(2*TD_parameters.zeta_scale^2)...
                            + (czeta - zetanew)^2/(2*TD_parameters.sig_zeta^2) - (modeln.phi - model.phi)/2) ]);
                        
                    elseif strcmp(TD_parameters.prior, 'Exponential')
                                                
                        if zetanew > 0
                        
                            [modeln, dataStructn, valid] = evaluate(modeln, dataStruct, TD_parameters);

%                             alpha = min([1 (sqrt(2*pi)*TD_parameters.sig_zeta/TD_parameters.zeta_scale)*...
%                                 exp(-zetanew/TD_parameters.zeta_scale...
%                                 + (czeta - zetanew)^2/(2*TD_parameters.sig_zeta^2) - (modeln.phi - model.phi)/2) ]);
                            alpha = min([1 ((model.nCells)/(model.nCells + 1))*...
                                (sqrt(2*pi)*TD_parameters.sig_zeta/TD_parameters.zeta_scale)*...
                                exp(-zetanew/TD_parameters.zeta_scale...
                                + (czeta - zetanew)^2/(2*TD_parameters.sig_zeta^2) - (modeln.phi - model.phi)/2) ]);

                        else

                            valid = 0;

                        end
                                                
                    elseif strcmp(TD_parameters.prior, 'Uniform')
                        
                        if zetanew > -TD_parameters.zeta_scale && zetanew < TD_parameters.zeta_scale
                        
                            [modeln, dataStructn, valid] = evaluate(modeln, dataStruct, TD_parameters);
                            
                            alpha = min([1 ((model.nCells)/(model.nCells + 1))*((TD_parameters.sig_zeta*sqrt(2*pi))/(2*TD_parameters.zeta_scale))...
                                *exp(((czeta - zetanew)^2)/(2*TD_parameters.sig_zeta^2) - (modeln.phi - model.phi)/2 )]);

                        else

                            valid = 0;

                        end

                    end
                        
                    if rand(1) < alpha && valid

                        model        = modeln;
                        dataStruct   = dataStructn;
                        model.accept = 1;
                        
                    end

                end
                
            case 2 %death

                if model.nCells > TD_parameters.min_cells
                    
                    kill = randi(model.nCells, 1);

                    xCell_n        = model.xCell;
                    yCell_n        = model.yCell;
                    zCell_n        = model.zCell;
                    zeta_n         = model.zeta;
                    layer_n        = model.layer;
                    id_n           = model.id;
                                        
                    zeta_n(kill)    = [];
                    xCell_n(kill)    = [];
                    yCell_n(kill)    = [];
                    zCell_n(kill)    = [];
                    layer_n(kill)    = [];
                    id_n(kill)       = [];
                                 
                    modeln          = model;
                    modeln.xCell    = xCell_n;
                    modeln.yCell    = yCell_n;
                    modeln.zCell    = zCell_n;
                    modeln.zeta     = zeta_n;
                    modeln.layer    = layer_n;
                    modeln.id       = id_n;
                    modeln.nCells   = modeln.nCells - 1;
                    
                    %now pick which ones should be updated
                    %vn                 = voronoi_neighbor(model);
                    %modeln.node_change = full(vn(kill, :));%update everything bordering the node that died
                    
                    if sum(model.layer(kill) == model.layer) ~= 1
                        
                        [modeln, dataStructn, valid] = evaluate(modeln, dataStruct, TD_parameters);

                        F = return_interpolant(modeln, (modeln.layer == model.layer(kill)), TD_parameters.interp_style);

                        if any(yVec)

                            zetanew = F(model.xCell(kill), model.yCell(kill), model.zCell(kill));

                        else

                            zetanew = F(model.xCell(kill), model.zCell(kill));

                        end

                        if strcmp(TD_parameters.prior, 'Normal')

%                             alpha = min([1 ((TD_parameters.zeta_scale)/TD_parameters.sig_zeta)...
%                                 *exp((model.zeta(kill)^2)/(2*TD_parameters.zeta_scale^2)...
%                                 - (model.zeta(kill) - zetanew)^2/(2*TD_parameters.sig_zeta^2) - (modeln.phi - model.phi)/2) ]);
                            alpha = min([1 ((model.nCells)/(model.nCells - 1))*...
                                ((TD_parameters.zeta_scale)/TD_parameters.sig_zeta)...
                                *exp((model.zeta(kill)^2)/(2*TD_parameters.zeta_scale^2)...
                                - (model.zeta(kill) - zetanew)^2/(2*TD_parameters.sig_zeta^2) - (modeln.phi - model.phi)/2) ]);

                        elseif strcmp(TD_parameters.prior, 'Exponential')

                            if zetanew > 0

%                                 alpha = min([1 ((TD_parameters.zeta_scale)/(sqrt(2*pi)*TD_parameters.sig_zeta))*...
%                                     exp(model.zeta(kill)/TD_parameters.zeta_scale...    
%                                     - (model.zeta(kill) - zetanew)^2/(2*TD_parameters.sig_zeta^2) - (modeln.phi - model.phi)/2) ]);
                                alpha = min([1 ((model.nCells)/(model.nCells - 1))*...
                                    ((TD_parameters.zeta_scale)/(sqrt(2*pi)*TD_parameters.sig_zeta))*...
                                    exp(model.zeta(kill)/TD_parameters.zeta_scale...    
                                    - (model.zeta(kill) - zetanew)^2/(2*TD_parameters.sig_zeta^2) - (modeln.phi - model.phi)/2) ]);

                            else

                                valid = 0;

                            end

                        elseif strcmp(TD_parameters.prior, 'Uniform')

                            alpha = min([1 ((model.nCells)/(model.nCells - 1))*((2*TD_parameters.zeta_scale)/(TD_parameters.sig_zeta*sqrt(2*pi)))...
                                *exp(-((model.zeta(kill) - zetanew)^2)/(2*TD_parameters.sig_zeta^2) - (modeln.phi - model.phi)/2 )]);

                        end
                        
                    else
                        
                        valid = 0;
                        
                    end

                    %make sure you haven't removed all the nodes from one
                    %layer
                    if TD_parameters.enforce_discon && length(unique(modeln.layer)) == 1
                        
                        valid = 0;
                        
                    end
                    
                    if rand(1) < alpha && valid
                        
                        model        = modeln; 
                        dataStruct   = dataStructn;
                        model.accept = 1;
                        
                    end

                end

            case 3 %change t* value   
                
                change       = randi(model.nCells, 1);
                
                zetan         = model.zeta;
                zetan(change) = normrnd(model.zeta(change), TD_parameters.sig_zeta);
                
                modeln         = model;
                modeln.zeta    = zetan;
                
                %now pick which ones should be updated
                %vn                 = voronoi_neighbor(model);
                %modeln.node_change = full(vn(change, :));%update everything bordering the node that changed
                
                [modeln, dataStructn, valid] = evaluate(modeln, dataStruct, TD_parameters);
                
                if strcmp(TD_parameters.prior, 'Normal')
                    
                    alpha = min( [ 1 exp( (model.zeta(change)^2 - ...
                        zetan(change)^2)/(2*TD_parameters.zeta_scale^2) ...
                        - (modeln.phi - model.phi)/2) ] );
                    
                elseif strcmp(TD_parameters.prior, 'Exponential')
                    
                    if zetan(change) > 0
                    
                        alpha = min( [ 1 exp( (model.zeta(change) - ...
                            zetan(change))/TD_parameters.zeta_scale ...
                            - (modeln.phi - model.phi)/2) ] );
                    
                    else
                        
                        alpha = 0;
                        
                    end
                
                elseif strcmp(TD_parameters.prior, 'Uniform')
                    
                    if zetan(change) > -TD_parameters.zeta_scale && zetan(change) < TD_parameters.zeta_scale
                        
                        alpha = min( [ 1 exp(-(modeln.phi - model.phi)/2) ]);
                        valid = 1;
                        
                    else
                        
                        valid = 0;
                        
                    end
                    
                end
                                        
                if rand(1) <= alpha && valid
                    
                    model        = modeln;
                    dataStruct   = dataStructn;
                    model.accept = 1;
                
                end
                
            case 4 %move

                if model.nCells > 0
                
                    move    = randi(model.nCells, 1);
                    xCell_n = model.xCell;
                    yCell_n = model.yCell;
                    zCell_n = model.zCell;

                    xCell_n(move) = normrnd(model.xCell(move), xr);
                    yCell_n(move) = normrnd(model.yCell(move), yr);
                    zCell_n(move) = normrnd(model.zCell(move), zr);

                    layer_n = model.layer;
                    
                    if isfield(dataStruct, 'discontinuity')

                        %get discontinity depth at this point
                        %not set up for more than one discontinuity

                        if zCell_n(move) >= dataStruct.discontinuity.interpolant_xy(xCell_n(move), yCell_n(move))

                            layer_n(move) = 2;

                        else

                            layer_n(move) = 1;

                        end

                        if length(unique(layer_n)) == 1
                            
                            valid = 0;
                            
                        end
                        
                    else

                        layer_n(move) = 1;

                    end
                    
                    if (xCell_n(move) >= min(xVec) && xCell_n(move) <= max(xVec) && ...
                            yCell_n(move) >= min(yVec) && yCell_n(move) <= max(yVec) && ...
                            zCell_n(move) >= min(zVec) && zCell_n(move) <= max(zVec)) && valid
                    
                        modeln       = model;
                        modeln.xCell = xCell_n;
                        modeln.yCell = yCell_n;
                        modeln.zCell = zCell_n;
                        modeln.layer = layer_n;

                        %now pick which ones should be updated
                        %vn1                 = voronoi_neighbor(model);
                        %vn2                 = voronoi_neighbor(modeln);
                        %modeln.node_change  = full(vn1(move, :) & vn2(move, :));%update everything bordering the node in either position
                        
                        [modeln, dataStructn, valid] = evaluate(modeln, dataStruct, TD_parameters);

                        alpha = min( [ 1 exp(-(modeln.phi - model.phi)/2) ] );
                        
                    else
                        
                        valid = 0;
                        
                    end
                                        
                    if rand(1) <= alpha && valid
                        
                        model        = modeln;
                        dataStruct   = dataStructn;
                        model.accept = 1;
                        
                    end
                    
                end
                
            case 5 %change sigma

                sig_n       = normrnd(model.allSig, TD_parameters.sig_sig);%assumes uniform
                allSig_n    = sig_n*ones(size(dataStruct.dtS));
                
                if sig_n > 0 && sig_n < TD_parameters.max_sig
                
                    dataStructn        = dataStruct;
                    dataStructn.allSig = allSig_n;
    
                    [modeln, ~, ~] = evaluate(model, dataStructn, TD_parameters);%update no nodes

                    alpha = min( [ log(1) (log((model.allSig/sig_n))*(n) - ((modeln.phi - model.phi)/2)) ] );

                    if log(rand(1)) <= alpha

                        dataStruct    = dataStructn;
                        model         = modeln;
                        model.allSig  = sig_n;
                        model.accept  = 1;
                        
                    end
                    
                end

        end
                
        if iter == 1
            
            model_hist = model;
            
        end
        
        if iter >= TD_parameters.burn_in && mod(iter, TD_parameters.keep_each) == 0
                    
            model_hist(end + 1) = model;
            
        end
        
        nhist(iter)  = model.nCells;
        
        if mod(iter, TD_parameters.print_each) == 0
                                 
            disp([ 'Chain #' num2str(chain) ' at ' num2str(100*iter/TD_parameters.n_iter) '%' ]);
            
        end
                        
    end

    %model_hist = model_hist(2:end);
    
end

