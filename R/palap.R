#' Reflective colour palette
#'
#' This is currently just wrapping `scico::scico` with some tricks
#'
#' @param n The number of colours to generate for the palette
#' @param alpha The opacity of the generated colours. If specified rgba values
#' will be generated. The default (`NULL`) will generate rgb values which
#' corresponds to `alpha = 1`
#' @param begin,end The interval within the palette to sample colours from.
#' Defaults to `0` and `1` respectively
#' @param direction Either `1` or `-1`. If `-1` the palette will be reversed
#' @param palette The name of the palette to sample from from the `package`. See
#'   `paletteer::palettes_d_names` for a list of possible names. Default is
#'   "BuPu" from RColorBrewer
#' @param package The package to take the palette from
#'
#' @return A character vector of length `n` with hexencoded rgb(a) colour values
#' @export
#'
#' @examples
#' library(prismatic)
#' plot(colour(palap(8)))
#' plot(colour(palap(8, direction = -1)))
palap <- function(n,
         alpha = NULL,
         begin = 0,
         end = 1,
         direction = 1,
         palette = "PuBu",
         package = "RColorBrewer") {

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

  map_cols <- paletteer::paletteer_d(package = {{package}},
                                     palette = {{palette}},
                                     n = n)

  fn_cols <- colorRamp(colors = map_cols,
                       space = "Lab",
                       interpolate = "spline")

  lhs <- seq(begin,
             end,
             length.out = n/2)

  rhs <- seq(end,
             begin,
             length.out = n/2)

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

  hex_cols[-middle(hex_cols)]

}
