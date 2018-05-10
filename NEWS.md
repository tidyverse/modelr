# modelr 0.1.1.9000

* `data_grid()` no longer fails with modern tidyr (#58).

* Use more robust calculation of `rsquare()`: 1 - SS_res / SS_tot rather 
  than SS_reg / SS_tot (#37).

* New `mape()` and `rsae()` model quality statistics (@paulponcet, #33).

* Added `...` argument to the `typical()` generic function (@jrnold, #42)

* Added `typical.ordered` and `typical.integer` methods (@jrnold, #44)

# modelr 0.1.1

* Added a `NEWS.md` file to track changes to the package.

* Fixed R CMD CHECK note

* Updated usage of `reduce()` for upcoming purrr release

* More general `permute()` function

* Add `mse()` function to calculate mean squared error. Written by @bensoltoff, pull request #57
