#' Calculate Number of Raced Rate Values
#'
#' @param d
#'
#' @return A column with a rate value
#' @export
#'
#' @examples
#' count_values(d)


count_values <- function(x) {
  rates <- dplyr::select(x, ends_with("_rate"), -ends_with("_no_rate"), -total_rate)
  rates$values_count <- rowSums(!is.na(rates))
  x$values_count <- rates$values_count

  return(x)
}

#' @importFrom stats filter sd var
