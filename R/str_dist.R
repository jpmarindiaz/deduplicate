

#' @export
str_dist <- function(v){
  dit <- stringdist::stringdistmatrix(v, method = "jw")
  x <- broom::tidy(dit)
  # x <- x %>%
  #   mutate(item1 = v[item1], item2 = v[item2]) %>%
  #   select(item1, item2, distance)
  x
}



