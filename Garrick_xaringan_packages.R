install.packages("xaringan")
install.packages("babynames")

if (!requireNamespace("devtools", quietly = TRUE)) {
  stop("Please install the devtools package: install.packages('devtools')")
}

devtools::install_github("gadenbuie/xaringanthemer@dev", dependencies = TRUE)
devtools::install_github("gadenbuie/xaringanExtra", dependencies = TRUE)
devtools::install_github("gadenbuie/metathis", dependencies = TRUE)

