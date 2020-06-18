/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * NearestInterpolation_terminate.c
 *
 * Code generation for function 'NearestInterpolation_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "NearestInterpolation.h"
#include "NearestInterpolation_terminate.h"
#include "NearestInterpolation_data.h"

/* Function Definitions */
void NearestInterpolation_atexit(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void NearestInterpolation_terminate(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (NearestInterpolation_terminate.c) */
