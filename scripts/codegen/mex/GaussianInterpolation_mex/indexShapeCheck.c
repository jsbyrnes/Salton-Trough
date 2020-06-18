/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * indexShapeCheck.c
 *
 * Code generation for function 'indexShapeCheck'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation_mex.h"
#include "indexShapeCheck.h"

/* Variable Definitions */
static emlrtRSInfo p_emlrtRSI = { 14, "indexShapeCheck",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\indexShapeCheck.m"
};

static emlrtRSInfo q_emlrtRSI = { 80, "indexShapeCheck",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\indexShapeCheck.m"
};

static emlrtRTEInfo f_emlrtRTEI = { 88, 9, "indexShapeCheck",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\indexShapeCheck.m"
};

/* Function Definitions */
void indexShapeCheck(const emlrtStack *sp, const int32_T indexSize[2])
{
  boolean_T nonSingletonDimFound;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  nonSingletonDimFound = false;
  if (indexSize[0] != 1) {
    nonSingletonDimFound = true;
  }

  if (nonSingletonDimFound) {
    st.site = &p_emlrtRSI;
    b_st.site = &q_emlrtRSI;
    if (!(indexSize[0] == 1)) {
    } else {
      emlrtErrorWithMessageIdR2012b(&b_st, &f_emlrtRTEI,
        "Coder:FE:PotentialMatrixMatrix", 0);
    }
  }
}

/* End of code generation (indexShapeCheck.c) */
