#' Symmetric colour palettes (hex)
#'
#' A fourth type of colour palette is needed to cover cases where things
#'   diverge, but maintain some constant value/meaning as they get further from
#'   the center point. The proposed name for this is a "symmetric" colour
#'   palette. This is currently just wrapping `scico::scico` with some tricks
#'
#' @param hex The hex colour to generate
#' @param alpha The opacity of the generated colours. If specified rgba values
#'   will be generated. The default (`NULL`) will generate rgb values which
#'   corresponds to `alpha = 1`
#' @param begin,end The interval within the palette to sample colours from.
#'   Defaults to `0` and `1` respectively
#' @param direction Either `1` or `-1`. If `-1` the palette will be reversed
#'
#' @return A character vector the same length as `hex` with hexencoded rgb(a) colour values
#' @export
#'
#' @examples
#' # example
#'
palap_hex <- function(hex,
                  alpha = NULL,
                  begin = 0,
                  end = 1,
                  direction = 1) {

  if (begin < 0 | begin > 1 | end < 0 | end > 1) {
    stop("begin and end must be in [0,1]")
  }

  if (abs(direction) != 1) {
    stop("direction must be 1 or -1")
  }

  if (direction == -1) {
    tmp <- begin
    begin <- end
    end <- tmp
  }

  hex_size <- length(hex)

  fn_cols <- colorRamp(colors = hex,
                       space = "Lab",
                       interpolate = "spline")

  lhs <- seq(begin,
             end,
             length.out = hex_size/2)

  rhs <- seq(end,
             begin,
             length.out = hex_size/2)

  cols_lhs <- fn_cols(lhs)
  cols_rhs <- fn_cols(rhs)

  cols <- rbind(cols_lhs, cols_rhs)

  if (is.null(alpha)) {
    hex_cols <-
      rgb(red = cols[, 1],
          green = cols[, 2],
          blue = cols[, 3],
          maxColorValue = 255)

  } else {

    hex_cols <-
      rgb(red = cols[, 1],
          green = cols[, 2],
          blue = cols[, 3],
          alpha = alpha * 255,
          maxColorValue = 255)
  }

  if (is_odd(hex_size)) {
    return(hex_cols[-middle(hex_cols)])
  }

  if (is_even(hex_size)) {
    return(hex_cols)
  }

}
