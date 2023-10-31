#' @importFrom stats filter sd var

#calculate number of raced "_rate" values#
count_values <- function(x) {
  rates <- dplyr::select(x, ends_with("_rate"), -ends_with("_no_rate"), -total_rate)
  rates$values_count <- rowSums(!is.na(rates))
  x$values_count <- rates$values_count

  return(x)
}
