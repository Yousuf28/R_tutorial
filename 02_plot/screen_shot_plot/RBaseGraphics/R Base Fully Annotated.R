#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#   # Susan E. Johnston.
#                                                #   # Susan.Johnston@ed.ac.uk
#              R GRAPHICS SEMINAR                #
#                30th August 2012                #
#                                                #
#                                                #
#             Part 1: Base Graphics              #
#                                                #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

#~~ Set your working directory

setwd("C:/Users/Susan Johnston/Desktop/Teaching/R Graphics Course/")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#    What types of data can we build graphs from?         #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

#~~ vectors

height<-c(145,167,176,123,150)
weight<-c(51,63,64,40,55)

plot(height,weight)

#~~ data frames

tarsus<-read.table("tarsus.txt",header=T)
tarsus
str(tarsus)

# To call a variable in the dataframe, use the $ notation.
tarsus$TarsusLength
tarsus$Weight

plot(tarsus$TarsusLength,tarsus$Weight)

#~~ tables

tarsus_tab<-table(tarsus$TarsusLength)

tarsus_tab

plot(tarsus_tab)

barplot(tarsus_tab)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#    1. Basic Histogram          #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# For this part, we will use data on birthweight measured in male and female unicorns.
# Lets read the data into R:

unicorns<-read.table("unicorns.txt",header=T)
head(unicorns)
str(unicorns)

unicorns$birthweight

#~~ Basic histogram of unicorn birthweight and longevity using hist()

hist(unicorns$birthweight)            # normal distribution
hist(unicorns$longevity)              # poisson distribution

#~~ Specify the number of cells for the histogram using: breaks = N

hist(unicorns$birthweight, breaks = 40)
hist(unicorns$birthweight, breaks = c(0,1,2,3,4,5,6,7))
hist(unicorns$birthweight, breaks = c(0,1,2,3,4,7))

#~~ Relabel the x-axis using: xlab = "Text"

hist(unicorns$birthweight, breaks = 40, xlab = "Birth Weight")

#~~ Relabel the main title using: main = "Text"     

hist(unicorns$birthweight, breaks = 40, xlab = "Birth Weight", main = "Histogram of Unicorn Birth Weight")

#~~ The lines start to get too long. When there is a comma, R knows that there is more
#   information on the next line!

hist(unicorns$birthweight,
     breaks = 40,
     xlab = "Birth Weight",
     main = "Histogram of Unicorn Birth Weight")

#~~ The y-axis stops short of the highest value in the histogram.
#   Lets specify new limits using: ylim = c(minimum, maximum)

hist(unicorns$birthweight,
     breaks = 40,
     xlab = "Birth Weight", 
     main = "Histogram of Unicorn Birth Weight",
     ylim = c(0,80))

#~~ FINAL PLOT:

hist(unicorns$birthweight,                            # x value
     breaks = 40,                                     # number of cells
     xlab = "Birth Weight",                           # x-axis label
     main = "Histogram of Unicorn Birth Weight",      # plot title
     ylim = c(0,80))                                  # limits of the y axis (min,max)

#~~~ Which customisations did we learn in this section?

#  hist
#  breaks
#  xlab & ylab
#  main
#  ylim & xlim

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#    2. Basic Line Graph with Regression    #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Data on population density of Moomins on Ruissalo from 1971 to 2000.

moomins<-read.table("Moomin Density.txt",header=T)
head(moomins)

#~~ Create a plot using the default options in plot.

plot(moomins$Year, moomins$PopSize)

#~~ There are several types of plot within the plot function. Use "type":   

plot(moomins$Year, moomins$PopSize, type = "l")     # Try "o" "p" "l" "b"

#~~ We can also change the line type using "lty"

plot(moomins$Year, moomins$PopSize, type = "l", lty = "dashed")
plot(moomins$Year, moomins$PopSize, type = "l", lty = "dotted")

#~~ The solid line looks best, so lets stick with it.

plot(moomins$Year, moomins$PopSize, type = "l")

#~~ Let's start to add colour using "col".

plot(moomins$Year, moomins$PopSize, type = "l", col = "red")    # R Colour Chart

# NB. numbers can also be used as colours!
plot(moomins$Year, moomins$PopSize, type = "l", col = 3)

#~~ Let's make the line a little thicker using "lwd" (line width)

plot(moomins$Year, moomins$PopSize, type = "l", col = "red", lwd = 3)

#~~ Finally, lets sort out the axis titles plot title:

plot(moomins$Year, moomins$PopSize, 
     type = "l", 
     col = "red", 
     lwd = 3,
     xlab = "Year",
     ylab = "Population Size",
     main = "Moomin Population Size on Ruissalo 1971 - 2001")

#~~ Is the Moomin population increasing in size?
#   We can add a basic linear regression to the plot.

fit1 <- lm (PopSize ~ Year, data = moomins) 
summary(fit1)

#~~ add the regression line to the plot using "abline"
#   NB. we can also use lty, lwd, col here.

abline(fit1, lty = "dashed")    #abline(a=intercept,b=slope)

#~~ we can also add horizontal and vertical lines

abline(h=700,col="blue")
abline(v=1985,lty="dotted")
abline(a=fit1$coefficients[1],b=fit1$coefficients[2],col="green")

#~~ finally, we can add some text to the plot giving the R2 value and the P value using "text"
#   Specify the x and y coordinates for the text

text(x=1974,y=750,labels="R2 = 0.896\nP = 2.615e-15")

#~~ FINAL PLOT Script

plot(moomins$Year, moomins$PopSize,                              # x variable, y variable
     type = "l",                                                 # draw a line graphs
     col = "red",                                                # red line colour
     lwd = 3,                                                    # line width of 3
     xlab = "Year",                                              # x axis label
     ylab = "Population Size",                                   # y axis label
     main = "Moomin Population Size on Ruissalo 1971 - 2001")    # plot title

fit1 <- lm (PopSize ~ Year, data = moomins)             # carry out a linear regression
abline(fit1, lty = "dashed")                            # add the regression line to the plot
text(x=1974,y=750,labels="R2 = 0.896\nP = 2.615e-15")   # add a label to the plot at coordinates (x,y)


#~~~ Which customisations did we learn in this section?

# plot
# type
# lty
# lwd
# col
# abline
# text

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#    3. Scatterplot with Legend             #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# R comes with many datasets preinstalled.
# Let's load a dataset of Flower characteristics in 3 species of Iris.

data(iris)
head(iris)

# There is a lot of data here! Let's explore using the 'pairs' function

pairs(iris)

# This doesn't tell us much about the species differences. We can tell R
# to plot using a different colour for the three species of iris:

pairs(iris, col = iris$Species)


#~~ Sepal.Length and Petal.Length look interesting! Let's start by looking at that.
#   Again, we will specify colour as the Species.

plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species)

# These points are difficult to see! Let's pick some different ones using "pch"

plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species, pch = 15)
plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species, pch = "A")

# pch 21:25 also specify an edge colour (col) and a background colour (bg)

plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species, pch = 21, bg = "blue")

# lets settle on solid circles (pch = 16)

plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species, pch = 16)

# we can change the size of the points with "cex"

plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species, pch = 16, cex = 2)

#~~ It's difficult to tell these points apart, so perhaps we should make a legend.
#   This is one of the major drawbacks with R.
#   iris$Species is a factor, and R will automatically order factors in alphabetical order.

levels(iris$Species)

# Therefore, setosa, versicolor and virginica will correspond to 1, 2 and 3 on the 
# plot default colours. Keep this in mind for the next part!

legend(x = 4.5, y = 7, legend = levels(iris$Species), col = c(1:3), pch = 16)

# FINAL PLOT

plot(iris$Sepal.Length, iris$Petal.Length,        # x variable, y variable
     col = iris$Species,                          # colour by species
     pch = 16,                                    # type of point to use
     cex = 2,                                     # size of point to use
     xlab = "Sepal Length",                       # x axis label
     ylab = "Petal Length",                       # y axis label
     main = "Flower Characteristics in Iris")     # plot title

legend (x = 4.5, y = 7, legend = levels(iris$Species), col = c(1:3), pch = 16)
# legend with titles of iris$Species and colours 1 to 3, point type pch at coords (x,y)

#~~~ Which customisations did we learn in this section?

# pch
# bg
# cex
# legend


# SIDE NOTE 1: specifying colours:
#  It is also possible to specify colours in your data frame.

iris$Colour <- ""
iris$Colour[iris$Species=="setosa"] <- "magenta"
iris$Colour[iris$Species=="versicolor"] <- "cyan"
iris$Colour[iris$Species=="virginica"] <- "yellow"

plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Colour, pch = 16, cex = 2)
legend(x = 4.5, y = 7, legend = c("setosa","versicolor","virginica"),col=c("magenta","cyan","yellow"), pch=16)

# SIDE NOTE 2:
# It would also be possible to specify lines in the legend by using "lty" instead of "pch"

plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species, pch = 16, cex = 2)
legend(4.5,7,legend=c("setosa","versicolor","virginica"),col=c(1:3),lty="solid")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#    4. Boxplots with reordered and formatted axes        #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

#~~ We will continue to use the Iris dataset for this section

head(iris)

#~~ lets examine the distribution of Sepal Length for each species

boxplot(iris$Sepal.Length ~ iris$Species)

#~~ If you wish to compare the medians of the boxplot, you can use the function "notch".
#   If the notches of two plots do not overlap, this is 'strong evidence' that the two 
#   medians differ (see ?boxplot)

boxplot(iris$Sepal.Length ~ iris$Species, notch = T)

# You may have noticed that the y-axis labels are always orientated to be perpendicular to
# the axis. We can rotate all axis labels using "las". Play around with different values.

boxplot(iris$Sepal.Length ~ iris$Species, notch = T, las = 1)

#~~ Let's add in all the axis and plot labels:

boxplot(iris$Sepal.Length ~ iris$Species, notch = T, las = 1,
        xlab = "Species", ylab = "Sepal Length", main = "Sepal Length by Species in Iris")        

#~~ Like we can change the size of the points in the scatterplot, we can change the size
#   of the axis labels and titles. Let's start with "cex.lab", which controls the axis titles:

boxplot(iris$Sepal.Length ~ iris$Species, notch = T, las = 1,
        xlab = "Species", ylab = "Sepal Length", main = "Sepal Length by Species in Iris",
        cex.lab=1.5)

#~~ Now we can add in "cex.axis" (changing the tickmark size) and "cex.main" (changing the 
#   plot title size)

boxplot(iris$Sepal.Length ~ iris$Species, notch = T, las = 1,
        xlab = "Species", ylab = "Sepal Length", main = "Sepal Length by Species in Iris",
        cex.lab = 1.5,
        cex.axis = 1.5,
        cex.main = 2)

#~~ As we discussed earlier, R automatically puts factors in alphabetical order. But perhaps
#   we would prefer to list the iris species as virginica, versicolor and setosa.

# First lets look at the levels of iris:
data(iris)
levels(iris$Species)

# we reorder them with the following command:

iris$Species<-factor(iris$Species, levels = c("virginica","versicolor","setosa"))

#~~ FINAL PLOT

boxplot(iris$Sepal.Length ~ iris$Species,              # x variable, y variable
        notch = T,                                     # Draw notch
        las = 1,                                       # Orientate the axis tick labels
        xlab = "Species",                              # X-axis label
        ylab = "Sepal Length",                         # Y-axis label
        main = "Sepal Length by Species in Iris",      # Plot title
        cex.lab = 1.5,                                 # Size of axis labels
        cex.axis = 1.5,                                # Size of the tick mark labels
        cex.main = 2)                                  # Size of the plot title

#~~~ Which customisations did we learn in this section?

# boxplot
# notch
# las
# cex.lab
# cex.axis
# cex.main

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#   5. Barplot  with error bars                       #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# ~~ Let's create a new data frame with information on three populations of dragon in the UK:
#    Working with summaries, rather than the whole data, is a bit easier with this function.
dragons <- data.frame(
  TalonLength = c(20.9, 58.3, 35.5),
  SE = c(4.5, 6.3, 5.5),
  Population = c("England", "Scotland", "Wales"))

# Have a look at the data:

dragons

# Let's make our barplot.

barplot(dragons$Population, dragons$TalonLength)

# It would be better to add Titles to the x-axis:

barplot(dragons$TalonLength, names = dragons$Population)

# would a box look better around this plot?

box()

# not really. Let's start again:

barplot(dragons$TalonLength, names = dragons$Population)

# Let's reorder the columns by how beautiful the dragon habitat is (from best to worst).
# Naturally, this order is 'Scotland, Wales, England'.

levels(dragons$Population)

dragons$Population <- factor(dragons$Population, levels=c("Scotland","Wales","England"))

barplot(dragons$TalonLength, names = dragons$Population)

# No.... it's not working. I give up for now. What about error bars?

# This is as far as I got before I gave up:

install.packages("gplots")
library(gplots)
barplot(dragons$TalonLength, names = dragons$Population, 
        ylim=c(0,70),xlim=c(0,4),yaxs='i', xaxs='i',
        main="Dragon Talon Length in the UK",
        ylab="Mean Talon Length",
        xlab="Country")
par(new=T)
plotCI (dragons$TalonLength, 
        uiw = dragons$SE, liw = dragons$SE,
        gap=0,sfrac=0.01,pch="",
        ylim=c(0,70),
        xlim=c(0.4,3.7),
        yaxs='i', xaxs='i',axes=F,ylab="",xlab="")
box()

# Lets deal with this in ggplot2!

#~~ FINAL PLOT

# Do it in ggplot2!


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#   Final words in base graphics            #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#   6. More than one plot in a window         #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

par(mfrow=c(1,2))      # number of rows, number of columns

plot(iris$Sepal.Length, iris$Petal.Length,        # x variable, y variable
     col = iris$Species,                          # colour by species
     main = "Sepal vs Petal Length in Iris")      # plot title

plot(iris$Sepal.Length, iris$Sepal.Width,         # x variable, y variable
     col = iris$Species,                          # colour by species
     main = "Sepal Length vs Width in Iris")      # plot title

par(mfrow=c(1,1))     # sets the plot window back to normal

# OR

dev.off()      # But this will clear your plot history.

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#  7. Saving a Plot                         #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# png

png("Sepal vs Petal Length in Iris.png", width = 500, height = 500, res = 72)

plot(iris$Sepal.Length, iris$Petal.Length,
     col = iris$Species,
     main = "Sepal vs Petal Length in Iris")

dev.off()


# pdf

pdf("Sepal vs Petal Length in Iris.pdf")

plot(iris$Sepal.Length, iris$Petal.Length,
     col = iris$Species,
     main = "Sepal vs Petal Length in Iris")

dev.off()


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#   8. par()                                #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

plot(moomins$Year, moomins$PopSize, type="l")
boxplot(iris$Sepal.Length ~ iris$Species)


par(col=2,pch=16,las=1,lty="dotted")

plot(moomins$Year, moomins$PopSize, type="l")
boxplot(iris$Sepal.Length ~ iris$Species)

dev.off()

plot(moomins$Year, moomins$PopSize, type="l")
boxplot(iris$Sepal.Length ~ iris$Species)



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#   9. Examples for the plot functions in R Base Graphics   #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

example(plot)
example(barplot)
example(boxplot)
example(coplot)
example(hist)
example(fourfoldplot)
example(stars)
example(image)
example(contour)
example(filled.contour)
example(persp) 

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#   10. Trellis plots using library(lattice)    #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# scatterplots for each combination of two factors 

library(lattice)

xyplot(iris$Petal.Length ~ iris$Sepal.Length | iris$Species, layout = c(3,1))

histogram( ~ unicorns$birthweight | unicorns$sex, layout = c(1,2))

