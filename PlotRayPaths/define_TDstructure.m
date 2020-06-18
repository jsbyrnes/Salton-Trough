function [ TD_parameters ] = define_TDstructure( )

    %%%%%%%search parameters
    TD_parameters.sig            = 10;%in percent of scales for all parameters.
    TD_parameters.zeta_scale     = 30;
    TD_parameters.max_cells      = 100;%don't go over 100
    TD_parameters.min_cells      = 5;%minimum for a box shaped anomaly
    TD_parameters.max_sig        = 0.3;%on t*
    TD_parameters.interp_style   = 'nearest';%nearest, linear, or natural
    TD_parameters.enforce_discon = 0;%load a discontinuity, and use it in the inversion
    TD_parameters.prior          = 'Exponential';
    TD_parameters.event_statics  = 1;%much better if you use this!!
    TD_parameters.demean         = 1;%for plotting
    
    %%%%
    %enable this to set fit to one for all models
    %if the code works, you will get the priors for all values
    TD_parameters.debug_prior    = 0; 
    
    TD_parameters.individual_noise = 0;
    
    TD_parameters.n_chains       = 12;
    TD_parameters.n_iter         = 5e6;%for now, just iterate to a max
    TD_parameters.burn_in        = 2.5e6;
    TD_parameters.keep_each      = 2.5e3;
    TD_parameters.print_each     = 1e5;
    
    TD_parameters.max_depth      = 300;%in km
    TD_parameters.min_depth      = 0;%in km

    %%%%%%%map parameters
    TD_parameters.arc_inc          = 5;%for Pn
    TD_parameters.XYnodeSpacing    = 5;%not actually part of the inversion, but used for synthetic models.
    TD_parameters.ZnodeSpacing     = 10;%also used for slices the ray path
    TD_parameters.buffer           = 100;%in km
    TD_parameters.rotation         = 20;%in degrees 20 for ST, -33 for MAGIC
    TD_parameters.save_for_gmt     = 1;

end

%    TD_parameters.interp_style   = 'Gaussian';%nearest or Gaussian
%     %if gaussian interp_style
%     TD_parameters.width          = 100;%max, positive
%     TD_parameters.eccentricity   = 0.99;%max, positive
%     TD_parameters.gaussian_sig   = 33;%percent of range
%     TD_parameters.log_sig        = 2;%for log-normal
%     TD_parameters.log_mean       = log(1000/180) + TD_parameters.log_sig^2;%for log-normal
