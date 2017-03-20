context("deduplicate")

test_that("Create Dic", {

  customers <- read_csv(system.file("data/customers.csv",package = "deduplicate"))
  expect_error(get_approx_dup_ids(customers, id = "first_name"),"id provided not unique")

})




