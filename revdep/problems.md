# ERSA

Version: 0.1.0

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘ERSA-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: plotSum
    > ### Title: Plots of model summaries
    > ### Aliases: plotSum plotAnovaStats plottStats plotCIStats
    > 
    > ### ** Examples
    > 
    > plotAnovaStats(lm(mpg ~ wt+hp+disp, data=mtcars))
    Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
      there is no package called ‘data.table’
    Calls: plotAnovaStats ... tryCatch -> tryCatchList -> tryCatchOne -> <Anonymous>
    Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘RColorBrewer’ ‘modelr’
      All declared Imports should be used.
    ```

# sjPlot

Version: 2.4.1

## In both

*   checking whether package ‘sjPlot’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/hadley/Documents/modelling/modelr/revdep/checks.noindex/sjPlot/new/sjPlot.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘sjPlot’ ...
** package ‘sjPlot’ successfully unpacked and MD5 sums checked
** R
** data
** inst
** preparing package for lazy loading
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  there is no package called ‘data.table’
ERROR: lazy loading failed for package ‘sjPlot’
* removing ‘/Users/hadley/Documents/modelling/modelr/revdep/checks.noindex/sjPlot/new/sjPlot.Rcheck/sjPlot’

```
### CRAN

```
* installing *source* package ‘sjPlot’ ...
** package ‘sjPlot’ successfully unpacked and MD5 sums checked
** R
** data
** inst
** preparing package for lazy loading
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  there is no package called ‘data.table’
ERROR: lazy loading failed for package ‘sjPlot’
* removing ‘/Users/hadley/Documents/modelling/modelr/revdep/checks.noindex/sjPlot/old/sjPlot.Rcheck/sjPlot’

```
# sjstats

Version: 0.14.3

## In both

*   checking whether package ‘sjstats’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/hadley/Documents/modelling/modelr/revdep/checks.noindex/sjstats/new/sjstats.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘sjstats’ ...
** package ‘sjstats’ successfully unpacked and MD5 sums checked
** R
** data
** inst
** preparing package for lazy loading
Warning in checkMatrixPackageVersion() :
  Package version inconsistency detected.
TMB was built with Matrix version 1.2.12
Current Matrix version is 1.2.14
Please re-install 'TMB' from source using install.packages('TMB', type = 'source') or ask CRAN for a binary version of 'TMB' matching CRAN's 'Matrix' package
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  there is no package called ‘data.table’
ERROR: lazy loading failed for package ‘sjstats’
* removing ‘/Users/hadley/Documents/modelling/modelr/revdep/checks.noindex/sjstats/new/sjstats.Rcheck/sjstats’

```
### CRAN

```
* installing *source* package ‘sjstats’ ...
** package ‘sjstats’ successfully unpacked and MD5 sums checked
** R
** data
** inst
** preparing package for lazy loading
Warning in checkMatrixPackageVersion() :
  Package version inconsistency detected.
TMB was built with Matrix version 1.2.12
Current Matrix version is 1.2.14
Please re-install 'TMB' from source using install.packages('TMB', type = 'source') or ask CRAN for a binary version of 'TMB' matching CRAN's 'Matrix' package
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  there is no package called ‘data.table’
ERROR: lazy loading failed for package ‘sjstats’
* removing ‘/Users/hadley/Documents/modelling/modelr/revdep/checks.noindex/sjstats/old/sjstats.Rcheck/sjstats’

```
# tidyverse

Version: 1.2.1

## In both

*   checking whether package ‘tidyverse’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: package ‘tibble’ was built under R version 3.4.3
      Warning: package ‘forcats’ was built under R version 3.4.3
    See ‘/Users/hadley/Documents/modelling/modelr/revdep/checks.noindex/tidyverse/new/tidyverse.Rcheck/00install.out’ for details.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘dbplyr’ ‘reprex’ ‘rlang’
      All declared Imports should be used.
    ```

