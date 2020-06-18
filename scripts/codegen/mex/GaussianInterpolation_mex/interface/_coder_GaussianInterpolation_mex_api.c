/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_GaussianInterpolation_mex_api.c
 *
 * Code generation for function '_coder_GaussianInterpolation_mex_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation_mex.h"
#include "_coder_GaussianInterpolation_mex_api.h"
#include "GaussianInterpolation_mex_data.h"

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[100];
static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *X, const
  char_T *identifier))[1000];
static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[1000];
static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[100];
static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *xCell,
  const char_T *identifier))[100];
static const mxArray *emlrt_marshallOut(const real_T u_data[], const int32_T
  u_size[1]);
static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[1000];

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[100]
{
  real_T (*y)[100];
  y = e_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
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
  y = f_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[100]
{
  real_T (*ret)[100];
  static const int32_T dims[1] = { 100 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims);
  ret = (real_T (*)[100])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
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
  static const mxArray *emlrt_marshallOut(const real_T u_data[], const int32_T
  u_size[1])
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv10[1] = { 0 };

  y = NULL;
  m0 = emlrtCreateNumericArray(1, iv10, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m0, (void *)u_data);
  emlrtSetDimensions((mxArray *)m0, u_size, 1);
  emlrtAssign(&y, m0);
  return y;
}

static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[1000]
{
  real_T (*ret)[1000];
  static const int32_T dims[1] = { 1000 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims);
  ret = (real_T (*)[1000])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  void GaussianInterpolation_mex_api(const mxArray * const prhs[9], const
  mxArray *plhs[1])
{
  real_T (*mQinv_data)[1000];
  real_T (*xCell)[100];
  real_T (*zCell)[100];
  real_T (*angle)[100];
  real_T (*width)[100];
  real_T (*eccentricity)[100];
  real_T (*dmQinv)[100];
  real_T (*cell_ind)[100];
  real_T (*X)[1000];
  real_T (*Z)[1000];
  int32_T mQinv_size[1];
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  mQinv_data = (real_T (*)[1000])mxMalloc(sizeof(real_T [1000]));

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

  /* Invoke the target function */
  GaussianInterpolation_mex(&st, *xCell, *zCell, *angle, *width, *eccentricity, *
    dmQinv, *cell_ind, *X, *Z, *mQinv_data, mQinv_size);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(*mQinv_data, mQinv_size);
}

/* End of code generation (_coder_GaussianInterpolation_mex_api.c) */
