
#' add_unique_id
#' Find possible duplicates
#' @name add_unique_id
#' @param x A number.
#' @param y A number.
#' @export
#' @return The sum of \code{x} and \code{y}.
#' @examples
#' add(1, 1)
add_unique_id <- function(d, col, uidName = NULL, uidPrefix = NULL){
  uidName <- uidName %||% ".unique_id"
  dic <- d[col] %>% distinct()
  dic[uidName] <- 1:nrow(dic)
  if(!is.null(uidPrefix))
    dic[uidName] <- paste0(uidPrefix,dic[uidName])
  x <- right_join(d,dic, by = col)
  move_first(x,uidName)
}


#' create_idcols
#' Find possible duplicates
#' @name create_idcols
#' @param x A number.
#' @param y A number.
#' @export
#' @return The sum of \code{x} and \code{y}.
#' @examples
#' add(1, 1)
create_idcols <- function(d, id_cols, id = NULL, keepCols = FALSE, noAccents = TRUE, lowerCase = TRUE){
  if(!all(id_cols %in% names(d)))
    stop("All id_cols must be in d")
  d1 <- d[id_cols]
  d1[is.na(d1)] <- ""
  if(noAccents)
    d1 <- map_df(d1,remove_accents)
  if(lowerCase)
    d1 <- map_df(d1,tolower)
  d1 <- unite_(d1,"custom_id",id_cols)
  d <- add_row_id(d, id = id)
  d2 <- bind_cols(d[".row_id"],d1)
  if(keepCols)
    d2 <- bind_cols(d2,d %>% select(-.row_id))
  d2
}


