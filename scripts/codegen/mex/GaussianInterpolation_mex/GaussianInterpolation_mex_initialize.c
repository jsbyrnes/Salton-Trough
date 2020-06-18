/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * GaussianInterpolation_mex_initialize.c
 *
 * Code generation for function 'GaussianInterpolation_mex_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation_mex.h"
#include "GaussianInterpolation_mex_initialize.h"
#include "_coder_GaussianInterpolation_mex_mex.h"
#include "GaussianInterpolation_mex_data.h"

/* Function Definitions */
void GaussianInterpolation_mex_initialize(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (GaussianInterpolation_mex_initialize.c) */
