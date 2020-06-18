function [ dataStruct ] = load_data_PnCascadia( TD_parameters )

    allLats     = [];
    allLons     = [];
    arrivalTime = [];
    allSig      = [];
    dataE       = [];
    allSta      = {};

    %fnames = dir('../DeepResults/*result.mat');
    %fnames = dir('./*witherror.mat');
    %fnames = dir('./*_ShallowWithError.mat');
    %fnames = dir('./tSMeasurements/tS-*');

    load('C:/Research/tstar/TDTomography/PnCascadia/srEvent_Tomo_Final.mat');
    load('C:/Research/tstar/TDTomography/PnCascadia/tlArrival_Tomo.mat');
    load('C:/Research/tstar/TDTomography/PnCascadia/srStation_Tomo_Final.mat');
    
    %% define a map projection and inversion grid
    %origin in the center of the array footprint

    centerLat = min(allLats)+(max(allLats)-min(allLats))/2;
    centerLon = min(allLons)+(max(allLons)-min(allLons))/2;

    origin               = [ mean([srStation.latitude]) mean([srStation.longitude]) ];           % array center [ lat lon ]
    mstruct              = defaultm('mercator');
    mstruct.origin       = [ origin TD_parameters.rotation ];%second number is rotation
    mstruct              = defaultm( mstruct );
    mstruct.scalefactor  = 6371;

    %%%%%%%%%%
    %%%consider rotating the grid for the inversion so cut down the number
    %%%of unsed nodes
    %%%%%%%%%%

    %projected lat/lon of stations to X/Y:
    [staX, staY] = mfwdtran(mstruct,srStation.latitude,srStation.longitude);
    [evtX, evtY] = mfwdtran(mstruct,srEvent.latitude,srEvent.longitude);
    %figure; plot(dataX,dataY,'k.');
    %dataY(:) = 0;
    %make the grid on which to invert
    
    minX = min([ staX; evtX ]) - TD_parameters.buffer;
    maxX = max([ staX; evtX ]) + TD_parameters.buffer;
    minY = min([ staY; evtY ]) - TD_parameters.buffer;
    maxY = max([ staY; evtY ]) + TD_parameters.buffer;

    dataStruct.xVec = minX:TD_parameters.XYnodeSpacing:maxX;
    dataStruct.yVec = minY:TD_parameters.XYnodeSpacing:maxY;    
        
    dataStruct.arrivalTime   = tlArrival.time;
    dataStruct.allSta        = tlArrival.station;
    dataStruct.dataE         = tlArrival.eventid;
        
    %fill out the ray paths
    for i = 1:length(dataStruct.arrivalTime)
        
        %event lat,lon
        ex = evtX(dataStruct.dataE(i) == srEvent.id);
        ey = evtY(dataStruct.dataE(i) == srEvent.id);
                
        sx = staX(strcmp(dataStruct.allSta(i), srStation.name));
        sy = staY(strcmp(dataStruct.allSta(i), srStation.name));
        
        raylen = sqrt( (ex - sx)^2 + (ey - sy)^2);        
        raylen = [ 0:TD_parameters.arc_inc:raylen raylen];
        
        angle = atan2d( (sy - ey),(sx - ex));
        
        dataStruct.ray(i).x = ex + cosd(angle).*raylen;
        dataStruct.ray(i).y = ey + sind(angle).*raylen;
        
        dataStruct.arrivalTime(i) = dataStruct.arrivalTime(i)...
             - srEvent.origintime(dataStruct.dataE(i) == srEvent.id) ...
             - srStation.statics.P(strcmp(dataStruct.allSta(i), srStation.name));
        
        dataStruct.staX(i) = sx;
        dataStruct.staY(i) = sy;
        dataStruct.evtX(i) = ex;
        dataStruct.evtY(i) = ey;
         
    end
                    
end

