
devtools::install()


library(deduplicate)
library(tidyverse)
library(fuzzyjoin)
library(purrrlyr)

customers <- read_csv(system.file("data/customers.csv",package = "deduplicate"))
customers2 <- read_csv(system.file("data/customers2.csv",package = "deduplicate"))

names(customers)
id_cols <- c("first_name","document_number")
d <- customers

####





v <- c("aaaa","bafdsa","caddsaa")
str_dist(v)






dapproxuid0 <- add_approx_unique_id(d,"first_name",max_dist = 0)
dapproxuid10 <- add_approx_unique_id(d,"first_name",max_dist = 0.1)
dapproxuid20 <- add_approx_unique_id(d,"first_name",max_dist = 0.2)
dapproxuid30 <- add_approx_unique_id(d,"first_name",max_dist = 0.3)
dapproxuid50 <- add_approx_unique_id(d,"first_name",max_dist = 0.5)


# Find approximate duplicates

dups <- get_approx_dup_ids(customers,id_cols = id_cols, max_dist = 0)
dups <- get_approx_dup_ids(customers,id_cols = id_cols,
                           id = "uid", max_dist = 0)
dups <- get_approx_dup_ids(d,id_cols = id_cols,
                           id = "uid", max_dist = 0)
dups <- get_approx_dup_ids(d,id_cols = id_cols,
                           id = "uid", max_dist = 0, asList = TRUE)

dups <- get_approx_dup_ids(customers,id_cols = id_cols, max_dist = 0,
                           asList = TRUE)

dups <- get_approx_dup_ids(customers,id_cols = id_cols, max_dist = 0.12)
dups <- get_approx_dup_ids(customers,id_cols = id_cols,
                           max_dist = 0.12, asList = TRUE)

dups <- get_approx_dups(customers,id_cols = id_cols, max_dist = 0)
dups <- get_approx_dups(customers,id_cols = id_cols, max_dist = 0.12)

## Old and new records

dold <- customers
dnew <- customers2

id_cols <- c("last_name","document_type","city")
isnew <- new_or_dup(dnew,dold,id_cols = id_cols, max_dist = 0)
isnew <- new_or_dup(dnew,dold,id_cols = id_cols, max_dist = 0.2)

## Exclusive ids

d <- data_frame(
  r = 1:10,
  g1 = c('x','x','y','y','y','z','w','w','w','u'),
  g2 = c('a','a','b','b','c','c','d','d','d','e'),
  c = letters[1:10]
)
ids <- c('g1','g2')

exclusive_ids(x, ids = c("g1","g2"), .row_id = "r")
exclusive_ids(x, ids = c("g1","g2"), keepCols = FALSE)
exclusive_ids(x, ids = c("g1","g2"), .row_id = "r", keepCols = FALSE)
exclusive_ids(x, ids = c("g1","g2"), .row_id = "r", keepCols = TRUE)









