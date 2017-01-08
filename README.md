# Bootstrapping made easy and tidy with slipper
=================

Note 1: This README file was writen by the author of this repo: https://github.com/jtleek/slipper

Note 2: The slipper.Rmd file in this directory was build from the code in this document. View the slipper.md file to view the full output, using 12 or 8 bootstraps for easy of viewing. 

=================

You've heard of [broom](https://cran.r-project.org/web/packages/broom/index.html) for tidying up your R functions. slipper is an R package for tidy/easy bootstrapping. There are already a bunch of good bootstrapping packages out there including [bootstrap](https://cran.r-project.org/web/packages/bootstrap/) and [boot](https://cran.r-project.org/web/packages/boot/). You can also bootstrap with [dplyr and broom](https://cran.r-project.org/web/packages/broom/vignettes/bootstrapping.html) or with [purrr and modelr](https://cran.r-project.org/web/packages/modelr).

But I'm too dumb for any of those. So slipper includes some simple,pipeable bootstrapping functions for me 

### install
with `devtools`:

```S
devtools::install_github('jtleek/slipper')
```

### use

There are only two functions in this package. 

Call `slipper` to bootstrap any function that returns
a single value. 

```S
slipper(mtcars,mean(mpg),B=100)
```

slipper is built to work with pipes and the tidyverse too. 

```S
mtcars %>% slipper(mean(mpg),B=100)
```

The output is a data frame with the values of the function on the original data set and the bootstrapped replicates. You can calculate confidence intervals using summarize

``` S
mtcars %>% slipper(mean(mpg),B=100) %>%
  filter(type=="bootstrap") %>% 
  summarize(ci_low = quantile(value,0.025),
            ci_high = quantile(value,0.975))
```

You can also bootstrap linear models using `slipper_lm` just pass the data frame and the formula you want to fit on the original data and on the bootstrap samples. 

``` S
 slipper_lm(mtcars,mpg ~ cyl,B=100)
```

This is also pipeable

```S
mtcars %>% slipper_lm(mpg ~ cyl,B=100)
```

The default behavior is to bootstrap complete cases, but if you want to bootstrap residuals set `boot_resid=TRUE`

```S
mtcars %>% slipper_lm(mpg ~ cyl,B=100,boot_resid=TRUE)
```

You can calculate bootstrap confidence intervals in the same way as you do for `slipper`.

```S
mtcars %>% slipper_lm(mpg ~ cyl,B=100) %>% 
 filter(type=="bootstrap",term=="cyl") %>%
  summarize(ci_low = quantile(value,0.025),
            ci_high = quantile(value,0.975))
```

Finally if you want to do a bootstrap hypothesis test you can pass a formula and a nested null formula. `formula` must every term in `null_formula` and one additional one you want to test. 

```S
# Bootstrap hypothesis test - 
# here I've added one to the numerator
# and denominator because bootstrap p-values should 
# never be zero.

mtcars %>% 
  slipper_lm(mpg ~ cyl, null_formula = mpg ~ 1,B=1000) %>%
    filter(term=="cyl") %>%
    summarize(num = sum(abs(value) >= abs(value[1])),
                                den = n(),
                                pval = num/den)
```

That's basically it for now. Would love some help/pull requests/fixes as this is my first attempt at getting into the tidyverse :). 