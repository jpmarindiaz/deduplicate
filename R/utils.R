

match_replace <- function (v, dic, force = TRUE)
{
  matches <- dic[[2]][match(v, dic[[1]])]
  out <- matches
  if (!force)
    out[is.na(matches)] <- v[is.na(matches)]
  out
}
