/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * GaussianInterpolation_mex.c
 *
 * Code generation for function 'GaussianInterpolation_mex'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation_mex.h"
#include "power.h"
#include "error.h"
#include "exp.h"
#include "rdivide.h"
#include "sqrt.h"
#include "cosd.h"
#include "sind.h"
#include "assertValidSizeArg.h"
#include "indexShapeCheck.h"
#include "sum.h"
#include "GaussianInterpolation_mex_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 20, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtRSInfo b_emlrtRSI = { 26, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtRSInfo c_emlrtRSI = { 28, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtRSInfo d_emlrtRSI = { 29, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtRSInfo e_emlrtRSI = { 30, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtRSInfo f_emlrtRSI = { 31, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtRSInfo g_emlrtRSI = { 32, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtRSInfo h_emlrtRSI = { 33, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtRSInfo i_emlrtRSI = { 38, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtRSInfo j_emlrtRSI = { 40, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtRSInfo k_emlrtRSI = { 41, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtRSInfo n_emlrtRSI = { 28, "reshape",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elmat\\reshape.m"
};

static emlrtRSInfo o_emlrtRSI = { 61, "reshape",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elmat\\reshape.m"
};

static emlrtRTEInfo emlrtRTEI = { 71, 15, "reshape",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elmat\\reshape.m"
};

static emlrtECInfo emlrtECI = { 2, 40, 13, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtECInfo b_emlrtECI = { -1, 40, 25, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtECInfo c_emlrtECI = { 2, 38, 12, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtECInfo d_emlrtECI = { -1, 36, 10, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtECInfo e_emlrtECI = { 2, 36, 31, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtECInfo f_emlrtECI = { 2, 36, 32, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtECInfo g_emlrtECI = { 2, 36, 10, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtECInfo h_emlrtECI = { 2, 36, 11, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtECInfo i_emlrtECI = { -1, 35, 10, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtECInfo j_emlrtECI = { 2, 35, 31, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtECInfo k_emlrtECI = { 2, 35, 32, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtECInfo l_emlrtECI = { 2, 35, 10, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtECInfo m_emlrtECI = { 2, 35, 11, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtRTEInfo b_emlrtRTEI = { 18, 5, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m" };

static emlrtBCInfo emlrtBCI = { 1, 100, 28, 24, "cell_ind",
  "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 0
};

static emlrtBCInfo b_emlrtBCI = { 1, 100, 28, 18, "xCell",
  "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 0
};

static emlrtDCInfo emlrtDCI = { 28, 18, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 1
};

static emlrtBCInfo c_emlrtBCI = { 1, 100, 29, 18, "zCell",
  "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 0
};

static emlrtDCInfo b_emlrtDCI = { 29, 18, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 1
};

static emlrtBCInfo d_emlrtBCI = { 1, 100, 30, 18, "angle",
  "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 0
};

static emlrtDCInfo c_emlrtDCI = { 30, 18, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 1
};

static emlrtBCInfo e_emlrtBCI = { 1, 100, 31, 18, "width",
  "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 0
};

static emlrtDCInfo d_emlrtDCI = { 31, 18, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 1
};

static emlrtBCInfo f_emlrtBCI = { 1, 100, 32, 18, "eccentricity",
  "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 0
};

static emlrtDCInfo e_emlrtDCI = { 32, 18, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 1
};

static emlrtBCInfo g_emlrtBCI = { 1, 100, 33, 18, "dmQinv",
  "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 0
};

static emlrtDCInfo f_emlrtDCI = { 33, 18, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 1
};

static emlrtBCInfo h_emlrtBCI = { -1, -1, 20, 32, "X",
  "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 0
};

static emlrtBCInfo i_emlrtBCI = { 1, 100, 20, 14, "xCell",
  "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 0
};

static emlrtDCInfo g_emlrtDCI = { 20, 14, "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 1
};

static emlrtBCInfo j_emlrtBCI = { -1, -1, 20, 62, "Z",
  "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 0
};

static emlrtBCInfo k_emlrtBCI = { -1, -1, 22, 13, "ind",
  "GaussianInterpolation_mex",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation_mex.m", 0
};

/* Function Definitions */
void GaussianInterpolation_mex(const emlrtStack *sp, const real_T xCell[100],
  const real_T zCell[100], const real_T angle[100], const real_T width[100],
  const real_T eccentricity[100], const real_T dmQinv[100], const real_T
  cell_ind[100], const real_T X[1000], const real_T Z[1000], real_T mQinv_data[],
  int32_T mQinv_size[1])
{
  boolean_T b_xCell[100];
  int32_T maxdimlen;
  real_T nCells;
  int32_T trueCount;
  int32_T nx;
  int32_T ix;
  real_T ind_data[1000];
  int32_T k;
  int32_T b_trueCount;
  int16_T tmp_data[1000];
  real_T varargin_1[2];
  int16_T b_tmp_data[1000];
  int32_T c_trueCount;
  int32_T sz[2];
  real_T c_xCell[100];
  real_T d[100];
  real_T b_ind_data[1000];
  int32_T ind_size[2];
  real_T dv0[100];
  real_T mtmp;
  boolean_T exitg1;
  real_T x_data[1000];
  real_T mX_data[1000];
  int32_T mX_size[2];
  real_T mZ_data[1000];
  int32_T mZ_size[2];
  real_T mA_data[1000];
  int32_T mA_size[2];
  real_T mW_data[1000];
  int32_T mW_size[2];
  real_T mE_data[1000];
  int32_T mE_size[2];
  real_T mQ_data[1000];
  int32_T mQ_size[2];
  int32_T tmp_size[2];
  int32_T iv0[2];
  int32_T mX[2];
  real_T c_tmp_data[1000];
  real_T d_tmp_data[1000];
  int32_T iv1[2];
  int32_T ind[2];
  int32_T b_tmp_size[2];
  int32_T iv2[2];
  int32_T mZ[2];
  real_T e_tmp_data[1000];
  int32_T x_size[2];
  int32_T iv3[2];
  int32_T x[2];
  real_T f_tmp_data[1000];
  int32_T c_tmp_size[2];
  int32_T iv4[2];
  int32_T b_mX[2];
  real_T g_tmp_data[1000];
  int32_T iv5[2];
  int32_T iv6[2];
  int32_T d_tmp_size[2];
  int32_T iv7[2];
  int32_T b_mZ[2];
  real_T h_tmp_data[1000];
  int32_T iv8[2];
  int32_T mA[2];
  real_T i_tmp_data[1000];
  real_T j_tmp_data[1000];
  int32_T mW[2];
  int32_T iv9[2];
  int32_T b_ind_size[1];
  int32_T c_ind_size[1];
  int32_T e_tmp_size[2];
  int32_T f_tmp_size[1];
  int32_T b_mW_size[2];
  int32_T g_tmp_size[2];
  int32_T mQ[2];
  int32_T mQinv[2];
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  for (maxdimlen = 0; maxdimlen < 100; maxdimlen++) {
    b_xCell[maxdimlen] = (xCell[maxdimlen] != 0.0);
  }

  nCells = sum(b_xCell);
  if (nCells == 0.0) {
    mQinv_size[0] = 1000;
    memset(&mQinv_data[0], 0, 1000U * sizeof(real_T));
  } else {
    trueCount = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (X[maxdimlen] != 0.0) {
        trueCount++;
      }
    }

    nx = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (X[maxdimlen] != 0.0) {
        ind_data[nx] = X[maxdimlen];
        nx++;
      }
    }

    for (ix = 0; ix < trueCount; ix++) {
      ind_data[ix] = 0.0;
    }

    emlrtForLoopVectorCheckR2012b(1.0, 1.0, nCells, mxDOUBLE_CLASS, (int32_T)
      nCells, &b_emlrtRTEI, sp);
    k = 1;
    while (k - 1 <= (int32_T)nCells - 1) {
      b_trueCount = 0;
      for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
        if (X[maxdimlen] != 0.0) {
          b_trueCount++;
        }
      }

      nx = 0;
      c_trueCount = 0;
      for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
        if (X[maxdimlen] != 0.0) {
          tmp_data[nx] = (int16_T)(maxdimlen + 1);
          nx++;
        }

        if (Z[maxdimlen] != 0.0) {
          c_trueCount++;
        }
      }

      nx = 0;
      for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
        if (Z[maxdimlen] != 0.0) {
          b_tmp_data[nx] = (int16_T)(maxdimlen + 1);
          nx++;
        }
      }

      if (!((k >= 1) && (k <= b_trueCount))) {
        emlrtDynamicBoundsCheckR2012b(k, 1, b_trueCount, &h_emlrtBCI, sp);
      }

      for (ix = 0; ix < 100; ix++) {
        if (cell_ind[ix] != (int32_T)muDoubleScalarFloor(cell_ind[ix])) {
          emlrtIntegerCheckR2012b(cell_ind[ix], &g_emlrtDCI, sp);
        }

        nx = (int32_T)cell_ind[ix];
        if (!((nx >= 1) && (nx <= 100))) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, 100, &i_emlrtBCI, sp);
        }

        c_xCell[ix] = xCell[nx - 1] - X[tmp_data[k - 1] - 1];
      }

      st.site = &emlrtRSI;
      power(c_xCell, d);
      if (!((k >= 1) && (k <= c_trueCount))) {
        emlrtDynamicBoundsCheckR2012b(k, 1, c_trueCount, &j_emlrtBCI, sp);
      }

      for (ix = 0; ix < 100; ix++) {
        c_xCell[ix] = zCell[(int32_T)cell_ind[ix] - 1] - Z[b_tmp_data[k - 1] - 1];
      }

      st.site = &emlrtRSI;
      power(c_xCell, dv0);
      for (ix = 0; ix < 100; ix++) {
        d[ix] += dv0[ix];
      }

      maxdimlen = 1;
      mtmp = d[0];
      nx = 1;
      if (muDoubleScalarIsNaN(d[0])) {
        ix = 2;
        exitg1 = false;
        while ((!exitg1) && (ix < 101)) {
          maxdimlen = ix;
          if (!muDoubleScalarIsNaN(d[ix - 1])) {
            mtmp = d[ix - 1];
            nx = ix;
            exitg1 = true;
          } else {
            ix++;
          }
        }
      }

      if (maxdimlen < 100) {
        while (maxdimlen + 1 < 101) {
          if (d[maxdimlen] < mtmp) {
            mtmp = d[maxdimlen];
            nx = maxdimlen + 1;
          }

          maxdimlen++;
        }
      }

      if (!((k >= 1) && (k <= trueCount))) {
        emlrtDynamicBoundsCheckR2012b(k, 1, trueCount, &k_emlrtBCI, sp);
      }

      ind_data[k - 1] = nx;
      k++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }

    b_trueCount = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (X[maxdimlen] != 0.0) {
        b_trueCount++;
      }
    }

    st.site = &b_emlrtRSI;
    varargin_1[0] = b_trueCount;
    varargin_1[1] = 1.0;
    b_st.site = &n_emlrtRSI;
    assertValidSizeArg(&b_st, varargin_1);
    for (ix = 0; ix < 2; ix++) {
      sz[ix] = (int32_T)varargin_1[ix];
    }

    maxdimlen = (int16_T)trueCount;
    if (1 > (int16_T)trueCount) {
      maxdimlen = 1;
    }

    maxdimlen = muIntScalarMax_sint32(trueCount, maxdimlen);
    if (sz[0] > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    if (1 > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    ind_size[0] = sz[0];
    ind_size[1] = 1;
    if (trueCount == sz[0]) {
    } else {
      emlrtErrorWithMessageIdR2012b(&st, &emlrtRTEI,
        "Coder:MATLAB:getReshapeDims_notSameNumel", 0);
    }

    for (k = 0; k + 1 <= trueCount; k++) {
      b_ind_data[k] = ind_data[k];
    }

    st.site = &c_emlrtRSI;
    indexShapeCheck(&st, ind_size);
    maxdimlen = sz[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      nx = (int32_T)b_ind_data[ix];
      if (!((nx >= 1) && (nx <= 100))) {
        emlrtDynamicBoundsCheckR2012b(nx, 1, 100, &emlrtBCI, sp);
      }
    }

    st.site = &c_emlrtRSI;
    indexShapeCheck(&st, ind_size);
    trueCount = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (X[maxdimlen] != 0.0) {
        trueCount++;
      }
    }

    st.site = &c_emlrtRSI;
    maxdimlen = sz[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      mtmp = cell_ind[(int32_T)b_ind_data[ix] - 1];
      if (mtmp != (int32_T)muDoubleScalarFloor(mtmp)) {
        emlrtIntegerCheckR2012b(mtmp, &emlrtDCI, &st);
      }

      nx = (int32_T)mtmp;
      if (!((nx >= 1) && (nx <= 100))) {
        emlrtDynamicBoundsCheckR2012b(nx, 1, 100, &b_emlrtBCI, &st);
      }

      x_data[ix] = xCell[nx - 1];
    }

    varargin_1[0] = trueCount;
    varargin_1[1] = 1.0;
    nx = sz[0];
    b_st.site = &n_emlrtRSI;
    assertValidSizeArg(&b_st, varargin_1);
    for (ix = 0; ix < 2; ix++) {
      sz[ix] = (int32_T)varargin_1[ix];
    }

    maxdimlen = ind_size[0];
    if (1 > ind_size[0]) {
      maxdimlen = 1;
    }

    maxdimlen = muIntScalarMax_sint32(ind_size[0], maxdimlen);
    if (sz[0] > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    if (1 > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    mX_size[0] = sz[0];
    mX_size[1] = 1;
    if (ind_size[0] == sz[0]) {
    } else {
      emlrtErrorWithMessageIdR2012b(&st, &emlrtRTEI,
        "Coder:MATLAB:getReshapeDims_notSameNumel", 0);
    }

    for (k = 0; k + 1 <= nx; k++) {
      mX_data[k] = x_data[k];
    }

    st.site = &d_emlrtRSI;
    indexShapeCheck(&st, ind_size);
    st.site = &d_emlrtRSI;
    indexShapeCheck(&st, ind_size);
    trueCount = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (X[maxdimlen] != 0.0) {
        trueCount++;
      }
    }

    st.site = &d_emlrtRSI;
    maxdimlen = ind_size[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      mtmp = cell_ind[(int32_T)b_ind_data[ix] - 1];
      if (mtmp != (int32_T)muDoubleScalarFloor(mtmp)) {
        emlrtIntegerCheckR2012b(mtmp, &b_emlrtDCI, &st);
      }

      nx = (int32_T)mtmp;
      if (!((nx >= 1) && (nx <= 100))) {
        emlrtDynamicBoundsCheckR2012b(nx, 1, 100, &c_emlrtBCI, &st);
      }

      x_data[ix] = zCell[nx - 1];
    }

    varargin_1[0] = trueCount;
    varargin_1[1] = 1.0;
    b_st.site = &n_emlrtRSI;
    assertValidSizeArg(&b_st, varargin_1);
    for (ix = 0; ix < 2; ix++) {
      sz[ix] = (int32_T)varargin_1[ix];
    }

    maxdimlen = ind_size[0];
    if (1 > ind_size[0]) {
      maxdimlen = 1;
    }

    maxdimlen = muIntScalarMax_sint32(ind_size[0], maxdimlen);
    if (sz[0] > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    if (1 > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    mZ_size[0] = sz[0];
    mZ_size[1] = 1;
    if (ind_size[0] == sz[0]) {
    } else {
      emlrtErrorWithMessageIdR2012b(&st, &emlrtRTEI,
        "Coder:MATLAB:getReshapeDims_notSameNumel", 0);
    }

    for (k = 0; k + 1 <= ind_size[0]; k++) {
      mZ_data[k] = x_data[k];
    }

    st.site = &e_emlrtRSI;
    indexShapeCheck(&st, ind_size);
    st.site = &e_emlrtRSI;
    indexShapeCheck(&st, ind_size);
    trueCount = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (X[maxdimlen] != 0.0) {
        trueCount++;
      }
    }

    st.site = &e_emlrtRSI;
    maxdimlen = ind_size[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      mtmp = cell_ind[(int32_T)b_ind_data[ix] - 1];
      if (mtmp != (int32_T)muDoubleScalarFloor(mtmp)) {
        emlrtIntegerCheckR2012b(mtmp, &c_emlrtDCI, &st);
      }

      nx = (int32_T)mtmp;
      if (!((nx >= 1) && (nx <= 100))) {
        emlrtDynamicBoundsCheckR2012b(nx, 1, 100, &d_emlrtBCI, &st);
      }

      x_data[ix] = angle[nx - 1];
    }

    varargin_1[0] = trueCount;
    varargin_1[1] = 1.0;
    b_st.site = &n_emlrtRSI;
    assertValidSizeArg(&b_st, varargin_1);
    for (ix = 0; ix < 2; ix++) {
      sz[ix] = (int32_T)varargin_1[ix];
    }

    maxdimlen = ind_size[0];
    if (1 > ind_size[0]) {
      maxdimlen = 1;
    }

    maxdimlen = muIntScalarMax_sint32(ind_size[0], maxdimlen);
    if (sz[0] > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    if (1 > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    mA_size[0] = sz[0];
    mA_size[1] = 1;
    if (ind_size[0] == sz[0]) {
    } else {
      emlrtErrorWithMessageIdR2012b(&st, &emlrtRTEI,
        "Coder:MATLAB:getReshapeDims_notSameNumel", 0);
    }

    for (k = 0; k + 1 <= ind_size[0]; k++) {
      mA_data[k] = x_data[k];
    }

    st.site = &f_emlrtRSI;
    indexShapeCheck(&st, ind_size);
    st.site = &f_emlrtRSI;
    indexShapeCheck(&st, ind_size);
    trueCount = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (X[maxdimlen] != 0.0) {
        trueCount++;
      }
    }

    st.site = &f_emlrtRSI;
    maxdimlen = ind_size[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      mtmp = cell_ind[(int32_T)b_ind_data[ix] - 1];
      if (mtmp != (int32_T)muDoubleScalarFloor(mtmp)) {
        emlrtIntegerCheckR2012b(mtmp, &d_emlrtDCI, &st);
      }

      nx = (int32_T)mtmp;
      if (!((nx >= 1) && (nx <= 100))) {
        emlrtDynamicBoundsCheckR2012b(nx, 1, 100, &e_emlrtBCI, &st);
      }

      x_data[ix] = width[nx - 1];
    }

    varargin_1[0] = trueCount;
    varargin_1[1] = 1.0;
    b_st.site = &n_emlrtRSI;
    assertValidSizeArg(&b_st, varargin_1);
    for (ix = 0; ix < 2; ix++) {
      sz[ix] = (int32_T)varargin_1[ix];
    }

    maxdimlen = ind_size[0];
    if (1 > ind_size[0]) {
      maxdimlen = 1;
    }

    maxdimlen = muIntScalarMax_sint32(ind_size[0], maxdimlen);
    if (sz[0] > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    if (1 > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    mW_size[0] = sz[0];
    mW_size[1] = 1;
    if (ind_size[0] == sz[0]) {
    } else {
      emlrtErrorWithMessageIdR2012b(&st, &emlrtRTEI,
        "Coder:MATLAB:getReshapeDims_notSameNumel", 0);
    }

    for (k = 0; k + 1 <= ind_size[0]; k++) {
      mW_data[k] = x_data[k];
    }

    st.site = &g_emlrtRSI;
    indexShapeCheck(&st, ind_size);
    st.site = &g_emlrtRSI;
    indexShapeCheck(&st, ind_size);
    trueCount = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (X[maxdimlen] != 0.0) {
        trueCount++;
      }
    }

    st.site = &g_emlrtRSI;
    maxdimlen = ind_size[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      mtmp = cell_ind[(int32_T)b_ind_data[ix] - 1];
      if (mtmp != (int32_T)muDoubleScalarFloor(mtmp)) {
        emlrtIntegerCheckR2012b(mtmp, &e_emlrtDCI, &st);
      }

      nx = (int32_T)mtmp;
      if (!((nx >= 1) && (nx <= 100))) {
        emlrtDynamicBoundsCheckR2012b(nx, 1, 100, &f_emlrtBCI, &st);
      }

      x_data[ix] = eccentricity[nx - 1];
    }

    varargin_1[0] = trueCount;
    varargin_1[1] = 1.0;
    b_st.site = &n_emlrtRSI;
    assertValidSizeArg(&b_st, varargin_1);
    for (ix = 0; ix < 2; ix++) {
      sz[ix] = (int32_T)varargin_1[ix];
    }

    maxdimlen = ind_size[0];
    if (1 > ind_size[0]) {
      maxdimlen = 1;
    }

    maxdimlen = muIntScalarMax_sint32(ind_size[0], maxdimlen);
    if (sz[0] > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    if (1 > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    mE_size[0] = sz[0];
    mE_size[1] = 1;
    if (ind_size[0] == sz[0]) {
    } else {
      emlrtErrorWithMessageIdR2012b(&st, &emlrtRTEI,
        "Coder:MATLAB:getReshapeDims_notSameNumel", 0);
    }

    for (k = 0; k + 1 <= ind_size[0]; k++) {
      mE_data[k] = x_data[k];
    }

    st.site = &h_emlrtRSI;
    indexShapeCheck(&st, ind_size);
    st.site = &h_emlrtRSI;
    indexShapeCheck(&st, ind_size);
    trueCount = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (X[maxdimlen] != 0.0) {
        trueCount++;
      }
    }

    st.site = &h_emlrtRSI;
    maxdimlen = ind_size[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      mtmp = cell_ind[(int32_T)b_ind_data[ix] - 1];
      if (mtmp != (int32_T)muDoubleScalarFloor(mtmp)) {
        emlrtIntegerCheckR2012b(mtmp, &f_emlrtDCI, &st);
      }

      nx = (int32_T)mtmp;
      if (!((nx >= 1) && (nx <= 100))) {
        emlrtDynamicBoundsCheckR2012b(nx, 1, 100, &g_emlrtBCI, &st);
      }

      x_data[ix] = dmQinv[nx - 1];
    }

    varargin_1[0] = trueCount;
    varargin_1[1] = 1.0;
    b_st.site = &n_emlrtRSI;
    assertValidSizeArg(&b_st, varargin_1);
    for (ix = 0; ix < 2; ix++) {
      sz[ix] = (int32_T)varargin_1[ix];
    }

    maxdimlen = ind_size[0];
    if (1 > ind_size[0]) {
      maxdimlen = 1;
    }

    maxdimlen = muIntScalarMax_sint32(ind_size[0], maxdimlen);
    if (sz[0] > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    if (1 > maxdimlen) {
      b_st.site = &o_emlrtRSI;
      b_error(&b_st);
    }

    mQ_size[0] = sz[0];
    mQ_size[1] = 1;
    if (ind_size[0] == sz[0]) {
    } else {
      emlrtErrorWithMessageIdR2012b(&st, &emlrtRTEI,
        "Coder:MATLAB:getReshapeDims_notSameNumel", 0);
    }

    for (k = 0; k + 1 <= ind_size[0]; k++) {
      mQ_data[k] = x_data[k];
    }

    trueCount = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (X[maxdimlen] != 0.0) {
        trueCount++;
      }
    }

    tmp_size[0] = trueCount;
    tmp_size[1] = 1;
    nx = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (X[maxdimlen] != 0.0) {
        c_tmp_data[nx] = X[maxdimlen];
        nx++;
      }
    }

    for (ix = 0; ix < 2; ix++) {
      iv0[ix] = tmp_size[ix];
      mX[ix] = mX_size[ix];
    }

    if ((iv0[0] != mX[0]) || (iv0[1] != mX[1])) {
      emlrtSizeEqCheckNDR2012b(&iv0[0], &mX[0], &m_emlrtECI, sp);
    }

    for (ix = 0; ix < trueCount; ix++) {
      d_tmp_data[ix] = c_tmp_data[ix] - mX_data[ix];
    }

    tmp_size[0] = trueCount;
    tmp_size[1] = 1;
    for (ix = 0; ix < trueCount; ix++) {
      c_tmp_data[ix] = d_tmp_data[ix];
    }

    ind_size[0] = mA_size[0];
    ind_size[1] = 1;
    maxdimlen = mA_size[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      b_ind_data[ix] = mA_data[ix];
    }

    cosd(b_ind_data, ind_size);
    for (ix = 0; ix < 2; ix++) {
      iv1[ix] = tmp_size[ix];
      ind[ix] = ind_size[ix];
    }

    if ((iv1[0] != ind[0]) || (iv1[1] != ind[1])) {
      emlrtSizeEqCheckNDR2012b(&iv1[0], &ind[0], &l_emlrtECI, sp);
    }

    b_trueCount = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (Z[maxdimlen] != 0.0) {
        b_trueCount++;
      }
    }

    b_tmp_size[0] = b_trueCount;
    b_tmp_size[1] = 1;
    nx = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (Z[maxdimlen] != 0.0) {
        e_tmp_data[nx] = Z[maxdimlen];
        nx++;
      }
    }

    for (ix = 0; ix < 2; ix++) {
      iv2[ix] = b_tmp_size[ix];
      mZ[ix] = mZ_size[ix];
    }

    if ((iv2[0] != mZ[0]) || (iv2[1] != mZ[1])) {
      emlrtSizeEqCheckNDR2012b(&iv2[0], &mZ[0], &k_emlrtECI, sp);
    }

    for (ix = 0; ix < b_trueCount; ix++) {
      d_tmp_data[ix] = e_tmp_data[ix] - mZ_data[ix];
    }

    b_tmp_size[0] = b_trueCount;
    b_tmp_size[1] = 1;
    for (ix = 0; ix < b_trueCount; ix++) {
      e_tmp_data[ix] = d_tmp_data[ix];
    }

    x_size[0] = mA_size[0];
    x_size[1] = 1;
    maxdimlen = mA_size[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      x_data[ix] = mA_data[ix];
    }

    sind(x_data, x_size);
    for (ix = 0; ix < 2; ix++) {
      iv3[ix] = b_tmp_size[ix];
      x[ix] = x_size[ix];
    }

    if ((iv3[0] != x[0]) || (iv3[1] != x[1])) {
      emlrtSizeEqCheckNDR2012b(&iv3[0], &x[0], &j_emlrtECI, sp);
    }

    for (ix = 0; ix < trueCount; ix++) {
      ind_data[ix] = c_tmp_data[ix] * b_ind_data[ix];
    }

    for (ix = 0; ix < b_trueCount; ix++) {
      f_tmp_data[ix] = e_tmp_data[ix] * x_data[ix];
    }

    if (trueCount != b_trueCount) {
      emlrtSizeEqCheck1DR2012b(trueCount, b_trueCount, &i_emlrtECI, sp);
    }

    b_trueCount = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (X[maxdimlen] != 0.0) {
        b_trueCount++;
      }
    }

    c_tmp_size[0] = b_trueCount;
    c_tmp_size[1] = 1;
    nx = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (X[maxdimlen] != 0.0) {
        g_tmp_data[nx] = X[maxdimlen];
        nx++;
      }
    }

    for (ix = 0; ix < 2; ix++) {
      iv4[ix] = c_tmp_size[ix];
      b_mX[ix] = mX_size[ix];
    }

    if ((iv4[0] != b_mX[0]) || (iv4[1] != b_mX[1])) {
      emlrtSizeEqCheckNDR2012b(&iv4[0], &b_mX[0], &h_emlrtECI, sp);
    }

    for (ix = 0; ix < b_trueCount; ix++) {
      d_tmp_data[ix] = g_tmp_data[ix] - mX_data[ix];
    }

    c_tmp_size[0] = b_trueCount;
    c_tmp_size[1] = 1;
    for (ix = 0; ix < b_trueCount; ix++) {
      g_tmp_data[ix] = d_tmp_data[ix];
    }

    tmp_size[0] = mA_size[0];
    tmp_size[1] = 1;
    maxdimlen = mA_size[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      c_tmp_data[ix] = mA_data[ix];
    }

    sind(c_tmp_data, tmp_size);
    for (ix = 0; ix < 2; ix++) {
      iv5[ix] = c_tmp_size[ix];
      iv6[ix] = tmp_size[ix];
    }

    if ((iv5[0] != iv6[0]) || (iv5[1] != iv6[1])) {
      emlrtSizeEqCheckNDR2012b(&iv5[0], &iv6[0], &g_emlrtECI, sp);
    }

    c_trueCount = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (Z[maxdimlen] != 0.0) {
        c_trueCount++;
      }
    }

    d_tmp_size[0] = c_trueCount;
    d_tmp_size[1] = 1;
    nx = 0;
    for (maxdimlen = 0; maxdimlen < 1000; maxdimlen++) {
      if (Z[maxdimlen] != 0.0) {
        h_tmp_data[nx] = Z[maxdimlen];
        nx++;
      }
    }

    for (ix = 0; ix < 2; ix++) {
      iv7[ix] = d_tmp_size[ix];
      b_mZ[ix] = mZ_size[ix];
    }

    if ((iv7[0] != b_mZ[0]) || (iv7[1] != b_mZ[1])) {
      emlrtSizeEqCheckNDR2012b(&iv7[0], &b_mZ[0], &f_emlrtECI, sp);
    }

    for (ix = 0; ix < c_trueCount; ix++) {
      d_tmp_data[ix] = h_tmp_data[ix] - mZ_data[ix];
    }

    d_tmp_size[0] = c_trueCount;
    d_tmp_size[1] = 1;
    for (ix = 0; ix < c_trueCount; ix++) {
      h_tmp_data[ix] = d_tmp_data[ix];
    }

    cosd(mA_data, mA_size);
    for (ix = 0; ix < 2; ix++) {
      iv8[ix] = d_tmp_size[ix];
      mA[ix] = mA_size[ix];
    }

    if ((iv8[0] != mA[0]) || (iv8[1] != mA[1])) {
      emlrtSizeEqCheckNDR2012b(&iv8[0], &mA[0], &e_emlrtECI, sp);
    }

    for (ix = 0; ix < b_trueCount; ix++) {
      i_tmp_data[ix] = g_tmp_data[ix] * c_tmp_data[ix];
    }

    for (ix = 0; ix < c_trueCount; ix++) {
      j_tmp_data[ix] = h_tmp_data[ix] * mA_data[ix];
    }

    if (b_trueCount != c_trueCount) {
      emlrtSizeEqCheck1DR2012b(b_trueCount, c_trueCount, &d_emlrtECI, sp);
    }

    st.site = &i_emlrtRSI;
    b_power(&st, mE_data, mE_size, c_tmp_data, tmp_size);
    tmp_size[1] = 1;
    maxdimlen = tmp_size[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      c_tmp_data[ix] = 1.0 - c_tmp_data[ix];
    }

    st.site = &i_emlrtRSI;
    b_sqrt(&st, c_tmp_data, tmp_size);
    for (ix = 0; ix < 2; ix++) {
      mW[ix] = mW_size[ix];
      iv9[ix] = tmp_size[ix];
    }

    if ((mW[0] != iv9[0]) || (mW[1] != iv9[1])) {
      emlrtSizeEqCheckNDR2012b(&mW[0], &iv9[0], &c_emlrtECI, sp);
    }

    b_ind_size[0] = trueCount;
    for (ix = 0; ix < trueCount; ix++) {
      b_ind_data[ix] = ind_data[ix] - f_tmp_data[ix];
    }

    st.site = &j_emlrtRSI;
    c_power(&st, b_ind_data, b_ind_size, ind_data, c_ind_size);
    st.site = &j_emlrtRSI;
    b_power(&st, mW_data, mW_size, b_ind_data, ind_size);
    e_tmp_size[0] = ind_size[0];
    e_tmp_size[1] = 1;
    maxdimlen = ind_size[0] * ind_size[1];
    for (ix = 0; ix < maxdimlen; ix++) {
      d_tmp_data[ix] = 2.0 * b_ind_data[ix];
    }

    st.site = &j_emlrtRSI;
    rdivide(&st, ind_data, c_ind_size, d_tmp_data, e_tmp_size, mQinv_data,
            mQinv_size);
    f_tmp_size[0] = b_trueCount;
    for (ix = 0; ix < b_trueCount; ix++) {
      d_tmp_data[ix] = i_tmp_data[ix] + j_tmp_data[ix];
    }

    st.site = &k_emlrtRSI;
    c_power(&st, d_tmp_data, f_tmp_size, ind_data, c_ind_size);
    b_mW_size[0] = mW_size[0];
    b_mW_size[1] = 1;
    maxdimlen = mW_size[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      d_tmp_data[ix] = mW_data[ix] * c_tmp_data[ix];
    }

    st.site = &k_emlrtRSI;
    b_power(&st, d_tmp_data, b_mW_size, b_ind_data, ind_size);
    g_tmp_size[0] = ind_size[0];
    g_tmp_size[1] = 1;
    maxdimlen = ind_size[0] * ind_size[1];
    for (ix = 0; ix < maxdimlen; ix++) {
      d_tmp_data[ix] = 2.0 * b_ind_data[ix];
    }

    st.site = &k_emlrtRSI;
    rdivide(&st, ind_data, c_ind_size, d_tmp_data, g_tmp_size, f_tmp_data,
            f_tmp_size);
    if (mQinv_size[0] != f_tmp_size[0]) {
      emlrtSizeEqCheck1DR2012b(mQinv_size[0], f_tmp_size[0], &b_emlrtECI, sp);
    }

    maxdimlen = mQinv_size[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      mQinv_data[ix] = -(mQinv_data[ix] + f_tmp_data[ix]);
    }

    b_exp(mQinv_data, mQinv_size);
    for (ix = 0; ix < 2; ix++) {
      mQ[ix] = mQ_size[ix];
    }

    mQinv[0] = mQinv_size[0];
    mQinv[1] = 1;
    if ((mQ[0] != mQinv[0]) || (mQ[1] != mQinv[1])) {
      emlrtSizeEqCheckNDR2012b(&mQ[0], &mQinv[0], &emlrtECI, sp);
    }

    mQinv_size[0] = sz[0];
    maxdimlen = sz[0];
    for (ix = 0; ix < maxdimlen; ix++) {
      mQinv_data[ix] *= mQ_data[ix];
    }
  }

  /*      for k = 1:numel(X) */
  /*       */
  /*          d = (model.xCell(cell_ind) - X(k)).^2 + (model.zCell(cell_ind) - Z(k)).^2; */
  /*          [~, ind] = min(d); */
  /*           */
  /*           */
  /*      end */
  /*      for k = cell_ind */
  /*                  */
  /*          Xr = (X - model.xCell(k))*cosd(model.angle(k)) - (Z - model.zCell(k))*sind(model.angle(k)); */
  /*          Zr = (X - model.xCell(k))*sind(model.angle(k)) + (Z - model.zCell(k))*cosd(model.angle(k)); */
  /*           */
  /*          sigb = model.width(k)*sqrt(1 - (model.eccentricity(k)^2)); */
  /*           */
  /*          mQinv = mQinv + model.dmQinv(k)*exp( -( ( Xr.^2)/(2*model.width(k)^2) ... */
  /*              + (Zr.^2)/(2*sigb^2))); */
  /*           */
  /*      end */
}

/* End of code generation (GaussianInterpolation_mex.c) */
