/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * GaussianInterpolation.c
 *
 * Code generation for function 'GaussianInterpolation'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation.h"
#include "GaussianInterpolation_emxutil.h"
#include "sqrt.h"
#include "cosd.h"
#include "sind.h"
#include "power.h"
#include "GaussianInterpolation_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 18, "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m" };

static emlrtRSInfo b_emlrtRSI = { 23, "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m" };

static emlrtRSInfo c_emlrtRSI = { 25, "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m" };

static emlrtRSInfo d_emlrtRSI = { 26, "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m" };

static emlrtRSInfo h_emlrtRSI = { 15, "min",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\datafun\\min.m"
};

static emlrtRSInfo i_emlrtRSI = { 16, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtRTEInfo emlrtRTEI = { 1, 22, "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m" };

static emlrtDCInfo emlrtDCI = { 12, 16, "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 1 };

static emlrtBCInfo emlrtBCI = { 1, 100, 12, 16, "cell_ind",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo b_emlrtBCI = { 1, 1000, 13, 11, "X", "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtECInfo emlrtECI = { -1, 18, 24, "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m" };

static emlrtBCInfo c_emlrtBCI = { -1, -1, 23, 61, "cell_ind",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo d_emlrtBCI = { -1, -1, 25, 70, "cell_ind",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtRTEInfo c_emlrtRTEI = { 39, 27, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtRTEInfo d_emlrtRTEI = { 121, 27, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtDCInfo b_emlrtDCI = { 4, 19, "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 1 };

static emlrtDCInfo c_emlrtDCI = { 4, 19, "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 4 };

static emlrtBCInfo e_emlrtBCI = { -1, -1, 18, 25, "X", "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo f_emlrtBCI = { 1, 100, 18, 32, "xCell",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtDCInfo d_emlrtDCI = { 18, 32, "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 1 };

static emlrtBCInfo g_emlrtBCI = { -1, -1, 18, 55, "Z", "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo h_emlrtBCI = { -1, -1, 20, 56, "cell_ind",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo i_emlrtBCI = { -1, -1, 20, 116, "cell_ind",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo j_emlrtBCI = { -1, -1, 20, 15, "X", "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo k_emlrtBCI = { -1, -1, 20, 28, "cell_ind",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo l_emlrtBCI = { -1, -1, 20, 75, "Z", "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo m_emlrtBCI = { -1, -1, 20, 88, "cell_ind",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo n_emlrtBCI = { -1, -1, 21, 56, "cell_ind",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo o_emlrtBCI = { -1, -1, 21, 116, "cell_ind",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo p_emlrtBCI = { -1, -1, 21, 15, "X", "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo q_emlrtBCI = { -1, -1, 21, 28, "cell_ind",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo r_emlrtBCI = { -1, -1, 21, 75, "Z", "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo s_emlrtBCI = { -1, -1, 21, 88, "cell_ind",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo t_emlrtBCI = { -1, -1, 23, 22, "cell_ind",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo u_emlrtBCI = { -1, -1, 25, 27, "cell_ind",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

static emlrtBCInfo v_emlrtBCI = { -1, -1, 25, 9, "mQinv",
  "GaussianInterpolation",
  "C:\\Research\\tstar\\TDCode2Ddepth\\scripts\\GaussianInterpolation.m", 0 };

/* Function Definitions */
void GaussianInterpolation(const emlrtStack *sp, const real_T xCell[100], const
  real_T zCell[100], const real_T angle[100], const real_T width[100], const
  real_T eccentricity[100], const real_T dmQinv[100], const real_T cell_ind[100],
  const real_T X[1000], const real_T Z[1000], real_T nCells, real_T npoints,
  emxArray_real_T *mQinv)
{
  int32_T i0;
  real_T d0;
  int32_T loop_ub;
  real_T cell_ind_data[100];
  int32_T i1;
  int32_T k;
  real_T X_data[100];
  int32_T X_size[1];
  int32_T n;
  real_T varargin_1_data[100];
  int32_T varargin_1_size[1];
  int32_T ixstart;
  int32_T Z_size[1];
  real_T tmp_data[100];
  int32_T tmp_size[1];
  boolean_T b0;
  real_T mtmp;
  int32_T itmp;
  int32_T ix;
  boolean_T exitg1;
  real_T Xr;
  real_T Zr;
  real_T sigb;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  i0 = mQinv->size[0];
  if (!(npoints >= 0.0)) {
    emlrtNonNegativeCheckR2012b(npoints, &c_emlrtDCI, sp);
  }

  d0 = npoints;
  if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
    emlrtIntegerCheckR2012b(d0, &b_emlrtDCI, sp);
  }

  mQinv->size[0] = (int32_T)d0;
  emxEnsureCapacity(sp, (emxArray__common *)mQinv, i0, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  if (!(npoints >= 0.0)) {
    emlrtNonNegativeCheckR2012b(npoints, &c_emlrtDCI, sp);
  }

  if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
    emlrtIntegerCheckR2012b(d0, &b_emlrtDCI, sp);
  }

  loop_ub = (int32_T)d0;
  for (i0 = 0; i0 < loop_ub; i0++) {
    mQinv->data[i0] = 0.0;
  }

  if (nCells == 0.0) {
  } else {
    if (1.0 > nCells) {
      loop_ub = 0;
    } else {
      if (nCells != (int32_T)muDoubleScalarFloor(nCells)) {
        emlrtIntegerCheckR2012b(nCells, &emlrtDCI, sp);
      }

      loop_ub = (int32_T)nCells;
      if (!((loop_ub >= 1) && (loop_ub <= 100))) {
        emlrtDynamicBoundsCheckR2012b(loop_ub, 1, 100, &emlrtBCI, sp);
      }
    }

    for (i0 = 0; i0 < loop_ub; i0++) {
      cell_ind_data[i0] = cell_ind[i0];
    }

    if (1.0 > npoints) {
      i0 = 0;
    } else {
      i0 = (int32_T)npoints;
      if (!((i0 >= 1) && (i0 <= 1000))) {
        emlrtDynamicBoundsCheckR2012b(i0, 1, 1000, &b_emlrtBCI, sp);
      }
    }

    if (1.0 > npoints) {
      i1 = 0;
    } else {
      i1 = (int32_T)npoints;
    }

    k = 1;
    while (k - 1 <= (int32_T)npoints - 1) {
      if (!((k >= 1) && (k <= i0))) {
        emlrtDynamicBoundsCheckR2012b(k, 1, i0, &e_emlrtBCI, sp);
      }

      X_size[0] = loop_ub;
      for (n = 0; n < loop_ub; n++) {
        if (cell_ind_data[n] != (int32_T)muDoubleScalarFloor(cell_ind_data[n]))
        {
          emlrtIntegerCheckR2012b(cell_ind_data[n], &d_emlrtDCI, sp);
        }

        ixstart = (int32_T)cell_ind_data[n];
        if (!((ixstart >= 1) && (ixstart <= 100))) {
          emlrtDynamicBoundsCheckR2012b(ixstart, 1, 100, &f_emlrtBCI, sp);
        }

        X_data[n] = X[k - 1] - xCell[ixstart - 1];
      }

      st.site = &emlrtRSI;
      power(&st, X_data, X_size, varargin_1_data, varargin_1_size);
      if (!((k >= 1) && (k <= i1))) {
        emlrtDynamicBoundsCheckR2012b(k, 1, i1, &g_emlrtBCI, sp);
      }

      Z_size[0] = loop_ub;
      for (n = 0; n < loop_ub; n++) {
        X_data[n] = Z[k - 1] - zCell[(int32_T)cell_ind_data[n] - 1];
      }

      st.site = &emlrtRSI;
      power(&st, X_data, Z_size, tmp_data, tmp_size);
      if (varargin_1_size[0] != tmp_size[0]) {
        emlrtSizeEqCheck1DR2012b(varargin_1_size[0], tmp_size[0], &emlrtECI, sp);
      }

      st.site = &emlrtRSI;
      ixstart = varargin_1_size[0];
      for (n = 0; n < ixstart; n++) {
        varargin_1_data[n] += tmp_data[n];
      }

      b_st.site = &h_emlrtRSI;
      c_st.site = &i_emlrtRSI;
      if ((varargin_1_size[0] == 1) || (varargin_1_size[0] != 1)) {
        b0 = true;
      } else {
        b0 = false;
      }

      if (b0) {
      } else {
        emlrtErrorWithMessageIdR2012b(&c_st, &c_emlrtRTEI,
          "Coder:toolbox:autoDimIncompatibility", 0);
      }

      if (varargin_1_size[0] > 0) {
      } else {
        emlrtErrorWithMessageIdR2012b(&c_st, &d_emlrtRTEI,
          "Coder:toolbox:eml_min_or_max_varDimZero", 0);
      }

      ixstart = 1;
      n = varargin_1_size[0];
      mtmp = varargin_1_data[0];
      itmp = 1;
      if (varargin_1_size[0] > 1) {
        if (muDoubleScalarIsNaN(varargin_1_data[0])) {
          ix = 2;
          exitg1 = false;
          while ((!exitg1) && (ix <= n)) {
            ixstart = ix;
            if (!muDoubleScalarIsNaN(varargin_1_data[ix - 1])) {
              mtmp = varargin_1_data[ix - 1];
              itmp = ix;
              exitg1 = true;
            } else {
              ix++;
            }
          }
        }

        if (ixstart < varargin_1_size[0]) {
          while (ixstart + 1 <= n) {
            if (varargin_1_data[ixstart] < mtmp) {
              mtmp = varargin_1_data[ixstart];
              itmp = ixstart + 1;
            }

            ixstart++;
          }
        }
      }

      if (!((itmp >= 1) && (itmp <= loop_ub))) {
        emlrtDynamicBoundsCheckR2012b(itmp, 1, loop_ub, &h_emlrtBCI, sp);
      }

      d0 = angle[(int32_T)cell_ind[itmp - 1] - 1];
      cosd(&d0);
      if (!((itmp >= 1) && (itmp <= loop_ub))) {
        emlrtDynamicBoundsCheckR2012b(itmp, 1, loop_ub, &i_emlrtBCI, sp);
      }

      mtmp = angle[(int32_T)cell_ind[itmp - 1] - 1];
      sind(&mtmp);
      if (!((k >= 1) && (k <= i0))) {
        emlrtDynamicBoundsCheckR2012b(k, 1, i0, &j_emlrtBCI, sp);
      }

      if (!((itmp >= 1) && (itmp <= loop_ub))) {
        emlrtDynamicBoundsCheckR2012b(itmp, 1, loop_ub, &k_emlrtBCI, sp);
      }

      if (!((k >= 1) && (k <= i1))) {
        emlrtDynamicBoundsCheckR2012b(k, 1, i1, &l_emlrtBCI, sp);
      }

      if (!((itmp >= 1) && (itmp <= loop_ub))) {
        emlrtDynamicBoundsCheckR2012b(itmp, 1, loop_ub, &m_emlrtBCI, sp);
      }

      Xr = (X[k - 1] - xCell[(int32_T)cell_ind[itmp - 1] - 1]) * d0 - (Z[k - 1]
        - zCell[(int32_T)cell_ind[itmp - 1] - 1]) * mtmp;
      if (!((itmp >= 1) && (itmp <= loop_ub))) {
        emlrtDynamicBoundsCheckR2012b(itmp, 1, loop_ub, &n_emlrtBCI, sp);
      }

      d0 = angle[(int32_T)cell_ind[itmp - 1] - 1];
      sind(&d0);
      if (!((itmp >= 1) && (itmp <= loop_ub))) {
        emlrtDynamicBoundsCheckR2012b(itmp, 1, loop_ub, &o_emlrtBCI, sp);
      }

      mtmp = angle[(int32_T)cell_ind[itmp - 1] - 1];
      cosd(&mtmp);
      if (!((k >= 1) && (k <= i0))) {
        emlrtDynamicBoundsCheckR2012b(k, 1, i0, &p_emlrtBCI, sp);
      }

      if (!((itmp >= 1) && (itmp <= loop_ub))) {
        emlrtDynamicBoundsCheckR2012b(itmp, 1, loop_ub, &q_emlrtBCI, sp);
      }

      if (!((k >= 1) && (k <= i1))) {
        emlrtDynamicBoundsCheckR2012b(k, 1, i1, &r_emlrtBCI, sp);
      }

      if (!((itmp >= 1) && (itmp <= loop_ub))) {
        emlrtDynamicBoundsCheckR2012b(itmp, 1, loop_ub, &s_emlrtBCI, sp);
      }

      Zr = (X[k - 1] - xCell[(int32_T)cell_ind[itmp - 1] - 1]) * d0 + (Z[k - 1]
        - zCell[(int32_T)cell_ind[itmp - 1] - 1]) * mtmp;
      st.site = &b_emlrtRSI;
      if (!((itmp >= 1) && (itmp <= loop_ub))) {
        emlrtDynamicBoundsCheckR2012b(itmp, 1, loop_ub, &c_emlrtBCI, &st);
      }

      b_st.site = &e_emlrtRSI;
      d0 = 1.0 - eccentricity[(int32_T)cell_ind[itmp - 1] - 1] * eccentricity
        [(int32_T)cell_ind[itmp - 1] - 1];
      st.site = &b_emlrtRSI;
      b_sqrt(&st, &d0);
      if (!((itmp >= 1) && (itmp <= loop_ub))) {
        emlrtDynamicBoundsCheckR2012b(itmp, 1, loop_ub, &t_emlrtBCI, sp);
      }

      sigb = width[(int32_T)cell_ind[itmp - 1] - 1] * d0;
      st.site = &c_emlrtRSI;
      b_st.site = &e_emlrtRSI;
      st.site = &c_emlrtRSI;
      if (!((itmp >= 1) && (itmp <= loop_ub))) {
        emlrtDynamicBoundsCheckR2012b(itmp, 1, loop_ub, &d_emlrtBCI, &st);
      }

      b_st.site = &e_emlrtRSI;
      st.site = &d_emlrtRSI;
      b_st.site = &e_emlrtRSI;
      st.site = &d_emlrtRSI;
      b_st.site = &e_emlrtRSI;
      if (!((itmp >= 1) && (itmp <= loop_ub))) {
        emlrtDynamicBoundsCheckR2012b(itmp, 1, loop_ub, &u_emlrtBCI, sp);
      }

      n = mQinv->size[0];
      if (!((k >= 1) && (k <= n))) {
        emlrtDynamicBoundsCheckR2012b(k, 1, n, &v_emlrtBCI, sp);
      }

      mQinv->data[k - 1] = dmQinv[(int32_T)cell_ind[itmp - 1] - 1] *
        muDoubleScalarExp(-(Xr * Xr / (2.0 * (width[(int32_T)cell_ind[itmp - 1]
        - 1] * width[(int32_T)cell_ind[itmp - 1] - 1])) + Zr * Zr / (2.0 * (sigb
        * sigb))));
      k++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
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

/* End of code generation (GaussianInterpolation.c) */
