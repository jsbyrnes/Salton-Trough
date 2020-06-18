function [ best_vec ] = GibbsSearch( parameters, dataStruct )

    phimin   = 1e9;
    best_vec = zeros(1, parameters.nd);
    
    for i = 1:parameters.n_chains

        vec  = rand(parameters.nd,1);

        for j = 2:parameters.n_iterations

            for k = 1:parameters.nd

                sample_points       = repmat(vec, [1 parameters.nsamples]);
                sample_points(k, :) = normrnd(vec(k),parameters.sig, [ 1 parameters.nsamples]);
                    
                sample_points(k, sample_points(k, :) < 0) = 0;
                sample_points(k, sample_points(k, :) > 1) = 1;
                
                for kk = 1:parameters.nsamples

                    phi(kk)  = parameters.function(dataStruct, sample_points(:, kk), parameters.limits);
                    
                end
                
                [~, ind] = min(phi);
                vec(k)   = sample_points(k, ind);

            end
            
            phi    = parameters.function(dataStruct, vec, parameters.limits);
            
            if phi < phimin
               
                phimin   = phi;
                best_vec = vec;
                
            end
            
        end

    end
        
end

