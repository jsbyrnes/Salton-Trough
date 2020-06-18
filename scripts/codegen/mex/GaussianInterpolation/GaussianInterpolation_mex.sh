MATLAB="/panfs/roc/msisoft/matlab/R2017b"
Arch=glnxa64
ENTRYPOINT=mexFunction
MAPFILE=$ENTRYPOINT'.map'
PREFDIR="/home/bezadam/jsbyrnes/.matlab/R2017b"
OPTSFILE_NAME="./setEnv.sh"
. $OPTSFILE_NAME
COMPILER=$CC
. $OPTSFILE_NAME
echo "# Make settings for GaussianInterpolation" > GaussianInterpolation_mex.mki
echo "CC=$CC" >> GaussianInterpolation_mex.mki
echo "CFLAGS=$CFLAGS" >> GaussianInterpolation_mex.mki
echo "CLIBS=$CLIBS" >> GaussianInterpolation_mex.mki
echo "COPTIMFLAGS=$COPTIMFLAGS" >> GaussianInterpolation_mex.mki
echo "CDEBUGFLAGS=$CDEBUGFLAGS" >> GaussianInterpolation_mex.mki
echo "CXX=$CXX" >> GaussianInterpolation_mex.mki
echo "CXXFLAGS=$CXXFLAGS" >> GaussianInterpolation_mex.mki
echo "CXXLIBS=$CXXLIBS" >> GaussianInterpolation_mex.mki
echo "CXXOPTIMFLAGS=$CXXOPTIMFLAGS" >> GaussianInterpolation_mex.mki
echo "CXXDEBUGFLAGS=$CXXDEBUGFLAGS" >> GaussianInterpolation_mex.mki
echo "LDFLAGS=$LDFLAGS" >> GaussianInterpolation_mex.mki
echo "LDOPTIMFLAGS=$LDOPTIMFLAGS" >> GaussianInterpolation_mex.mki
echo "LDDEBUGFLAGS=$LDDEBUGFLAGS" >> GaussianInterpolation_mex.mki
echo "Arch=$Arch" >> GaussianInterpolation_mex.mki
echo "LD=$LD" >> GaussianInterpolation_mex.mki
echo OMPFLAGS= >> GaussianInterpolation_mex.mki
echo OMPLINKFLAGS= >> GaussianInterpolation_mex.mki
echo "EMC_COMPILER=gcc" >> GaussianInterpolation_mex.mki
echo "EMC_CONFIG=optim" >> GaussianInterpolation_mex.mki
"/panfs/roc/msisoft/matlab/R2017b/bin/glnxa64/gmake" -B -f GaussianInterpolation_mex.mk
