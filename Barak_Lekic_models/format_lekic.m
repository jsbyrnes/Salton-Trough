%format Lekic's LAB depths
clear, close all

model = dlmread('LAB_depths_in_Science_paper.txt');

%not a mesh grid so interpolate
lon    = model(:, 1);
lat    = model(:, 2);
depth  = model(:, 3);

lat_vec = 30:0.05:38;
lon_vec = -122:0.05:-113;

[LAT, LON] = meshgrid(lat_vec, lon_vec);

depth_grid = griddata(lat, lon, depth, LAT, LON);

%contourf(LON, LAT, depth_grid, 40:1:100);
contour(LON, LAT, depth_grid, [50 65]);%, 'Color', 'k', 'LineWidth', 2);
colorbar
xlim([-117 -114.5]);
ylim([32.25 33.75]);

figure
scatter(lon, lat, 20, depth, 'filled')
colorbar

save('LAB_depths', 'LON', 'LAT', 'depth_grid')