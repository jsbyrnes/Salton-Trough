%fit a smooth surface to all t* observations through an inversion scheme.
%This inversion is quick and useful for many applications. 
clear, clc, close all
%% collect all lats, lons and t* by loading one results file at a time.

addpath('../scripts/')

name                  = 'ST_data3';
sig                   = 0.1;
add_noise             = 0;
enforce_discontinuity = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EDIT THESE LINES TO CONTROL THE INVERSION
smoothness  = exp(linspace(4.5, 7, 30));% linspace(0.03, 0.2, 10);
smallness   = exp(linspace(-0.5, 2, 30));% linspace(0.1,  3,  10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v = -2:1:8;
%v = -0.5:0.1:0.5;    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EDIT THIS LINE TO LOAD THE DATA
load( [ '../Data/' name '.mat']);
if add_noise

    rng(100)%make noise same for all chains
    dataStruct.dtS       = normrnd(dataStruct.dtS, sig);

end

for k = 1:length(unique(dataStruct.dataE))
    
    dataStruct.dtS(dataStruct.dataE==k) = dataStruct.dtS(dataStruct.dataE==k) - mean(dataStruct.dtS(dataStruct.dataE==k));
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% p = parpool;
% 
% if p.NumWorkers
% 
%     error('Parpool didn''t start bro!');
%     
% end

% for k = 1:length(smoothness)
%         
%     disp([ num2str(k) ' of ' num2str(numel(smoothness)) ]);
%     
%     [~, misfit(k), ~, ~, ~, Mnorm(k), MRough(k)] = linear_tomography(dataStruct, smoothness(k), smallness, sig, enforce_discontinuity, grad_strength);
%     %[~, misfit(k)] = linear_tomography(dataStruct, smoothness(k), 0.5, sig);
% 
% end


[SMOOTH,SMALL] = meshgrid(smoothness, smallness);

parfor k = 1:numel(SMOOTH)
        
    disp([ num2str(k) ' of ' num2str(numel(SMOOTH)) ]);
    
    [~, misfit(k), ~, ~, ~, Mnorm(k), MRough(k)] = linear_tomography(dataStruct, SMOOTH(k), SMALL(k), sig, enforce_discontinuity);
    %[~, misfit(k)] = linear_tomography(dataStruct, smoothness(k), 0.5, sig);

end

Mnorm  = log(Mnorm);
MRough = log(MRough);
misfit = log(misfit);

[MR, MN] = meshgrid(linspace(min(MRough(:)), max(MRough(:)), 100), ...
    linspace(min(Mnorm(:)), max(Mnorm(:)), 100));

MF = griddata(MRough, Mnorm, misfit, MR, MN, 'natural');

Mnorm = reshape(Mnorm, size(SMOOTH));
MRough = reshape(MRough, size(SMOOTH));
misfit = reshape(misfit, size(SMOOTH));

% 
% mf = linspace(min(misfit), max(misfit), 50);
% sm = interp1(misfit, smoothness, mf, 'spline');
% 
% figure, plot(smoothness, misfit)
% figure, plot(mf, gradient(gradient(sm)), 'ko');



%% Max curvature
[K1,H1] = surfature(log(SMOOTH), log(SMALL), (misfit));
[K2,H2] = surfature(MRough, Mnorm, (misfit));

% figure(1)
% subplot(211)
% contourf(log10(SMOOTH), log10(SMALL), misfit, 10);colorbar
% subplot(212)
% contourf(log10(SMOOTH), log10(SMALL), K, 10);colorbar
% 
% [K,H] = surfature(MR, MN, MF);
% 
% figure(2)
% contourf(MR, MN, K, -5:5);
% 
% mf1 = gradient(log10(misfit), log10(smoothness(2)) - log10(smoothness(1)));
% r1  = gradient(log10(MRough), log10(smoothness(2)) - log10(smoothness(1)));
% mf2 = gradient(mf1, log10(smoothness(2)) - log10(smoothness(1)));
% r2  = gradient(r1, log10(smoothness(2)) - log10(smoothness(1)));
% 
% k      = (mf1.*r2 - mf2.*r1)./(mf1.^2 + r1.^2).^(3/2);
% k      = k(2:end-1);
% misfit = misfit(2:end-1);
% MRough = MRough(2:end-1);

Kclipped = K1;
%Kclipped(Kclipped > 0.5)  = 0.5;
Kclipped(Kclipped < 0)    = 0;

%Kclipped = -Kclipped;

figure(1)
subplot(311)
pcolor(log(SMOOTH), log(SMALL), misfit); shading interp
colormap(gca, flipud(gray))
h = colorbar; h.Label.String = 'ln(\chi^2)';
caxis([0 2])
hold on
contour(log(SMOOTH), log(SMALL), Kclipped, 5, 'LineColor', 'k');
xlabel('ln(\lambda)');
ylabel('ln(\epsilon)');
axis equal

colormap(gca, flipud(gray))

% yyaxis left
% plot(log10(misfit), log10(MRough));
% ylabel('||\nabla^2(\DeltamQ^-^1)||')
% 
% yyaxis right
% plot(log10(misfit), k);
% xlabel('ln(\chi^2)')
% ylabel('\kappa')
[~, ind] = max(Kclipped(:));
[m0, misf0, X, Z, ~] = linear_tomography(dataStruct, SMOOTH(ind), SMALL(ind), sig, 0);
[m1, misf1, X, Z, ~] = linear_tomography(dataStruct, SMOOTH(ind), SMALL(ind), sig, 1);
%[m1, misf1, X, Z, ~] = linear_tomography(dataStruct, exp(3.5), exp(2), sig, 1);
%[m1, misf1, X, Z, ~] = linear_tomography(dataStruct, exp(2.58), exp(0.73), sig, 0);
%[m2, misf2, X, Z, ~] = linear_tomography(dataStruct, exp(2.78), exp(0), sig, 0);

% subplot(212)
% contourf(X, Z, m1, v);colorbar
% set(gca, 'YDir', 'reverse');
% colormap(gca, cm); 
% h = colorbar; h.Label.String = '\DeltamQ^-^1';
% caxis([min(v) max(v)]);
% xlabel('Depth, km');
% ylabel('Distance, km');

m1(m1<min(v)) = min(v);load('CMfine');
%[~, ind] = max(K1(:));
%[m, misf, X, Z, es] = linear_tomography(dataStruct, SMOOTH(ind), SMALL(ind), sig, enforce_discontinuity);

m1(m1>max(v)) = max(v);

subplot(312)
contourf(X, Z, m0, v);colorbar
set(gca, 'YDir', 'reverse');
h = colorbar; h.Label.String = '\Delta\zeta';
caxis([min(v) max(v)]);
xlabel('Depth, km');
ylabel('Distance, km');
axis equal
colormap(gca, flipud(pink)); 

subplot(313)
contourf(X, Z, m1, v);colorbar
set(gca, 'YDir', 'reverse');
h = colorbar; h.Label.String = '\Delta\zeta';
caxis([min(v) max(v)]);
xlabel('Depth, km');
ylabel('Distance, km');
axis equal

colormap(gca, flipud(pink)); 
%colormap(gca, jet); 

% [m0, misf0, X, Z, ~] = linear_tomography(dataStruct, exp(4.7), exp(1.9), sig, 0);
% [m1, misf1, ~, ~, ~] = linear_tomography(dataStruct, exp(4.7), exp(1.9), sig, 1);
% [m2, misf2, ~, ~, ~] = linear_tomography(dataStruct, exp(4.7), exp(1.9), sig, 2);
% subplot(311)
% contourf(X, Z, m0, v);colorbar
% set(gca, 'YDir', 'reverse');
% colormap(gca, cm); 
% h = colorbar; h.Label.String = '\DeltamQ^-^1';
% caxis([min(v) max(v)]);
% xlabel('Depth, km');
% ylabel('Distance, km');
% 
% subplot(312)
% contourf(X, Z, m1, v);colorbar
% set(gca, 'YDir', 'reverse');
% colormap(gca, cm); 
% h = colorbar; h.Label.String = '\DeltamQ^-^1';
% caxis([min(v) max(v)]);
% xlabel('Depth, km');
% ylabel('Distance, km');
% 
% subplot(313)
% contourf(X, Z, m2, v);colorbar
% set(gca, 'YDir', 'reverse');
% colormap(gca, cm); 
% h = colorbar; h.Label.String = '\DeltamQ^-^1';
% caxis([min(v) max(v)]);
% xlabel('Depth, km');
% ylabel('Distance, km');


print(1, [ name '.pdf' ], '-dpdf');

save(name);
