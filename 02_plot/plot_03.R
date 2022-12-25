# https://r-coder.com/histogram-r/

library(ggplot2)
####### Histogram ----
distance <- c(241.1, 284.4, 220.2, 272.4, 271.1, 268.3,
              291.6, 241.6, 286.1, 285.9, 259.6, 299.6,
              253.1, 239.6, 277.8, 263.8, 267.2, 272.6,
              283.4, 234.5, 260.4, 264.2, 295.1, 276.4,
              263.1, 251.4, 264.0, 269.2, 281.0, 283.2)
              
hist(distance, main = "Frequency histogram")

dat1 <- data.frame(
  sex = factor(c("Female", "Female", "Male", "Male")),
  time = factor(c("Lunch", "Dinner", "Lunch", "Dinner"),
    levels = c("Lunch", "Dinner")),
  total_bill = c(13.53, 16.81, 16.24, 17.42)
)
ggplot(data = dat1, aes(x = time, y = total_bill, fill = sex)) +
  geom_bar(stat = "identity", position = position_dodge())
  
    #   colour="black") +
#   scale_fill_manual(values=c("#999999", "#E69F00"))


#########   base
dat1mat <- matrix(dat1$total_bill,
                   nrow = 2,
                   byrow=TRUE,
                   dimnames = list(c("Female", "Male"), c("Lunch", "Dinner"))
                   )
par(bg='white')
mf_col <- c("#3CC3BD", "#FD8210")
barplot(dat1mat, beside = TRUE, border=NA, col=mf_col)
legend("topleft", row.names(dat1mat), pch=15, col=mf_col)

# GGPLOT COLOR
mf_col <- c("#F8766D","#00BFC4" )
barplot(dat1mat, beside = TRUE, border=NA, col=mf_col)
legend("topleft", row.names(dat1mat), pch=15, col=mf_col)
##


par(cex=1.2, cex.axis=1.1)
barplot(dat1mat, beside = TRUE, border=NA, col=mf_col,
    main="Average Bill for Two People", yaxt="n")
axis(2, at=axTicks(2), labels=sprintf("$%s", axTicks(2)),
    las=1, cex.axis=0.8)
# grid(NA, NULL, lwd=1, lty=1, col="#ffffff")
abline(0, 0)
text(1.5, dat1mat["Female", "Lunch"], "Female", pos=3)
text(2.5, dat1mat["Male", "Lunch"], "Male", pos=3)
text(1.5, dat1mat["Female", "Lunch"]+0.7, "SEX OF PAYER",
    pos=3, cex=0.75)

#### find the ggplot color plate
library(scales)
show_col(hue_pal()(4))


#### 
#https://towardsdatascience.com/base-plotting-in-r-eb365da06b22

##global parameters
library(datasets)
attach(iris)

par(mfrow = c(1,1), mar = c(5,5,4,1),font = 7,font.axis = 7,
    fg = "azure4",  col.axis = "azure4", cex.axis = .75) 
##Create the empty plot
plot(NULL, ylim=c(0,2.5),xlim=c(0,7), 
     xlab = "Petal Length", 
     ylab = "Petal Width", 
     font.lab = 7,
     main = "Petal Width vs. Petal Length",
     font.main = 7,
     col.main = "black",)
##Add the background color
abline(v = 0:7, col = "aliceblue", lwd = 200)
abline(v = 0:7, col = "white")
abline(h=0:2.5, col = "white")
##Add the data points
points(iris$Petal.Length, iris$Petal.Width, 
       pch = 20,
       cex = 1.5,
       col=ifelse(iris$Species == "setosa","coral1", 
                  ifelse(iris$Species == "virginica","cyan4", 
                         ifelse(iris$Species ==  "versicolor",
                                "darkgoldenrod2", "grey"))))
##legend
legend("bottomright", c("setosa", "virginica", "versicolor"),
       col = c("coral1","cyan4", "darkgoldenrod2"), pch=20)

library(tidyverse)
ggplot(data = iris) +
geom_point(aes(x = Sepal.Length,
               y = Sepal.Width, col = Species)
               )


colors <- c("#F8766D", "#00BFC4", "#C77CFF")

plot(iris[["Sepal.Length"]], iris[["Sepal.Width"]], col=colors[iris$Species],
pch=16,
xlab="sepal length",
ylab="sepal width")


?ggplot

