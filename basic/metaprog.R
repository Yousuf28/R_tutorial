library(rlang)
library(lobstr)

x <- base::expression(a+b)
x


class(x)
a <- 1
b <- 2
eval(x)

y <- base::expression("a+b")
y
eval(y)

y_string <- "a+b"

par_y <- base::parse(text=y_string)
par_y


eval(par_y)

par_y


char_y <- base::deparse(par_y)
char_y

class(char_y)

# base:quote() or rlang::expr() prevent evaluation of R code.
# The defusing operator expr() is similar to quote().
# Like bquote(), it allows forcing  evaluation of parts of an expression.

q <- base::quote(c+d) # rlang expr
q
q_lang <- rlang::expr(e+f)
q_lang

c <- 1
d <- 3
e <- 4
f <- 6

eval(q)
eval(q_lang)
class(q)
class(q_lang)



# The argument-defusing operator rlang::enquo() is similar to base::substitute()

# expr vs quote

(e1 <- quote(sin(x+y)))
# sin(x + y)
e1[[1]]
e1[[2]]
str(e1)
(e2 <- expression(sin(x+y)))
# expression(sin(x + y))

# language sin(x + y)
str(e2)
e2[[1]]
# expression(sin(x + y))
str(e2[[1]])
# language sin(x + y)
all.equal(e1, e2)
# [1] "Modes of target, current: call, expression" "target, current do not match when deparsed"
all.equal(e1, e2[[1]])
# [1] TRUE


(e1 <- quote(sin(x+y)))
(e2 <- expression(sin(x+y)))

e2[[1]]

# parse

(dp_e1 <- deparse(e1))

(p_e1 <- parse(text = dp_e1))


################################
#rlang and dplyr
data_mean <- function(data,var) {
    require(dplyr)
    var <- rlang::enquo(var)
    data %>% 
        dplyr::summarise(mean=mean(!!var))
}

data_mean(mtcars,mpg)

####
data_mean_base <- function(data,var) {
    require(dplyr)

    var <- base::substitute(var)
    data %>% 
        dplyr::summarise(mean=mean(!!var))
}

data_mean_base(mtcars,mpg)

#### base

data_mean <- function(data,var,var2) {
    require(dplyr)
    var <- base::substitute(var)
    var2 <- base::substitute(var2)
    ind <- which(data[[var2]]==4)
    df <- data[ind,]
    df
  
}

data_mean(mtcars,mpg,cyl)

##### new way in dplyr

data_mean <- function(data,var) {
    require(dplyr)
    
    data %>% 
        dplyr::summarise(mean=mean({{var}}))
}

data_mean(mtcars,mpg)

boomer::boom({
    mtcars %>% arrange(cyl) %>% 
        dplyr::group_by(cyl) %>%
        dplyr::summarise(mean(mpg))
    })

library(data.table)
dt <- as.data.table(mtcars)

boomer::boom({
    dt[, mean(mpg),by=.(cyl)]
}
)
