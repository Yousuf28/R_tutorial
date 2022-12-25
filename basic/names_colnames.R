
library(data.table)
df <- data.frame(x=1:5, y=6:10, z=11:15)

df
str(df)
dimnames(df)
attributes(df)

vec <- c(1:5)
names(vec) <- c(letters[1:5])
dimnames(vec)
str(vec)

vec_col <- c(1:5)
colnames(vec_col) <- c(letters[1:5])
# does not work for one dimension

df
dimnames(df)
names(df) <- c('A', 'B', 'C')
dimnames(df)
str(df)
attributes(df)

mat <- matrix(1:16, 4,4)
mat
attributes(mat)

names(mat) <- c(letters[1:4])

# does not work names

colnames(mat) <- c(letters[1:4])

mat <- matrix(1:16, 4,4)
mat
attributes(mat)
colnames(mat) <- c(letters[1:4])
attributes(mat)
rownames(mat) <- c(LETTERS[1:4])
attributes(mat)
str(mat)
str(df)
attributes(df)

dt <- as.data.table(df)
dt
attributes(dt)

attributes(df)

rownames(df) <- c(LETTERS[1:5])
attributes(df)
dt <- as.data.table(df)
dt
attributes(dt)
rownames(dt) <- c(letters[1:5])
attributes(dt)
