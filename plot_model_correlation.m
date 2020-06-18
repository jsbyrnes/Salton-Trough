%%%%plot TD inversions
clear
close all
clc

addpath('./scripts')
%addpath('./Inversions')
addpath('./Data')

load('CMfine.mat')
cmap = cm;

warning('off', 'all')

hist_loc     = [ 25 225 ];%x,z. y average. Not in yet
logtransform = 0;
demean       = 0;

load('ST_data3ADistribution.mat');

[~, ind] = min( (X(:) - hist_loc(1)).^2 + (Z(:) - hist_loc(2)).^2 );
    
for k = 1:numel(X)
   
    m  = interp_models(k, :);
    m2 = interp_models(ind, :);
    
%     ind2 = m ~= m2;
%     
%     m  = m(ind2);
%     m2 = m2(ind2);
    
    cctmp = corrcoef(m, m2);
        
    cc(k) = cctmp(1,2);
    
end

figure(1)
contourf(X, Z, reshape(cc, size(X)), -1:0.1:1);
colormap(cmap);caxis([-1 1])
h = colorbar; h.Label.String = 'Correlation coefficient';
set(gca, 'YDir', 'reverse');
xlabel('Distance, km');
ylabel('Depth, km');
