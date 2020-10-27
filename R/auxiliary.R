# Auxiliary functions

# Helper function to remove NA's from a list
na.omit.list <- function(y) { return(y[!sapply(y, function(x) all(is.na(x)))]) }

