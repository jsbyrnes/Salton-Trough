addpath('./scripts')
addpath('./Data')

name       = 'ST_syn6'; 
nameappend = 'TestSept';

javaaddpath('.\matTaup\matTaup\lib\matTaup.jar')
javaaddpath('.\matTaup\matTaup\lib\matTaupClasses.jar')

TD_parameters = define_TDstructure( );

if ~exist([ './Data/' name '.mat'], 'file')

    dataStruct = load_data_SaltonTrough3D_3Dsynthetic6(TD_parameters);
    save(name, 'dataStruct');
    
else
    
    load([ './Data/' name '.mat'])

end
%% Let's invert

rng(10)%make noise same for all chains
dataStruct.dtS       = normrnd(dataStruct.dtS, 0.003);
for k = 1:length(unique(dataStruct.dataE))
       
   dataStruct.dtS(dataStruct.dataE==k) = dataStruct.dtS(dataStruct.dataE==k) - mean(dataStruct.dtS(dataStruct.dataE==k));
       
end
    
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

