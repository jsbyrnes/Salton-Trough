/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * NearestInterpolation.c
 *
 * Code generation for function 'NearestInterpolation'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "NearestInterpolation.h"
#include "NearestInterpolation_emxutil.h"
#include "power.h"
#include "NearestInterpolation_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 22, "NearestInterpolation",
  "/panfs/roc/groups/13/bezadam/jsbyrnes/TD3D/scripts/NearestInterpolation.m" };

static emlrtRSInfo e_emlrtRSI = { 18, "min",
  "/panfs/roc/msisoft/matlab/R2015a/toolbox/eml/lib/matlab/datafun/min.m" };

static emlrtRSInfo f_emlrtRSI = { 15, "eml_min_or_max",
  "/panfs/roc/msisoft/matlab/R2015a/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRTEInfo emlrtRTEI = { 1, 21, "NearestInterpolation",
  "/panfs/roc/groups/13/bezadam/jsbyrnes/TD3D/scripts/NearestInterpolation.m" };

static emlrtBCInfo emlrtBCI = { 1, 50000, 13, 11, "X", "NearestInterpolation",
  "/panfs/roc/groups/13/bezadam/jsbyrnes/TD3D/scripts/NearestInterpolation.m", 0
};

static emlrtECInfo emlrtECI = { -1, 22, 24, "NearestInterpolation",
  "/panfs/roc/groups/13/bezadam/jsbyrnes/TD3D/scripts/NearestInterpolation.m" };

static emlrtRTEInfo d_emlrtRTEI = { 38, 19, "eml_min_or_max",
  "/panfs/roc/msisoft/matlab/R2015a/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRTEInfo e_emlrtRTEI = { 81, 19, "eml_min_or_max",
  "/panfs/roc/msisoft/matlab/R2015a/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtDCInfo emlrtDCI = { 4, 18, "NearestInterpolation",
  "/panfs/roc/groups/13/bezadam/jsbyrnes/TD3D/scripts/NearestInterpolation.m", 1
};

static emlrtDCInfo b_emlrtDCI = { 4, 18, "NearestInterpolation",
  "/panfs/roc/groups/13/bezadam/jsbyrnes/TD3D/scripts/NearestInterpolation.m", 4
};

static emlrtBCInfo b_emlrtBCI = { -1, -1, 22, 25, "X", "NearestInterpolation",
  "/panfs/roc/groups/13/bezadam/jsbyrnes/TD3D/scripts/NearestInterpolation.m", 0
};

static emlrtBCInfo c_emlrtBCI = { -1, -1, 22, 45, "Z", "NearestInterpolation",
  "/panfs/roc/groups/13/bezadam/jsbyrnes/TD3D/scripts/NearestInterpolation.m", 0
};

static emlrtBCInfo d_emlrtBCI = { -1, -1, 24, 10, "zeta", "NearestInterpolation",
  "/panfs/roc/groups/13/bezadam/jsbyrnes/TD3D/scripts/NearestInterpolation.m", 0
};

static emlrtBCInfo e_emlrtBCI = { -1, -1, 24, 20, "zetaCell",
  "NearestInterpolation",
  "/panfs/roc/groups/13/bezadam/jsbyrnes/TD3D/scripts/NearestInterpolation.m", 0
};

/* Function Definitions */
void NearestInterpolation(const emlrtStack *sp, const real_T xCell[100], const
  real_T zCell[100], const real_T zetaCell[100], const boolean_T cell_ind[100],
  const real_T X[50000], const real_T Z[50000], real_T nCells, real_T npoints,
  emxArray_real_T *zeta)
{
  int32_T i0;
  real_T mtmp;
  int32_T ixstart;
  int32_T i1;
  int32_T k;
  int8_T tmp_data[100];
  int32_T ix;
  int32_T n;
  real_T X_data[100];
  int32_T X_size[1];
  int32_T varargin_1_size[1];
  real_T varargin_1_data[100];
  int32_T Z_size[1];
  int32_T tmp_size[1];
  real_T b_tmp_data[100];
  boolean_T b0;
  int32_T itmp;
  boolean_T exitg1;
  int32_T b_k;
  int32_T b_itmp;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;

  /* replaces scattered interp, this can handle zero cells */
  i0 = zeta->size[0];
  if (npoints >= 0.0) {
    mtmp = npoints;
  } else {
    mtmp = emlrtNonNegativeCheckR2012b(npoints, &b_emlrtDCI, sp);
  }

  if (mtmp == (int32_T)muDoubleScalarFloor(mtmp)) {
    zeta->size[0] = (int32_T)mtmp;
  } else {
    zeta->size[0] = (int32_T)emlrtIntegerCheckR2012b(mtmp, &emlrtDCI, sp);
  }

  emxEnsureCapacity(sp, (emxArray__common *)zeta, i0, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  if (npoints >= 0.0) {
    mtmp = npoints;
  } else {
    mtmp = emlrtNonNegativeCheckR2012b(npoints, &b_emlrtDCI, sp);
  }

  if (mtmp == (int32_T)muDoubleScalarFloor(mtmp)) {
    ixstart = (int32_T)mtmp;
  } else {
    ixstart = (int32_T)emlrtIntegerCheckR2012b(mtmp, &emlrtDCI, sp);
  }

  for (i0 = 0; i0 < ixstart; i0++) {
    zeta->data[i0] = 0.0;
  }

  if (nCells == 0.0) {
  } else {
    /* cell_ind = cell_ind(1:nCells); */
    if (1.0 > npoints) {
      i0 = 0;
    } else {
      i0 = (int32_T)npoints;
      if ((i0 >= 1) && (i0 < 50000)) {
      } else {
        i0 = emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &emlrtBCI, sp);
      }
    }

    if (1.0 > npoints) {
      i1 = 0;
    } else {
      i1 = (int32_T)npoints;
    }

    k = 1;
    while (k - 1 <= (int32_T)npoints - 1) {
      ix = 0;
      for (ixstart = 0; ixstart < 100; ixstart++) {
        if (cell_ind[ixstart]) {
          ix++;
        }
      }

      n = 0;
      for (ixstart = 0; ixstart < 100; ixstart++) {
        if (cell_ind[ixstart]) {
          tmp_data[n] = (int8_T)(ixstart + 1);
          n++;
        }
      }

      emlrtDynamicBoundsCheckR2012b(k, 1, i0, &b_emlrtBCI, sp);
      X_size[0] = ix;
      for (n = 0; n < ix; n++) {
        X_data[n] = X[k - 1] - xCell[tmp_data[n] - 1];
      }

      st.site = &emlrtRSI;
      power(&st, X_data, X_size, varargin_1_data, varargin_1_size);
      ix = 0;
      for (ixstart = 0; ixstart < 100; ixstart++) {
        if (cell_ind[ixstart]) {
          ix++;
        }
      }

      n = 0;
      for (ixstart = 0; ixstart < 100; ixstart++) {
        if (cell_ind[ixstart]) {
          tmp_data[n] = (int8_T)(ixstart + 1);
          n++;
        }
      }

      emlrtDynamicBoundsCheckR2012b(k, 1, i1, &c_emlrtBCI, sp);
      Z_size[0] = ix;
      for (n = 0; n < ix; n++) {
        X_data[n] = Z[k - 1] - zCell[tmp_data[n] - 1];
      }

      st.site = &emlrtRSI;
      power(&st, X_data, Z_size, b_tmp_data, tmp_size);
      if (varargin_1_size[0] != tmp_size[0]) {
        emlrtSizeEqCheck1DR2012b(varargin_1_size[0], tmp_size[0], &emlrtECI, sp);
      }

      st.site = &emlrtRSI;
      ixstart = varargin_1_size[0];
      for (n = 0; n < ixstart; n++) {
        varargin_1_data[n] += b_tmp_data[n];
      }

      b_st.site = &e_emlrtRSI;
      c_st.site = &f_emlrtRSI;
      if ((varargin_1_size[0] == 1) || (varargin_1_size[0] != 1)) {
        b0 = true;
      } else {
        b0 = false;
      }

      if (b0) {
      } else {
        emlrtErrorWithMessageIdR2012b(&c_st, &d_emlrtRTEI,
          "Coder:toolbox:autoDimIncompatibility", 0);
      }

      if (varargin_1_size[0] > 0) {
      } else {
        emlrtErrorWithMessageIdR2012b(&c_st, &e_emlrtRTEI,
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

      ix = 0;
      for (ixstart = 0; ixstart < 100; ixstart++) {
        if (cell_ind[ixstart]) {
          ix++;
        }
      }

      n = 0;
      for (ixstart = 0; ixstart < 100; ixstart++) {
        if (cell_ind[ixstart]) {
          tmp_data[n] = (int8_T)(ixstart + 1);
          n++;
        }
      }

      n = zeta->size[0];
      if ((k >= 1) && (k < n)) {
        b_k = k;
      } else {
        b_k = emlrtDynamicBoundsCheckR2012b(k, 1, n, &d_emlrtBCI, sp);
      }

      if ((itmp >= 1) && (itmp < ix)) {
        b_itmp = itmp;
      } else {
        b_itmp = emlrtDynamicBoundsCheckR2012b(itmp, 1, ix, &e_emlrtBCI, sp);
      }

      zeta->data[b_k - 1] = zetaCell[tmp_data[b_itmp - 1] - 1];
      k++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }
  }
}

/* End of code generation (NearestInterpolation.c) */
