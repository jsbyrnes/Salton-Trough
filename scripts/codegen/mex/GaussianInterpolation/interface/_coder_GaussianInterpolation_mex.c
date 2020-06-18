/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_GaussianInterpolation_mex.c
 *
 * Code generation for function '_coder_GaussianInterpolation_mex'
 *
 */

/* Include files */
#include "GaussianInterpolation.h"
#include "_coder_GaussianInterpolation_mex.h"
#include "GaussianInterpolation_terminate.h"
#include "_coder_GaussianInterpolation_api.h"
#include "GaussianInterpolation_initialize.h"
#include "GaussianInterpolation_data.h"

/* Function Declarations */
static void c_GaussianInterpolation_mexFunc(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[11]);

/* Function Definitions */
static void c_GaussianInterpolation_mexFunc(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[11])
{
  int32_T n;
  const mxArray *inputs[11];
  const mxArray *outputs[1];
  int32_T b_nlhs;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 11) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 11, 4,
                        21, "GaussianInterpolation");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 21,
                        "GaussianInterpolation");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  GaussianInterpolation_api(inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  GaussianInterpolation_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(GaussianInterpolation_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  GaussianInterpolation_initialize();

  /* Dispatch the entry-point. */
  c_GaussianInterpolation_mexFunc(nlhs, plhs, nrhs, prhs);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_GaussianInterpolation_mex.c) */
