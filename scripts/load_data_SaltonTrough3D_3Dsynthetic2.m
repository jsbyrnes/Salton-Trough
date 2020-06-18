function [ dataStruct ] = load_data_SaltonTrough3D_3Dsynthetic2( TD_parameters )

    allLats   = [];
    allLons   = [];
    allTS     = [];
    allSig    = [];
    dataE     = [];
    allSta    = {};

    %fnames = dir('../DeepResults/*result.mat');
    %fnames = dir('./*witherror.mat');
    %fnames = dir('./*_ShallowWithError.mat');
    %fnames = dir('./tSMeasurements/tS-*');

    %dir                      = 'C:\Research\tstar\SaltonTrough\SaltonTrough\CalTech_firstpass\'; 
    dir_ssip                 = 'C:\Research\tstar\SaltonTrough\SaltonTrough\Post2pifix_measurements\';
    QC                       = 1;
    fnames                   = { '004', '006', '011', '020', '028', '030', '046', '048' };
    eventind                 = [ 4 6 11 20 28 30 46 48 ];
    stations_to_remove       = { 'MLAC' 'SNCC' 'SCI2' 'PDM' 'B01' 'M02' 'S01' 'N01'};
    ssip_aswell              = 1;
    pert_ssip                = 0.0;

    load('C:\Research\tstar\SaltonTrough\SaltonTrough\SSIP_data\SSIP.mat');
        
    for k=1:length(fnames)

%         fname=[ dir 'CalTech_SSIP_' fnames{k} '_3Hz_result.mat'];
%         %disp(fname)
% 
%         load(fname, 'ts_run');
%         traces=ts_run; clear ts_run;
% 
%         if QC
% 
%             fname    = [dir 'CalTech_SSIP_' fnames{k} '_3Hz_resultQC.mat'];
%             load(fname);
%             passedQC = [Traces.QC];
%             traces   = traces(passedQC);
%             %error    = error(passedQC);
% 
%         end
% 
%         %loop to remove doubled lats/lons (not my preferred solution)
%         for kt=1:length(traces)
% 
%             lt=traces(kt).latitude;
%             traces(kt).latitude=lt(1);
% 
%             ln=traces(kt).longitude;
%             traces(kt).longitude=ln(1);
% 
%         end
% 
%         sta   = {traces.station};
%         lats  = [traces.latitude];
%         lons  = [traces.longitude];
%         tS    = [traces.tStar];
% 
%         for i = 1:length(stations_to_remove)
% 
%             indkill = strcmp(stations_to_remove(i), sta);
% 
%             sta(indkill)      = [];
%             lats(indkill)     = [];
%             lons(indkill)     = [];
%             tS(indkill)       = [];
%             %error(indkill)    = [];
% 
%         end

        if ssip_aswell

            fname=[ dir_ssip 'SSIP_' fnames{k} '_1.5Hz_result.mat'];

            load(fname, 'ts_run');
            traces=ts_run; clear ts_run;

            if QC

                fname=[ dir_ssip 'SSIP_' fnames{k} '_1.5Hz_resultQC.mat'];
                load(fname);
                passedQC = [Traces.QC];
                traces   = traces(passedQC);
                %error    = error(passedQC);

            end

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
            tS    = [traces.tStar];

            for i = 1:length(stations_to_remove)

                indkill = strcmp(stations_to_remove(i), sta);

                sta(indkill)      = [];
                lats(indkill)     = [];
                lons(indkill)     = [];
                tS(indkill)       = [];
                %error(indkill)    = [];

            end

%             sta   = [ sta sta ];
%             lats  = [ lats lats ];
%             lons  = [ lons lons ];
%             tS    = [ tS (tS + pert_ssip) ];
    %         sta   = [ sta2 ];
    %         lats  = [ lats2 ];
    %         lons  = [ lons2 ];
    %         tS    = [ (tS2 + pert_ssip) ];

        end

        allLats  = [allLats lats];
        allLons  = [allLons lons];
        allTS    = [allTS tS];
        allSta   = [allSta sta];
        dataE    = [dataE lats*0+k]; % this is just the event number
        %allError = [allError error]
        
    end

    uSta=unique(allSta); %list of all station names

    %%%%synthetic data
    % allTS(:)                                   = normrnd(0, noise, size(allTS));
    % allTS( allLons < -79 & allLons > -80 )     = 0.2 + normrnd(0, noise, size(allTS( allLons < -79 & allLons > -80 )));
    % allTS( allLons < -81 & allLons > -82 )     = -0.2 + normrnd(0, noise, size(allTS( allLons < -81 & allLons > -82 )));
    % allTS( (length(allTS)+1):2*length(allTS) ) = 0.8*rand(size(allTS)) - 0.4;
    allSig  = 0.1*ones(size(allTS));
    % dataE   = [ dataE ( dataE + max(dataE)) ];
    % allLats = [ allLats allLats ];
    % allLons = [ allLons allLons ];
    % allSta  = [ allSta allSta ];

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
    
    minX = min(dataX) - TD_parameters.buffr;
    maxX = max(dataX) + TD_parameters.buffr;
    minY = min(dataY) - TD_parameters.buffr;
    maxY = max(dataY) + TD_parameters.buffr;

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
    dataStruct.coastX  = coastX;
    dataStruct.coastY  = coastY;
    
    [vp,~] = iasp91(zVec);
    
    vp(isnan(vp)) = interp1(zVec(~isnan(vp)), vp(~isnan(vp)), zVec(isnan(vp)), 'nearest', 'extrap');
    
    %fill out the ray paths
    for i = 1:length(dataStruct.allTS)
        
        %event lat,lon
        elat = E(eventind(dataE(i))).PreferredLatitude;
        elon = E(eventind(dataE(i))).PreferredLongitude;
        
        %have to do this one at a time, but at least taupPierce makes it
        %easy
        for j = 1:length(zVec)
           
            tt = taupPierce([], 600, 'P', 'sta', [allLats(i) allLons(i)], 'evt', [elat elon], 'pierce', zVec(j), 'nodiscon');
            dataStruct.ray(i).lat(j) = tt.pierce.latitude(tt.pierce.latitude~=0);
            dataStruct.ray(i).lon(j) = tt.pierce.longitude(tt.pierce.longitude~=0);
            
        end
        
        [ dataStruct.ray(i).x, dataStruct.ray(i).y ] = mfwdtran(mstruct, dataStruct.ray(i).lat, dataStruct.ray(i).lon);
        dataStruct.ray(i).U = 1./vp;%dummy model for now
        
        %now fill with placeholders
        dataStruct.ray(i).Qinv   = NaN(size(dataStruct.ray(i).U));
        dataStruct.ray(i).nodeId = NaN(size(dataStruct.ray(i).U));
        
    end
    
    %%%%%%%%%
    %make a 3D synthetic model and predict t* with it
    Qmodel = (1/300)*ones(length(xVec), length(yVec), length(zVec));
    
    Qmodel(xVec<0, :, zVec< 80)             = 1/2000;
    Qmodel(xVec>70, :, zVec<120)            = 1/1000;
    Qmodel(xVec>=0 & xVec<=70, :, zVec<=80) = 1/50;

    [Y, X, Z] = meshgrid(yVec, xVec, zVec);
    
    F    = scatteredInterpolant(X(:), Y(:), Z(:), Qmodel(:), TD_parameters.interp_style);
    
    for k = 1:length(dataStruct.allTS);
    
        %get tS at ray nodes
        rayX = dataStruct.ray(k).x;
        rayY = dataStruct.ray(k).y;
        rayU = dataStruct.ray(k).U;
        
        %integrate over the ray path
        Qinv = F(rayX,rayY,dataStruct.zVec);
        
        for kk = 1:(length(rayX) - 1) %hope there's no subarray
            
            rayL(kk)    = sqrt( (rayX(kk) - rayX(kk + 1))^2 + (rayY(kk) - rayY(kk + 1))^2 ...
                + (dataStruct.zVec(kk) - dataStruct.zVec(kk + 1))^2);
            rayQinv(kk) = 0.5*(Qinv(kk) + Qinv(kk + 1));
            U(kk)       = 0.5*(rayU(kk) + rayU(kk + 1));
            
        end
                
        dataStruct.allTS(k) = sum(rayL.*rayQinv.*U) + normrnd(0, 0.1);
        
    end
    
    de = unique(dataStruct.dataE);
    for k = 1:length(de)
       
        dataStruct.allTS(dataStruct.dataE == de(k)) = dataStruct.allTS(dataStruct.dataE == de(k)) ...
            - mean(dataStruct.allTS(dataStruct.dataE == de(k)));
        
    end
        
end

