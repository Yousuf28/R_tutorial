# base plot


mtcars
chickwts
library(data.table)
df <- ChickWeight
dt <- as.data.table(df)
dt
############################################### plot 2 ----
hist(dt$weight,
     breaks = 40,
     xlab = "Birth Weight",
     #ylab =
     main = "Histogram of Unicorn Birth Weight",
     ylim = c(0, 80))

     moomins <- read.table("Moomin Density.txt", header = TRUE) 
     
     plot(moomins$Year, moomins$PopSize, #type = 'l', col = "red",
     lwd = 3,
     xlab = "time",
     ylab = "weight",
     main = "time vs weight"
)
########################### plot 3----
plot(moomins$Year, moomins$PopSize,
     type = "l",
     col = "red",
     lwd = 3,
     xlab = "time",
     ylab = "weight",
     main = "time vs weight")

plot(moomins$Year, moomins$PopSize,
     type = 'o',
     col='red',
     lwd=3,
     xlab = "time",
     ylab = 'weight',
     main = "time vs weight"
     
)

plot(moomins$Year, moomins$PopSize,
     type = 'p',
     col='red',
     lwd=3,
     xlab = "time",
     ylab = 'weight',
     main = "time vs weight"
     
)

plot(moomins$Year, moomins$PopSize,
     type = 'b',
     col='red',
     lwd=3,
     xlab = "time",
     ylab = 'weight',
     main = "time vs weight"
     
)

plot(moomins$Year, moomins$PopSize,
     type = 'l',
     lty='dashed',
     col='red',
     lwd=3,
     xlab = "time",
     ylab = 'weight',
     main = "time vs weight"
     
)
fit1 <- lm (PopSize ~ Year, data = moomins)
abline(fit1, lty = "dashed")
#We can add some text to the plot giving
# the R2 value and the P value using "text" and specifying the x and y coordinates for the text.
text(x  =1978, y = 750,labels="R2 = 0.896\nP = 2.615e-15")


plot(1:7, abs(stats::rnorm(7)), type = "h", axes = FALSE)
axis(1, at = 1:7, labels = letters[1:7])
box(lty = '1373', col = 'red')

dt[, .(mean = mean(mpg)), by = .(mpg)]

mtcars %>% dplyr::select(mpg)

df <- as.data.table(mtcars)

