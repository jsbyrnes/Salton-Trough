/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * NearestInterpolation.h
 *
 * Code generation for function 'NearestInterpolation'
 *
 */

#ifndef __NEARESTINTERPOLATION_H__
#define __NEARESTINTERPOLATION_H__

/* Include files */
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "blas.h"
#include "rtwtypes.h"
#include "NearestInterpolation_types.h"

/* Function Declarations */
extern void NearestInterpolation(const emlrtStack *sp, const real_T xCell[100],
  const real_T zCell[100], const real_T zetaCell[100], const boolean_T cell_ind
  [100], const real_T X[50000], const real_T Z[50000], real_T nCells, real_T
  npoints, emxArray_real_T *zeta);

#endif

/* End of code generation (NearestInterpolation.h) */
