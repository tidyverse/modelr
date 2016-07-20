library(tibble)
library(ggplot2)
library(dplyr)

set.seed(1014)

# 1 con
sim1 <- tibble(
  x = rep(1:10, each = 3),
  y = x * 2 + 5 + rnorm(length(x), sd = 2)
)

# 1 cat
means <- c(a = 1, b = 8, c = 6, d = 2)
sim2 <- tibble(
  x = rep(names(means), each = 10),
  y = means[x] + rnorm(length(x))
)

# 1 cat + 1 con with interaction
slopes <- c(a = -0.1, b = -0.8, c = -0.1, d = 0.2)
sim3 <-
  tidyr::crossing(x1 = 1:10, x2 = factor(names(means)), rep = 1:3) %>%
  mutate(y = means[x2] + slopes[x2] * x1 + rnorm(length(x1)), sd = 2)

# 2 con
x <- seq(-1, 1, length = 10)
sim4 <-
  tidyr::crossing(x1 = x, x2 = x, rep = 1:3) %>%
  mutate(
    y = 2 * x1 - 3 * x2 + x1 * x2 + rnorm(length(x1), sd = 2)
  )
ggplot(sim4, aes(x1, y, colour = x2)) + geom_point()


devtools::use_data(sim1, overwrite = TRUE)
devtools::use_data(sim2, overwrite = TRUE)
devtools::use_data(sim3, overwrite = TRUE)
devtools::use_data(sim4, overwrite = TRUE)
