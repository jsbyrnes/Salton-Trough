/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * rdivide.h
 *
 * Code generation for function 'rdivide'
 *
 */

#ifndef RDIVIDE_H
#define RDIVIDE_H

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
extern void rdivide(const emlrtStack *sp, const real_T x_data[], const int32_T
                    x_size[1], const real_T y_data[], const int32_T y_size[2],
                    real_T z_data[], int32_T z_size[1]);

#endif

/* End of code generation (rdivide.h) */
