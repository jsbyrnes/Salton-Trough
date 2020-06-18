function [ dataStruct ] = load_data_MAGIC3D_syn1( TD_parameters )

    allLats   = [];
    allLons   = [];
    allTS     = [];
    allSig    = [];
    dataE     = [];
    allSta    = {};

    load('MAGICeventData.mat');
    
    %fnames = dir('../DeepResults/*result.mat');
    fnames = dir('C:\Research\tstar\MAGIC\SourceTest\*Deepwitherror.mat');
    %fnames = dir('./*_ShallowWithError.mat');
    fnames = { fnames.name };

    for k=1:length(fnames)

        fname=[ 'C:\Research\tstar\MAGIC\SourceTest\' fnames{k} ];
    %    fname=[ '../DeepResults/' fnames{k} ];

        load(fname, 'Traces', 'tsMeanVel');
        traces = Traces; clear Traces
    %     load(fname, 'ts_run');
    %     traces = ts_run; clear Traces

        %loop to remove doubled lats/lons (not my preferred solution)
        for kt=1:length(traces)

            lt=traces(kt).latitude;
            traces(kt).latitude=lt(1);

            ln=traces(kt).longitude;
            traces(kt).longitude=ln(1);

        end

        sta   = {traces.station};
        lats  = [traces.latitude];
        lons  = [traces.longitude];
        tS    = tsMeanVel;%[traces.tS_slopes];;%[traces.tStar];tsMeanVel
        sig   = 0.125*ones(size([traces.tStar]));%[traces.sigma];

    %     allLats  = [allLats lats lats ];
    %     allLons  = [allLons lons lons ];
    %     allTS    = [allTS tS tS ];
    %     allSig   = [allSig sig sig ];
    %     allSta   = [allSta sta sta ];
    %     dataE    = [dataE lats*0+k lats*0+k]; % this is just the event number
        allLats  = [ allLats lats ];
        allLons  = [ allLons lons ];
        allTS    = [ allTS tS ];
        allSig   = [ allSig sig ];
        allSta   = [ allSta sta ];
        dataE    = [ dataE lats*0+k ]; % this is just the event number

    end

    uSta=unique(allSta); %list of all station names

    %%%%synthetic data
    %synthetic model with two steps
    % allTS(:)                                   = 0;%normrnd(0, noise, size(allTS));
    % allTS( allLons < -79 & allLons > -80 )     =  0.2;
    % allTS( allLons < -81 & allLons > -82 )     = -0.2;
    % 
    % for k = 1:3
    % 
    % 	allTS(dataE == k) = allTS(dataE==k) + normrnd(0,0.075, size(allTS(dataE==k)));
    % 
    % end
    % 
    % for k = 4:6
    % 
    % 	allTS(dataE == k) = allTS(dataE==k) + normrnd(0, 0.15, size(allTS(dataE==k)));
    % 
    % end

    % 
    % trueModel = zeros(size(allLons));
    % trueModel( allLons < -81 & allLons > -82 )  = -0.2;
    % trueModel( allLons < -79 & allLons > -80 )      = 0.2;

    %synthetic model with a linear increase
    %allLons = linspace(min(allLons), max(allLons), length(allLons));
    %allLats = linspace(min(allLats), max(allLats), length(allLats));
    %allTS(:) = normrnd(0, noise, size(allTS)) + (( 0.4/(max(allLons) - min(allLons)) *(allLons - min(allLons))) - 0.2);

    %make half the data random
    %allTS( (length(allTS)+1):2*length(allTS) ) = 0.8*rand(size(allTS)) - 0.4;
    % dataE   = [ dataE ( dataE + max(dataE)) ];
    % allLats = [ allLats allLats ];
    % allLons = [ allLons allLons ];
    % allSta  = [ allSta allSta ];

    allSig  = 0.3*ones(size(allTS));

    for k = 1:length(unique(dataE))

        allTS(dataE==k) = allTS(dataE==k) - mean(allTS(dataE==k));

    end

    %% define a map projection and inversion grid
    %origin in the center of the array footprint

    centerLat = min(allLats)+(max(allLats)-min(allLats))/2;
    centerLon = min(allLons)+(max(allLons)-min(allLons))/2;

    origin               = [ centerLat centerLon ];           % array center [ lat lon ]
    mstruct              = defaultm('mercator');
    mstruct.origin       = [ origin TD_parameters.rotation ];%second number is rotation
    mstruct              = defaultm( mstruct );
    mstruct.scalefactor  = 6371;

    %%%%%%%%%%
    %%%consider rotating the grid for the inversion so cut down the number
    %%%of unsed nodes
    %%%%%%%%%%

    %projected lat/lon of observations to X/Y:
    [dataX, dataY] = mfwdtran(mstruct,allLats,allLons);
    dataY = zeros(size(dataY));

    %make the grid on which to invert

    minX=min(dataX) - TD_parameters.buffr;
    maxX=max(dataX) + TD_parameters.buffr;
    minY=min(dataY) - TD_parameters.buffr;
    maxY=max(dataY) + TD_parameters.buffr;

    xVec = minX:TD_parameters.XYnodeSpacing:maxX;
    yVec = minY:TD_parameters.XYnodeSpacing:maxY;    
    zVec = TD_parameters.min_depth:TD_parameters.ZnodeSpacing:TD_parameters.max_depth;
    
    dataStruct.allTS   = allTS;
    dataStruct.allLats = allLats;
    dataStruct.allLons = allLons;
    dataStruct.allSig  = allSig;
    dataStruct.allSta  = allSta;
    dataStruct.dataX   = dataX;
    dataStruct.dataY   = dataY;
    dataStruct.dataE   = dataE;
    dataStruct.xVec    = xVec;
    dataStruct.yVec    = yVec;
    dataStruct.zVec    = zVec;
    
    [vp,~] = iasp91(zVec);
    
    vp(isnan(vp)) = interp1(zVec(~isnan(vp)), vp(~isnan(vp)), zVec(isnan(vp)), 'nearest', 'extrap');
    
    %fill out the ray paths
    for i = 1:length(dataStruct.allTS)
        
        %event lat,lon
        elat = E(dataE(i)).PreferredLatitude;
        elon = E(dataE(i)).PreferredLongitude;
        
        %have to do this one at a time, but at least taupPierce makes it
        %easy
        for j = 1:length(zVec)
           
            tt = taupPierce([], E(dataE(i)).PreferredDepth, 'P', 'sta', [allLats(i) allLons(i)], 'evt', [elat elon], 'pierce', zVec(j), 'nodiscon');
            
            try
            
                dataStruct.ray(i).lat(j) = tt.pierce.latitude(find(tt.pierce.latitude~=0, 1, 'last'));
                dataStruct.ray(i).lon(j) = tt.pierce.longitude(find(tt.pierce.longitude~=0, 1, 'last'));
            
            catch
                
                keyboard
                
            end
            
        end
        
        [ dataStruct.ray(i).x, dataStruct.ray(i).y ] = mfwdtran(mstruct, dataStruct.ray(i).lat, dataStruct.ray(i).lon);
        dataStruct.ray(i).U = 1./vp;%dummy model for now
        
    end
    
    %%%%%%%%%
    %make a 3D synthetic model and predict t* with it
    Qmodel = (1/1000)*ones(length(xVec), length(yVec), length(zVec));
    
    Qmodel(xVec>=100 & xVec<=200, :, zVec>=80 & zVec<=150) = 1/50;

    [Y, X, Z] = meshgrid(yVec, xVec, zVec);
    
    F    = scatteredInterpolant(X(:), Z(:), Qmodel(:), 'nearest');
    
    for k = 1:length(dataStruct.allTS);
        
        %get tS at ray nodes
        rayX = dataStruct.ray(k).x;
        rayY = zeros(size(rayX));
        rayU = dataStruct.ray(k).U;
        
        %integrate over the ray path
        Qinv = F(rayX,dataStruct.zVec);
        
        for kk = 1:(length(rayX) - 1) %hope there's no subarray
            
            rayL(kk)    = sqrt( (rayX(kk) - rayX(kk + 1))^2 + (rayY(kk) - rayY(kk + 1))^2 ...
                + (dataStruct.zVec(kk) - dataStruct.zVec(kk + 1))^2);
            rayQinv(kk) = 0.5*(Qinv(kk) + Qinv(kk + 1));
            U(kk)       = 0.5*(rayU(kk) + rayU(kk + 1));
            
        end
                
        dataStruct.allTS(k) = sum(rayL.*rayQinv.*U);
        
    end
    
    de = unique(dataStruct.dataE);
    for k = 1:length(de)
       
        dataStruct.allTS(dataStruct.dataE == de(k)) = dataStruct.allTS(dataStruct.dataE == de(k)) ...
            - mean(dataStruct.allTS(dataStruct.dataE == de(k)));
        
    end
    
end

