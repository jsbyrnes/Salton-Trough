/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * power.c
 *
 * Code generation for function 'power'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation.h"
#include "power.h"
#include "scalexpAlloc.h"
#include "GaussianInterpolation_data.h"

/* Variable Definitions */
static emlrtRSInfo f_emlrtRSI = { 58, "power",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\ops\\power.m" };

static emlrtRSInfo g_emlrtRSI = { 73, "applyScalarFunction",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\applyScalarFunction.m"
};

static emlrtRTEInfo e_emlrtRTEI = { 17, 19, "scalexpAlloc",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\scalexpAlloc.m"
};

/* Function Definitions */
void power(const emlrtStack *sp, const real_T a_data[], const int32_T a_size[1],
           real_T y_data[], int32_T y_size[1])
{
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &e_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  b_st.site = &f_emlrtRSI;
  c_st.site = &g_emlrtRSI;
  y_size[0] = (int8_T)a_size[0];
  if (dimagree(y_size, a_size)) {
  } else {
    emlrtErrorWithMessageIdR2012b(&c_st, &e_emlrtRTEI, "MATLAB:dimagree", 0);
  }

  for (k = 0; k + 1 <= a_size[0]; k++) {
    y_data[k] = a_data[k] * a_data[k];
  }
}

/* End of code generation (power.c) */
