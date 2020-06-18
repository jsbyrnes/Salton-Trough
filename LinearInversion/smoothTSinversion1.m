%fit a smooth surface to all t* observations through an inversion scheme.
%This inversion is quick and useful for many applications. 
clear, close all
%% collect all lats, lons and t* by loading one results file at a time.

name = 'ST_data4';
sig  = 1e-1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EDIT THESE LINES TO CONTROL THE INVERSION
smoothness          = logspace(-1, 1, 100);
model_smallness     = logspace(-2.5, 0, 100);

dsmooth = log10(smoothness(2)) - log10(smoothness(1));
dsmall  = log10(model_smallness(2)) - log10(model_smallness(1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EDIT THIS LINE TO LOAD THE DATA
load( [ '../Data/' name '.mat']);
%rng(100)%make noise same for all chains
%dataStruct.dtS       = normrnd(dataStruct.dtS, sig);
%for k = 1:length(unique(dataStruct.dataE))
%        
%    dataStruct.dtS(dataStruct.dataE==k) = dataStruct.dtS(dataStruct.dataE==k) - mean(dataStruct.dtS(dataStruct.dataE==k));
%        
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%
%Save results as 
name = 'LinearInv2';
%%%%%%

%%%%%%
%These lines control how things are plotted
v                   = -2:0.2:2;
clim                = [min(v) max(v)];
label_for_colorbar  = '\Deltat*, s';

%%

[SMALL, SMOOTH] = meshgrid(model_smallness, smoothness);

p = parpool;

if p.NumWorkers

    error('Parpool didn''t start bro!');
    
end

parfor k = 1:numel(SMOOTH)
        
    [~, misfit(k)] = linear_tomography(dataStruct, SMALL(k), SMOOTH(k), sig);

end

%% Minimum curvature
misfit = reshape(misfit, size(SMOOTH));

L = del2(misfit, dsmall, dsmooth);

figure(1)
subplot(211)
contourf(log10(model_smallness), log10(smoothness), misfit, 3:10);colorbar
subplot(212)
contourf(log10(model_smallness), log10(smoothness), L, -5:5);colorbar

save([ name '.mat' ]);
