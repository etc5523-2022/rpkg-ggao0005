#' Wine points and prices
#'
#' @description
#' Showing average points and average prices of wines from different countries.
#'
#' @param w A character of country of wine origin.
#'
#' @return
#' A tibble object or a sentence. If the `input_country` is in the dataset, it will return a tibble includes mean point, mean price and total number of wines from different country. If the `input_country` is not in the dataset, or if an incorrect country is input, it will prompt you with a sentence.
#'
#' @examples
#' point_price("Australia")
#'
#'
#' @export
point_price <- function(w) {

  `%>%` <- magrittr::`%>%`
  wine <- wine::wine

  if(w %in% wine$country) {
    out <- wine %>%
      dplyr::select(country, points, price) %>%
      dplyr::filter(!is.na(country)) %>%
      dplyr::group_by(country) %>%
      dplyr::summarise(mean_point = mean(points, na.rm = T),
                       mean_price = mean(price, na.rm = T)) %>%
      dplyr::mutate(total_wines = dplyr::n()) %>%
      dplyr::filter(country == w)
    return(out) }

  else
    return('Sorry, there is no information about the wines of this country available here.')
}
