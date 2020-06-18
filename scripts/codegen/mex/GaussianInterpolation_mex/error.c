/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * error.c
 *
 * Code generation for function 'error'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation_mex.h"
#include "error.h"

/* Variable Definitions */
static emlrtRTEInfo c_emlrtRTEI = { 17, 9, "error",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\error.m"
};

/* Function Definitions */
void b_error(const emlrtStack *sp)
{
  emlrtErrorWithMessageIdR2012b(sp, &c_emlrtRTEI,
    "Coder:toolbox:reshape_emptyReshapeLimit", 0);
}

void c_error(const emlrtStack *sp)
{
  emlrtErrorWithMessageIdR2012b(sp, &c_emlrtRTEI,
    "Coder:toolbox:ElFunDomainError", 3, 4, 4, "sqrt");
}

void error(const emlrtStack *sp)
{
  emlrtErrorWithMessageIdR2012b(sp, &c_emlrtRTEI,
    "Coder:toolbox:power_domainError", 0);
}

/* End of code generation (error.c) */
