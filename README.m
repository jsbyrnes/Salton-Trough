%%%%%%%%%%%%%%%%%
%Read me script
%This package contains all the scripts for reproducing the figures from
%Byrnes and Bezada, JGR (in revision). 

%The current work flow is to run through qsub with the run_batch.pbs script
%Run batch submits several jobs of 24 workers, each which call the
%TD_inversion_function. This circumvents matlab's inability to distribute
%across multiple machines, and shoul be rethought for each problem. 

%Demonstration_script produces the result in Figure 6 of Byrnes and Bezada,
%and Demonstration_script_localmachine runs in serial without the
%supercomputer overhead. 

%To load new data into the inverison, the dataStruct must be built. 
%An example is in load_data_SaltonTrough3D
%The fields are
%     dataStruct.dtS     t* data. The d will be removed when absolute t* is
%     enabled
%     dataStruct.allLats station location in lat/lon
%     dataStruct.allLons 

%     dataStruct.allSig  dummy field for initilaization. Set to any value
%     with same size of dtS
%     dataStruct.allSta  = allSta;

%     dataStruct.dataX   mapping of lat/lon to x/y cartesian coodinates.
%     dataStruct.dataY   

%     dataStruct.dataE   event index

%     dataStruct.xVec    meshgrid results that define the imaging domain
%     dataStruct.yVec    
%     dataStruct.zVec    

%allSta and coastFields in load_data_SaltonTrough3D are not used

%then there are two substructures. 
%dataStruct.discontinuity is defined if you want a discontinuity in the
%model (see Byrnes and Bezada, JGR for an exmaple)

%dataStruct.ray contains ray tracing information. The load for Salton
%Trough script contains and example of how to built the ray structure with
%the previous dataStruct fields, event lat/lon/depths, and matTaup
%(included). 

%To tweak the inverison once you have the data, see define_TDstructure.
%Comments in there define parameters. 

%For the Salton Trough dataset, check chain takes approximately ~24 hours,
%but each chain is independant and can be run in parallel. This is a small
%dataset (220 observations) and while time will scale with the size of the
%dataset, performance can be tweaked with Znodespacing (finer spacing means
%longer times), or the algorithm can be compiled for larger datasets. 

%Finally, if running a synthetic, you *must* add noise to the synthetic data. 
%See salton trough examples for examples of synthetic datasets, and
%Demonstration_script for how to add noise. 
%Body wave tomography is high non-unique, and noise-free datasets will be
%perfectly fit by a bizarre set of models that could in theory converage,
%but would take forever so far as I can tell. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Results are gathered from many chains by the MakeDistributions script. 
%[name]Distribution.mat files are plotted by the
%plot_distribution_parameters.m script. 
%plot_model_histogram plots a PDF of zeta values at a point in the imaging
%domain
%plot_raypaths shows the ray paths in dataStruct
%plot_voronoi can be used to look at individual models, either after a run
%or if you are in debug mode while a particular model is running. 

%Please contact Joseph Byrnes at byrnes.joseph@gmail.com or
%jsbyrnes@umn.edu for help building dataStruct, or anything else.


