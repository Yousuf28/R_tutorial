library(data.table)
library(microbenchmark)
set.seed(1L)

## Create a data table
DT <- data.table(V1 = rep(c(1L, 2L), 5)[-10],
                 V2 = 1:9,
                 V3 = c(0.5, 1.0, 1.5),
                 V4 = rep(LETTERS[1:3], 3))

class(DT)
DT

library(dplyr)
set.seed(1L)

## Create a data frame (tibble)
DF <- tibble(V1 = rep(c(1L, 2L), 5)[-10],
             V2 = 1:9,
             V3 = rep(c(0.5, 1.0, 1.5), 3),
             V4 = rep(LETTERS[1:3], 3))

class(DF)
DF

mbm =microbenchmark(
    df=filter(DF, V2 > 5),
     dt=DT[V2 > 5],   
    times = 1000
)
mbm


mbm =microbenchmark(
    df=arrange(DF, V3),
    dt=DT[order(V3)],   
    times = 1000
)
mbm

mbm =microbenchmark(
    df=DF %>%
        summarise(sumv1 = sum(V1),
                  sdv3  = sd(V3)),
    dt=DT[, .(sumv1 = sum(V1),
              sdv3  = sd(V3))],   
    times = 1000
)
mbm

mbm =microbenchmark(
    df=DF %>%
        group_by(V4) %>%
        summarise(sumV2 = sum(V2)),
    dt=DT[, .(sumV2 = sum(V2)), by = "V4"],   
    times = 1000
)
mbm
