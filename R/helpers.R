

create_idcols <- function(d, id_cols, noAccents = TRUE, lowerCase = TRUE){
    if(!all(id_cols %in% names(d)))
      stop("All id_cols must be in d")
    d1 <- d[id_cols]
    d1[is.na(d1)] <- ""
    if(noAccents)
      d1 <- map_df(d1,remove_accents)
    if(lowerCase)
      d1 <- map_df(d1,tolower)
    d1 <- bind_cols(d[".row_id"],d1)
    d1 <- unite_(d1,"custom_id",id_cols)
    #customId <- d1[id_cols] %>% by_row(paste,collapse = "_",.collate = "cols") %>% .$.out
    #d2$customId <- customId
    d1
}

create_row_id <- function(d,id= NULL){
  if(is.null(id)){
    #dname <- deparse(substitute(d))
    id <- data_frame(.row_id = 1:nrow(d))
    d <- bind_cols(id,d)
  }else{
    if(!length(unique(d %>% .$id)) == nrow(d))
      stop("id provided not unique")
    else
      d$.row_id <- d$id
  }
  d
}

remove_accents <- function(string){
  accents <- "àèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝäëïöüÄËÏÖÜâêîôûÂÊÎÔÛñÑç"
  translation <- "aeiouAEIOUaeiouyAEIOUYaeiouAEIOUaeiouAEIOUnNc"
  chartr(accents, translation, string)
}

