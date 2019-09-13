#' Scales to use for ggplot2
#'
#' These functions provide the option to use the scico/palap palettes along
#'    with the `ggplot2` package. It goes without saying that it requires
#'    `ggplot2` to work.
#'
#' @param ... Arguments to pass on to `ggplot2::scale_colour_gradientn()`,
#'   `ggplot2::scale_fill_gradientn()`, `ggplot2::ggplot2::discrete_scale()`
#' @param aesthetics Character string or vector of character strings listing the
#'   name(s) of the aesthetic(s) that this scale works with. This can be useful,
#'   for example, to apply colour settings to the colour and fill aesthetics at
#'   the same time, via aesthetics = c("colour", "fill").
#' @inheritParams palap
#'
#' @return A `ScaleContinuous` or `ScaleDiscrete` object that can be added to a
#'   `ggplot` object
#'
#' @name ggplot2-scales
#' @rdname ggplot2-scales
#' @export
#'
#' @examples
#'
#' if (require('ggplot2')) {
#'   volcano <- data.frame(
#'     x = rep(seq_len(ncol(volcano)), each = nrow(volcano)),
#'     y = rep(seq_len(nrow(volcano)), ncol(volcano)),
#'     height = as.vector(volcano)
#'   )
#'
#'   ggplot(volcano, aes(x = x, y = y, fill = height)) +
#'     geom_raster() +
#'     scale_fill_palap(palette = 'tokyo')
#'
#'   ggplot(iris, aes(x=Petal.Width, y=Petal.Length)) +
#'     geom_point(aes(color=Species), size=10) +
#'     scale_colour_palap_d()
#' }
#'
#'
#'


# Continuous scales -------------------------------------------------------

scale_colour_palap <- function(...,
                               alpha = NULL,
                               begin = 0,
                               end = 1,
                               direction = 1,
                               palette = "bilbao") {

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop('ggplot2 is required for this functionality', call. = FALSE)
  }

  ggplot2::scale_colour_gradientn(colours = palap(256,
                                                  alpha,
                                                  begin,
                                                  end,
                                                  direction,
                                                  palette), ...)
}
#' @rdname ggplot2-scales
#' @export
#'
scale_color_palap <- scale_colour_palap
#' @rdname ggplot2-scales
#' @export
#'
scale_fill_palap <- function(...,
                             alpha = NULL,
                             begin = 0,
                             end = 1,
                             direction = 1,
                             palette = "bilbao") {

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop('ggplot2 is required for this functionality', call. = FALSE)
  }
  ggplot2::scale_fill_gradientn(colours = palap(256,
                                                alpha,
                                                begin,
                                                end,
                                                direction,
                                                palette),
                                ...)
}



# Discrete scales ---------------------------------------------------------

#' @rdname ggplot2-scales
#' @export
#'
scale_colour_palap_d <-
  function(...,
           alpha = 1,
           begin = 0,
           end = 1,
           direction = 1,
           palette = 'batlow',
           aesthetics = "colour") {


    # initial checks (direction and beg/end are already checked with scico::scico)
    if (!requireNamespace("ggplot2", quietly = TRUE)) {
      stop('ggplot2 is required for this functionality', call. = FALSE)
    }

    if (alpha < 0 | alpha > 1) stop('alpha must be in [0,1]')

    if (!palette %in% scico::scico_palette_names()) {
      stop('Need to pick a scico palette')
    }

    ggplot2::discrete_scale(aesthetics,
                            "palap_d",
                            palap_discrete(alpha, begin, end, direction, palette),
                            ...)
  }

#' @rdname ggplot2-scales
#' @export
#'
scale_color_palap_d <- scale_colour_palap_d


#' @rdname ggplot2-scales
#' @export
#'
scale_fill_palap_d <- function(...,
                               alpha = 1,
                               begin = 0,
                               end = 1,
                               direction = 1,
                               palette = 'batlow',
                               aesthetics = "fill") {

  # initial checks (direction and beg/end are already checked with scico::scico)
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop('ggplot2 is required for this functionality', call. = FALSE)
  }

  if (alpha < 0 | alpha > 1) stop('alpha must be in [0,1]')

  if (!palette %in% scico::scico_palette_names()){
    stop('Need to pick a scico palette')
  }

  ggplot2::discrete_scale(aesthetics,
                          "palap_d",
                          palap_discrete(alpha, begin, end, direction, palette),
                          ...)
}


palap_discrete <- function(alpha, begin, end, direction, palette) {
  function(n) {
    palap(n, alpha, begin, end, direction, palette)
  }
}
