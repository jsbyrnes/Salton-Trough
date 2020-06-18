@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2016a
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2016a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=GaussianInterpolation_mex_mex
set MEX_NAME=GaussianInterpolation_mex_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for GaussianInterpolation_mex > GaussianInterpolation_mex_mex.mki
echo COMPILER=%COMPILER%>> GaussianInterpolation_mex_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> GaussianInterpolation_mex_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> GaussianInterpolation_mex_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> GaussianInterpolation_mex_mex.mki
echo LINKER=%LINKER%>> GaussianInterpolation_mex_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> GaussianInterpolation_mex_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> GaussianInterpolation_mex_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> GaussianInterpolation_mex_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> GaussianInterpolation_mex_mex.mki
echo BORLAND=%BORLAND%>> GaussianInterpolation_mex_mex.mki
echo OMPFLAGS= >> GaussianInterpolation_mex_mex.mki
echo OMPLINKFLAGS= >> GaussianInterpolation_mex_mex.mki
echo EMC_COMPILER=mingw64>> GaussianInterpolation_mex_mex.mki
echo EMC_CONFIG=optim>> GaussianInterpolation_mex_mex.mki
"C:\Program Files\MATLAB\R2016a\bin\win64\gmake" -B -f GaussianInterpolation_mex_mex.mk
