# modelr

[![Travis-CI Build Status](https://travis-ci.org/hadley/modelr.svg?branch=master)](https://travis-ci.org/hadley/modelr)
[![Coverage Status](https://img.shields.io/codecov/c/github/hadley/modelr/master.svg)](https://codecov.io/github/hadley/modelr?branch=master)

The goal of modelr is to provide functions that help you create elegant pipelines when modelling.

## Installation

You can install modelr from github with:

```R
# install.packages("devtools")
devtools::install_github("hadley/modelr")
```

Additionally, modelr is available as part of [the tidyverse package](http://blog.revolutionanalytics.com/2016/09/tidyverse.html), which can be installed via:

```R
install.packages("tidyverse")
```

Note that unlike the core tidyverse packages, modelr would not be loaded via `library(tidyverse)`. You should load it explicitly using `library(modelr)`.


