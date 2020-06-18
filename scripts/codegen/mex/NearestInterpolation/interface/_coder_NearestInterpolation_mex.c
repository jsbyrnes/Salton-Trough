/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_NearestInterpolation_mex.c
 *
 * Code generation for function '_coder_NearestInterpolation_mex'
 *
 */

/* Include files */
#include "NearestInterpolation.h"
#include "_coder_NearestInterpolation_mex.h"
#include "NearestInterpolation_terminate.h"
#include "_coder_NearestInterpolation_api.h"
#include "NearestInterpolation_initialize.h"
#include "NearestInterpolation_data.h"

/* Function Declarations */
static void c_NearestInterpolation_mexFunct(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[8]);

/* Function Definitions */
static void c_NearestInterpolation_mexFunct(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[8])
{
  int32_T n;
  const mxArray *inputs[8];
  const mxArray *outputs[1];
  int32_T b_nlhs;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 8) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 8, 4,
                        20, "NearestInterpolation");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 20,
                        "NearestInterpolation");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  NearestInterpolation_api(inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  NearestInterpolation_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  /* Initialize the memory manager. */
  mexAtExit(NearestInterpolation_atexit);

  /* Module initialization. */
  NearestInterpolation_initialize();

  /* Dispatch the entry-point. */
  c_NearestInterpolation_mexFunct(nlhs, plhs, nrhs, prhs);
}

/* End of code generation (_coder_NearestInterpolation_mex.c) */
