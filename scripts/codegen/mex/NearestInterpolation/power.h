/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * power.h
 *
 * Code generation for function 'power'
 *
 */

#ifndef __POWER_H__
#define __POWER_H__

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
extern void power(const emlrtStack *sp, const real_T a_data[], const int32_T
                  a_size[1], real_T y_data[], int32_T y_size[1]);

#endif

/* End of code generation (power.h) */
