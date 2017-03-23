
move_first <- function(d,name){
  d[c(name, names(d)[names(d) != name])]
}


add_row_id <- function(d,id = NULL){
  if(".row_id" %in% names(d))
    return(d)
  if(is.null(id)){
    #dname <- deparse(substitute(d))
    id <- data_frame(.row_id = 1:nrow(d))
    d <- bind_cols(id,d)
  }else{
    if(!nrow(d[id] %>% distinct()) == nrow(d))
      stop("id provided not unique")
    else
      d <- d %>% mutate_(.row_id = id) %>% select(.row_id, everything())
  }
  d
}

remove_accents <- function(string){
  accents <- "àèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝäëïöüÄËÏÖÜâêîôûÂÊÎÔÛñÑç"
  translation <- "aeiouAEIOUaeiouyAEIOUYaeiouAEIOUaeiouAEIOUnNc"
  chartr(accents, translation, string)
}

