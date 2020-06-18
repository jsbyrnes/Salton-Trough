function [ model, dataStruct, valid ] = build_starting_Pn( TD_parameters, dataStruct )

    xVec = dataStruct.xVec;
    yVec = dataStruct.yVec;
    
    model.nCells       = round(exp(rand(1)*(log(TD_parameters.max_cells) - ...
        log(TD_parameters.min_cells)) + log(TD_parameters.min_cells)));%round((TD_parameters.max_cells - TD_parameters.min_cells)*rand(1)) + TD_parameters.min_cells;
           
    model.xCell       = min(xVec(:)) + (max(xVec(:)) - min(xVec))*rand([ model.nCells 1 ]);
    model.yCell       = min(yVec(:)) + (max(yVec(:)) - min(yVec))*rand([ model.nCells 1 ]);
            
    if strcmp(TD_parameters.prior, 'Normal')
        
        model.mQinv       = normrnd(0, TD_parameters.mQinv_scale, model.nCells, 1);
        
    elseif strcmp(TD_parameters.prior, 'Uniform')
        
        %zero mean
        model.Vp       = rand(model.nCells, 1)*range(TD_parameters.Vp_bounds)...
            + TD_parameters.Vp_bounds(1);
        
    end
        
    model.allSig      = rand(1)*TD_parameters.max_sig;            
    dataStruct.allSig = model.allSig*ones(size(dataStruct.arrivalTime));
    
    [ model.phi, model.likelyhood, ~, valid] = evaluate_Pn(model, dataStruct, TD_parameters);

end


