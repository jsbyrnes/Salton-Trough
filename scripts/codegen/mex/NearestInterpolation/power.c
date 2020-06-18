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
#include "NearestInterpolation.h"
#include "power.h"
#include "scalexpAlloc.h"

/* Variable Definitions */
static emlrtRSInfo b_emlrtRSI = { 42, "power",
  "/panfs/roc/msisoft/matlab/R2015a/toolbox/eml/lib/matlab/ops/power.m" };

static emlrtRSInfo c_emlrtRSI = { 51, "power",
  "/panfs/roc/msisoft/matlab/R2015a/toolbox/eml/lib/matlab/ops/power.m" };

static emlrtRSInfo d_emlrtRSI = { 11, "eml_scalexp_alloc",
  "/panfs/roc/msisoft/matlab/R2015a/toolbox/eml/lib/matlab/eml/eml_scalexp_alloc.m"
};

static emlrtRTEInfo b_emlrtRTEI = { 1, 1, "scalexpAlloc",
  "/panfs/roc/msisoft/matlab/R2015a/toolbox/coder/coder/+coder/+internal/scalexpAlloc.p"
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
  st.site = &b_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  b_st.site = &c_emlrtRSI;
  c_st.site = &d_emlrtRSI;
  y_size[0] = (int8_T)a_size[0];
  if (dimagree(y_size, a_size)) {
  } else {
    emlrtErrorWithMessageIdR2012b(&c_st, &b_emlrtRTEI, "MATLAB:dimagree", 0);
  }

  for (k = 0; k < (int8_T)a_size[0]; k++) {
    y_data[k] = a_data[k] * a_data[k];
  }
}

/* End of code generation (power.c) */
