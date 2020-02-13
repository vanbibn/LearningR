getwd()
list.files('hw/diet_data')
andy <- read.csv('hw/diet_data/Andy.csv')

files_full <- list.files("hw/diet_data", full.names = TRUE)

## First approach ===========

# dat4 <- data.frame()
# 
# for (i in 1:length(files_full)) {
#         dat4 <- rbind(dat4, read.csv(files_full[i]))
# }

## Better approach =====================

summary(files_full)
# this is the same as using lapply()!
# tmp <- vector(mode = "list", length = length(files_full))
# summary(tmp)
# 
# for (i in seq_along(files_full)) {
#         tmp[[i]] <- read.csv(files_full[[i]])
# }
# str(tmp)

tmp <- lapply(files_full, read.csv)
str(tmp)

output <- do.call(rbind, tmp)
str(output)
