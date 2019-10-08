
<!-- README.md is generated from README.Rmd. Please edit that file -->

# palap

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of palap is to provide “symmetric” colour palettes. Broadly
speaking, there are three categories of colour palette:

1\. **Qualitative**: categorical variables

2\. **Sequential**: low to high numeric values

3\. **Diverging**: negative to positive values

However, a fourth colour palette is needed, to cover cases where things
diverge, but maintain some constant value/meaning as they get further
from the center point. The proposed name for this is a “symmetric”
colour palette:

4\. **Symmetric**: Diverging values with equivalent meaning as they get
further from the diverging point.

At the moment this package exists as a proof of concept, and a place to
explore this idea. It is currently drawing heavily from
[scico](https://github.com/thomasp85/scico).

## Installation

You can install the released version of `palap` from github with:

``` r
# install.packages("remotes")
remotes::install_github("njtierney/palap")
```

# Example

We can see a normal sequential colourplot such as the Yellow Green Blue
palette here:

``` r
library(palap)
library(prismatic)
library(paletteer)

regular <- paletteer_d(package = "RColorBrewer", palette = "YlGnBu", n = 7)

# use the colour and plot functions from prismatic
plot(colour(regular))
```

<img src="man/figures/README-example-1.png" width="100%" />

Using `palap`, we can create a symmetric version of this colour palette

``` r
# now show this with palap
sym_pal <- palap(7)

plot(colour(sym_pal))
```

<img src="man/figures/README-example-palap-1.png" width="100%" />

We can also change the direction of the colourscale

``` r
plot(colour(palap(7, direction = -1)))
```

<img src="man/figures/README-example-reverse-1.png" width="100%" />

Note that when an even number is given, the colour palette will be
“doubled” - like so:

``` r
plot(colour(palap(8)))
```

<img src="man/figures/README-palap-even-1.png" width="100%" />

``` r
plot(colour(palap(8, direction = -1)))
```

<img src="man/figures/README-palap-even-2.png" width="100%" />

# Using other colour palettes

Thanks to [`paletteer`](https://github.com/EmilHvitfeldt/paletteer) by
[Emil Hvitfeldt](https://github.com/EmilHvitfeldt), you can use a wide
variety of colour palettes from other packages.

By default it uses `RColorBrewer` and the Yellow Green Blue colour
(YlGnBu) colour palette.

You could change this so that you can consider the Blue Purple (BuPu)
palette:

``` r
plot(colour(palap(7, palette = "BuPu")))
```

<img src="man/figures/README-show-blue-purple-1.png" width="100%" />

For symmetric colour scales we recommend that you use colour scales that
are sequential.

# Future work

  - Generalise across other packages, only using sequential colour
    palettes.
  - Generate your own symmetric colour palette from a given vector of
    colours - perhaps similarly to
    [paletti](https://github.com/EdwinTh/paletti).

# example with lm

``` r
lm_fit <- lm(speed ~ dist, cars)
conf_int <- function(x, conf_level){
  predict(x,
          interval = c("confidence"),
          level = conf_level) %>% 
    tibble::as_tibble() %>% 
    setNames(c("fit",
               paste0("lwr_",conf_level*100),
               paste0("upr_",conf_level*100)))
}

library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(tidyr)
library(tibble)

lm_conf <- conf_int(lm_fit, 0.95) %>%
  bind_cols(conf_int(lm_fit, 0.80)) %>%
  bind_cols(cars) %>%
  select(-fit1) %>% 
  pivot_longer(cols = c(lwr_95:upr_80), 
               names_to = "conf_var",
               values_to = "conf_val") %>%
  mutate(conf_var = factor(x = conf_var,
                           levels = c("lwr_95",
                                      "lwr_80",
                                      "upr_80",
                                      "upr_95"),
                           ordered = TRUE))
  
library(ggplot2)
gg_conf <- 
ggplot(lm_conf,
       aes(x = dist,
           y = speed)) + 
  geom_point() + 
  geom_line(aes(y = fit)) + 
  geom_line(aes(y = conf_val,
                colour = conf_var))

# without palap - the bands aren't really ordered in a meaningful way
gg_conf
```

<img src="man/figures/README-loing-example-of-lm-1.png" width="100%" />

``` r


# with palap - scales are ordered in a way that makes sense
gg_conf +
  scale_colour_palap_d(begin = 0.5)
```

<img src="man/figures/README-loing-example-of-lm-2.png" width="100%" />

# Example from `brolgar`

``` r
library(dplyr)
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

<img src="man/figures/README-brolgar-1.png" width="100%" />

``` r

p + scale_colour_palap_d()
```

<img src="man/figures/README-brolgar-2.png" width="100%" />

``` r

p + scale_colour_palap_d(direction = -1)
```

<img src="man/figures/README-brolgar-3.png" width="100%" />

# Acknowledgements

Thank you to [Di Cook](http://dicook.org/) for pointing out the need for
this kind of colour palette, it is one of those things that once you
notice, you cannot unsee, and that’s so cool. Thanks also to [Alison
Hill](https://alison.rbind.io/) for pointing out that I could call this
“symmetric” instead of “reflective” - to me this is much clearer.
