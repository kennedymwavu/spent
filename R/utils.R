#' Format Currency
#'
#' @param x Numeric vector. Can be any type of vector which is coercible to 
#' numeric.
#' @param currency Currency string to use as prefix.
#' @param digits Number of digits to round the result to.
#' @param sep The string to use as a separator between the currency and number.
#'
#' @return Character vector of same length as `x`
#' @export
#'
#' @examples
#' format_currency(x = c(15774.025, 2123))
#' 
#' format_currency(x = c(10000, 5000.25, 7755.378), currency = '$', sep = '')
format_currency  <- function(x, currency = 'Kshs', digits = 2, sep = ' ') {
  paste(
    currency, 
    formatC(as.numeric(x), format = 'f', digits = digits, big.mark = ','), 
    sep = sep
  )
}
