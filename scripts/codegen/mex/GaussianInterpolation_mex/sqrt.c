/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sqrt.c
 *
 * Code generation for function 'sqrt'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation_mex.h"
#include "sqrt.h"
#include "error.h"

/* Variable Definitions */
static emlrtRSInfo t_emlrtRSI = { 12, "sqrt",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elfun\\sqrt.m"
};

/* Function Definitions */
void b_sqrt(const emlrtStack *sp, real_T x_data[], int32_T x_size[2])
{
  boolean_T p;
  int32_T k;
  int32_T nx;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  p = false;
  for (k = 0; k < x_size[0]; k++) {
    if (p || (x_data[k] < 0.0)) {
      p = true;
    } else {
      p = false;
    }
  }

  if (p) {
    st.site = &t_emlrtRSI;
    c_error(&st);
  }

  nx = x_size[0];
  for (k = 0; k + 1 <= nx; k++) {
    x_data[k] = muDoubleScalarSqrt(x_data[k]);
  }
}

/* End of code generation (sqrt.c) */
