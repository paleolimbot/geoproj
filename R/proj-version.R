
#' PROJ Version
#'
#' @return A [package_version()] with the internal version of PROJ
#' @export
#'
#' @examples
#' proj_version()
#'
proj_version <- function() {
  package_version(geoproj_cpp_proj_version())
}
