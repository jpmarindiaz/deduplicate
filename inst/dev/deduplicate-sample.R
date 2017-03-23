
devtools::install()


library(deduplicate)

customers <- read_csv(system.file("data/customers.csv",package = "deduplicate"))
customers2 <- read_csv(system.file("data/customers2.csv",package = "deduplicate"))

names(customers)
id_cols <- c("first_name","document_number")
d <- customers

add_row_id(d)
d$uid <- paste0("uid",1:nrow(x))
add_row_id(d, id = "uid")
add_row_id(d, id = "first_name")

dids <- create_idcols(d, id_cols)
dids <- create_idcols(d, id_cols, idName = "idPerson")

dids <- create_idcols(d, id_cols, id = "uid")
dids <- create_idcols(d, id_cols, id = "first_name")

dids <- create_idcols(d, id_cols, keepCols = TRUE, idName = "idPerson")
dids <- create_idcols(d, id_cols, id = "uid")
dids <- create_idcols(d, id_cols, id = "uid", keepCols = TRUE)

duids <- add_unique_id(d, "first_name")
duids <- add_unique_id(d, "age", uidName = "ageId")

duids <- add_unique_id(dids, "custom_id")
duids <- add_unique_id(dids, "first_name")
duids <- add_unique_id(dids, "age")

dapproxuid0 <- add_approx_unique_id(d,"first_name",max_dist = 0)
dapproxuid10 <- add_approx_unique_id(d,"first_name",max_dist = 0.1)
dapproxuid20 <- add_approx_unique_id(d,"first_name",max_dist = 0.2)
dapproxuid30 <- add_approx_unique_id(d,"first_name",max_dist = 0.3)
dapproxuid50 <- add_approx_unique_id(d,"first_name",max_dist = 0.5)


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

dold <- customers
dnew <- customers2

id_cols <- c("last_name","document_type","city")

isnew <- new_or_dup(dnew,dold,id_cols = id_cols, max_dist = 0)
isnew <- new_or_dup(dnew,dold,id_cols = id_cols, max_dist = 0.2)












