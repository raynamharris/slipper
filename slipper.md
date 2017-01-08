An Rmd version of the Slipper tutorial found here: <https://github.com/jtleek/slipper>

``` r
library(devtools)
#devtools::install_github('jtleek/slipper')
library(slipper)
```

    ## Loading required package: tidyverse

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

    ## Loading required package: lazyeval

    ## 
    ## Attaching package: 'lazyeval'

    ## The following objects are masked from 'package:purrr':
    ## 
    ##     is_atomic, is_formula

    ## Loading required package: broom

``` r
slipper(mtcars,mean(mpg),B=12)
```

    ##         type    value
    ## 1   observed 20.09062
    ## 2  bootstrap 20.54062
    ## 3  bootstrap 20.11875
    ## 4  bootstrap 19.69375
    ## 5  bootstrap 22.15312
    ## 6  bootstrap 19.35625
    ## 7  bootstrap 19.73750
    ## 8  bootstrap 20.18437
    ## 9  bootstrap 22.56563
    ## 10 bootstrap 19.92188
    ## 11 bootstrap 18.34062
    ## 12 bootstrap 20.40625
    ## 13 bootstrap 19.84062

``` r
mtcars %>% slipper(mean(mpg),B=12)
```

    ##         type    value
    ## 1   observed 20.09062
    ## 2  bootstrap 18.80625
    ## 3  bootstrap 19.18750
    ## 4  bootstrap 20.10312
    ## 5  bootstrap 22.39062
    ## 6  bootstrap 19.49687
    ## 7  bootstrap 20.48750
    ## 8  bootstrap 19.94375
    ## 9  bootstrap 19.57187
    ## 10 bootstrap 19.99063
    ## 11 bootstrap 18.40312
    ## 12 bootstrap 19.11875
    ## 13 bootstrap 20.61563

``` r
mtcars %>% slipper(mean(mpg),B=12) %>%
  filter(type=="bootstrap") %>% 
  summarize(ci_low = quantile(value,0.025),
            ci_high = quantile(value,0.975))
```

    ##     ci_low  ci_high
    ## 1 18.92797 21.89031

``` r
slipper_lm(mtcars,mpg ~ cyl,B=8)
```

    ##           term     value      type
    ## 1  (Intercept) 37.884576  observed
    ## 2          cyl -2.875790  observed
    ## 3  (Intercept) 41.381383 bootstrap
    ## 4          cyl -3.298936 bootstrap
    ## 5  (Intercept) 34.325654 bootstrap
    ## 6          cyl -2.504188 bootstrap
    ## 7  (Intercept) 36.526122 bootstrap
    ## 8          cyl -2.712041 bootstrap
    ## 9  (Intercept) 37.352915 bootstrap
    ## 10         cyl -2.843049 bootstrap
    ## 11 (Intercept) 36.359865 bootstrap
    ## 12         cyl -2.724552 bootstrap
    ## 13 (Intercept) 32.173303 bootstrap
    ## 14         cyl -1.882504 bootstrap
    ## 15 (Intercept) 34.084674 bootstrap
    ## 16         cyl -2.385760 bootstrap
    ## 17 (Intercept) 38.613768 bootstrap
    ## 18         cyl -2.951812 bootstrap

``` r
mtcars %>% slipper_lm(mpg ~ cyl,B=8)
```

    ##           term     value      type
    ## 1  (Intercept) 37.884576  observed
    ## 2          cyl -2.875790  observed
    ## 3  (Intercept) 42.863994 bootstrap
    ## 4          cyl -3.658158 bootstrap
    ## 5  (Intercept) 36.810762 bootstrap
    ## 6          cyl -2.740022 bootstrap
    ## 7  (Intercept) 36.609043 bootstrap
    ## 8          cyl -2.728191 bootstrap
    ## 9  (Intercept) 36.054020 bootstrap
    ## 10         cyl -2.545729 bootstrap
    ## 11 (Intercept) 37.776812 bootstrap
    ## 12         cyl -2.856159 bootstrap
    ## 13 (Intercept) 36.190280 bootstrap
    ## 14         cyl -2.538733 bootstrap
    ## 15 (Intercept) 35.448000 bootstrap
    ## 16         cyl -2.562429 bootstrap
    ## 17 (Intercept) 34.111008 bootstrap
    ## 18         cyl -2.358517 bootstrap

``` r
mtcars %>% slipper_lm(mpg ~ cyl,B=8,boot_resid=TRUE)
```

    ##           term     value      type
    ## 1  (Intercept) 37.884576  observed
    ## 2          cyl -2.875790  observed
    ## 3  (Intercept) 41.250579 bootstrap
    ## 4          cyl -3.430870 bootstrap
    ## 5  (Intercept) 36.933513 bootstrap
    ## 6          cyl -2.701897 bootstrap
    ## 7  (Intercept) 36.587008 bootstrap
    ## 8          cyl -2.564551 bootstrap
    ## 9  (Intercept) 37.723453 bootstrap
    ## 10         cyl -2.994147 bootstrap
    ## 11 (Intercept) 39.211344 bootstrap
    ## 12         cyl -3.061445 bootstrap
    ## 13 (Intercept) 35.636350 bootstrap
    ## 14         cyl -2.508044 bootstrap
    ## 15 (Intercept) 38.818248 bootstrap
    ## 16         cyl -3.116734 bootstrap
    ## 17 (Intercept) 38.405182 bootstrap
    ## 18         cyl -2.971561 bootstrap

``` r
mtcars %>% slipper_lm(mpg ~ cyl,B=8) %>% 
  filter(type=="bootstrap",term=="cyl") %>%
  summarize(ci_low = quantile(value,0.025),
            ci_high = quantile(value,0.975))
```

    ##      ci_low ci_high
    ## 1 -3.526347 -2.4558
