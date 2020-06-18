function [ es ] = e_static( all_tS, dataE )

    if isrow(all_tS)
        
        all_tS = all_tS';
        
    end

    G = zeros(length(all_tS), length(unique(dataE)));
    %build row-by-row
    
    for k=1:length(all_tS)
        
       G(k,:)=0;
       
       G(k,dataE(k))=1;
    
    end
    
    %and give a mean of zero
    all_tS(length(all_tS) + 1) = 0;
    G(length(all_tS), :)       = 1;
    
    [ es, ~ ] = lsqr(G, all_tS);
    
end
