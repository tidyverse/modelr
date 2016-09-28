# modelr

[![Travis-CI Build Status](https://travis-ci.org/hadley/modelr.svg?branch=master)](https://travis-ci.org/hadley/modelr)
[![Coverage Status](https://img.shields.io/codecov/c/github/hadley/modelr/master.svg)](https://codecov.io/github/hadley/modelr?branch=master)

The goal of the modelr package is to provide functions that help you create elegant pipelines when modelling. The package design follows Hadley Wickham's (tidy tool manifesto)[https://mran.microsoft.com/web/packages/tidyverse/vignettes/manifesto.html]. Full documentation is available in (R for Data Science)[http://r4ds.had.co.nz/], especially in the (Model basics)[http://r4ds.had.co.nz/model-basics.html] chapter.

## Installation

You can install modelr from github with:

```R
# install.packages("devtools")
devtools::install_github("hadley/modelr")
```

Alternatively, modelr is available as part of [the tidyverse package](http://blog.revolutionanalytics.com/2016/09/tidyverse.html), which can be installed via:

```R
install.packages("tidyverse")
```

Note that unlike the core tidyverse packages, modelr would not be loaded via `library(tidyverse)`. Instead, you can load it explicitly via `library(modelr)`.


