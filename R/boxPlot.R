#' Wine points and prices box plot
#'
#' @description
#' The box plot shows the relationship between wine prices and points in different countries.
#'
#' @param input_country A character of country of wine origin.
#'
#' @return
#' A `ggplot` object. The plot of wine prices and points. If the `input_country` is in the dataset, a box plot of wine prices and points for that country is generated. If the `input_country` is not in the dataset, or if an incorrect country is input, the box plot will be generated with all wine prices and points in the dataset.
#'
#' @examples
#' boxPlot("US")
#' boxPlot("world")
#'
#' @export
boxPlot <- function(input_country){

  `%>%` <- magrittr::`%>%`
  wine <- wine::wine

  if(input_country %in% wine$country) {
    data <- wine %>%
      dplyr::filter(country == input_country,
                    !is.na(country),
                    !is.na(points),
                    !is.na(price))

    data %>%
      dplyr::mutate(points = factor(points,
                                    levels = sort(unique(points)))) %>%
      ggplot2::ggplot(ggplot2::aes(x = points,
                                   y = price)) +
      ggplot2::geom_boxplot(ggplot2::aes(fill = as.numeric(as.character(points)))) +
      ggplot2::scale_y_sqrt() +
      ggplot2::labs(x = "Point",
                    y = "Price") +
      ggplot2::coord_flip() +
      ggplot2::scale_fill_distiller(palette = "Reds",
                                    direction = 1) +
      ggplot2::theme_minimal() +
      ggplot2::theme(legend.position = "none",
                     text = ggplot2::element_text(size = 17))
  }

  else(wine%>%
         dplyr::filter(!is.na(country),
                       !is.na(points),
                       !is.na(price)) %>%
         dplyr::mutate(points = factor(points,
                                       levels = sort(unique(points)))) %>%
         ggplot2::ggplot(ggplot2::aes(x = points,
                                      y = price)) +
         ggplot2::geom_boxplot(ggplot2::aes(fill = as.numeric(as.character(points)))) +
         ggplot2::scale_y_sqrt() +
         ggplot2::labs(x = "Point",
                       y = "Price") +
         ggplot2::coord_flip() +
         ggplot2::scale_fill_distiller(palette = "Reds",
                                       direction = 1) +
         ggplot2::theme_minimal() +
         ggplot2::theme(legend.position = "none",
                        text = ggplot2::element_text(size = 17)))

}

