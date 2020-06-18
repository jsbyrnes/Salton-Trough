MATLAB="/panfs/roc/msisoft/matlab/R2015a"
Arch=glnxa64
ENTRYPOINT=mexFunction
MAPFILE=$ENTRYPOINT'.map'
PREFDIR="/home/bezadam/jsbyrnes/.matlab/R2015a"
OPTSFILE_NAME="./setEnv.sh"
. $OPTSFILE_NAME
COMPILER=$CC
. $OPTSFILE_NAME
echo "# Make settings for NearestInterpolation" > NearestInterpolation_mex.mki
echo "CC=$CC" >> NearestInterpolation_mex.mki
echo "CFLAGS=$CFLAGS" >> NearestInterpolation_mex.mki
echo "CLIBS=$CLIBS" >> NearestInterpolation_mex.mki
echo "COPTIMFLAGS=$COPTIMFLAGS" >> NearestInterpolation_mex.mki
echo "CDEBUGFLAGS=$CDEBUGFLAGS" >> NearestInterpolation_mex.mki
echo "CXX=$CXX" >> NearestInterpolation_mex.mki
echo "CXXFLAGS=$CXXFLAGS" >> NearestInterpolation_mex.mki
echo "CXXLIBS=$CXXLIBS" >> NearestInterpolation_mex.mki
echo "CXXOPTIMFLAGS=$CXXOPTIMFLAGS" >> NearestInterpolation_mex.mki
echo "CXXDEBUGFLAGS=$CXXDEBUGFLAGS" >> NearestInterpolation_mex.mki
echo "LD=$LD" >> NearestInterpolation_mex.mki
echo "LDFLAGS=$LDFLAGS" >> NearestInterpolation_mex.mki
echo "LDOPTIMFLAGS=$LDOPTIMFLAGS" >> NearestInterpolation_mex.mki
echo "LDDEBUGFLAGS=$LDDEBUGFLAGS" >> NearestInterpolation_mex.mki
echo "Arch=$Arch" >> NearestInterpolation_mex.mki
echo OMPFLAGS= >> NearestInterpolation_mex.mki
echo OMPLINKFLAGS= >> NearestInterpolation_mex.mki
echo "EMC_COMPILER=gcc" >> NearestInterpolation_mex.mki
echo "EMC_CONFIG=optim" >> NearestInterpolation_mex.mki
"/panfs/roc/msisoft/matlab/R2015a/bin/glnxa64/gmake" -B -f NearestInterpolation_mex.mk
