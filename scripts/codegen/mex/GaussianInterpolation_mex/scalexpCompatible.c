/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * scalexpCompatible.c
 *
 * Code generation for function 'scalexpCompatible'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation_mex.h"
#include "scalexpCompatible.h"

/* Function Definitions */
boolean_T scalexpCompatible(const int32_T a_size[1], const int32_T b_size[2])
{
  boolean_T p;
  int16_T varargin_1[2];
  int16_T varargin_2[2];
  int32_T k;
  boolean_T b_p;
  boolean_T exitg1;
  varargin_1[0] = (int16_T)a_size[0];
  varargin_1[1] = 1;
  for (k = 0; k < 2; k++) {
    varargin_2[k] = (int16_T)b_size[k];
  }

  p = false;
  b_p = true;
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k < 2)) {
    if (!(varargin_1[k] == varargin_2[k])) {
      b_p = false;
      exitg1 = true;
    } else {
      k++;
    }
  }

  if (!b_p) {
  } else {
    p = true;
  }

  return p;
}

/* End of code generation (scalexpCompatible.c) */
