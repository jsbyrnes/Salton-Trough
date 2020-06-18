%make the mex files

%codegen GaussianInterpolation -args { zeros(100,1),zeros(100,1),zeros(100,1),zeros(100,1),zeros(100,1),zeros(100,1),zeros(100,1),zeros(1000,1),zeros(1000,1),zeros(1,1),zeros(1,1) }
codegen NearestInterpolation -args { zeros(100,1),zeros(100,1),zeros(100,1),logical(zeros(100,1)),zeros(5e4,1),zeros(5e4,1),zeros(1,1),zeros(1,1) }
