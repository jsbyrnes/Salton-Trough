%%%%plot TD inversions
addpath('./scripts')
addpath('./Data')

%%%%%%%%%%%%
disp([' Running ' num2str(iter) ' batches of ' scriptname ' to be ' ...
    'saved as ' [name nameappend]]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%First, check if the jobs need to be submitted
%Wait for them to finish if so
file_exists = zeros(1,iter);

for k = 1:iter

    if ~exist([name nameappend 'inversion' num2str(k) '.mat'], 'file')

        if exist('run_data_batch.pbs')

            delete('run_data_batch.pbs');

        end

        fid = fopen('run_data_batch.pbs', 'w');

        fprintf(fid, '#PBS -l walltime=96:00:00,nodes=1:ppn=24\n');
        fprintf(fid, '#PBS -m n\n');
        fprintf(fid, '#PBS -M jsbyrnes@umn.edu\n');
        fprintf(fid, [ '#PBS -N ' name nameappend '\n' ]);
        fprintf(fid, '\n');
        fprintf(fid, 'module load matlab');
        fprintf(fid, '\n');
        fprintf(fid, 'cd /home/bezadam/jsbyrnes/TD3D/');
        fprintf(fid, '\n');
        fprintf(fid, [ 'matlab -r "name = ''' name '''; nameappend = ''' nameappend '''; ' scriptname '"']);

        fclose(fid);

        disp(['Submitted job to create ' name nameappend 'inversion' num2str(k) '.mat']);
        unix('qsub run_data_batch.pbs');

        pause(60);

    else

        disp([ 'Already saved ' ' ' name nameappend 'inversion' num2str(k) ]);
        file_exists(k) = 1;

    end

end

while any(~file_exists)

    pause(5*60) %wait 5 minutes to try again.

    for k = 1:iter

        if exist([name nameappend 'inversion' num2str(iter) '.mat'], 'file')

            disp([ 'Just got ' ' ' name nameappend 'inversion' num2str(k) '!' ]);
            file_exists(k) = 1;

        end

    end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%
load([ './Data/' name '.mat' ]);
files = dir([ name nameappend 'inversion*.mat']);

models = [];

for i = 1:length(files)
   
    load(files(i).name, 'bestmodels', 'TD_parameters');%TD should all be the same
    
    bestmodels = bestmodels(2:end, :);
    bestmodels = bestmodels(:);
    
    if TD_parameters.event_statics %zero mean inversion
            
        for k = 1:length(bestmodels)

            if ~isfield(bestmodels(k), 'zeta')
            
                bestmodels(k).zeta       = bestmodels(k).mQinv;
                TD_parameters.zeta_scale = TD_parameters.mQinv_scale;
                
            end
            
%             if TD_parameters.demean
%                 
%                 bestmodels(k).zeta = bestmodels(k).zeta - mean(bestmodels(k).zeta);
%                 
%             end
                
        end
    
    end
    
    models = [ models(:); bestmodels(2:end) ];%remove starting points
    
end

models = models(:);

fit            = [models.phi];%failed models. Cause not yet identified. 
models(fit==0) = [];

dx                  = dataStruct.xVec(2) - dataStruct.xVec(1); 
dz                  = dataStruct.zVec(2) - dataStruct.zVec(1); 

[X,Z] = meshgrid(dataStruct.xVec, dataStruct.zVec);

hit = zeros(size(X));

%make the edges vector automatically here
if strcmp(TD_parameters.prior, 'Normal')
   
    edges = linspace(-4*TD_parameters.zeta_scale, 4*TD_parameters.zeta_scale, 500);
    
elseif strcmp(TD_parameters.prior, 'Uniform')
   
    %because the mean is floating, you might need to shift stuff around
    edges = linspace(-2*TD_parameters.zeta_scale, 2*TD_parameters.zeta_scale, 500);
    
elseif strcmp(TD_parameters.prior, 'Exponential')

    edges = linspace( 4*TD_parameters.zeta_scale, 4*TD_parameters.zeta_scale, 500);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%common parameters for each search
%%%%%%%%%%%
%parameters
parameters.n_chains       = 1;
parameters.n_iterations   = 1000;
parameters.nsamples       = 50;
parameters.sig            = 0.1;%non-dimensionalizied
%%%%%%double gaussian distribution
parameters.limits(1, :) = [0 1];%relative height; p=1 is all the second
parameters.limits(2, :) = [ min(edges) max(edges) ];%mu1
parameters.limits(3, :) = [ min(edges) max(edges) ];%mu2
parameters.limits(4, :) = [ 0.01 max(edges)/2 ];%sig1
parameters.limits(5, :) = [ 0.01 max(edges)/2 ];%sig2
%parameters.limits(6, :) = [ -10 10 ];%shape1
%parameters.limits(7, :) = [ -10 10 ];%shape2
parameters.function     = @(x,y,z) return_fit_TwoNormal(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[parameters.nd, ~] = size(parameters.limits);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = parpool;
%occasionally, you get runs only have one worker. This cloggs the
%whole process
if p.NumWorkers == 1

    error('Problem starting parallel pool');
    
end

parfor i = 1:length(models)

    warning('off', 'all')

    m                   = make_voronoi(models(i), dataStruct, TD_parameters, 0, 0);
    m                   = m(:);    
    m                   = m - mean(m);
    interp_models(:, i) = m;
    
end

model_mean   = reshape(mean(interp_models, 2), size(X));
model_median = reshape(median(interp_models, 2), size(X));

for i = 1:numel(X)
   
    pdf = histcounts(interp_models(i, :), edges, 'Normalization', 'pdf');
    
    [~, ind] = max(pdf);
    
    model_mode(i) = edges(ind);%rounds down by one unit
    
end

model_mode = reshape(model_mode, size(X));

clear interp_models

save([ name nameappend 'Distribution' ], '-v7.3')

% for i = 1:numel(X)
% 
%     disp([ 'Point ' num2str(i) ' of ' num2str(numel(X))])
%     warning('off', 'all')
% 
%     mQinv = zeros(length(models), 1);
% 
%     for k = 1:length(models)
% 
%         F       = return_interpolant(models(k), 1:models(k).nCells, ...
%                   TD_parameters.interp_style);
%         mQinv(k) = F(X(i), Z(i));
%         hit(i) = hit(i) + any( dx > abs(models(k).xCell - X(i)) & ...
%             dz > abs(models(k).zCell - Z(i)) );
%         
%     end
% 
% %     pdf     = histcounts(mQinv, edges, 'Normalization', 'pdf');
% %     ds.x    = edges(1:end-1) + (edges(2) - edges(1))/2;
% %     ds.data = pdf;
% %     vec               = GibbsSearch(parameters, ds);
% %     [~, pdf, dim_vec] = parameters.function(ds, vec, parameters.limits);    
% %     dim_vec_cell{i}   = dim_vec;
%         
%     model_mean(i)   = mean(mQinv);
%     model_median(i) = median(mQinv);
%     
%     fedges = linspace(min(edges), max(edges), length(edges));
%     kspdf = ksdensity(mQinv, fedges);
%     
%     [~, ind]      = max(kspdf);
%     model_mode(i) = fedges(ind);
%     
%     ds = [];
%             
% end
