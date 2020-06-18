/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * assertValidSizeArg.c
 *
 * Code generation for function 'assertValidSizeArg'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation_mex.h"
#include "assertValidSizeArg.h"

/* Variable Definitions */
static emlrtRTEInfo d_emlrtRTEI = { 44, 19, "assertValidSizeArg",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\assertValidSizeArg.m"
};

static emlrtRTEInfo e_emlrtRTEI = { 59, 15, "assertValidSizeArg",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\assertValidSizeArg.m"
};

/* Function Definitions */
void assertValidSizeArg(const emlrtStack *sp, const real_T varargin_1[2])
{
  int32_T k;
  int32_T exitg2;
  boolean_T p;
  boolean_T guard1 = false;
  int32_T exitg1;
  real_T n;
  k = 0;
  do {
    exitg2 = 0;
    if (k < 2) {
      if (varargin_1[k] != varargin_1[k]) {
        p = false;
        exitg2 = 1;
      } else {
        k++;
      }
    } else {
      p = true;
      exitg2 = 1;
    }
  } while (exitg2 == 0);

  guard1 = false;
  if (p) {
    k = 0;
    do {
      exitg1 = 0;
      if (k < 2) {
        if (-2.147483648E+9 > varargin_1[k]) {
          p = false;
          exitg1 = 1;
        } else {
          k++;
        }
      } else {
        p = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (p) {
      p = true;
    } else {
      guard1 = true;
    }
  } else {
    guard1 = true;
  }

  if (guard1) {
    p = false;
  }

  if (p) {
  } else {
    emlrtErrorWithMessageIdR2012b(sp, &d_emlrtRTEI,
      "Coder:toolbox:eml_assert_valid_size_arg_invalidSizeVector", 4, 12,
      MIN_int32_T, 12, MAX_int32_T);
  }

  n = 1.0;
  for (k = 0; k < 2; k++) {
    if (varargin_1[k] <= 0.0) {
      n = 0.0;
    } else {
      n *= varargin_1[k];
    }
  }

  if (2.147483647E+9 >= n) {
  } else {
    emlrtErrorWithMessageIdR2012b(sp, &e_emlrtRTEI, "Coder:MATLAB:pmaxsize", 0);
  }
}

/* End of code generation (assertValidSizeArg.c) */
