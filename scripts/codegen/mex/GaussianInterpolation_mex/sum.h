/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sum.h
 *
 * Code generation for function 'sum'
 *
 */

#ifndef SUM_H
#define SUM_H

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
extern real_T sum(const boolean_T x[100]);

#ifdef __WATCOMC__

#pragma aux sum value [8087];

#endif
#endif

/* End of code generation (sum.h) */
