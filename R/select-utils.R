starts_with <- function(vars, match, ignore.case = TRUE) {
  stopifnot(is.string(match), !is.na(match), nchar(match) > 0)

  if (ignore.case) match <- tolower(match)
  n <- nchar(match)

  if (ignore.case) vars <- tolower(vars)
  which(substr(vars, 1, n) == match)
}

ends_with <- function(vars, match, ignore.case = TRUE) {
  stopifnot(is.string(match), !is.na(match), nchar(match) > 0)

  if (ignore.case) match <- tolower(match)
  n <- nchar(match)

  if (ignore.case) vars <- tolower(vars)
  length <- nchar(vars)

  which(substr(vars, pmax(1, length - n + 1), length) == match)
}

contains <- function(vars, match, ignore.case = TRUE) {
  stopifnot(is.string(match), nchar(match) > 0)

  if (ignore.case) {
    vars <- tolower(vars)
    match <- tolower(match)
  }
  grep(match, vars, fixed = TRUE)
}

matches <- function(vars, match, ignore.case = TRUE) {
  stopifnot(is.string(match), nchar(match) > 0)

  grep(match, vars, ignore.case = ignore.case)
}

num_range <- function(vars, prefix, range, width = NULL) {
  if (!is.null(width)) {
    range <- sprintf(paste0("%0", width, "d"), range)
  }
  match(paste0(prefix, range), vars)
}

one_of <- function(vars, ...) {
  keep <- c(...)
  stopifnot(is.character(keep))
  match(keep, vars)
}

type_of <- function(vars, match, ignore.case = TRUE) {
  if (ignore.case) match <- tolower(match) 
  if (match == "numeric") {match <- c("integer", "double", "complex")} 
  possibletypes <- c("logical", "integer", "double", "complex", "character", "raw", "list", "NULL", "closure")
 
  stopifnot(is.string(match), !is.na(match), nchar(match) > 0, !match %in% possibletypes)
  
  which(sapply(., typeof) == match))  
} 

everything <- function(vars) {
  seq_along(vars)
}
