/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_GaussianInterpolation_mex_mex.c
 *
 * Code generation for function '_coder_GaussianInterpolation_mex_mex'
 *
 */

/* Include files */
#include "GaussianInterpolation_mex.h"
#include "_coder_GaussianInterpolation_mex_mex.h"
#include "GaussianInterpolation_mex_terminate.h"
#include "_coder_GaussianInterpolation_mex_api.h"
#include "GaussianInterpolation_mex_initialize.h"
#include "GaussianInterpolation_mex_data.h"

/* Function Declarations */
static void c_GaussianInterpolation_mex_mex(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[9]);

/* Function Definitions */
static void c_GaussianInterpolation_mex_mex(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[9])
{
  int32_T n;
  const mxArray *inputs[9];
  const mxArray *outputs[1];
  int32_T b_nlhs;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 9) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 9, 4,
                        25, "GaussianInterpolation_mex");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 25,
                        "GaussianInterpolation_mex");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  GaussianInterpolation_mex_api(inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  GaussianInterpolation_mex_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(GaussianInterpolation_mex_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  GaussianInterpolation_mex_initialize();

  /* Dispatch the entry-point. */
  c_GaussianInterpolation_mex_mex(nlhs, plhs, nrhs, prhs);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_GaussianInterpolation_mex_mex.c) */
