%format the Barak, Klemperer, and Lawrence model
clear, close all

model = dlmread('Barak2015_Vs.txt');

lon    = model(:, 1);
lat    = model(:, 2);
depth  = model(:, 3);
Vs     = model(:, 4);

%reshape the vectors
lat0   = unique(lat);
lon0   = unique(lon);
depth0 = unique(depth);

new_size = [length(lat0) length(lon0) length(depth0) ];

Vs    = reshape(Vs, new_size);
lat   = reshape(lat, new_size);
lon   = reshape(lon, new_size);
depth = reshape(depth, new_size);

%check if it's correct
contourf(lon(:, :, 45), lat(:, :, 45), Vs(:, :, 45), 4:0.1:4.7)
colorbar

save('Barak_Vs', 'Vs', 'lat', 'lon', 'depth')