function [ dataStruct ] = load_data_SaltonTrough3D( TD_parameters )

    %output stored in ST_data3.mat

    allLats   = [];
    allLons   = [];
    allTS     = [];
    allSig    = [];
    dataE     = [];
    allSta    = {};

    datadir                  = '.\Post2pifix_measurements\*_1.5Hz_result.mat';
    QC                       = 0;
    fnames                   = { '004', '006', '011', '020', '028', '030', '046', '048' };
    eventind                 = [ 4 6 11 20 28 30 46 48 ];
    stations_to_remove       = { 'MLAC' 'SNCC' 'SCI2' 'PDM' 'B01' 'M02' 'S01' 'N01'};
    
    load('.\Post2pifix_measurements\SSIP.mat');
        
    files = dir(datadir);
    
    for k = 1:length(files)
        
        load([ files(k).folder '\' files(k).name ], 'ts_run');
        traces=ts_run; clear ts_run;
        
        if QC
            
            fname=[ dir_ssip 'SSIP_' fnames{k} '_1.5Hz_resultQC.mat'];
            load(fname);
            passedQC = [Traces.QC];
            traces   = traces(passedQC);
            
        end
        
        %loop to remove doubled lats/lons (not my preferred solution), not
        %needed in 99.9999% of cases
        for kt=1:length(traces)
            
            lt=traces(kt).latitude;
            traces(kt).latitude=lt(1);
            
            ln=traces(kt).longitude;
            traces(kt).longitude=ln(1);
            
        end
        
        sta   = {traces.station};
        lats  = [traces.latitude];
        lons  = [traces.longitude];
        tS    = [traces.tStar];
        
        for i = 1:length(stations_to_remove)
            
            indkill = strcmp(stations_to_remove(i), sta);
            
            sta(indkill)      = [];
            lats(indkill)     = [];
            lons(indkill)     = [];
            tS(indkill)       = [];
            
        end
        
        allLats  = [allLats lats];
        allLons  = [allLons lons];
        allTS    = [allTS tS];
        allSta   = [allSta sta];
        dataE    = [dataE lats*0+k]; % this is just the event number
        %allError = [allError error]
        
    end

    uSta=unique(allSta); %list of all station names

    allSig  = 0.2*ones(size(allTS));

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
    %figure; plot(dataX,dataY,'k.');
    %dataY(:) = 0;
    %make the grid on which to invert

    load coastlines.mat

    [coastX, coastY] = mfwdtran(mstruct, coastlat, coastlon);
    
    minX = min(dataX) - TD_parameters.buffer;
    maxX = max(dataX) + TD_parameters.buffer;
    minY = min(dataY) - TD_parameters.buffer;
    maxY = max(dataY) + TD_parameters.buffer;

    xVec = minX:TD_parameters.XYnodeSpacing:maxX;
    yVec = minY:TD_parameters.XYnodeSpacing:maxY;    
    zVec = TD_parameters.min_depth:TD_parameters.ZnodeSpacing:TD_parameters.max_depth;
    
    dataStruct.dtS     = allTS;
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
    dataStruct.coastX  = coastX;
    dataStruct.coastY  = coastY;
    
    [vp,~] = iasp91(zVec);
    
    vp(isnan(vp)) = interp1(zVec(~isnan(vp)), vp(~isnan(vp)), zVec(isnan(vp)), 'nearest', 'extrap');
    
    load('.\Barak_Lekic_models\LAB_depths.mat');
    GLON = LON;
    GLAT = LAT;
    clear LON LAT
    
    GLON = GLON(:);
    GLAT = GLAT(:);
    GDEP = depth_grid(:);
    
    GLON(isnan(GDEP)) = [];
    GLAT(isnan(GDEP)) = [];
    GDEP(isnan(GDEP)) = [];
    
    dataStruct.discontinuity(1).sign        = 0;%Must be zero, deprecaited feature
    dataStruct.discontinuity(1).z           = GDEP;
    dataStruct.discontinuity(1).lon         = GLON;
    dataStruct.discontinuity(1).lat         = GLAT;
    
    [dataStruct.discontinuity(1).x, dataStruct.discontinuity(1).y] ...
        = mfwdtran(mstruct,GLAT,GLON);

    dataStruct.discontinuity(1).interpolant_xy = scatteredInterpolant(dataStruct.discontinuity(1).x...
        , dataStruct.discontinuity(1).y, GDEP, 'nearest');
    dataStruct.discontinuity(1).interpolant_latlon ...
        = scatteredInterpolant(GLON, GLAT, GDEP, 'nearest');
    
    for i = 1:length(dataStruct.dtS)
        
        %event lat,lon
        elat = E(eventind(dataE(i))).PreferredLatitude;
        elon = E(eventind(dataE(i))).PreferredLongitude;
        
        %have to do this one at a time, but at least taupPierce makes it
        %easy
        for j = 1:length(zVec)
           
            tt = taupPierce([], E(eventind(dataE(i))).PreferredDepth, 'P', 'sta', [allLats(i) allLons(i)], 'evt', [elat elon], 'pierce', zVec(j), 'nodiscon');
            dataStruct.ray(i).lat(j) = tt.pierce.latitude(tt.pierce.latitude~=0);
            dataStruct.ray(i).lon(j) = tt.pierce.longitude(tt.pierce.longitude~=0);
            
        end
        
        [ dataStruct.ray(i).x, dataStruct.ray(i).y ] = mfwdtran(mstruct, dataStruct.ray(i).lat, dataStruct.ray(i).lon);
        dataStruct.ray(i).U       = 1./vp;%dummy model for now
        dataStruct.ray(i).zeta    = zeros(size(vp));
        dataStruct.ray(i).id      = zeros(size(vp));
        
        dataStruct.discontinuity(1).rayz  (i) = interp1(dataStruct.discontinuity(1).interpolant_latlon...
            (dataStruct.ray(i).lon, dataStruct.ray(i).lat) - dataStruct.zVec, dataStruct.zVec, 0, 'linear');
        dataStruct.discontinuity(1).raylat(i) = interp1(dataStruct.zVec, dataStruct.ray(i).lat, dataStruct.discontinuity(1).z(i), 'linear');
        dataStruct.discontinuity(1).raylon(i) = interp1(dataStruct.zVec, dataStruct.ray(i).lon, dataStruct.discontinuity(1).z(i), 'linear');
        dataStruct.discontinuity(1).rayX(i)   = interp1(dataStruct.zVec, dataStruct.ray(i).x, dataStruct.discontinuity(1).z(i), 'linear');
        dataStruct.discontinuity(1).rayY(i)   = interp1(dataStruct.zVec, dataStruct.ray(i).y, dataStruct.discontinuity(1).z(i), 'linear');
        dataStruct.discontinuity(1).rayU(i)   = interp1(dataStruct.zVec, dataStruct.ray(i).U, dataStruct.discontinuity(1).z(i), 'linear');
           
    end
        
end

