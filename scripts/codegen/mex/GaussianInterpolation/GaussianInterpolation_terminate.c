/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * GaussianInterpolation_terminate.c
 *
 * Code generation for function 'GaussianInterpolation_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation.h"
#include "GaussianInterpolation_terminate.h"
#include "_coder_GaussianInterpolation_mex.h"
#include "GaussianInterpolation_data.h"

/* Function Definitions */
void GaussianInterpolation_atexit(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void GaussianInterpolation_terminate(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (GaussianInterpolation_terminate.c) */
