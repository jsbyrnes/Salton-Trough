%%%%plot TD inversions
clear
%close all
clc

addpath('./scripts')
%addpath('./Inversions')
addpath('./Data')

warning('off', 'all')
logtransform = 0;

hist_loc      = [ 25  120 ];%x,z. y average. Not in yet
hist_loc_ref  = [ -25 120 ];%x,z. y average. Not in yet

radius = 20;

load('ST_data3ADistribution.mat');

edges = -100:2.5:100;

r = sqrt((X(:) - hist_loc(1)).^2 + (Z(:) - hist_loc(2)).^2);
    
if radius == 0
   
    [~, ind] = min(r);
    mset     = interp_models(ind, :);
   
else
    
    ind = find(r(:) < radius);
    
    for k = 1:length(interp_models)
               
        mset(k) = max(interp_models(ind, k));
        
    end
    
end

r = sqrt((X(:) - hist_loc_ref(1)).^2 + (Z(:) - hist_loc_ref(2)).^2);
    
if radius == 0
   
    [~, ind] = min(r);
    msetref  = interp_models(ind, :);
   
else
    
    ind = find(r(:) < radius);
    
    for k = 1:length(interp_models)
               
        msetref(k) = min(interp_models(ind, k));
        
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pdf     = histcounts(mset, edges, 'Normalization', 'pdf');
edges   = edges(1:end-1) + (edges(2) - edges(1))/2;
ds1.x    = edges;
ds1.data = pdf;

mset = mset - msetref;

pdf     = histcounts(mset, edges, 'Normalization', 'cdf');
edges   = edges(1:end-1) + (edges(2) - edges(1))/2;
ds2.x    = edges;
ds2.data = pdf;

figure(1)
hold on
plot(ds1.x, ds1.data, 'LineWidth', 2)%, xlim([0 75])
figure(2)
hold on
plot(ds2.x, ds2.data, 'LineWidth', 2)%, xlim([0 75])

% 
% figure(1)
% histogram([models.nCells], 'Normalization', 'pdf', 'BinWidth', 1)
% hold on
% plot(TD_parameters.min_cells:TD_parameters.max_cells, ...
%     (1./((TD_parameters.min_cells:TD_parameters.max_cells)*(log(TD_parameters.max_cells) - log(TD_parameters.min_cells)))), 'k')
% 
% figure(2)
% histogram([models.allSig], 'Normalization', 'pdf');
% xlabel('\sigma_t_*, s')