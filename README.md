---
output:
  md_document:
    variant: markdown_github
---



# modelr

[![Travis-CI Build Status](https://travis-ci.org/tidyverse/modelr.svg?branch=master)](https://travis-ci.org/tidyverse/modelr)
[![Coverage Status](https://img.shields.io/codecov/c/github/tidyverse/modelr/master.svg)](https://codecov.io/github/tidyverse/modelr?branch=master)

The modelr package provides functions that help you create elegant pipelines when modelling. Its design follows Hadley Wickham's [tidy tool manifesto](https://mran.microsoft.com/web/packages/tidyverse/vignettes/manifesto.html).

## Installation and Documentation

You can install modelr from github with:

```
# install.packages("devtools")
devtools::install_github("hadley/modelr")
```

Alternatively, modelr is available as part of [the tidyverse package](http://blog.revolutionanalytics.com/2016/09/tidyverse.html) which can be installed via:

```
install.packages("tidyverse")
```

Note that unlike the core tidyverse packages, modelr would not be loaded via `library(tidyverse)`. Instead, you can load it explicitly:


```r
library(modelr)
```

Full documentation is available in [R for Data Science](http://r4ds.had.co.nz/), mostly in the [Model basics](http://r4ds.had.co.nz/model-basics.html) chapter.

## Main Features

### Partitioning and sampling

The `resample` class stores a "pointer" to the original dataset and a vector of row indices. `resample` can be turned into a dataframe by calling `as.data.frame`. The indices can be extracted using `as.integer`:


```r
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

The class can be utilized in generating an exclusive partitioning of a data frame:


```r
# generate a 30% testing partition and a 70% training partition
ex <- resample_partition(mtcars, c(test = 0.3, train = 0.7))
lapply(ex, dim)
#> $test
#> [1]  9 11
#> 
#> $train
#> [1] 23 11
```

modelr offers several resampling methods that result in a list of `resample` objects (organized in a data frame):


```r
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


```r
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

A set of functions let you seamlessly add predictions and residuals as additional columns to an existing data frame:


```r
df <- tibble::data_frame(
  x = sort(runif(100)),
  y = 5 * x + 0.5 * x ^ 2 + 3 + rnorm(length(x))
)

mod <- lm(y ~ x, data = df)
df %>% add_predictions(mod)
#> # A tibble: 100 × 3
#>             x         y     pred
#>         <dbl>     <dbl>    <dbl>
#> 1  0.00859932 3.1862180 2.601857
#> 2  0.01545169 2.6204296 2.644123
#> 3  0.01848258 4.6334283 2.662818
#> 4  0.02955594 2.2979198 2.731121
#> 5  0.03737513 0.8101851 2.779351
#> 6  0.04397960 2.4761070 2.820088
#> 7  0.04623513 5.0681121 2.834001
#> 8  0.04800758 1.7018879 2.844934
#> 9  0.06098940 2.0351324 2.925008
#> 10 0.06455042 3.7841005 2.946973
#> # ... with 90 more rows
df %>% add_residuals(mod)
#> # A tibble: 100 × 3
#>             x         y       resid
#>         <dbl>     <dbl>       <dbl>
#> 1  0.00859932 3.1862180  0.58436135
#> 2  0.01545169 2.6204296 -0.02369364
#> 3  0.01848258 4.6334283  1.97061002
#> 4  0.02955594 2.2979198 -0.43320093
#> 5  0.03737513 0.8101851 -1.96916562
#> 6  0.04397960 2.4761070 -0.34398128
#> 7  0.04623513 5.0681121  2.23411135
#> 8  0.04800758 1.7018879 -1.14304565
#> 9  0.06098940 2.0351324 -0.88987534
#> 10 0.06455042 3.7841005  0.83712781
#> # ... with 90 more rows
```

For visualization purposes it is often useful to use an evenly spaced grid of points from the data:


```r
data_grid(mtcars, wt = seq_range(wt, 10), cyl, vs)
#> # A tibble: 60 × 3
#>          wt   cyl    vs
#>       <dbl> <dbl> <dbl>
#> 1  1.513000     4     0
#> 2  1.513000     4     1
#> 3  1.513000     6     0
#> 4  1.513000     6     1
#> 5  1.513000     8     0
#> 6  1.513000     8     1
#> 7  1.947556     4     0
#> 8  1.947556     4     1
#> 9  1.947556     6     0
#> 10 1.947556     6     1
#> # ... with 50 more rows

# For continuous variables, seq_range is useful
mtcars_mod <- lm(mpg ~ wt + cyl + vs, data = mtcars)
data_grid(mtcars, wt = seq_range(wt, 10), cyl, vs) %>% add_predictions(mtcars_mod)
#> # A tibble: 60 × 4
#>          wt   cyl    vs     pred
#>       <dbl> <dbl> <dbl>    <dbl>
#> 1  1.513000     4     0 28.37790
#> 2  1.513000     4     1 28.90207
#> 3  1.513000     6     0 25.64969
#> 4  1.513000     6     1 26.17386
#> 5  1.513000     8     0 22.92148
#> 6  1.513000     8     1 23.44566
#> 7  1.947556     4     0 26.96717
#> 8  1.947556     4     1 27.49134
#> 9  1.947556     6     0 24.23896
#> 10 1.947556     6     1 24.76314
#> # ... with 50 more rows
```

