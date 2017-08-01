install.packages("stringdist")
library(stringdist)


v <- c("a","ba","ca")
d <- stringdist::stringdistmatrix(v, method = "jw")
x <- broom::tidy(d)
x <- x %>% mutate(item1 = v[item1], item2 = v[item2])




# many_words <- sapply(1:100000, function(x) paste(sample(letters, 10, replace=T),
#                                                  collapse=""))
# # Needs a lot of memory
# d <- stringdist::stringdistmatrix(many_words, method = "jw")
#
# length(many_words)
# length(d)
#
# size <- attr(d, "Size")
# stopifnot(inherits(d, "dist"))
# stopifnot(size == length(many_words))
# stopifnot(length(d) == size*(size - 1)/2)


# few_words <- sapply(1:1000, function(x) paste(sample(letters, 10, replace=T),
#                                               collapse=""))
# d <- stringdist::stringdistmatrix(few_words, method = "jw")
#
# x <- broom::tidy(d)
#
# stopifnot(inherits(d, "dist"))
# size <- attr(d, "Size")
# stopifnot(size == length(few_words))
# stopifnot(length(d) == size*(size - 1)/2)
