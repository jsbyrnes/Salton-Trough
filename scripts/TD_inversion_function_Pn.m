function [ model_hist ] = TD_inversion_function_Pn(TD_parameters, dataStruct)

    rng(round(mod(now*1e12,1e3)))%seed down to less than the milisecond

    %convert the jump sigmas to real numbers instead of percentages
    TD_parameters.sig_Vp = range(TD_parameters.Vp_bounds)*TD_parameters.sig/100;
    Vpr                  = range(TD_parameters.Vp_bounds);
    
    xVec = dataStruct.xVec;
    yVec = dataStruct.yVec;
        
    n  = length(dataStruct.arrivalTime);
    xr = (TD_parameters.sig/100)*(max(xVec(:)) - min(xVec));
    yr = (TD_parameters.sig/100)*(max(yVec(:)) - min(yVec));
    
    TD_parameters.sig_sig = TD_parameters.max_sig*TD_parameters.sig/100;
    
    if ~TD_parameters.enforce_discon && isfield(dataStruct, 'discontinuity')
    
        dataStruct = rmfield(dataStruct, 'discontinuity');
        
    end
            
    valid = 0;    
    while ~valid
    
        [ model, dataStruct, valid ] = build_starting_Pn(TD_parameters, dataStruct);
                
    end
            
    valid      = 1;
    phiN       = 0;
    likelyhood = 0;
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
                                                                                
                    F    = return_interpolant(model, 1:model.nCells, TD_parameters.interp_style);
                    cVp  = F(xNew, yNew);
                        
                    Vpnew = normrnd(cVp, TD_parameters.sig_Vp);
                        
                    xCell_n    = [ model.xCell; xNew ];
                    yCell_n    = [ model.yCell; yNew ];
                    Vp_n       = [ model.Vp; Vpnew ];

                    modeln               = model;
                    modeln.xCell         = xCell_n;
                    modeln.yCell         = yCell_n;
                    modeln.Vp            = Vp_n;
                    modeln.nCells        = modeln.nCells + 1;
                                                    
                    if strcmp(TD_parameters.prior, 'Normal')
                        
                        [modeln.phi, modeln.likelyhood, ~, valid] = evaluate_Pn(modeln, dataStruct, TD_parameters);

                        alpha = min([1 ((model.nCells)/(model.nCells + 1))*...
                            (TD_parameters.sig_Vp/(TD_parameters.Vp_scale))*...
                            exp(-(Vpnew)^2/(2*TD_parameters.Vp_scale^2)...
                            + (cVp - Vpnew)^2/(2*TD_parameters.sig_Vp^2) - (modeln.phi - model.phi)/2) ]);
                        
                    elseif strcmp(TD_parameters.prior, 'Uniform')
                        
                        if Vpnew > TD_parameters.Vp_bounds(1) && Vpnew < TD_parameters.Vp_bounds(2)
                        
                            [modeln.phi, modeln.likelyhood, ~, valid] = evaluate_Pn(modeln, dataStruct, TD_parameters);
                            
                            alpha = min([1 ((model.nCells)/(model.nCells + 1))*((TD_parameters.sig_Vp*sqrt(2*pi))/(Vpr))...
                                *exp(((cVp - Vpnew)^2)/(2*TD_parameters.sig_Vp^2) - (modeln.phi - model.phi)/2 )]);

                        else

                            valid = 0;

                        end

                    end
                        
                    if rand(1) < alpha && valid

                        model        = modeln;

                    end

                end
                
            case 2 %death

                if model.nCells > TD_parameters.min_cells
                    
                    kill = randi(model.nCells, 1);

                    xCell_n        = model.xCell;
                    yCell_n        = model.yCell;
                    Vp_n           = model.Vp;
                                        
                    Vp_n(kill)       = [];
                    xCell_n(kill)    = [];
                    yCell_n(kill)    = [];
                                 
                    modeln          = model;
                    modeln.xCell    = xCell_n;
                    modeln.yCell    = yCell_n;
                    modeln.Vp       = Vp_n;
                    modeln.nCells   = modeln.nCells - 1;
                    
                    [modeln.phi, modeln.likelyhood, ~, valid] = evaluate_Pn(modeln, dataStruct, TD_parameters);
                    
                    F        = return_interpolant(modeln, 1:modeln.nCells, TD_parameters.interp_style);
                    Vpnew    = F(model.xCell(kill), model.yCell(kill));

                    if strcmp(TD_parameters.prior, 'Normal')
                                                
                        alpha = min([1 ((model.nCells)/(model.nCells - 1))*...
                            ((TD_parameters.Vp_scale)/TD_parameters.sig_Vp)...
                            *exp((model.Vp(kill)^2)/(2*TD_parameters.Vp_scale^2)...
                            - (model.Vp(kill) - Vpnew)^2/(2*TD_parameters.sig_Vp^2) - (modeln.phi - model.phi)/2) ]);
                        
                    elseif strcmp(TD_parameters.prior, 'Uniform')
                                                
                        alpha = min([1 ((model.nCells)/(model.nCells - 1))*((Vpr)/(TD_parameters.sig_Vp*sqrt(2*pi)))...
                            *exp(-((model.Vp(kill) - Vpnew)^2)/(2*TD_parameters.sig_Vp^2) - (modeln.phi - model.phi)/2 )]);
                        
                    end
                                        
                    if rand(1) < alpha && valid
                        
                        model = modeln;                        
                                                
                    end

                end

            case 3 %change t* value   
                
                change       = randi(model.nCells, 1);
                
                Vpn         = model.Vp;
                Vpn(change) = normrnd(model.Vp(change), TD_parameters.sig_Vp);
                
                modeln      = model;
                modeln.Vp   = Vpn;
                
                [modeln.phi, modeln.likelyhood, ~, valid] = evaluate_Pn(modeln, dataStruct, TD_parameters);
                
                if strcmp(TD_parameters.prior, 'Normal')
                    
                    alpha = min( [ 1 exp( (model.Vp(change)^2 - ...
                        Vpn(change)^2)/(2*TD_parameters.Vp_scale^2) ...
                        - (modeln.phi - model.phi)/2) ] );
                
                elseif strcmp(TD_parameters.prior, 'Uniform')
                    
                    if Vpn(change) > TD_parameters.Vp_bounds(1) && Vpn(change) < TD_parameters.Vp_bounds(2)
                        
                        alpha = min( [ 1 exp(-(modeln.phi - model.phi)/2) ]);
                        valid = 1;
                        
                    else
                        
                        valid = 0;
                        
                    end
                    
                end
                                        
                if rand(1) <= alpha && valid
                    
                    model = modeln;
                    
                end
                
            case 4 %move

                if model.nCells > 0
                
                    move    = randi(model.nCells, 1);
                    xCell_n = model.xCell;
                    yCell_n = model.yCell;

                    xCell_n(move) = normrnd(model.xCell(move), xr);
                    yCell_n(move) = normrnd(model.yCell(move), yr);
                                                            
                    if xCell_n(move) > min(xVec) && xCell_n(move) < max(xVec) && ...
                            yCell_n(move) > min(yVec) && yCell_n(move) < max(yVec)
                    
                        modeln       = model;
                        modeln.xCell = xCell_n;
                        modeln.yCell = yCell_n;

                        [modeln.phi, modeln.likelyhood, ~, valid] = evaluate_Pn(modeln, dataStruct, TD_parameters);

                        alpha = min( [ 1 exp(-(modeln.phi - model.phi)/2) ] );
                        
                    else
                        
                        valid = 0;
                        
                    end
                    
                    if rand(1) <= alpha && valid
                        
                        model = modeln;
                        
                    end
                    
                end
                
            case 5 %change sigma

                sig_n       = normrnd(model.allSig, TD_parameters.sig_sig);%assumes uniform
                allSig_n    = sig_n*ones(size(dataStruct.arrivalTime));
                
                if sig_n > 0 && sig_n < TD_parameters.max_sig
                
                    dataStructn        = dataStruct;
                    dataStructn.allSig = allSig_n;

                    [phiN, likelyhood, ~, ~] = evaluate_Pn(model, dataStructn, TD_parameters);%update no nodes

                    alpha = min( [ log(1) (log((model.allSig/sig_n))*(n) - ((phiN - model.phi)/2)) ] );

                    if log(rand(1)) <= alpha

                        dataStruct.allSig   = allSig_n;
                        model.allSig        = allSig_n(1);
                        model.phi           = phiN;
                        model.likelyhood    = likelyhood;

                    end
                    
                end

        end
                
        if iter == 1
            
            model_hist = model;
            
        end
        
        if iter >= TD_parameters.burn_in && mod(iter, TD_parameters.keep_each) == 0
                    
            model_hist(end + 1) = model;
            
        end
        
        nhist(iter)   = model.nCells;
        phihist(iter) = model.phi;
        sighist(iter) = model.allSig;
        llhhist(iter) = model.likelyhood;
        
        if mod(iter, TD_parameters.print_each) == 0
                                 
            disp([ 'Iteration ' num2str(iter)]);
            
        end
                        
    end

    model_hist = model_hist(2:end);
    
end

