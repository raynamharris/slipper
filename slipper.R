library(devtools)
devtools::install_github('jtleek/slipper')
library(slipper)
slipper(mtcars,mean(mpg),B=100)
mtcars %>% slipper(mean(mpg),B=100)
mtcars %>% slipper(mean(mpg),B=100) %>%
  filter(type=="bootstrap") %>% 
  summarize(ci_low = quantile(value,0.025),
            ci_high = quantile(value,0.975))
slipper_lm(mtcars,mpg ~ cyl,B=100)
mtcars %>% slipper_lm(mpg ~ cyl,B=100)
mtcars %>% slipper_lm(mpg ~ cyl,B=100,boot_resid=TRUE)
mtcars %>% slipper_lm(mpg ~ cyl,B=100) %>% 
  filter(type=="bootstrap",term=="cyl") %>%
  summarize(ci_low = quantile(value,0.025),
            ci_high = quantile(value,0.975))