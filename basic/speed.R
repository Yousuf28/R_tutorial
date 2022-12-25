library(data.table)
library(tidyverse)
library(microbenchmark)

d <- data.table(
    grp = sample(c(1,2,3), size = 1e6, replace = TRUE) %>% factor,
    x = rnorm(1e6),
    y = runif(1e6)
)
d

base_mutate <- function(data){
    data$z <- rnorm(1e6)
    data
}
base_filter <- function(data){
    data[data$grp == 1, ]
}
base_summarize <- function(data){
    tapply(data$x, data$grp, mean)
}

dplyr_mutate <- function(data){
    mutate(data, z = rnorm(1e6))
}
dplyr_filter <- function(data){
    filter(data, grp == 1)
}
dplyr_summarize <- function(data){
    summarize(group_by(data, grp), mean(x))
}

dt_mutate <- function(data){
    data[, z := rnorm(1e6)]
}
dt_filter <- function(data){
    data[grp == 1]
}
dt_summarize <- function(data){
    data[, mean(x), by = "grp"]
}

df <- copy(d) %>% as.data.frame()
tbl <- copy(d) %>% as_tibble()
dt <- copy(d)

# Adding a variable
var_mbm=microbenchmark(
    bench_base_m  <- base_mutate(df),
    bench_dplyr_m <- dplyr_mutate(tbl),
    bench_dt_m    <- dt_mutate(dt), times = 100
)
var_mbm


# Filtering rows

filter_mbm=microbenchmark(
    bench_base_f  <- base_filter(df), 
    bench_dplyr_f <- dplyr_filter(tbl), 
    bench_dt_f    <- dt_filter(dt), 
    times = 100
)
filter_mbm


# Summarizing by group

sum_mbm=microbenchmark(
    bench_base_s  <- base_summarize(df),
    bench_dplyr_s <- dplyr_summarize(tbl),
    bench_dt_s    <- dt_summarize(dt),
    times = 100
    
)
sum_mbm
