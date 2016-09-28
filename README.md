modelr
======

<!--
[![Travis-CI Build Status](https://travis-ci.org/hadley/modelr.svg?branch=master)](https://travis-ci.org/hadley/modelr)
[![Coverage Status](https://img.shields.io/codecov/c/github/hadley/modelr/master.svg)](https://codecov.io/github/hadley/modelr?branch=master)
-->
The goal of the modelr package is to provide functions that help you create elegant pipelines when modelling. The package design follows Hadley Wickham's [tidy tool manifesto](https://mran.microsoft.com/web/packages/tidyverse/vignettes/manifesto.html).

Installation and Documentation
------------------------------

You can install modelr from github with:

    # install.packages("devtools")
    devtools::install_github("hadley/modelr")

Alternatively, modelr is available as part of [the tidyverse package](http://blog.revolutionanalytics.com/2016/09/tidyverse.html) which can be installed via:

    install.packages("tidyverse")

Note that unlike the core tidyverse packages, modelr would not be loaded via `library(tidyverse)`. Instead, you can load it explicitly:

``` r
library(modelr)
```

Full documentation is available in [R for Data Science](http://r4ds.had.co.nz/), especially in the [Model basics](http://r4ds.had.co.nz/model-basics.html) chapter.

Main Features
-------------

### Partitioning and sampling

The `resample` class stores a "pointer" to the original dataset and a vector of row indices. `resample` can be turned into a dataframe by calling `as.data.frame`. The indices can be extracted using `as.integer`:

``` r
# a subsample of the first ten rows in the data frame
rs <- resample(mtcars, 1:10)
as.data.frame(rs)
```

    ##                    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4         21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag     21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710        22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive    21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant           18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
    ## Duster 360        14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
    ## Merc 240D         24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
    ## Merc 230          22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
    ## Merc 280          19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4

``` r
as.integer(rs)
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

The class can be utilized in generating an exclusive partitioning of a data frame:

``` r
# generate a 30% testing partition and a 70% training partition
ex <- resample_partition(mtcars, c(test = 0.3, train = 0.7))
lapply(ex, dim)
```

    ## $test
    ## [1]  9 11
    ## 
    ## $train
    ## [1] 23 11

modelr offers several resampling methods that result in a list of `resample` objects (organized in a data frame):

``` r
# bootstrap
boot <- bootstrap(mtcars, 100)
# k-fold cross-validation
cv1 <- crossv_kfold(mtcars, 5)
# Monte Carlo cross-validation
cv2 <- crossv_mc(mtcars, 100)

dim(boot$strap[[1]])
```

    ## [1] 32 11

``` r
dim(cv1$train[[1]])
```

    ## [1] 25 11

``` r
dim(cv1$test[[1]])
```

    ## [1]  7 11

``` r
dim(cv2$train[[1]])
```

    ## [1] 25 11

``` r
dim(cv2$test[[1]])
```

    ## [1]  7 11

### Model quality metrics

modelr includes several common model quality metrics:

``` r
mod <- lm(mpg ~ wt, data = mtcars)
rmse(mod, mtcars)
```

    ## [1] 2.949163

``` r
rsquare(mod, mtcars)
```

    ## [1] 0.7528328

``` r
mae(mod, mtcars)
```

    ## [1] 2.340642

``` r
qae(mod, mtcars)
```

    ##        5%       25%       50%       75%       95% 
    ## 0.1784985 1.0005640 2.0946199 3.2696108 6.1794815

### Interacting with models

A set of functions let you seamlessly add predictions and residuals as additional columns to an existing data frame:

``` r
df <- tibble::data_frame(
  x = sort(runif(100)),
  y = 5 * x + 0.5 * x ^ 2 + 3 + rnorm(length(x))
)

mod <- lm(y ~ x, data = df)
df %>% add_predictions(mod)
```

    ## # A tibble: 100 × 3
    ##              x         y     pred
    ##          <dbl>     <dbl>    <dbl>
    ## 1  0.001960865 3.3765343 2.903298
    ## 2  0.009710429 0.4879972 2.948092
    ## 3  0.026235324 3.4264812 3.043611
    ## 4  0.027837300 3.5372679 3.052870
    ## 5  0.030021915 1.8151134 3.065498
    ## 6  0.031186287 1.9037856 3.072229
    ## 7  0.038435193 3.0714626 3.114129
    ## 8  0.044384863 1.1072440 3.148520
    ## 9  0.052380702 1.7221297 3.194738
    ## 10 0.074117513 2.9017861 3.320382
    ## # ... with 90 more rows

``` r
df %>% add_residuals(mod)
```

    ## # A tibble: 100 × 3
    ##              x         y       resid
    ##          <dbl>     <dbl>       <dbl>
    ## 1  0.001960865 3.3765343  0.47323640
    ## 2  0.009710429 0.4879972 -2.46009522
    ## 3  0.026235324 3.4264812  0.38287059
    ## 4  0.027837300 3.5372679  0.48439742
    ## 5  0.030021915 1.8151134 -1.25038477
    ## 6  0.031186287 1.9037856 -1.16844288
    ## 7  0.038435193 3.0714626 -0.04266657
    ## 8  0.044384863 1.1072440 -2.04127577
    ## 9  0.052380702 1.7221297 -1.47260820
    ## 10 0.074117513 2.9017861 -0.41859631
    ## # ... with 90 more rows

For visualization purposes it is often useful to use an evenly spaced grid of points from the data:

``` r
data_grid(df, x, y)
```

    ## # A tibble: 10,000 × 2
    ##              x         y
    ##          <dbl>     <dbl>
    ## 1  0.001960865 0.4879972
    ## 2  0.001960865 1.1072440
    ## 3  0.001960865 1.7221297
    ## 4  0.001960865 1.8151134
    ## 5  0.001960865 1.9037856
    ## 6  0.001960865 2.9017861
    ## 7  0.001960865 2.9952107
    ## 8  0.001960865 2.9970347
    ## 9  0.001960865 3.0258177
    ## 10 0.001960865 3.0714626
    ## # ... with 9,990 more rows

``` r
data_grid(df, x, y) %>% add_predictions(mod)
```

    ## # A tibble: 10,000 × 3
    ##              x         y     pred
    ##          <dbl>     <dbl>    <dbl>
    ## 1  0.001960865 0.4879972 2.903298
    ## 2  0.001960865 1.1072440 2.903298
    ## 3  0.001960865 1.7221297 2.903298
    ## 4  0.001960865 1.8151134 2.903298
    ## 5  0.001960865 1.9037856 2.903298
    ## 6  0.001960865 2.9017861 2.903298
    ## 7  0.001960865 2.9952107 2.903298
    ## 8  0.001960865 2.9970347 2.903298
    ## 9  0.001960865 3.0258177 2.903298
    ## 10 0.001960865 3.0714626 2.903298
    ## # ... with 9,990 more rows
