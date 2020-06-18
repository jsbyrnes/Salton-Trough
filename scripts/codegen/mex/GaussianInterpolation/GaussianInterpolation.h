/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * GaussianInterpolation.h
 *
 * Code generation for function 'GaussianInterpolation'
 *
 */

#ifndef GAUSSIANINTERPOLATION_H
#define GAUSSIANINTERPOLATION_H

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
#include "GaussianInterpolation_types.h"

/* Function Declarations */
extern void GaussianInterpolation(const emlrtStack *sp, const real_T xCell[100],
  const real_T zCell[100], const real_T angle[100], const real_T width[100],
  const real_T eccentricity[100], const real_T dmQinv[100], const real_T
  cell_ind[100], const real_T X[1000], const real_T Z[1000], real_T nCells,
  real_T npoints, emxArray_real_T *mQinv);

#endif

/* End of code generation (GaussianInterpolation.h) */
