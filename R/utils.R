#' Subset list of arguments to those supported by a given function
#'
#' @noRd
.subset_args <- function(fun, args) {
  idx_valid_args <- which(names(args) %in% names(formals(fun)))
  args[idx_valid_args]
}
