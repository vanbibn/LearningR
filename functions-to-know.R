strinstalled.packages() #check what packages are installed
library()
old.packages() #check what packages need to update

version
sessionInfo()
help() # shortcut is to just use ? at start of line
help.search("") # searches through R's documentation (?? is shortcut)
help(package = 'ggplot2')
browseVignettes('ggplot2')

str() #displays the internal structure of any R object
example() # runs code from Examples section of Help

vector('numeric', length = 10) #creates a numeric vector of length 10 (default value is 0)

#ways to create a matrix:
m1 <- matrix(1:6, nrow = 2,ncol = 3) #filled collumn-wise
m2 <- 1:10
dim(m2) <- c(2,5)
x4 <- 1:3
y4 <- 10:12
cbind(x4,y4)
rbind(x4,y4)
