# 
library(readr)
library(stringr)

# paste in temporary url fro PONDR-FIT data
u <- url("http://original.disprot.org/temp/1582165344.182021.pondrfit")
fit <- readLines(u)
close(u)

#remove header row and extra spaces between and before "columns"
fit1 <- fit[2:length(fit)]
fit1 <- gsub("\\s+", " ", str_trim(fit1))


df1 <- strsplit(fit1, " ") # makes a list not a df
df2 <- as.data.frame(str_split(fit1, " ")) #makes a df but wrong orientation
m1 <- as.matrix(str_split(fit1, " ")) #str_split must still make it a list
