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
#include "GaussianInterpolation.h"
#include "sqrt.h"
#include "error.h"

/* Variable Definitions */
static emlrtRSInfo j_emlrtRSI = { 12, "sqrt",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elfun\\sqrt.m"
};

/* Function Definitions */
void b_sqrt(const emlrtStack *sp, real_T *x)
{
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  if (*x < 0.0) {
    st.site = &j_emlrtRSI;
    error(&st);
  }

  *x = muDoubleScalarSqrt(*x);
}

/* End of code generation (sqrt.c) */
