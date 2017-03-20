
devtools::install()


library(deduplicate)

customers <- read_csv(system.file("data/customers.csv",package = "deduplicate"))
customers2 <- read_csv(system.file("data/customers2.csv",package = "deduplicate"))

get_approx_dup_ids(customers, id = "first_name")

names(customers)
id_cols <- c("first_name","document_number")
d <- customers

dups <- get_approx_dup_ids(customers,id_cols = id_cols, max_dist = 0)
dups <- get_approx_dup_ids(customers,id_cols = id_cols, max_dist = 0.12)

dups <- get_approx_dups(customers,id_cols = id_cols, max_dist = 0)
dups <- get_approx_dups(customers,id_cols = id_cols, max_dist = 0.12)

dold <- customers
dnew <- customers2

id_cols <- c("last_name","document_type","city")

isnew <- new_or_dup(dnew,dold,id_cols = id_cols, max_dist = 0)
isnew <- new_or_dup(dnew,dold,id_cols = id_cols, max_dist = 0.2)












