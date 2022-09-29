#' Shiny App about wine ratings dataset
#'
#' @description
#' The shiny app can be launched from the `wine` package and contains the point plot, column plot, box plot and wordcloud related to the wine dataset.
#'
#' @return
#' A object about shiny app.
#'
#' @export
myapp <- function() {
  app_dir <- system.file("shinyapp", package = "wine")
  shiny::runApp(app_dir, display.mode = "normal")
}
