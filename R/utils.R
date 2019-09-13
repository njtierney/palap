middle <- function(x){
  floor(stats::median(seq_along(x)))
}


if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))
globalVariables(
  c(
    "colorRamp",
    "rgb"
  )
)
