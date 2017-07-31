

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
  dnew <- add_row_id(dnew, id = id)
  dnew <- create_idcols(dnew, id_cols)
  dold <- add_row_id(dold, id = id)
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

#' add_approx_unique_id
#' Add an approximate unique id to rows for a given column
#' @name add_approx_unique_id
#' @param x A number.
#' @param y A number.
#' @export
#' @return The sum of \code{x} and \code{y}.
#' @examples
#' add(1, 1)
add_approx_unique_id <- function(d, col,id=NULL, max_dist = 0.1, uidName = NULL, uidPrefix = NULL){
  uidName <- uidName %||% ".unique_id"
  d1 <- create_idcols(d, col, id = id, keepCols = TRUE)
  dic <- distinct(d1,custom_id,.keep_all = FALSE)
  if(max_dist != 0){
    dups <- stringdist_left_join(dic,d1, by = "custom_id",
                                 method = "jw",max_dist = max_dist) %>%
      select(custom_id = custom_id.x, .row_id)
  }else{
    dups <- left_join(dic,d1, by = "custom_id")
  }
  x <- dups %>%
    arrange(.row_id,custom_id) %>%
    group_by(.row_id) %>%
    summarise(members = paste0(custom_id,collapse = "-")) %>%
    add_unique_id(col = "members",uidName = NULL) %>%
    select(.row_id,.unique_id)
  d2 <- left_join(d1,x, by = ".row_id")
  if(!is.null(uidPrefix))
    d2 <- d2 %>% mutate(.unique_id=paste0(uidPrefix,.unique_id))

  d2 <- d2 %>%
    rename_(.dots = setNames(".unique_id", uidName)) %>%
    move_first(uidName)
  d2$.row_id <- NULL
  d2
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
                                 max_dist = max_dist, asList = FALSE)
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
get_approx_dup_ids <- function(d, id_cols, id = NULL,
                               max_dist = 0.1, asList = FALSE){
  d1 <- create_idcols(d, id_cols, id)
  dic <- distinct(d1,custom_id,.keep_all = FALSE)
  if(max_dist != 0){
    dups <- stringdist_left_join(dic,d1, by = "custom_id",
                                 method = "jw",max_dist = max_dist) %>%
      select(custom_id = custom_id.x, .row_id)
  }else{
    dups <- left_join(dic,d1,by = "custom_id")
  }
  dupsDf <- dups %>%
    group_by(custom_id) %>%
    filter(n()>1) %>%
    select(custom_id,.row_id) %>%
    slice_rows("custom_id") %>%
    by_slice(function(x) x$.row_id, .collate="list",.to = ".row_id")
  if(asList){
    dupsList <- dupsDf %>% .$.row_id
    names(dupsList) <- dupsDf$custom_id
    dupsList
    return(dupsList)
  }
  unnest(dupsDf)
}




