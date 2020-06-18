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
#include "GaussianInterpolation_mex.h"
#include "power.h"
#include "error.h"
#include "scalexpAlloc.h"

/* Variable Definitions */
static emlrtRSInfo l_emlrtRSI = { 49, "power",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\ops\\power.m" };

static emlrtRSInfo m_emlrtRSI = { 61, "power",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\ops\\power.m" };

static emlrtRSInfo r_emlrtRSI = { 58, "power",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\ops\\power.m" };

static emlrtRSInfo s_emlrtRSI = { 73, "applyScalarFunction",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\applyScalarFunction.m"
};

static emlrtRTEInfo g_emlrtRTEI = { 17, 19, "scalexpAlloc",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\scalexpAlloc.m"
};

/* Function Declarations */
static boolean_T b_fltpower_domain_error(void);
static boolean_T fltpower_domain_error(void);

/* Function Definitions */
static boolean_T b_fltpower_domain_error(void)
{
  return false;
}

static boolean_T fltpower_domain_error(void)
{
  return false;
}

void b_power(const emlrtStack *sp, const real_T a_data[], const int32_T a_size[2],
             real_T y_data[], int32_T y_size[2])
{
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &l_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  b_st.site = &r_emlrtRSI;
  c_st.site = &s_emlrtRSI;
  y_size[0] = (int16_T)a_size[0];
  y_size[1] = 1;
  if (dimagree(y_size, a_size)) {
  } else {
    emlrtErrorWithMessageIdR2012b(&c_st, &g_emlrtRTEI, "MATLAB:dimagree", 0);
  }

  for (k = 0; k + 1 <= a_size[0]; k++) {
    y_data[k] = a_data[k] * a_data[k];
  }

  if (fltpower_domain_error()) {
    b_st.site = &m_emlrtRSI;
    error(&b_st);
  }
}

void c_power(const emlrtStack *sp, const real_T a_data[], const int32_T a_size[1],
             real_T y_data[], int32_T y_size[1])
{
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &l_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  b_st.site = &r_emlrtRSI;
  c_st.site = &s_emlrtRSI;
  y_size[0] = (int16_T)a_size[0];
  if (b_dimagree(y_size, a_size)) {
  } else {
    emlrtErrorWithMessageIdR2012b(&c_st, &g_emlrtRTEI, "MATLAB:dimagree", 0);
  }

  for (k = 0; k + 1 <= a_size[0]; k++) {
    y_data[k] = a_data[k] * a_data[k];
  }

  if (b_fltpower_domain_error()) {
    b_st.site = &m_emlrtRSI;
    error(&b_st);
  }
}

void power(const real_T a[100], real_T y[100])
{
  int32_T k;
  for (k = 0; k < 100; k++) {
    y[k] = a[k] * a[k];
  }
}

/* End of code generation (power.c) */
