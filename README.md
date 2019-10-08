
<!-- README.md is generated from README.Rmd. Please edit that file -->

# palap

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of palap is to provide “reflective” colour palettes. Broadly
speaking, there are three categories of colour palette:

1.  **Qualitative**: categorical variables
2.  **Sequential**: low to high numeric values
3.  **Diverging**: negative to positive values

However,a fourth colour palette is needed, to cover cases where things
diverge, but maintain some constant value/meaning as they get further
from the center point. The proposed name for this is a “reflective”
colour palette.

At the moment this package exists as a proof of concept, and a place to
explore this idea. It is currently drawing heavily from
[scico](https://github.com/thomasp85/scico).

## Installation

You can install the released version of palap from github with:

``` r
# install.packages("remotes")
remotes::install_github("njtierney/palap")
```

# Example

``` r
library(palap)
library(prismatic)
library(paletteer)

regular <- paletteer_d(package = "RColorBrewer", palette = "PuBu", n = 8)

# use the colour and plot functions from prismatic
plot(colour(regular))
```

<img src="man/figures/README-example-1.png" width="100%" />

``` r
# now show this with palap
sym_pal <- palap(8)

plot(colour(sym_pal))
```

<img src="man/figures/README-example-palap-1.png" width="100%" />

``` r
plot(colour(palap(8, direction = -1)))
```

<img src="man/figures/README-example-reverse-1.png" width="100%" />

In the future there may be a magic function that allows for creation of
“reflective” colour palettes - perhaps similary to
[paletti](https://github.com/EdwinTh/paletti).

# Example from `brolgar`

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(brolgar)
heights_near <- key_slope(heights,
          height_cm ~ year) %>%
  keys_near(key = country,
            var = .slope_year) %>%
  left_join(heights, by = "country")
#> Warning: Outer names are only allowed for unnamed scalar atomic inputs

library(ggplot2)
p <- ggplot(heights_near,
       aes(x = year,
           y = height_cm,
           group = country,
           colour = stat)) +
  geom_line()

p
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

``` r

# lhs
p + scale_colour_palap_d(begin = 0,
                         end = 0.5)
```

<img src="man/figures/README-unnamed-chunk-2-2.png" width="100%" />

``` r

# rhs?
p + scale_colour_palap_d(begin = 0.5,
                         end = 1)
```

<img src="man/figures/README-unnamed-chunk-2-3.png" width="100%" />

``` r

p + scale_colour_palap_d(direction = -1)
```

<img src="man/figures/README-unnamed-chunk-2-4.png" width="100%" />
