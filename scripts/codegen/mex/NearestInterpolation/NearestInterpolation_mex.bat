@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2016a
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2016a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=NearestInterpolation_mex
set MEX_NAME=NearestInterpolation_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for NearestInterpolation > NearestInterpolation_mex.mki
echo COMPILER=%COMPILER%>> NearestInterpolation_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> NearestInterpolation_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> NearestInterpolation_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> NearestInterpolation_mex.mki
echo LINKER=%LINKER%>> NearestInterpolation_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> NearestInterpolation_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> NearestInterpolation_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> NearestInterpolation_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> NearestInterpolation_mex.mki
echo BORLAND=%BORLAND%>> NearestInterpolation_mex.mki
echo OMPFLAGS= >> NearestInterpolation_mex.mki
echo OMPLINKFLAGS= >> NearestInterpolation_mex.mki
echo EMC_COMPILER=mingw64>> NearestInterpolation_mex.mki
echo EMC_CONFIG=optim>> NearestInterpolation_mex.mki
"C:\Program Files\MATLAB\R2016a\bin\win64\gmake" -B -f NearestInterpolation_mex.mk
