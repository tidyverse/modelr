
# modelr <img src="man/figures/logo.png" align="right" />

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
[![Travis build
status](https://travis-ci.org/hadley/modelr.svg?branch=master)](https://travis-ci.org/hadley/modelr)
[![Codecov test
coverage](https://codecov.io/gh/hadley/modelr/branch/master/graph/badge.svg)](https://codecov.io/gh/hadley/modelr?branch=master)
<!-- badges: end -->

## Overview

The modelr package provides functions that help you create elegant
pipelines when modelling. It is designed primarily to support teaching
the basics of modelling within the tidyverse, particularly in [R for
Data Science](http://r4ds.had.co.nz/model-basics.html).

## Installation

``` r
# The easiest way to get modelr is to install the whole tidyverse:
install.packages("tidyverse")

# Alternatively, install just modelr:
install.packages("modelr")

# Or the development version from GitHub:
# install.packages("devtools")
devtools::install_github("tidyverse/modelr")
```

## Status

modelr is stable: it has achieved its goal of making it easier to teach
modelling within the tidyverse. For more general modelling tasks, check
out the family of “tidymodel” packages like
[recipes](https://topepo.github.io/recipes/),
[rsample](https://topepo.github.io/rsample/),
[parsnip](https://topepo.github.io/parsnip/), and
[tidyposterior](https://topepo.github.io/tidyposterior/).

## Getting started

``` r
library(modelr)
```

### Partitioning and sampling

The `resample` class stores a “reference” to the original dataset and a
vector of row indices. A resample can be turned into a dataframe by
calling `as.data.frame()`. The indices can be extracted using
`as.integer()`:

``` r
# a subsample of the first ten rows in the data frame
rs <- resample(mtcars, 1:10)
as.data.frame(rs)
#>                    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4         21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag     21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710        22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive    21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
#> Valiant           18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
#> Duster 360        14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
#> Merc 240D         24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
#> Merc 230          22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
#> Merc 280          19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
as.integer(rs)
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

The class can be utilized in generating an exclusive partitioning of a
data frame:

``` r
# generate a 30% testing partition and a 70% training partition
ex <- resample_partition(mtcars, c(test = 0.3, train = 0.7))
lapply(ex, dim)
#> $test
#> [1]  9 11
#> 
#> $train
#> [1] 23 11
```

modelr offers several resampling methods that result in a list of
`resample` objects (organized in a data frame):

``` r
# bootstrap
boot <- bootstrap(mtcars, 100)
# k-fold cross-validation
cv1 <- crossv_kfold(mtcars, 5)
# Monte Carlo cross-validation
cv2 <- crossv_mc(mtcars, 100)

dim(boot$strap[[1]])
#> [1] 32 11
dim(cv1$train[[1]])
#> [1] 25 11
dim(cv1$test[[1]])
#> [1]  7 11
dim(cv2$train[[1]])
#> [1] 25 11
dim(cv2$test[[1]])
#> [1]  7 11
```

### Model quality metrics

modelr includes several often-used model quality metrics:

``` r
mod <- lm(mpg ~ wt, data = mtcars)
rmse(mod, mtcars)
#> [1] 2.949163
rsquare(mod, mtcars)
#> [1] 0.7528328
mae(mod, mtcars)
#> [1] 2.340642
qae(mod, mtcars)
#>        5%       25%       50%       75%       95% 
#> 0.1784985 1.0005640 2.0946199 3.2696108 6.1794815
```

### Interacting with models

A set of functions let you seamlessly add predictions and residuals as
additional columns to an existing data frame:

``` r
df <- tibble::data_frame(
  x = sort(runif(100)),
  y = 5 * x + 0.5 * x ^ 2 + 3 + rnorm(length(x))
)
#> Warning: `data_frame()` is deprecated, use `tibble()`.
#> This warning is displayed once per session.

mod <- lm(y ~ x, data = df)
df %>% add_predictions(mod)
#> # A tibble: 100 x 3
#>          x     y  pred
#>      <dbl> <dbl> <dbl>
#>  1 0.00776  3.43  3.07
#>  2 0.0101   3.92  3.08
#>  3 0.0204   3.57  3.14
#>  4 0.0541   1.79  3.32
#>  5 0.0756   2.54  3.44
#>  6 0.0993   2.86  3.57
#>  7 0.122    3.57  3.69
#>  8 0.138    3.87  3.78
#>  9 0.152    3.67  3.86
#> 10 0.153    3.86  3.86
#> # … with 90 more rows
df %>% add_residuals(mod)
#> # A tibble: 100 x 3
#>          x     y    resid
#>      <dbl> <dbl>    <dbl>
#>  1 0.00776  3.43  0.369  
#>  2 0.0101   3.92  0.846  
#>  3 0.0204   3.57  0.440  
#>  4 0.0541   1.79 -1.53   
#>  5 0.0756   2.54 -0.892  
#>  6 0.0993   2.86 -0.712  
#>  7 0.122    3.57 -0.121  
#>  8 0.138    3.87  0.0888 
#>  9 0.152    3.67 -0.183  
#> 10 0.153    3.86  0.00228
#> # … with 90 more rows
```

For visualization purposes it is often useful to use an evenly spaced
grid of points from the data:

``` r
data_grid(mtcars, wt = seq_range(wt, 10), cyl, vs)
#> # A tibble: 60 x 3
#>       wt   cyl    vs
#>    <dbl> <dbl> <dbl>
#>  1  1.51     4     0
#>  2  1.51     4     1
#>  3  1.51     6     0
#>  4  1.51     6     1
#>  5  1.51     8     0
#>  6  1.51     8     1
#>  7  1.95     4     0
#>  8  1.95     4     1
#>  9  1.95     6     0
#> 10  1.95     6     1
#> # … with 50 more rows

# For continuous variables, seq_range is useful
mtcars_mod <- lm(mpg ~ wt + cyl + vs, data = mtcars)
data_grid(mtcars, wt = seq_range(wt, 10), cyl, vs) %>% add_predictions(mtcars_mod)
#> # A tibble: 60 x 4
#>       wt   cyl    vs  pred
#>    <dbl> <dbl> <dbl> <dbl>
#>  1  1.51     4     0  28.4
#>  2  1.51     4     1  28.9
#>  3  1.51     6     0  25.6
#>  4  1.51     6     1  26.2
#>  5  1.51     8     0  22.9
#>  6  1.51     8     1  23.4
#>  7  1.95     4     0  27.0
#>  8  1.95     4     1  27.5
#>  9  1.95     6     0  24.2
#> 10  1.95     6     1  24.8
#> # … with 50 more rows
```

## Code of conduct

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
