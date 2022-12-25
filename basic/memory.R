library(lobstr)
library(data.table)
library(tidyverse)
library(microbenchmark)
library(nycflights13)
x <- c(1,2,3)
y <- x


lobstr::obj_addr(x)
lobstr::obj_addr(y)

y[[3]] <- 4
x
y
x <- c(1,2,3)
obj_addr(x)
y
obj_addr(y)

x <- c(1,2,3)
cat(base::tracemem(x), "\n")
y <- x
y[[3]] <- 4
y[[3]] <- 5L
untracemem(x)

# function call
set.seed(124)
df <- mtcars[sample(nrow(mtcars),10), 1:2]
str(df)

dt <- data.table::as.data.table(df)

lobstr::obj_addrs(df)
lobstr::obj_addr(dt)

obj_size(df)
obj_size(dt)
df <- df %>% mutate(mean=mean(mpg))
lobstr::obj_addrs(df)
dt <- dt[, mean_m:=mean(mpg)]
obj_size(dt)
obj_addr(dt)

x <- data.frame(matrix(runif(5 * 1e4), ncol = 5))
medians <- vapply(x, median, numeric(1))

for (i in seq_along(medians)) {
    x[[i]] <- x[[i]] - medians[[i]]
}
y <- as.list(x)
y

library(data.table)
library(tidyverse)
library(microbenchmark)
library(nycflights13)
attach(flights)

flight <- drop_na(flights)
flightsDT = data.table(flight)

mbm = microbenchmark(
    base = aggregate(flights$arr_delay, by=list(flights$carrier), mean, na.rm=TRUE),
    dplyr = flights %>% group_by(carrier) %>% summarize(mean(arr_delay, na.rm=TRUE)),
    datatable = flightsDT[ , mean(arr_delay, na.rm=TRUE), carrier],
    times=100
)
mbm

mbm = microbenchmark(
    #base = aggregate(flights$arr_delay, by=list(flights$carrier), mean, na.rm=TRUE),
    dplyr = flights %>% filter(arr_time>400) %>% transmute(new_col=arr_time*dep_time),
    datatable = flightsDT[ arr_time>400, new_col:=arr_time*dep_time ],
    times=100
)
mbm


mbm = microbenchmark(
    #base = aggregate(flights$arr_delay, by=list(flights$carrier), mean, na.rm=TRUE),
    dplyr = flights %>% group_by(origin,dest) %>% 
        summarise(mean_df=mean(arr_time, na.rm = TRUE),
                  median_df=median(arr_delay,na.rm = TRUE)),
    
    datatable = flightsDT[ , .(mean_dt=mean(arr_time, na.rm = TRUE),
                               median_dt=median(arr_delay, na.rm = TRUE)),
                                by=.(origin,dest) ][order(origin,dest)],
    datatable_order_first=flightsDT[order(origin,dest) , .(mean_dt=mean(arr_time, na.rm = TRUE),
                                                           median_dt=median(arr_delay, na.rm = TRUE)),
                                    by=.(origin,dest) ],
    times=100
)
mbm


