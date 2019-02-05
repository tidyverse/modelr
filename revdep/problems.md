# sjstats

Version: 0.17.3

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘arm’
    ```

# tidybayes

Version: 1.0.3

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
             "b"), adapt = 100, sample = 100, silent.jags = TRUE, summarise = FALSE)
      9: setup.jagsfile(model = model, n.chains = n.chains, data = data, inits = inits, monitor = monitor, modules = modules, 
             factories = factories, jags = jags, call.setup = TRUE, method = method, mutate = mutate)
      10: setup.jags(model = outmodel, monitor = outmonitor, data = outdata, n.chains = n.chains, inits = outinits, modules = modules, 
             factories = factories, response = response, fitted = fitted, residual = residual, jags = jags, method = method, 
             mutate = mutate)
      11: loadandcheckrjags()
      12: stop("Loading the rjags package failed (diagnostics are given above this error message)", call. = FALSE)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════════════════════════════════
      OK: 219 SKIPPED: 43 FAILED: 1
      1. Error: tidy_draws works with runjags (@test.tidy_draws.R#87) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# tidyverse

Version: 1.2.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘dbplyr’ ‘reprex’ ‘rlang’
      All declared Imports should be used.
    ```

