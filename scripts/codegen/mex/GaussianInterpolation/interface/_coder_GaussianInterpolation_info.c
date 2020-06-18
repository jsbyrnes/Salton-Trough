/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_GaussianInterpolation_info.c
 *
 * Code generation for function '_coder_GaussianInterpolation_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "GaussianInterpolation.h"
#include "_coder_GaussianInterpolation_info.h"

/* Function Definitions */
mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xResult;
  mxArray *xEntryPoints;
  const char * fldNames[4] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs" };

  mxArray *xInputs;
  const char * b_fldNames[4] = { "Version", "ResolvedFunctions", "EntryPoints",
    "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 4, fldNames);
  xInputs = emlrtCreateLogicalMatrix(1, 11);
  emlrtSetField(xEntryPoints, 0, "Name", mxCreateString("GaussianInterpolation"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", mxCreateDoubleScalar(11.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", mxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  xResult = emlrtCreateStructMatrix(1, 1, 4, b_fldNames);
  emlrtSetField(xResult, 0, "Version", mxCreateString("9.0.0.341360 (R2016a)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

const mxArray *emlrtMexFcnResolvedFunctionsInfo(void)
{
  const mxArray *nameCaptureInfo;
  const char * data[23] = {
    "789ced5dcb6f1bc7191f35b6eb1c1c17458b3669f35002f46540eb2448d026082059b22d25922d5b4a605749a825393407d9dda177970e5df440b44091630f01"
    "d2638e3de45cf4d0434f3db5b7f65ce43f0850a0496fdde172cde570c519edcc7067998f00217dd23cbed76fbf6f9e8b5676f650f27922f96e7f89d0b9e4e7f9",
    "e4fb0d947ece8ee995e47b6bfc33fdfb1974614cff26f9b66810e3419cfe33707d8cb24f9bfa247083f8f0610fa31047d47b80dba3ff7488870f898f77698ed8"
    "2609e15fcbfdeb11c1fe1576a3472d232f4fa41f26c7004de4385320c7959c1cdf1ad34757dfdb7ccdb98d23ec86adae1347b11b3a875b9bb48d5fda6ae35edc",
    "75a256487a71e45c77fb5144dc60279138ec51cf8d090dd6fc49ff3f17f47f96eb9fd13dfa210e25eb9fe3ea9f1b69b9dff4b09cfcd7b9fa8c3edad9bd3352c1"
    "7e48ef85aeff1c537ae4ec6d1cee6e5c716ebf74f9c5575d27a6d46bd281837dcff148d3f1ddd8739b0eed45ce88ff44093cffe70afa5fc9f5fff8f8ef080dff",
    "f89ffd7f6d94af5facff2aeaff24577fa5a03ecafd2c53be6afbee0bfa7f96eb9fd1ad0448e11a6190095c6f8d4457fac48b77821b7d1f87a4a5c5ef3f12d4bf"
    "c3d5bf53462fec7b69248d732913c7e1c559f315fce8ef2ffce39f800389f24334dfdefb68dade8cd68483d58e178f7e1dc54d011fdfe3f860348787a8e57a6e",
    "78f59e161c2c442f8538c8c450f2ffcfbeb80971c01aff97b0f3ba808f0b1c1f8c2651903e2a639616eac97b44fab8c9d5bf59461fec79d02103dceed1441dce"
    "941c4af90f7af1e849f0fb3af9bdc85fcf737c309a441d928493ee22fcfd4daefe9b65f430e3ef29ff278d77c0df67eb23a4e6efd5e5b5137f5fed90308a3b44",
    "26ff7f86e387d149f38da4d94687861ea5bd067d80c38e473f6cb4bab8f5412ae7e539ed669f7cbb997e7e2fe0e798ab775c463fb93c70acae39f2a8e43fc397"
    "011772e5ff8ce6dbfd7768daee8c366df7d5f9051a5decf5d8448fc8df57c67f9bf07f66143b348d3748d0c6839d20969a4fb8c6b577adac1eb938c26208c48f",
    "eae78b4cdb775dd0bfecf8e0b4786975dd10c605e9c786fa100fe6c78332e381a469df1d98c587b67144a6372ff9c54939d7308e807c49b2fcd7151f24a82b3e"
    "c889eb8a808fd9fa08a9e1e32334dfce8b1e67971d1f985e3f86f140bdfd7c88e6db7751eb6677047c3ccff1c1686e1cebf67adec383117aaef58316db893191",
    "735dd0fe45ae7d4677c6ad34ba6ed04e002133bf74c4b57354465f85cf8502f1c60141617ee9e2572f034e64cadb6a77d1fceb0f38be185db0de8c07bd0dcfa3"
    "ad427b98d87f71c8d53fd4a6afbc38a9a214fccb8138a2275f5ab4bd35c4937cc337e866ba3651648f32f8a8ee795220967a1cf9f8d76700273ae2c8fb68daee",
    "8c368193557cbfef7a11f915968b23b08e07eb7836e0c3d63ceb698e2f4673f1a41fe17d374c9c6b9306518cd4e6a144f1f61d8e9f77b4e9695a0cb571faf02f"
    "7ffb19e042477eb5687b6f0bf8f93ec70fa34fc2834a9c10e9e51657ef967ebd64d3b22a38f8df67bf051c2c737c80fc09f2271bf0f14b346d7746eb9acf4d57",
    "2e1a89c9ddb8911d624372f102ce459cca9fe05c846479111ede43d37666b4eef58d469bfa2e091a380ca9ecb9ceb31c5f8c2651e00692f555fd7f87abbfa3a8"
    "97f13a36934043be04ebd8b2e587c80e3bc3395138276a031e96291e248996747dfbe241a71f38230974c483ab777f04f1c0ce78506c678807100f000f133e34",
    "ede370c3b52c2aa8cd1f8970f03657efed327a29c4c1a5548e9c8e14e68dd6609c502f1c1c0bf8f829c707a3c5fb0077827dcf6de15c3feb827e64f703fe41d0"
    "4e936ba759466fb2f3d1633135ec13ffef97b02f50aabcedf63715574ce759105f960b274334dfde8bda67be2de0e33b1c1f8ce6f0900ddb95f66f88f4b1c7f1",
    "b157461f85fe3f625fd5ef1f120c7e2f535e747ec6f4fd9322ff7c6caaffc7103b2057c7f9a4b61bbb2ca3cc1d9353f18ff8420bfcdbc671c34976163dd725f6"
    "23056e788f04adee0726f75dbccbd57bf7b4fa88920082db4efa541f3fdbf947fc234954cf3f0c3f79e336cc23c994af83dd615de1d4fe03eb0a92e587a81e71",
    "40629f51d2e4cd70cf1d18cdefcded2fcad8575a3ff8bcd906bfd7e1f78bb233e43f90ffd89cff68d95721c0c1e8fe183c8843ecf7b3f90dc005e00270318b0b"
    "d1f9e81738be18cde1a2c5ce03dda0c10109ee7938a6c116293e476ce27cb4325e4ed45b9158ca78817502c9f2b6e245c3b802ce2fa047fe04e71724cb8bd697",
    "5d346d67461bc54323ea374fd01f9c6338b51fc13906c9f2b6e300ce7fc2f94fc0891827a23c4a62ff45883ddacbda5b17b427bb8f6f2868c7dc7e8c91388afb"
    "31e09e32d9f2b6efc798594fa0515b479e24927b9babcf68f57538c6bdd23801d6df24cb576d5fd17cd22ad73fa38bf799b2363782f60109da39f94ce541e6ee",
    "0bc9f699e6e451bf670fe69124cb578d876341ff708e01ce31d88417dbed6f3abe985eaf8038b39cb8a983dd8bf83acff1c568f6de8580c47811f3b2bb5cfddd"
    "327a2998974d2550bef71be69b24cb0f911d7686fb04e03e01c083dabe6f1291a023595ff5f96f6a5d2e9100d6e572f5abf6f745d9199efff0fcaf031eec7efe",
    "c3be0c78fe2fc7f8775bc0d7b739be183db3ef3b98c869ea1cd05b1c1f6f69d3cf04090a7ef4e99f76e1b95f671ce8bbff25c4fe2f2e17daa39ef7bf8ce451bd"
    "07630bd6a7e5cadb6c6fd9f9513f6c9307a4bd90f951ddef9166f7e164fcaff5267629e9375bf73fadd4ef5fd1959f553d1ea8c2ce457c7c93e383d1e3666a39",
    "1e607ac8d4a0e1fd3cceb3b7e039afc3df176567980f82f920c0c3840f111e9ee3f86074f1fb7037a9df73639278f422f64ddce5eadf2da39f79ef439d88a363"
    "de08f6614b961f223b70b12de043629e2869b558ef26f22473f3458918eafb867e0c79925c79511eb0e8f1b0687e93bf2732a9adc5df45fb74af73f5af97d1c3",
    "cc3edd84fbb559fe4fe127affff50df07399f255db17c601300e001cc0fd15707fc5d7d3ef35ad7f2503c50dcfa3ad42bd9b78fe1f72f50fcbe865deb877248e"
    "f23e6918ef4a96b71d074f72fd33fac475e09c5c65cf658afcff80ab7750461fa2f18ffa7817d67f25cb57edffa2f363cf73fd335a7c1e7322dfbaa07dd97398",
    "d5ed2329104f1d1f17bf82f39752e56db5bba9b8613a7f82f8b15cf810d97bd1f3a5fa70e136a313ec504f5c24f2a8e3e2bbff7e0d7051475c9c761d81797f7d"
    "d711525f87e7ffb28e1f26f68575045847001c98cb7bea3b8f04f94ebefeb2fb3fcc23c13c92cdf8b0d5ee305e86f861033e44f1c3b6fb7f2312d4f8fedf6874",
    "1855c12fe0fe5fc9f255dbf758d03fdc770af79dda841751dcbf8da6edcf685d7859f56862fe03126c4df8118d2b56397e180df79b96ce97e07e53c9f2b5cb97"
    "ee87718df3a5847bc8976cf06bd3f6158d877fc8f5cfe899f5842deabb24b81a8634cce45a17b42b9b1f89e2a3b975c529b154df8bf3be0778a8051eb605fd4b",
    "bc170ae77160eabe2e73ef81c21afc7df89060f0f73af8bbe8f9ff14d73fa38bf37dd6e6442e53eb68e6ce2364f97daa9b8c1fc8eb97dbff8f05fdc37c11cc17"
    "d98417dbed6f2a9ed4f79c1bc4151be38ae9f92291bfc23d7773fd1ceeb9932c5fb59f9f769f351ef46abccf3ae15eedbe169817952c5fb57df5ed13621e3f91",
    "abbefb4b53dd64fc40feb2dcfe7f2ce81fc6c5302eb6092fb6dbdf543ca9ffbe53882bf9fa2671f27f2dfe87f4",
    "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 63320U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_GaussianInterpolation_info.c) */
