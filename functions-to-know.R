# Functions to Know as Learning R #############################################

## Packages ===================================================================
strinstalled.packages() #check what packages are installed
library()
old.packages() #check what packages need to update

## Session Info and Help ======================================================
version
sessionInfo()
help() # shortcut is to just use ? at start of line
help.search("") # searches through R's documentation (?? is shortcut)
help(package = 'ggplot2')
browseVignettes('ggplot2')

str() #displays the internal structure of any R object
example() # runs code from Examples section of Help

vector('numeric', length = 10) #creates vector (0 is default value)

### Ways to create a matrix: --------------------------------------------------
m1 <- matrix(1:6, nrow = 2,ncol = 3) #filled collumn-wise
m2 <- 1:10
dim(m2) <- c(2,5)
x4 <- 1:3
y4 <- 10:12
cbind(x4,y4)
rbind(x4,y4)

### Reading tabular data  -----------------------------------------------------
?read.table # read this help page --Memorize!- optimize how read large datasets
  #Eg. optimize: comment.char, nrows, colClasses
  # how much memory needed to read in = (#row * #col * 8bytes)/(2^30 bytes/GB)
    #double to account for overhead in reading data in
  # Know your: OS, memory size, 64/32bit, other apps open or users logged in)

## Workspace and Files =======================================================
getwd()
dir.create('testdir')
setwd("testdir")
file.create("mytest.R")
list.files()
file.exists('mytest.R')

  # before running a program that loops through a series of files 
  # you will want to first check to see if each file exists 

file.info('mytest.R')  #use $ to grab spec field eg.| file.info("mytest.R")$mode

# construct file and directory paths that are independent of the operating sys
dir.create(file.path('testdir2','testdir3'), recursive = TRUE)

# It is helpful to save the initial settings before you began an analysis and 
# go back to them at the end. -- This trick is often used within functions too.
# "Take nothing but results. Leave nothing but assumptions."


## Sequences of Numbers =======================================================
1:20
?`:`  # `backtick` key is above Tab
seq(1,20)
seq(0,10,0.5)
my_seq <- seq(5,10, length.out = 30)
length(my_seq)
1:length(my_seq)
seq(along = my_seq)
seq_along(my_seq)
rep(0, times = 40)
rep(c(0,1,2), times = 10)
rep(c(0,1,2), each = 10)

## Vectors ====================================================================

num_vect <- c(0.5,55,-10,6)
tf <- num_vect < 1

#logicls
(3 > 5) & (4 == 4)
(TRUE == TRUE) | (TRUE == FALSE) # | = OR
((111 >= 111) | !(TRUE)) & ((4 + 1) == 5)

# character vectors
my_char <- c("My","name","is")
paste(my_char, collapse = " ")
my_name <- c(my_char, "Nathan")
paste(my_name, collapse = " ")
paste('Hello','world!', sep = ' ')
paste(1:3,c('X','Y','Z'), sep = "")


## Missing Values =============================================================

  # NA is used to represent any value that is 'not available' or 'missing'
  # NA is not a value, it is placeholder for a quantity that is not available. 
    # Therefore the logical expressions will not work as expected!!
  # R represents TRUE as 1 and FALSE as 0 so... 
    # sum of a bunch of TRUEs and FALSEs = total number of TRUEs.


x <- c(44, NA, 5, NA)
x * 3

y <- rnorm(1000)
z <- rep(NA, 1000)
# take a random sample of numbers and NA's
my_data <- sample(c(y,z), 100)
my_na <- is.na(my_data)
sum(my_na) # counts num of TRUE's ie. # NA values

# use subsetting to remove missing values from my_data
my_data[!my_na]


# NaN stands for "not a number"
0/0
Inf - Inf

## Subsetting Vectors ========================================================

# to select a subset of elements use an 'index vector' in [] after vname
# 4 diff flavors of index vectors: logical, (+ or -)integers, character strings

x[1:10]
x[!is.na(x)]
x[!is.na(x) & x > 0]
x[c(3,5,7)]
x[-c(2,10)] # all except index 2 and index 10 == x[c(-2,-10)]

# create a vector with named elements
vect <- c(foo = 11, bar = 2, norf = NA)
vect2 <- c(11,2,NA)
names(vect2) <- c("foo", "bar", "norf") # names can be added after the fact
identical(vect,vect2)
vect2["bar"]
vect[c("foo", "bar")]


## Matrices and Data Frames  ==================================================

my_vector <-  1:20
dim(my_vector)
length(my_vector)
dim(my_vector) <- c(4,5)
dim(my_vector)
attributes(my_vector)
class(my_vector)
my_data <- data.frame(patients, my_matrix)
cnames <- c("patient", "age", "weight", "bp", "rating", "test")
colnames(my_data) <- cnames

good <- complete.cases()




