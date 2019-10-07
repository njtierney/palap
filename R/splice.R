#- Palette helper functions

middle <- function(x){
  floor(stats::median(seq_along(x)))
}


left <- function(x){
  1:middle(x)
}


right <- function(x){
  middle(x):length(x)
}


reflect_left <- function(x){
  middle <- middle(x)
  lhs <- left(x)[-middle]
  rhs <- rev(lhs)
  x[c(lhs, middle, rhs)]
}

reflect_right <- function(x){
  middle <- middle(x)
  rhs <- right(x)[-1]
  lhs <- rev(rhs)
  x[c(lhs, middle, rhs)]
}

# palap(n = 5, palette = "Greens") %>% colour() %>% plot()

#
# vec <- 1:5
# middle(vec)
# left(vec)
# right(vec)
# reflect_left(vec)
# reflect_right(vec)
#
# library(prismatic)
#
# greens <- c("#f7fcfd",
#             "#e5f5f9",
#             "#ccece6",
#             "#99d8c9",
#             "#66c2a4",
#             "#41ae76",
#             "#238b45",
#             "#006d2c",
#             "#00441b")
#
# plot(colour(greens))
# plot(colour(reflect_left(greens)))
# plot(colour(reflect_right(greens)))
#
# brewer_names <-
# list("Blues" = "blues",
#      "BuGn" = "bg",
#      "BuPu" = "bp",
#      "GnBu" = "gb",
#      "Greens" = "greens",
#      "Greys" = "greys",
#      "Oranges" = "oranges",
#      "OrRd" = "or",
#      "PuBu" = "pb",
#      "PuBuGn" = "pbg",
#      "PuRd" = "pr",
#      "Purples" = "purples",
#      "RdPu" = "rp",
#      "Reds" = "reds",
#      "YlGn" = "yg",
#      "YlGnBu" = "ygb",
#      "YlOrBr" = "yob",
#      "YlOrRd" = "yor")
#
# rcb_blues <- paletteer::paletteer_d(package = "RColorBrewer",
#                                     palette = "Blues",
#                                     n = 9)
#
# rcb_blues_rgb <- col_to_rgb(rcb_blues)
#
# # reflect(x, begin, end, direction)
# reflect <- function(x,
#                     begin,
#                     end,
#                     direction){
#
# }
#
#
