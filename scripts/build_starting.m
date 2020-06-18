function [ model, dataStruct, valid ] = build_starting( TD_parameters, dataStruct )

    maxattempts = 1e5;

    xVec = dataStruct.xVec;
    yVec = dataStruct.yVec;
    zVec = dataStruct.zVec;
    
    model.nCells       = floor(exp(rand(1)*(log(TD_parameters.max_cells) - ...
        log(TD_parameters.min_cells)) + log(TD_parameters.min_cells)));
           
    model.id          = (1:model.nCells)';
    model.node_change = ones(model.nCells, 1);
    model.xCell       = min(xVec(:)) + (max(xVec(:)) - min(xVec))*rand([ model.nCells 1 ]);
    model.yCell       = min(yVec(:)) + (max(yVec(:)) - min(yVec))*rand([ model.nCells 1 ]);
    model.zCell       = min(zVec(:)) + (max(zVec(:)) - min(zVec))*rand([ model.nCells 1 ]);
            
    if strcmp(TD_parameters.prior, 'Normal')
        
        model.zeta       = normrnd(0, TD_parameters.zeta_scale, model.nCells, 1);
        
    elseif strcmp(TD_parameters.prior, 'Exponential')
        
        model.zeta       = -log(rand(model.nCells, 1))*TD_parameters.zeta_scale;
        
    elseif strcmp(TD_parameters.prior, 'Uniform')
        
        %zero mean
        model.zeta       = rand(model.nCells, 1)*TD_parameters.zeta_scale*2 - TD_parameters.zeta_scale;
        
    end
    
    if isfield(dataStruct, 'discontinuity')
       
        for k = 1:model.nCells
           
            if model.zCell(k) < dataStruct.discontinuity.interpolant_xy(model.xCell(k), model.yCell(k))
                
                model.layer(k) = 1;
                
            else
               
                model.layer(k) = 2;
                
            end
            
        end
        
        for n = 1:int32(max(model.layer))
           
            if sum(model.layer == n) == 0
                
                valid = 0;
                return
                
            end
            
        end
            
        %enforce the sign of the discontinuities
        
        if dataStruct.discontinuity.sign ~= 0
        
            for n = 1:length(dataStruct.discontinuity) + 1

                if any(yVec)

                    Fq{n}    = scatteredInterpolant(model.xCell(model.layer==n), ...
                        model.yCell(model.layer==n), model.zCell(model.layer==n), ...
                         model.zeta(model.layer==n), TD_parameters.interp_style);

                else

                    Fq{n}    = scatteredInterpolant(model.xCell(model.layer==n), ...
                        model.zCell(model.layer==n), model.zeta(model.layer==n), TD_parameters.interp_style);

                end

                if n > 1

                    Fa = Fq{n-1};
                    Fb = Fq{n};

                    if any(yVec)

                        Qa = Fa(dataStruct.discontinuity.x, dataStruct.discontinuity.y, dataStruct.discontinuity.z);
                        Qb = Fb(dataStruct.discontinuity.x, dataStruct.discontinuity.y, dataStruct.discontinuity.z);

                    else

                        Qa = Fa(dataStruct.discontinuity.x, dataStruct.discontinuity.z);
                        Qb = Fb(dataStruct.discontinuity.x, dataStruct.discontinuity.z);

                    end

                    if isempty(Qa) || isempty(Qb)

                        valid = 0;
                        return

                    end

                    attempts = 0;

                    while any( sign(Qb - Qa) ~= dataStruct.discontinuity(n-1).sign) && attempts < maxattempts

                        ind = find(sign(Qb - Qa) ~= dataStruct.discontinuity(n-1).sign);

                        tmp = randi(length(ind),1);
                        ind = ind(tmp);

                        if any(yVec)

                            indA = knnsearch([model.xCell(model.layer == (n-1)) model.yCell(model.layer == (n-1)) model.zCell(model.layer == (n-1))], ...
                                [ dataStruct.discontinuity(n-1).x(ind), dataStruct.discontinuity(n-1).y(ind), dataStruct.discontinuity(n-1).z(ind)]);
                            indB = knnsearch([model.xCell(model.layer == (n)) model.yCell(model.layer == (n)) model.zCell(model.layer == (n))], ...
                                [ dataStruct.discontinuity(n-1).x(ind), dataStruct.discontinuity(n-1).y(ind), dataStruct.discontinuity(n-1).z(ind)]);

                        else

                            indA = knnsearch([model.xCell(model.layer == (n-1)) model.zCell(model.layer == (n-1))], ...
                                [ dataStruct.discontinuity(n-1).x(ind), dataStruct.discontinuity(n-1).z(ind)]);
                            indB = knnsearch([model.xCell(model.layer == (n)) model.zCell(model.layer == (n))], ...
                                [ dataStruct.discontinuity(n-1).x(ind), dataStruct.discontinuity(n-1).z(ind)]);

                        end

                        %indA/B are indicies to the nodes in the list of nodes
                        %in their layers, need the indicies for the original
                        %list of nodes
                        indA = find(model.layer == (n-1), indA);indA = indA(end);
                        indB = find(model.layer == (n),   indB);indB = indB(end);

                        if strcmp(TD_parameters.prior, 'Normal')

                            Qnew       = sort(normrnd(0, TD_parameters.zeta_scale, 2, 1));

                        elseif strcmp(TD_parameters.prior, 'Uniform')

                            Qnew       = sort(rand(2, 1)*TD_parameters.zeta_scale*2 - TD_parameters.zeta_scale);

                        elseif strcmp(TD_parameters.prior, 'Exponential')

                            Qnew       = sort(-log(rand(2,1))*TD_parameters.zeta_scale);

                        end

                        if dataStruct.discontinuity(n-1).sign == 1

                            model.zeta(indA) = Qnew(1);
                            model.zeta(indB) = Qnew(2);

                        elseif dataStruct.discontinuity(n-1).sign == -1

                            model.zeta(indA) = Qnew(2);
                            model.zeta(indB) = Qnew(1);

                        else

                            error('Discontinuity sign must be -1 or 1');

                        end

                        %remake the interpolants
                        if any(yVec)

                            Fq{n-1}    = scatteredInterpolant(model.xCell(model.layer == (n-1)), model.yCell(model.layer == (n-1)), model.zCell(model.layer == (n-1)), ...
                                 model.zeta(model.layer == (n-1)), TD_parameters.interp_style);
                            Fq{n}    = scatteredInterpolant(model.xCell(model.layer == n), model.yCell(model.layer == n), model.zCell(model.layer == n), ...
                                 model.zeta(model.layer == n), TD_parameters.interp_style);

                            Fa = Fq{n-1};
                            Fb = Fq{n};

                            Qa = Fa(dataStruct.discontinuity.x, dataStruct.discontinuity.y, dataStruct.discontinuity.z);
                            Qb = Fb(dataStruct.discontinuity.x, dataStruct.discontinuity.y, dataStruct.discontinuity.z);

                        else

                            Fq{n-1}    = scatteredInterpolant(model.xCell(model.layer == (n-1)), model.zCell(model.layer == (n-1)), ...
                                 model.zeta(model.layer == (n-1)), TD_parameters.interp_style);
                            Fq{n}      = scatteredInterpolant(model.xCell(model.layer == n), model.zCell(model.layer == n), ...
                                 model.zeta(model.layer == n), TD_parameters.interp_style);

                            Fa = Fq{n-1};
                            Fb = Fq{n};

                            Qa = Fa(dataStruct.discontinuity.x, dataStruct.discontinuity.z);
                            Qb = Fb(dataStruct.discontinuity.x, dataStruct.discontinuity.z);

                        end

                        attempts = attempts + 1;

                    end

                end

            end
        
        end
        
    else
        
        model.layer       = ones(size(model.xCell));
        
    end
        
    model.allSig      = rand(1)*TD_parameters.max_sig;            
    dataStruct.allSig = model.allSig*ones(size(dataStruct.dtS));
    
    [ model, dataStruct, valid] = evaluate(model, dataStruct, TD_parameters);

end


