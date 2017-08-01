context("deduplicate")

test_that("Create Uid", {


  customers <- read_csv(system.file("data/customers.csv",package = "deduplicate"))
  #customers2 <- read_csv(system.file("data/customers2.csv",package = "deduplicate"))

  names(customers)
  id_cols <- c("first_name","document_number")
  d <- customers

  # helper funs

  # Create uid
  duid <- add_row_id(d)

  expect_error(add_row_id(d, id = ".row_id"))
  duid <- add_row_id(d, idName = "UID")
  expect_equal(names(duid)[1], "UID")
  expect_error(add_row_id(d, id = "first_name"),"id provided not unique")

  id_cols <- c("first_name","document_number")

  # create a custom id called .custom_id
  dids <- create_idcols(customers, id_cols)
  expect_equal(dids$.row_id, 1:nrow(dids))
  expect_equal(names(dids), c(".row_id",".custom_id"))

  dids <- create_idcols(d, id_cols, idName = "clusters")
  expect_equal(names(dids)[2], "clusters")

  dids <- create_idcols(d, id_cols, keepCols = TRUE, idName = "idPerson")
  expect_true(all(names(d) %in% names(dids)))

  # Add unique id

  duids <- add_unique_id(d, "first_name")
  expect_equal(length(unique(duids$first_name)), length(unique(duids$.unique_id)))
  duids <- add_unique_id(d, "age", uidName = "ageId")
  expect_equal(length(unique(duids$age)), length(unique(duids$ageId)))

})




context("String dist")

test_that("Create Uid", {

  customers <- read_csv(system.file("data/customers.csv",package = "deduplicate"))
  id_cols <- c("first_name","document_number")
  d <- customers

  get_approx_dup_ids(d, id_cols, max_dist = 0)

  dup <- get_approx_dup_ids(d, id_cols, max_dist = 1)
  expect_true(length(unique(dup$.new_id)))
  expect_error(get_approx_dup_ids(d),"id provided not unique")


  get_approx_dup_ids

})






