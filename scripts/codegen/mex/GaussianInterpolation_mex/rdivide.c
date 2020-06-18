/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * rdivide.c
 *
 * Code generation for function 'rdivide'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation_mex.h"
#include "rdivide.h"
#include "scalexpCompatible.h"

/* Variable Definitions */
static emlrtRTEInfo h_emlrtRTEI = { 13, 15, "rdivide",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\ops\\rdivide.m"
};

/* Function Definitions */
void rdivide(const emlrtStack *sp, const real_T x_data[], const int32_T x_size[1],
             const real_T y_data[], const int32_T y_size[2], real_T z_data[],
             int32_T z_size[1])
{
  int32_T loop_ub;
  int32_T i0;
  if (scalexpCompatible(x_size, y_size)) {
  } else {
    emlrtErrorWithMessageIdR2012b(sp, &h_emlrtRTEI, "MATLAB:dimagree", 0);
  }

  z_size[0] = x_size[0];
  loop_ub = x_size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    z_data[i0] = x_data[i0] / y_data[i0];
  }
}

/* End of code generation (rdivide.c) */
