%%%%plot TD inversions
clear 
close all
clc

load('ST_syn6TestSeptDistribution.mat')

contours_map = [ -2.5 2.5 ];
depth_slice  = [ 5 120 ];

xlimits = [-200 200];
zlimits = [0 300];

mask_thresh = 20;
mask_grid   = 15;%in kn

load('CMfine.mat')
cmap = cm;
%cmap = flipud(pink);

%% 
m    = model_mean;

%m = median(interp_models_coupled, 2);
m = reshape(m, size(X));

m(m > max(contours_map)) = max(contours_map);
m(m < min(contours_map)) = min(contours_map);

%v = linspace(0, sqrt(range(contours_map)), 15).^2 + contours_map(1);
%v = linspace(0, sqrt(range(contours_map)), 10).^2 + contours_map(1);
v = linspace(contours_map(1), contours_map(2), 10);

%%
[Xmask, Zmask] = meshgrid( min(dataStruct.xVec):mask_grid:max(dataStruct.xVec), ...
    min(dataStruct.zVec):mask_grid:max(dataStruct.zVec));
hitcount       = zeros(size(Zmask));

for k = 1:length(dataStruct.ray)
   
    for kk = 1:length(dataStruct.ray(k).x)
       
        [~, ind] = min( sqrt( (Xmask(:) - dataStruct.ray(k).x(kk)).^2 ...
            + (Zmask(:) - dataStruct.zVec(kk)).^2 ));
        hitcount(ind) = hitcount(ind) + 1;
        
    end
    
end

%%
figure(2)
%hold on
contourf(X, Z, m, v, 'LineColor', 'k')
set(gca,  'YDir', 'reverse')
h = colorbar;
h.Label.String = '\Delta\zeta';
colormap(cmap);
xlabel('Distance, km');
ylabel('Depth, km');
caxis([ min(contours_map) max(contours_map) ])
axis equal

if TD_parameters.enforce_discon

    hold on
    plot(dataStruct.xVec, dataStruct.discontinuity.interpolant_xy(dataStruct.xVec,...
        zeros(size(dataStruct.xVec))), 'k-.', 'LineWidth', 5);
    
end

%%plot the mask
%mask_ind = hitcount < mask_thresh;
%plot(Xmask(mask_ind), Zmask(mask_ind), 's', 'MarkerFaceColor', [0.5 0.5 0.5], 'MarkerEdgeColor', [0.5 0.5 0.5], 'MarkerSize', 20);

xlim(xlimits);ylim(zlimits);

figure(3)
hold on
for k = 1:length(depth_slice)
   
    [~, ind] = min(abs(dataStruct.zVec - depth_slice(k)));
    plot(dataStruct.xVec, m(ind, :))
    
    labels{k} = [ num2str(depth_slice(k)) ' km' ];
    
end

xlim([ xlimits ]);
xlabel('Distance, km');
ylabel('\Delta\zeta')
legend(labels, 'Location', 'NorthWest')

% dx = dataStruct.discontinuity.rayX;
% dz = dataStruct.discontinuity.rayz;
% 
% [dx, ind] = sort(dx);
% dz = dz(ind);
% 
% hold on
% plot(dx, dz, 'k', 'LineWidth', 2)

%hold on
%plot(dataStruct.staX, dataStruct.staY, 'ko')

% subplot(212)
% contourf(X, Z, log(m) - (TD_parameters.log_mean - TD_parameters.log_sig^2), -2:0.25:2)
% set(gca,  'YDir', 'reverse')
% h = colorbar;
% h.Label.String = '\Deltaln(mQ^-^1)';
% colormap(jet)%colormap(flipud(pink))
% set(gca, 'YDir', 'reverse')
% xlabel('Distance, km');
% ylabel('Depth, km');
% caxis([-2 2])
% axis equal
% 
% figure(4)
% c    = squeeze(reshape(cc_point, size(X)));
% contourf(X, Z, c, -0.5:0.1:0.5)
% set(gca,  'YDir', 'reverse')
% h = colorbar;
% h.Label.String = 'Correlation with \DeltamQ^-^1 at star';
% colormap(flipud(pink))
% set(gca, 'YDir', 'reverse')
% xlabel('Distance, km');
% ylabel('Depth, km');
% caxis([-0.5 0.5])
% hold on
% plot(point_correlation(1), point_correlation(2), 'kp', 'MarkerSize', 20,...
%     'MarkerFaceColor', 'w');
% axis equal
% 
% % figure(5)
% % p    = squeeze(reshape(p_anomaly, size(X)));
% % contourf(X, Z, p, 0:0.05:0.9)
% % set(gca,  'YDir', 'reverse')
% % h = colorbar;
% % h.Label.String = 'Probability of anomaly';
% % colormap(cm)
% % set(gca, 'YDir', 'reverse')
% % xlabel('Distance, km');
% % ylabel('Depth, km');
% % axis equal
% 
% figure(6)
% s    = squeeze(reshape(stdm, size(X)));
% contourf(X, Z, s, 0:10)
% set(gca,  'YDir', 'reverse')
% h = colorbar;
% h.Label.String = 'Standard deviation';
% colormap(flipud(pink))
% set(gca, 'YDir', 'reverse')
% xlabel('Distance, km');
% ylabel('Depth, km');
% axis equal
% caxis([ 0 10 ])
% 
% 
% 
% figure(8)
% d    = squeeze(reshape(d_matrix, size(X)));
% contourf(X, Z, d, 0:0.2:2)
% set(gca,  'YDir', 'reverse')
% h = colorbar;
% h.Label.String = 'Bimodality';
% colormap(flipud(pink))
% set(gca, 'YDir', 'reverse')
% xlabel('Distance, km');
% ylabel('Depth, km');
% axis equal
% 
% figure(9)
% contourf(X, Z, hit/(length(models)), 0:0.025:0.25)
% set(gca,  'YDir', 'reverse')
% h = colorbar;
% h.Label.String = 'Probability of node location';
% colormap(flipud(pink))
% set(gca, 'YDir', 'reverse')
% xlabel('Distance, km');
% ylabel('Depth, km');
% axis equal

%figure
%plot(X(Z==(depth_plot+15)), m(Z==(depth_plot+15)), 'k')
%hold on
%plot(X(Z==depth_plot), m(Z==depth_plot) + s(Z==depth_plot), 'k--')
%plot(X(Z==depth_plot), m(Z==depth_plot) - s(Z==depth_plot), 'k--')

% print(1, [ invname 'Bimodality.svg'], '-dsvg')
% print(2, [ invname 'RelativemQinv.svg'], '-dsvg')
% print(3, [ invname 'MinimummQinv.svg'], '-dsvg')
  

% for k = 1:length(dim_vec_cell)
%    
%     dv = dim_vec_cell{k};
%             
%     pd = (1 - dv(1))*(2*normpdf((edges - dv(2))/dv(4)).*normcdf(dv(6)*(edges - dv(2))/dv(4))) + ...
%         dv(1)*(2*normpdf((edges - dv(3))/dv(5)).*normcdf(dv(7)*(edges - dv(3))/dv(5)));
%     %pd = (1 - dv(1))*normpdf((edges - dv(2))/dv(4)) + dv(1)*normpdf((edges - dv(3))/dv(5));
%     
%     [~, ind] = max(pd);
%     
%     m(k) = edges(ind);
%     
% end
