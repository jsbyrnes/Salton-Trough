function [ dataStruct ] = load_data_TASRP( TD_parameters )

    allLats   = [];
    allLons   = [];
    allTS     = [];
    allSig    = [];
    dataE     = [];
    allSta    = {};

    stations_to_remove = { };

    elevation_correction = 0;%slowness in s/m to use, 0 to not do it.
    lat_box = [40 49];
    lon_box = [-120 -104];

    fnames             = { 'USArray_21_result' 'USArray_22_result' 'USArray_27_result' 'USArray_28_result' 'USArray_29_result' 'USArray_30_result' 'USArray_33_result' };
    fnames_QC          = { 'USArray_21_resultQC' 'USArray_22_resultQC' 'USArray_27_resultQC' 'USArray_28_resultQC' 'USArray_29_resultQC' 'USArray_30_resultQC' 'USArray_33_resultQC' };

    for k=1:length(fnames)

        %get the QC first and from the attenuation results
        qcfile=['C:\Research\tstar\USArray_Attenuation\MATLAB\JSBFilterAndQC\' fnames_QC{k} '.mat']; %recorrected results
        %qcfile=['C:\Research\tstar\JSBUSArray\USArray\Unfiltered_Measurements\' fnames_QC{k} '.mat']; %recorrected results
        load(qcfile);

        qc = [Traces.QC];
        qc_sta = {Traces.station};
        %fname=['../results/' fnames{k} 'QC'];%sarah's results
        %fname=['../TA_formatXCOR/' fnames{k} ]; %XCOR Results
        %fname=['../JSBFilterAndQC/' fnames{k} '.mat']; %recorrected results
        fname=['C:\Research\tstar\JSBUSArray\USArray\Unfiltered_Measurements\' fnames{k} '.mat']; %recorrected results

        load(fname);
        corrtraces = ts_run;
        %corrtraces = corrTraces;

        for i = 1:length(corrtraces)

            ind = find(strcmp(corrtraces(i).station, qc_sta), 1);

            if ~isempty(ind)

                qc_apply(i) = qc(ind);

            else

                qc_apply(i) = 0;

            end

        end

        corrtraces = corrtraces(logical(qc_apply));

        qc_apply = [];

        %loop to remove doubled lats/lons (not my preferred solution)
        for kt=1:length(corrtraces)
            lt=corrtraces(kt).latitude;
            corrtraces(kt).latitude=lt(1);

            ln=corrtraces(kt).longitude;
            corrtraces(kt).longitude=ln(1);

        end

        sta  = {corrtraces.station};
        lats = [corrtraces.latitude];
        lons = [corrtraces.longitude];
        tS   = [corrtraces.tStar];
        elev = [corrtraces.elevation];

        for i = 1:length(stations_to_remove)

            indkill = strcmp(stations_to_remove(i), sta);

            sta(indkill)      = [];
            lats(indkill)     = [];
            lons(indkill)     = [];
            tS(indkill)       = [];
            elev(indkill)     = [];

        end

        %cull by the box size
        lat_cull = lats>lat_box(2) | lats<lat_box(1);
        lon_cull = lons>lon_box(2) | lons<lon_box(1);

        lats(lat_cull | lon_cull) = [];
        lons(lat_cull | lon_cull) = [];
        tS(lat_cull | lon_cull)   = [];
        sta(lat_cull | lon_cull)  = [];
        elev(lat_cull | lon_cull) = [];

        tS = tS + elev*elevation_correction;

        allLats=[allLats lats];
        allLons=[allLons lons];
        allTS=[allTS tS];
        allSta=[allSta sta];
        dataE=[dataE lats*0+k]; % this is just the event number

    end

    %% define a map projection and inversion grid
    %origin in the center of the array footprint
    centerLat=min(allLats)+(max(allLats)-min(allLats))/2;
    centerLon=min(allLons)+(max(allLons)-min(allLons))/2;

    origin = [ centerLat centerLon ];           % array center [ lat lon ]

    mstruct             = defaultm('mercator');
    mstruct.origin      = [origin 0];
    mstruct             = defaultm( mstruct );
    mstruct.scalefactor = 6371;

    %projected lat/lon of observations to X/Y:
    [dataX, dataY] = mfwdtran(mstruct,allLats,allLons);
    %figure; plot(dataX,dataY,'k.')

    %make the grid on which to invert
    minX = min(dataX) - TD_parameters.buffr;
    maxX = max(dataX) + TD_parameters.buffr;
    minY = min(dataY) - TD_parameters.buffr;
    maxY = max(dataY) + TD_parameters.buffr;

    xVec = minX:TD_parameters.nodeSpacing:maxX;
    yVec = minY:TD_parameters.nodeSpacing:maxY;

    load C:\Research\tstar\USArray_Attenuation\MATLAB\states.mat
    [statesX, statesY]=mfwdtran(mstruct,lat,lon);
    
    dataStruct.allTS   = allTS;
    dataStruct.allLats = allLats;
    dataStruct.allLons = allLons;
    dataStruct.allSig  = 0.3*ones(size(allTS));
    dataStruct.allSta  = allSta;
    dataStruct.dataX   = dataX;
    dataStruct.dataY   = dataY;
    dataStruct.dataE   = dataE;
    dataStruct.xVec    = xVec;
    dataStruct.yVec    = yVec;
    dataStruct.statesX  = statesX;
    dataStruct.statesY  = statesY;
    
end

