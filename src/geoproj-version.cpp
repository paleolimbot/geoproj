#include <Rcpp.h>
#include "proj.h"
using namespace Rcpp;

#define STR_HELPER(x) #x
#define STR(x) STR_HELPER(x)
#define GEOPROJ_PROJ_VERSION STR(PROJ_VERSION_MAJOR) "." STR(PROJ_VERSION_MINOR) "." STR(PROJ_VERSION_PATCH)

// [[Rcpp::export]]
std::string geoproj_cpp_proj_version() {
  return GEOPROJ_PROJ_VERSION;
}
