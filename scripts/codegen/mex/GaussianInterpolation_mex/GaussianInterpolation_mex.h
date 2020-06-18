/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * GaussianInterpolation_mex.h
 *
 * Code generation for function 'GaussianInterpolation_mex'
 *
 */

#ifndef GAUSSIANINTERPOLATION_MEX_H
#define GAUSSIANINTERPOLATION_MEX_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "GaussianInterpolation_mex_types.h"

/* Function Declarations */
extern void GaussianInterpolation_mex(const emlrtStack *sp, const real_T xCell
  [100], const real_T zCell[100], const real_T angle[100], const real_T width
  [100], const real_T eccentricity[100], const real_T dmQinv[100], const real_T
  cell_ind[100], const real_T X[1000], const real_T Z[1000], real_T mQinv_data[],
  int32_T mQinv_size[1]);

#endif

/* End of code generation (GaussianInterpolation_mex.h) */
