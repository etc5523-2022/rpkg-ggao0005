#' Wine wordcloud plot
#'
#' @description
#' The wordcloud plot extracts key words from the `description` variable to visualize flavors and taste profiles as written by the reviewer.
#'
#' @param input_country A character of country of wine origin.
#'
#' @return
#' A `wordcloud2` object. The plot of wine descriptions. If the `input_country` is in the dataset, a wordcloud plot of wine descriptions for that country is generated. If the `input_country` is not in the dataset, or if an incorrect country is input, the wordcloud plot will be generated with all wine descriptions in the dataset.
#'
#' @examples
#' wordcloud("US")
#' wordcloud("world")
#'
#' @export
wordcloud <- function(input_country){

  `%>%` <- magrittr::`%>%`
  wine <- wine::wine
  stopword <- tidytext::get_stopwords(source = "stopwords-iso")

  if(input_country %in% wine$country) {
    wine %>%
      dplyr::filter(country == input_country,
                    !is.na(country)) %>%
      dplyr::mutate(id = dplyr::row_number()) %>%
      dplyr::select(id, points, description) %>%
      tidytext::unnest_tokens(output = word,
                              input = description,
                              token = "words") %>%
      dplyr::anti_join(stopword,
                       by = "word") %>%
      dplyr::count(word) %>%
      dplyr::arrange(desc(n)) %>%
      dplyr::top_n(200) %>%
      wordcloud2::wordcloud2(size = 0.9,
                             color = "random-dark",
                             backgroundColor = "#faf7f7")

  }

  else(wine %>%
         dplyr::filter(!is.na(country)) %>%
         dplyr::mutate(id = dplyr::row_number()) %>%
         dplyr::select(id, points, description) %>%
         tidytext::unnest_tokens(output = word,
                                 input = description,
                                 token = "words") %>%
         dplyr::anti_join(stopword,
                          by = "word")%>%
         dplyr::count(word) %>%
         dplyr::arrange(desc(n)) %>%
         dplyr::top_n(200) %>%
         wordcloud2::wordcloud2(size = 0.9,
                                color = "random-dark",
                                backgroundColor = "#faf7f7"))

}

