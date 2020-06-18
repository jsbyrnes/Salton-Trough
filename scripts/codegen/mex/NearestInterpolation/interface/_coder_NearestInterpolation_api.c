/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_NearestInterpolation_api.c
 *
 * Code generation for function '_coder_NearestInterpolation_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "NearestInterpolation.h"
#include "_coder_NearestInterpolation_api.h"
#include "NearestInterpolation_emxutil.h"
#include "NearestInterpolation_data.h"

/* Variable Definitions */
static emlrtRTEInfo c_emlrtRTEI = { 1, 1, "_coder_NearestInterpolation_api", ""
};

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[100];
static boolean_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *cell_ind, const char_T *identifier))[100];
static boolean_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[100];
static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *X, const
  char_T *identifier))[50000];
static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *xCell,
  const char_T *identifier))[100];
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[50000];
static real_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nCells,
  const char_T *identifier);
static real_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static real_T (*i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[100];
static boolean_T (*j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[100];
static real_T (*k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[50000];
static real_T l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[100]
{
  real_T (*y)[100];
  y = i_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static boolean_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *cell_ind, const char_T *identifier))[100]
{
  boolean_T (*y)[100];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  y = d_emlrt_marshallIn(sp, emlrtAlias(cell_ind), &thisId);
  emlrtDestroyArray(&cell_ind);
  return y;
}

static boolean_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[100]
{
  boolean_T (*y)[100];
  y = j_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *X,
  const char_T *identifier))[50000]
{
  real_T (*y)[50000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  y = f_emlrt_marshallIn(sp, emlrtAlias(X), &thisId);
  emlrtDestroyArray(&X);
  return y;
}

static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *xCell,
  const char_T *identifier))[100]
{
  real_T (*y)[100];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  y = b_emlrt_marshallIn(sp, emlrtAlias(xCell), &thisId);
  emlrtDestroyArray(&xCell);
  return y;
}
  static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  static const int32_T iv0[1] = { 0 };

  const mxArray *m0;
  y = NULL;
  m0 = emlrtCreateNumericArray(1, iv0, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m0, (void *)u->data);
  emlrtSetDimensions((mxArray *)m0, u->size, 1);
  emlrtAssign(&y, m0);
  return y;
}

static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[50000]
{
  real_T (*y)[50000];
  y = k_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nCells,
  const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  y = h_emlrt_marshallIn(sp, emlrtAlias(nCells), &thisId);
  emlrtDestroyArray(&nCells);
  return y;
}

static real_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = l_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[100]
{
  real_T (*ret)[100];
  int32_T iv1[1];
  iv1[0] = 100;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, iv1);
  ret = (real_T (*)[100])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static boolean_T (*j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[100]
{
  boolean_T (*ret)[100];
  int32_T iv2[1];
  iv2[0] = 100;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "logical", false, 1U, iv2);
  ret = (boolean_T (*)[100])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[50000]
{
  real_T (*ret)[50000];
  int32_T iv3[1];
  iv3[0] = 50000;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, iv3);
  ret = (real_T (*)[50000])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static real_T l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId)
{
  real_T ret;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, 0);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

void NearestInterpolation_api(const mxArray * const prhs[8], const mxArray *
  plhs[1])
{
  emxArray_real_T *zeta;
  real_T (*xCell)[100];
  real_T (*zCell)[100];
  real_T (*zetaCell)[100];
  boolean_T (*cell_ind)[100];
  real_T (*X)[50000];
  real_T (*Z)[50000];
  real_T nCells;
  real_T npoints;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_real_T(&st, &zeta, 1, &c_emlrtRTEI, true);

  /* Marshall function inputs */
  xCell = emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "xCell");
  zCell = emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "zCell");
  zetaCell = emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "zetaCell");
  cell_ind = c_emlrt_marshallIn(&st, emlrtAlias(prhs[3]), "cell_ind");
  X = e_emlrt_marshallIn(&st, emlrtAlias(prhs[4]), "X");
  Z = e_emlrt_marshallIn(&st, emlrtAlias(prhs[5]), "Z");
  nCells = g_emlrt_marshallIn(&st, emlrtAliasP(prhs[6]), "nCells");
  npoints = g_emlrt_marshallIn(&st, emlrtAliasP(prhs[7]), "npoints");

  /* Invoke the target function */
  NearestInterpolation(&st, *xCell, *zCell, *zetaCell, *cell_ind, *X, *Z, nCells,
                       npoints, zeta);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(zeta);
  zeta->canFreeData = false;
  emxFree_real_T(&zeta);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_NearestInterpolation_api.c) */
