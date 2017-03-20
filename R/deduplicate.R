

#' new_or_dup
#' Find if new or duplicate records
#' @name new_or_dup
#' @param x A number.
#' @param y A number.
#' @export
#' @return The sum of \code{x} and \code{y}.
#' @examples
#' add(1, 1)
new_or_dup <- function(dnew, dold, id_cols,id=NULL, max_dist = 0.1){
  if(!identical(sort(names(dnew)),sort(names(dold))))
    stop("Same structure needed for new and old data frames")
  dnew <- create_row_id(dnew, id = id)
  dnew <- create_idcols(dnew, id_cols)
  dold <- create_row_id(dold, id = id)
  dold <- create_idcols(dold, id_cols)
  if(max_dist != 0){
    dups <- stringdist_left_join(dnew,dold, by = "custom_id",
                                 method = "jw",
                                 max_dist = max_dist) %>%
      distinct() %>%
      select(custom_id = custom_id.x, .row_id = .row_id.x,
             match_id = .row_id.y, match = custom_id.y)
  }else{
    dups <- left_join(dnew,dold, by = "custom_id") %>%
      select(.row_id = .row_id.x, custom_id = custom_id, match_id = .row_id.y)
  }
  newdup <- dups %>% mutate(is_new = ifelse(is.na(match_id),"new","duplicate"))
  newdup
}



#' get_approx_dups
#' Find possible duplicates
#' @name approx_dup
#' @param x A number.
#' @param y A number.
#' @export
#' @return The sum of \code{x} and \code{y}.
#' @examples
#' add(1, 1)
get_approx_dups <- function(d, id_cols,id=NULL, max_dist = 0.1){
  dups <- get_approx_dup_ids(d, id_cols = id_cols, id = id,
                                 max_dist = max_dist, as.list = FALSE)
  dups <- unnest(dups)
  d$.row_id <- 1:nrow(d)
  left_join(dups,d, by = c(".row_id"=".row_id"))
}


#' get_approx_dup_ids
#' Find possible duplicates
#' @name approx_dup
#' @param x A number.
#' @param y A number.
#' @export
#' @return The sum of \code{x} and \code{y}.
#' @examples
#' add(1, 1)
get_approx_dup_ids <- function(d, id_cols,id=NULL, max_dist = 0.1, as.list = TRUE){
  d <- create_row_id(d, id = id)
  d1 <- create_idcols(d, id_cols)
  dic <- distinct(d1,custom_id,.keep_all = FALSE)
  if(max_dist != 0){
    dups <- stringdist_left_join(dic,d1,method = "jw",max_dist = max_dist) %>%
      select(custom_id = custom_id.x, .row_id)
  }else{
    dups <- left_join(dic,d1)
  }
  dupsDf <- dups %>%
    group_by(custom_id) %>%
    filter(n()>1) %>%
    select(custom_id,.row_id) %>%
    slice_rows("custom_id") %>%
    by_slice(~.$.row_id, .collate="list",.to = ".row_id")
  if(as.list){
    dupsList <- dupsDf %>% .$.row_id
    names(dupsList) <- dupsDf$custom_id
    dupsList
    return(dupsList)
  }
  dupsDf
}




