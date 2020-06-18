%fit a smooth surface to all t* observations through an inversion scheme.
%This inversion is quick and useful for many applications. 
clear, clc, close all
%% collect all lats, lons and t* by loading one results file at a time.

name = 'ST_syn6';
sig  = 1e-1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EDIT THESE LINES TO CONTROL THE INVERSION
smoothness  = logspace(0.5, 3, 5);% linspace(0.03, 0.2, 10);
smallness   = 10^0;% linspace(0.1,  3,  10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%v = -15:3:15;
v = -15:3:15;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EDIT THIS LINE TO LOAD THE DATA
load( [ '../Data/' name '.mat']);
rng(100)%make noise same for all chains
dataStruct.dtS       = normrnd(dataStruct.dtS, sig);
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

parfor k = 1:length(smoothness)
        
    disp([ num2str(k) ' of ' num2str(numel(smoothness)) ]);
    
    [~, misfit(k), ~, ~, ~, Mnorm(k), MRough(k)] = linear_tomography(dataStruct, smoothness(k), smallness, sig);
    %[~, misfit(k)] = linear_tomography(dataStruct, smoothness(k), 0.5, sig);

end


% [SMOOTH,SMALL] = meshgrid(smoothness, smallness);
% 
% parfor k = 1:numel(SMOOTH)
%         
%     disp([ num2str(k) ' of ' num2str(numel(SMOOTH)) ]);
%     
%     [~, misfit(k), ~, ~, ~, Mnorm(k), MRough(k)] = linear_tomography(dataStruct, SMOOTH(k), SMALL(k), sig);
%     %[~, misfit(k)] = linear_tomography(dataStruct, smoothness(k), 0.5, sig);
% 
% end
% 
% Mnorm  = log(Mnorm);
% MRough = log(MRough);
% misfit = log(misfit);
% 
% [MR, MN] = meshgrid(linspace(min(MRough(:))-1, max(MRough(:))+1, 50), ...
%     linspace(min(Mnorm(:))-1, max(Mnorm(:))+1, 50));
% 
% MF = griddata(MRough, Mnorm, misfit, MR, MN, 'linear');
% 
% Mnorm = reshape(Mnorm, size(SMOOTH));
% MRough = reshape(MRough, size(SMOOTH));
% misfit = reshape(misfit, size(SMOOTH));

% 
% mf = linspace(min(misfit), max(misfit), 50);
% sm = interp1(misfit, smoothness, mf, 'spline');
% 
% figure, plot(smoothness, misfit)
% figure, plot(mf, gradient(gradient(sm)), 'ko');



%% Max curvature
% [K,H] = surfature(log10(SMOOTH), log10(SMALL), misfit);
% 
% figure(1)
% subplot(211)
% contourf(log10(SMOOTH), log10(SMALL), misfit, 10);colorbar
% subplot(212)
% contourf(log10(SMOOTH), log10(SMALL), K, 10);colorbar
% 
% [K,H] = surfature(MR, MN, MF);
% 
% figure(2)
% contourf(MR, MN, MF, 10);

mf1 = gradient(log10(misfit), log10(smoothness(2)) - log10(smoothness(1)));
r1  = gradient(log10(MRough), log10(smoothness(2)) - log10(smoothness(1)));
mf2 = gradient(mf1, log10(smoothness(2)) - log10(smoothness(1)));
r2  = gradient(r1, log10(smoothness(2)) - log10(smoothness(1)));

k      = (mf1.*r2 - mf2.*r1)./(mf1.^2 + r1.^2).^(3/2);
k      = k(2:end-1);
misfit = misfit(2:end-1);
MRough = MRough(2:end-1);

figure(1)
subplot(211)
yyaxis left
plot(log10(misfit), log10(MRough));
ylabel('||\nabla^2(\DeltamQ^-^1)||')

yyaxis right
plot(log10(misfit), k);
xlabel('ln(\chi^2)')
ylabel('\kappa')

load('CMfine');
[~, ind] = max(k);
[m, misf, X, Z, es] = linear_tomography(dataStruct, smoothness(ind), smallness, sig);

subplot(212)
contourf(X, Z, m, v);colorbar
set(gca, 'YDir', 'reverse');
colormap(cm); 
h = colorbar; h.Label.String = '\DeltamQ^-^1';
caxis([min(v) max(v)]);
xlabel('Depth, km');
ylabel('Distance, km');

print(1, [ name '.pdf' ], '-dpdf');
