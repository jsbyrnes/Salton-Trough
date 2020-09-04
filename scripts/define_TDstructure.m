function [ TD_parameters ] = define_TDstructure( )

    %%%%%%%search parameters
    TD_parameters.sig            = 10;%in percent of scales for all parameters.
    TD_parameters.zeta_scale     = 3;%std of the prior for Normal. +/- bounds for uniform. 
    TD_parameters.max_cells      = 50;%don't go over 100
    TD_parameters.min_cells      = 5;%minimum for a box shaped anomaly
    TD_parameters.max_sig        = 0.03;%on t*
    TD_parameters.interp_style   = 'nearest';%nearest, linear, or natural. Similar results for each
    TD_parameters.enforce_discon = 0;%load a discontinuity, and use it in the inversion
    TD_parameters.prior          = 'Normal';%Uniform, normal, or exponential. exponential not recommended
    TD_parameters.event_statics  = 1;%much better if you use this if using relative measurements. 
    TD_parameters.demean         = 1;%for plotting only.     
    TD_parameters.n_chains       = 24;%Per script, not in total. See iter field in run_batch.pbs
    TD_parameters.n_iter         = 5e6;%How many times you iterate each chain
    TD_parameters.burn_in        = 2.5e6;%Don't save until you get to this iteration
    TD_parameters.keep_each      = 2.5e3;%how often to save a model post burnin
    TD_parameters.print_each     = 1e5;%how often to print to the screen if you are impatient and chekcing it (like I do)
    
    TD_parameters.max_depth      = 200;%in km
    TD_parameters.min_depth      = 0;%in km, should just be zero
    TD_parameters.rotation       = 20;%used to rotate the grid. Helpful when using linear arrays so everthing is on one axis
    TD_parameters.ZnodeSpacing   = 5;%in km, how often in the z-direction do you grid the ray paths
    TD_parameters.buffer         = 100;%in km. If zero, edges of the modeling domain are [max_x min_x max_y min_y] station locations. Add buffer to broader the imaging domain. 
    
    %%%%%%%map parameters
    TD_parameters.arc_inc          = 5;%for Pn. Ignore it. 
    TD_parameters.XYnodeSpacing    = 5;%not actually part of the inversion, but used for synthetic models.

end

