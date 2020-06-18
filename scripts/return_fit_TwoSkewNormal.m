function [ phi, pd, values, misfit, pd1, pd2] = return_fit_TwoSkewNormal( dataStruct, nondimvalues, lim_vec )
    
    %dimensionalize the model
    [m,~] = size(lim_vec);
    for k = 1:m
        
        values(k) = nondimvalues(k)*(diff(lim_vec(k,:))) + lim_vec(k,1);
                
    end
        
    p    = values(1);
    mu1  = values(2);
    mu2  = values(3);
    sig1 = values(4);
    sig2 = values(5);
    shp1 = values(6);
    shp2 = values(7);
        
    pd = (1 - p)*(2*normpdf((dataStruct.x - mu1)/sig1).*normcdf(shp1*(dataStruct.x - mu1)/sig1)) + ...
        p*(2*normpdf((dataStruct.x - mu2)/sig2).*normcdf(shp2*(dataStruct.x - mu2)/sig2));
    
    dpdf = dataStruct.x(2) - dataStruct.x(1);
    
    pd = pd/sum(dpdf*pd);
    
    misfit = (pd - dataStruct.data).^2;
    
    phi = sum(misfit);
    
    pd1 = (1 - p)*(2*normpdf((dataStruct.x - mu1)/sig1).*normcdf(shp1*(dataStruct.x - mu1)/sig1))/sum(dpdf*pd);
    pd2 = p*(2*normpdf((dataStruct.x - mu2)/sig2).*normcdf(shp2*(dataStruct.x - mu2)/sig2))/sum(dpdf*pd);
    
end

