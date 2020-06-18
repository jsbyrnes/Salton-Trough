function [ phi, pd, values, misfit, pd1, pd2] = return_fit_ExpGauss( dataStruct, nondimvalues, lim_vec )
    
    %dimensionalize the model
    [m,~] = size(lim_vec);
    for k = 1:m
        
        values(k) = nondimvalues(k)*(diff(lim_vec(k,:))) + lim_vec(k,1);
                
    end
    
    p      = values(1);
    mu     = values(2);
    sig    = values(3);
    lamda  = values(4);

    pd = (1 - p)*((sqrt(2*pi)*sig)^(-1))*exp(-((dataStruct.x - mu).^2)/(2*sig^2)) ...
        + p*exp(-dataStruct.x/lamda)/lamda;
           
    dpdf = dataStruct.x(2) - dataStruct.x(1);
    
    pd = pd/sum(dpdf*pd);
    
    misfit = (pd - dataStruct.data).^2;
    
    phi = sum(misfit);
    
    pd1 = (1 - p)*((sqrt(2*pi)*sig)^(-1))*exp(-((dataStruct.x - mu).^2)/(2*sig^2))/sum(dpdf*pd);
    pd2 = p*(exp(-dataStruct.x/lamda)/lamda)/sum(dpdf*pd);
    
end

