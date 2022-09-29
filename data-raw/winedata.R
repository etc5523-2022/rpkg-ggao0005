## code to prepare `wine` dataset goes here


library(readr)
library(tidyverse)

wine <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-28/winemag-data-130k-v2.csv") %>%
  select(country, points, price, description)



usethis::use_data(wine, overwrite = TRUE)

