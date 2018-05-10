# modelr 0.1.2

* `data_grid()` no longer fails with modern tidyr (#58).

* New `mape()` and `rsae()` model quality statistics (@paulponcet, #33).

* `rsquare()` use more robust calculation 1 - SS_res / SS_tot rather 
  than SS_reg / SS_tot (#37).

* `typical()` gains `ordered` and `integer` methods (@jrnold, #44), 
  and `...` argument (@jrnold, #42).

# modelr 0.1.1

* Added a `NEWS.md` file to track changes to the package.

* Fixed R CMD CHECK note

* Updated usage of `reduce()` for upcoming purrr release

* More general `permute()` function

* Add `mse()` function to calculate mean squared error. Written by @bensoltoff, pull request #57
