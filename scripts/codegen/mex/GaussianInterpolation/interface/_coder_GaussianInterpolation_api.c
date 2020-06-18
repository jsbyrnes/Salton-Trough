/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_GaussianInterpolation_api.c
 *
 * Code generation for function '_coder_GaussianInterpolation_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation.h"
#include "_coder_GaussianInterpolation_api.h"
#include "GaussianInterpolation_emxutil.h"
#include "GaussianInterpolation_data.h"

/* Variable Definitions */
static emlrtRTEInfo b_emlrtRTEI = { 1, 1, "_coder_GaussianInterpolation_api", ""
};

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[100];
static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *X, const
  char_T *identifier))[1000];
static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[1000];
static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nCells,
  const char_T *identifier);
static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *xCell,
  const char_T *identifier))[100];
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static real_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[100];
static real_T (*h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[1000];
static real_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[100]
{
  real_T (*y)[100];
  y = g_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *X,
  const char_T *identifier))[1000]
{
  real_T (*y)[1000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(X), &thisId);
  emlrtDestroyArray(&X);
  return y;
}

static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[1000]
{
  real_T (*y)[1000];
  y = h_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nCells,
  const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(nCells), &thisId);
  emlrtDestroyArray(&nCells);
  return y;
}

static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *xCell,
  const char_T *identifier))[100]
{
  real_T (*y)[100];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(xCell), &thisId);
  emlrtDestroyArray(&xCell);
  return y;
}
  static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv0[1] = { 0 };

  y = NULL;
  m0 = emlrtCreateNumericArray(1, iv0, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m0, (void *)u->data);
  emlrtSetDimensions((mxArray *)m0, u->size, 1);
  emlrtAssign(&y, m0);
  return y;
}

static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = i_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[100]
{
  real_T (*ret)[100];
  static const int32_T dims[1] = { 100 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims);
  ret = (real_T (*)[100])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static real_T (*h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[1000]
{
  real_T (*ret)[1000];
  static const int32_T dims[1] = { 1000 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims);
  ret = (real_T (*)[1000])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

void GaussianInterpolation_api(const mxArray * const prhs[11], const mxArray
  *plhs[1])
{
  emxArray_real_T *mQinv;
  real_T (*xCell)[100];
  real_T (*zCell)[100];
  real_T (*angle)[100];
  real_T (*width)[100];
  real_T (*eccentricity)[100];
  real_T (*dmQinv)[100];
  real_T (*cell_ind)[100];
  real_T (*X)[1000];
  real_T (*Z)[1000];
  real_T nCells;
  real_T npoints;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_real_T(&st, &mQinv, 1, &b_emlrtRTEI, true);

  /* Marshall function inputs */
  xCell = emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "xCell");
  zCell = emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "zCell");
  angle = emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "angle");
  width = emlrt_marshallIn(&st, emlrtAlias(prhs[3]), "width");
  eccentricity = emlrt_marshallIn(&st, emlrtAlias(prhs[4]), "eccentricity");
  dmQinv = emlrt_marshallIn(&st, emlrtAlias(prhs[5]), "dmQinv");
  cell_ind = emlrt_marshallIn(&st, emlrtAlias(prhs[6]), "cell_ind");
  X = c_emlrt_marshallIn(&st, emlrtAlias(prhs[7]), "X");
  Z = c_emlrt_marshallIn(&st, emlrtAlias(prhs[8]), "Z");
  nCells = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[9]), "nCells");
  npoints = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[10]), "npoints");

  /* Invoke the target function */
  GaussianInterpolation(&st, *xCell, *zCell, *angle, *width, *eccentricity,
                        *dmQinv, *cell_ind, *X, *Z, nCells, npoints, mQinv);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(mQinv);
  mQinv->canFreeData = false;
  emxFree_real_T(&mQinv);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_GaussianInterpolation_api.c) */
