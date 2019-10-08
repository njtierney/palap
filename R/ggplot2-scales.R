#' Scales to use for ggplot2
#'
#' These functions provide the option to use the palettes from `paletteer` along
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
                               palette = "BuPu",
                               package = "RColorBrewer") {

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop('ggplot2 is required for this functionality', call. = FALSE)
  }

  ggplot2::scale_colour_gradientn(colours = palap(256,
                                                  alpha,
                                                  begin,
                                                  end,
                                                  direction,
                                                  {{ palette }},
                                                  {{ package }}), ...)
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
                             palette = "BuPu",
                             package = "RColorBrewer") {

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop('ggplot2 is required for this functionality', call. = FALSE)
  }
  ggplot2::scale_fill_gradientn(colours = palap(256,
                                                alpha,
                                                begin,
                                                end,
                                                direction,
                                                {{ palette }},
                                                {{ package }}),
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
           palette = 'BuPu',
           package = "RColorBrewer",
           aesthetics = "colour") {


    # initial checks (direction and beg/end are already checked with palap)
    is_ggplot_available()
    is_alpha_in_01(alpha)
    is_palette_in_paletteer(palette)

    ggplot2::discrete_scale(aesthetics,
                            "palap_d",
                            palap_discrete(alpha,
                                           begin,
                                           end,
                                           direction,
                                           {{ palette }},
                                           {{ package }}),
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
                               palette = "BuPu",
                               package = "RColorBrewer",
                               aesthetics = "fill") {

  # initial checks (direction and beg/end are already checked with palap)
  is_ggplot_available()
  is_alpha_in_01(alpha)
  is_palette_in_paletteer(palette)

  ggplot2::discrete_scale(aesthetics,
                          "palap_d",
                          palap_discrete(alpha,
                                         begin,
                                         end,
                                         direction,
                                         {{ palette }},
                                         {{ package }}),
                          ...)
}


palap_discrete <- function(alpha,
                           begin,
                           end,
                           direction,
                           palette,
                           package) {
  function(n) {
    palap(n,
          alpha,
          begin,
          end,
          direction,
          {{ palette }},
          {{ package }})
  }
}
