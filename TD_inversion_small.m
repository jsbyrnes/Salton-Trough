addpath('./scripts')
addpath('./Data')

javaaddpath('.\matTaup\matTaup\lib\matTaup.jar')
javaaddpath('.\matTaup\matTaup\lib\matTaupClasses.jar')

TD_parameters = define_TDstructure( );

if ~exist([ './Data/' name '.mat'], 'file')

    %dataStruct = load_data_SaltonTrough3D_3Dsynthetic6(TD_parameters);
    dataStruct = load_data_SaltonTrough3D(TD_parameters);
    %dataStruct = load_data_MAGIC3D(TD_parameters);
    save(name, 'dataStruct');
    
else
    
    load([ './Data/' name '.mat'])

end
%% Let's invert
dataStruct.yVec = 0;

TD_parameters.max_sig        = 0.1;%on t*

TD_parameters.interp_style   = 'nearest';%nearest, linear, or natural. Nearest works fine. 

%rng(10)%make noise same for all chains
%dataStruct.dtS       = normrnd(dataStruct.dtS, 0.003);
%for k = 1:length(unique(dataStruct.dataE))
%        
%    dataStruct.dtS(dataStruct.dataE==k) = dataStruct.dtS(dataStruct.dataE==k) - mean(dataStruct.dtS(dataStruct.dataE==k));
%        
%end

TD_parameters.debug_prior = 0;

TD_parameters.individual_noise = 0;

%p = parpool;

%occasionally, you get runs only have one worker. This cloggs the
%whole process
% if p.NumWorkers == 1
% 
%     error('Problem starting parallel pool');
%     
% end
    
for k = 1:TD_parameters.n_chains

    warning off MATLAB:scatteredInterpolant:DupPtsAvValuesWarnId
    warning off MATLAB:scatteredInterpolant:TooFewPtsInterpWarnId

    disp(['Chain #' num2str(k) ]);
    
    bestmodels(:, k) = TD_inversion_function(TD_parameters, dataStruct, k);
        
end

if ~exist([name nameappend 'inversion1.mat'], 'file')
    
    savename = [ name nameappend 'inversion1.mat'];

else
    
    files = dir([name nameappend 'inversion*.mat']);
    n = length(files) + 1;
    
    savename = [ name nameappend 'inversion' num2str(n) '.mat'];
    
end

disp(['Saving models named ' savename]);
save(savename, '-v7.3')

