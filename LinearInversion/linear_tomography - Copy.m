function [MImodel,misfit, X, Z] = linear_tomography(dataStruct, smoothness, model_smallness, error)

    [X,Z] = meshgrid(dataStruct.xVec, dataStruct.zVec);
    
    % zeroeth step: sizes of things
    nData   = length(dataStruct.dtS); %number of observations
    nModel  = numel(X);  %number of model nodes
    nEvents = length(unique(dataStruct.dataE)); %number of events

    % and change variable names:
    dataV = dataStruct.dtS';

    %allocate G
    G = nan(nData,nModel);

    %%%%%
    %%%%%Partial Derivatives
    %%%%% Pass these out along ray paths
    for k = 1:nData

        hits = zeros(size(Z));

        for kk = 1:length(dataStruct.zVec)

            [~, ind]  = min( sqrt( (X(:) - dataStruct.ray(k).x(kk)).^2 ...
                + (Z(:) - dataStruct.zVec(kk)).^2 ));
            hits(ind) = 1;

        end

        G(k, :) = hits(:);

    end

    %event term
    %allocate
    Gevt = nan(nData,nEvents);
    %build row-by-row
    for k = 1:nData
       Gevt(k,:)        = 0;
       Gevt(k,dataStruct.dataE(k)) = 1;
    end

    %Put sensitivity matrix together:
    G = [G Gevt];

    %model smallness
    GMsml = eye(nModel);
    GMsml = GMsml*model_smallness; % smallness control factor

    %add regularization matrices
    %Gexpanded = [G; [zeros(nSta,nModel) zeros(nSta,nEvents) ]];
    Gexpanded = [G; [GMsml zeros(nModel,nEvents) ]];

    %smoothness constraint
    makeSmoothness % this script produces Gsmth
    Gsmth     = Gsmth*smoothness;
    Gexpanded = [Gexpanded; [Gsmth zeros(nModel,nEvents)]];

    %% build expanded d
    dExpanded = [dataV; zeros(nModel,1); zeros(nModel,1)];
    %the added zeros are for station term smallness, model smallness and model
    %smoothness.

    %% and invert
    Minverted = Gexpanded\dExpanded;% lsqr(Gexpanded, dExpanded, 1e-10, 3000);%
    MI        = Minverted;

    MImodel             = Minverted(1:nModel)*1000;
    Minverted(1:nModel) = [];

    MIevt                = Minverted(1:nEvents);
    Minverted(1:nEvents) = [];

    MImodel = reshape(MImodel,size(X));

    %% get the misfit
    for k = 1:nData

        rayX     = dataStruct.ray(k).x;
        rayU     = dataStruct.ray(k).U;
        ray_zVec = dataStruct.zVec;

        rayL       = zeros(length(rayX)-1,1);
        raymQinv   = zeros(length(rayX)-1,1);
        U          = zeros(length(rayX)-1,1);

        for kk = 1:(length(rayX) - 1) %hope there's no subloop

            rayL(kk)      = sqrt( (rayX(kk) - rayX(kk + 1))^2 ...
                + (ray_zVec(kk) - ray_zVec(kk + 1))^2);

            [~, indkk]  = min( sqrt( (X(:) - rayX(kk)).^2 ...
                + (Z(:) - dataStruct.zVec(kk)).^2 ));
            [~, indkk1]  = min( sqrt( (X(:) - rayX(kk + 1)).^2 ...
                + (Z(:) - dataStruct.zVec(kk + 1)).^2 ));

            raymQinv(kk)  = 0.5*(MImodel(indkk) + MImodel(indkk1));%convert from mQinv to dQinv
            U(kk)         = 0.5*(rayU(kk) + rayU(kk + 1));

        end

        ptS(k) = sum(rayL.*U.*raymQinv/1000);

    end

    dtS = dataStruct.dtS;

    ptS = ptS - mean(ptS);

    es = e_static(ptS - dtS, dataStruct.dataE);

    %adjust the data for the predicted mean offset
    for k = 1:length(unique(dataStruct.dataE))

        dtS(dataStruct.dataE==k) = dtS(dataStruct.dataE==k) + MIevt(k);

    end

    misfit = sum(((ptS - dtS)/error).^2)/length(ptS);

end

