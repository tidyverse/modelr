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

head(boot, 1)
```

    ## # A tibble: 1 × 2
    ##            strap   .id
    ##           <list> <chr>
    ## 1 <S3: resample>   001

``` r
head(cv1, 1)
```

    ## # A tibble: 1 × 3
    ##            train           test   .id
    ##           <list>         <list> <chr>
    ## 1 <S3: resample> <S3: resample>     1

``` r
head(cv2, 1)
```

    ## # A tibble: 1 × 3
    ##            train           test   .id
    ##           <list>         <list> <chr>
    ## 1 <S3: resample> <S3: resample>   001
