%plot all the ray paths
clear, close all
clc

load('./Data/ST_data3.mat');
figure(1)
subplot(211)
hold on

minx = 0;
maxx = 0;

for k = 1:length(dataStruct.ray)
   
    plot(dataStruct.ray(k).x, dataStruct.zVec, 'k')
    
    minx = min([ minx min(dataStruct.ray(k).x) ]);
    maxx = max([ maxx max(dataStruct.ray(k).x) ]);
    
end
set(gca, 'YDir', 'reverse');
xlim([ min(dataStruct.xVec) max(dataStruct.xVec) ])
xVec = minx:5:maxx;
xlabel('Distance, km');
ylabel('Depth, km');

subplot(212)
[X,Z] = meshgrid(xVec, dataStruct.zVec(2:2:end));

hitcount = zeros(size(Z));

for k = 1:length(dataStruct.ray)
   
    for kk = 1:length(dataStruct.ray(k).x)
       
        [~, ind] = min( sqrt( (X(:) - dataStruct.ray(k).x(kk)).^2 ...
            + (Z(:) - dataStruct.zVec(kk)).^2 ));
        hitcount(ind) = hitcount(ind) + 1;
        
    end
    
end

contourf(X, Z, hitcount, 5); 
h = colorbar; h.Label.String = 'Hit Count';
set(gca, 'YDir', 'reverse');
colormap(flipud(gray))
xlim([ min(dataStruct.xVec) max(dataStruct.xVec) ])
%caxis([0 15])
xlabel('Distance, km');
ylabel('Depth, km');
