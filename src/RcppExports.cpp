// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// geoproj_cpp_proj_version
std::string geoproj_cpp_proj_version();
RcppExport SEXP _geoproj_geoproj_cpp_proj_version() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(geoproj_cpp_proj_version());
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_geoproj_geoproj_cpp_proj_version", (DL_FUNC) &_geoproj_geoproj_cpp_proj_version, 0},
    {NULL, NULL, 0}
};

RcppExport void R_init_geoproj(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
