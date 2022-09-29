library(shiny)
library(tidyverse)
library(tidytext)
library(gridExtra)
library(wordcloud2)
library(ggridges)
library(renv)
library(stopwords)


# Read data
wine_ratings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-28/winemag-data-130k-v2.csv")

wine_ratings <- wine_ratings %>%
  select(country, description, points, price, variety)

# ui------------------------------------------------------------------------------------------------
ui = navbarPage(title = "Wine Rating", inverse = T, collapsible = T,

                sidebarLayout(
                  sidebarPanel(

                    selectInput(inputId = "country",
                                label = "Choose Country:",
                                choices = c("Italy" = "Italy",
                                            "Portugal" = "Portugal",
                                            "US" = "US",
                                            "Spain" = "Spain",
                                            "France" = "France",
                                            "Germany" = "Germany",
                                            "Argentina" = "Argentina",
                                            "Chile" = "Chile",
                                            "Australia" = "Australia",
                                            "Austria" = "Austria",
                                            "South Africa" = "South Africa",
                                            "New Zealand" = "New Zealand",
                                            "Israel" = "Israel",
                                            "Hungary" = "Hungary",
                                            "Greece" = "Greece",
                                            "Romania" = "Romania",
                                            "Mexico" = "Mexico",
                                            "Canada" = "Canada",
                                            "Turkey" = "Turkey",
                                            "Czech Republic" = "Czech Republic",
                                            "Slovenia" = "Slovenia",
                                            "Luxembourg" = "Luxembourg",
                                            "Croatia" = "Croatia",
                                            "Georgia" = "Georgia",
                                            "Uruguay" = "Uruguay",
                                            "England" = "England",
                                            "Lebanon" = "Lebanon",
                                            "Serbia" = "Serbia",
                                            "Brazil" = "Brazil",
                                            "Moldova" = "Moldova",
                                            "Morocco" = "Morocco",
                                            "Peru" = "Peru",
                                            "India" = "India",
                                            "Bulgaria" = "Bulgaria",
                                            "Cyprus" = "Cyprus",
                                            "Switzerland" = "Switzerland",
                                            "Ukraine" = "Ukraine",
                                            "Macedonia" = "Macedonia",
                                            "World" = "World"),
                                selected = "World"),

                    sliderInput(inputId = "frequency",
                                label = "Frequency:",
                                min = 1,
                                max = 30,
                                value = 1,
                                step = 2),

                    sliderInput(inputId = "word",
                                label = "Number of Words:",
                                min = 1,
                                max = 200,
                                value = 100,
                                step = 10),

                    radioButtons(inputId = "shape",
                                 label = "Shape of wordcloud:",
                                 choices = c("circle" = "circle",
                                             "diamond" = "diamond",
                                             "pentagon" = "pentagon",
                                             "star" = "star"),
                                 selected = "circle"),

                    width = 3),

                  mainPanel(
                    tabsetPanel(

                      tabPanel(title = "variety",
                               plotOutput(outputId = "variety", height = "600px")),

                      tabPanel(title = "price vs points",
                               plotOutput(outputId = "pp", height = "600px")),

                      tabPanel(title = "wordcloud",
                               wordcloud2Output(outputId = "wordcloud", height = "600px")),


                    )
                  )
                ),
                includeCSS("styles.css")

)


# server----------------------------------------------------------------------------------------------
server = function(input,output) {

  output$variety = renderPlot({
    if(input$country == "World") {
      data <- wine_ratings
    }

    if(input$country != "World") {
      data <- wine_ratings %>%
        filter(country == input$country)
    }

    wine_data <- data %>%
      group_by(variety) %>%
      summarise(n = n(),
                mean_points = mean(points, na.rm = T),
                sd_points = sd(points, na.rm = T),
                price = mean(price, na.rm = T)) %>%
      ungroup() %>%
      replace_na(list(sd_points = 0))

    p1 <- wine_data %>%
      mutate(variety = fct_reorder(variety, mean_points)) %>%
      top_n(10) %>%
      ggplot(aes(x = variety,
                 y = mean_points)) +
      geom_point(size = 5, color = "red") +
      geom_errorbar(aes(ymin = mean_points - 1.96 * sd_points / sqrt(n),
                        ymax = mean_points + 1.96 * sd_points / sqrt(n)),
                    color = "red",
                    width = 0.5) +
      labs(x = "Variety",
           y = "Point") +
      coord_flip() +
      theme_minimal() +
      theme(legend.position = "none",
            text = element_text(size = 17))

    p2 <- wine_data %>%
      mutate(variety = fct_reorder(variety, price)) %>%
      top_n(10) %>%
      ggplot(aes(x = variety,
                 y = price,
                 fill = price)) +
      geom_col() +
      labs(x = "Variety",
           y = "Price") +
      coord_flip() +
      scale_fill_distiller(palette = "Reds",
                           direction = 1) +
      theme_minimal() +
      theme(legend.position = "none",
            text = element_text(size = 17))

    grid.arrange(p1, p2, nrow = 1)

  })

  output$pp = renderPlot({
    if(input$country == "World") {
      data <- wine_ratings
    }

    if(input$country != "World") {
      data <- wine_ratings %>%
        filter(country == input$country)
    }

    data %>%
      mutate(points = factor(points,
                             levels = sort(unique(points)))) %>%
      ggplot(aes(x = points,
                 y = price)) +
      geom_boxplot(aes(fill = as.numeric(as.character(points)))) +
      scale_y_sqrt() +
      labs(x = "Point",
           y = "Price") +
      coord_flip() +
      scale_fill_distiller(palette = "Reds",
                           direction = 1) +
      theme_minimal() +
      theme(legend.position = "none",
            text = element_text(size = 17))

  })

  output$wordcloud <- renderWordcloud2({
    if(input$country == "World") {
      data <- wine_ratings
    }

    if(input$country != "World") {
      data <- wine_ratings %>%
        filter(country == input$country)
    }

    stopword <- get_stopwords(source = "stopwords-iso")
    word <- data %>%
      mutate(id = row_number()) %>%
      select(id, points, description) %>%
      unnest_tokens(output = word,
                    input = description,
                    token = "words") %>%
      anti_join(stopword,
                by = "word")

    word %>%
      count(word) %>%
      filter(n >= input$frequency) %>%
      arrange(desc(n)) %>%
      top_n(input$word) %>%
      wordcloud2(size = 0.9,
                 color = "random-dark",
                 backgroundColor = "#faf7f7",
                 shape = input$shape)

  })

}

shinyApp(ui = ui, server = server)
