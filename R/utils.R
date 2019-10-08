is_ggplot_available <- function(){
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop('ggplot2 is required for this functionality', call. = FALSE)
  }
}

is_alpha_in_01 <- function(alpha){
  if (alpha < 0 | alpha > 1) stop('alpha must be in [0,1]')
}

is_palette_in_paletteer <- function(palette){
  if (!palette %in% paletteer::palettes_d_names$palette) {
    stop('Need to pick a palette available in `paletteer::palettes_d_names`')
  }
}

is_odd <- function(x) !identical(x %% 2, 0)

is_even <- function(x) !is_odd(x)

if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))
globalVariables(
  c(
    "colorRamp",
    "rgb"
  )
)
