/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * scalexpAlloc.c
 *
 * Code generation for function 'scalexpAlloc'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation_mex.h"
#include "scalexpAlloc.h"

/* Function Definitions */
boolean_T b_dimagree(const int32_T z_size[1], const int32_T varargin_1_size[1])
{
  boolean_T p;
  boolean_T b_p;
  int32_T k;
  boolean_T exitg1;
  int32_T b_k;
  int32_T c_k;
  p = true;
  b_p = true;
  k = 1;
  exitg1 = false;
  while ((!exitg1) && (k < 3)) {
    if (k <= 1) {
      b_k = z_size[0];
    } else {
      b_k = 1;
    }

    if (k <= 1) {
      c_k = varargin_1_size[0];
    } else {
      c_k = 1;
    }

    if (b_k != c_k) {
      b_p = false;
      exitg1 = true;
    } else {
      k++;
    }
  }

  if (b_p) {
  } else {
    p = false;
  }

  return p;
}

boolean_T dimagree(const int32_T z_size[2], const int32_T varargin_1_size[2])
{
  boolean_T p;
  boolean_T b_p;
  int32_T k;
  boolean_T exitg1;
  p = true;
  b_p = true;
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k + 1 < 3)) {
    if (z_size[k] != varargin_1_size[k]) {
      b_p = false;
      exitg1 = true;
    } else {
      k++;
    }
  }

  if (b_p) {
  } else {
    p = false;
  }

  return p;
}

/* End of code generation (scalexpAlloc.c) */
