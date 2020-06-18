%This script makes a movie out of an inverison that you've saved
clear
clc
close all

addpath('./scripts/')

load('ST_syn6movieinversion3.mat');
load('CMfine')

v      = VideoWriter('ST_syn6_movie','MPEG-4');
open(v)
burn_in      = 5e5;
save_inteval = 2.5e3;%after burn in
movie_rate   = 1;
int_mult     = 2.5e3; 
contour_v    = -2:0.2:2;
true_error   = 0.003;
max_iter     = 1.5e6;

[X, Z] = meshgrid(dataStruct.xVec, dataStruct.zVec);

zero_model = zeros(size(X));

Qmodel = (5.5/1000)*ones(length(dataStruct.xVec), length(dataStruct.zVec));

Qmodel(dataStruct.xVec>=0   & dataStruct.xVec<=30, dataStruct.zVec>=60 & dataStruct.zVec<=90) = 3.5/1000;
Qmodel(dataStruct.xVec>=-50 & dataStruct.xVec<=-20, dataStruct.zVec>=60 & dataStruct.zVec<=90) = 7.5/1000;

Qmodel = (Qmodel - 5.5/1000)*1000;

count = 1;

figure('units','normalized','outerposition',[0 0 1 1])
subplot(231)
%plot the synthetic model
contourf(X, Z, Qmodel', contour_v);
h              = colorbar;
h.Label.String = '\Delta\zeta';
h.Label.FontSize     = 20;
set(gca, 'YDir', 'reverse')
xlabel('Distance, km');
ylabel('Depth, km');
title('Input model')
colormap(cm)
axis equal

for k = [ 1 movie_rate:movie_rate:(max_iter/int_mult) ]
        
    if (k - 1)*int_mult >= burn_in && (mod((k - 1)*int_mult, save_inteval) == 0)

        subplot(232)
        cla
        
        model_vec = (burn_in/int_mult):(save_inteval/int_mult):k;
           
        models_keep = bestmodels(model_vec, :);
        models_keep = models_keep(:);
        
        for i = 1:length(models_keep)
           
            models_keep(i).mQinv = models_keep(i).mQinv - mean(models_keep(i).mQinv);
            
            F           = return_interpolant(models_keep(i), 1:models_keep(i).nCells, 'nearest');
            m(:, :, i)   = F(X, Z); 
                        
        end
        
        m = median(m, 3);
                
        contourf(X, Z, m, 10); 
        xlabel('Distance, km');
        ylabel('Depth, km');
        caxis([ min(-abs(m(:))) max(abs(m(:))) ]);
        h              = colorbar; 
        h.Label.String = '\Delta\zeta';
        h.Label.FontSize     = 20;
        set(gca, 'YDir', 'reverse')
        axis equal
        title([ 'Median of ' num2str(length(models_keep)) ' models']);
        
    elseif k*int_mult < burn_in
        
        subplot(232)
        cla
        
        contourf(X, Z, zero_model, contour_v);
        h              = colorbar; 
        h.Label.String = '\Delta\zeta';
        h.Label.FontSize     = 20;
        set(gca, 'YDir', 'reverse')
        xlabel('Distance, km');
        ylabel('Depth, km');
        title('Burn in not yet reached')
        
        axis equal
        
    end
       
    subplot(2, 3, 3)
    cla
    
    for i = 1:3
    
        subplot(2, 3, i + 3) 
        cla

        if isfield(bestmodels(k, i), 'mQinv')
            
            bestmodels(k, i).zeta = bestmodels(k, i).mQinv;
            
        end
        
        plot_voroni(bestmodels(k, i), dataStruct);
        
        if k == 1
        
            title([ 'Starting model; $\bar{\chi^2}$=' ...
                num2str(bestmodels(k, i).phi/length(dataStruct.dataX), 3) '; $\sigma_{t*}$: ' num2str(bestmodels(k, i).allSig, 3) ', s' ], 'Interpreter', 'Latex')
    
        else
            
            title([ 'Iteration: ' num2str((k - 1)*int_mult) '; $\bar{\chi^2}$=' ...
                num2str(bestmodels(k, i).phi/length(dataStruct.dataX), 3) '; $\sigma_{t*}$: ' num2str(bestmodels(k, i).allSig, 3) ', s' ], 'Interpreter', 'Latex')
            
        end
            
        subplot(2, 3, 3)
        semilogy([ 1 (1:(k-1))*int_mult ], [bestmodels(1:k, i).allSig])
        hold on
        xlabel('Iteration')
        ylabel('\sigma_t_*, s')
        title('Data error along each chain')
        
    end

    subplot(2, 3, 3)
    semilogy([ 1 (1:(k-1))*int_mult ], true_error*ones(k, 1), 'k--')
    
    ylim([ 5e-4 0.3])
    
    frame     = getframe(gcf);
    writeVideo(v,frame);
    
end

close(v)