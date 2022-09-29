
# wine

<!-- badges: start -->
<!-- badges: end -->

The goal of wine is to provide tools for analyzing the average point, average price, number of wines and text descriptions of the wines in the *wine* dataset for different countries. 

## Installation

You can install the development version of wine from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("etc5523-2022/rpkg-ggao0005")
```

## Usage

```{r}
library(wine)
```

Here are some examples to show you how to use `wine` package.

### 1. Wine data

The `wine` package has a built-in dataset `wine` which contains four variables: country, points, price and description. All functions in this package are designed to help you better understand the dataset `wine`.

```{r}
str(wine)
```

### 2. Wine point and price

You can enter a country in `point_price()` to see the mean point, mean price and total number of wines in that country.

```{r}
point_price("Australia")
```

If there is not any data in the `wine` dataset for the country you entered, a message will appear.

```{r}
point_price("au")
```

### 3. Wine box plot

You can use the `boxPlot` function and enter a country to display a box plot related to the wine points and prices for that country.

```{r}
boxPlot("Canada")
```

If the `wine` dataset does not contain wine data for the country you entered, a box plot will be created with all data in the dataset.

```{r}
boxPlot("world")
```

### 4. Wine wordcloud plot

You can select the country you want to know about and enter its name in the `wordcloud` function, which will select the keywords in the country's wine descriptions and create a wordcloud plot.

```{r}
wordcloud("China")
```

If you enter a country that cannot be found in the `wine` dataset, the `wordcloud` function will create a wordcloud plot with all the wine descriptions.

```{r}
wordcloud("UK")
```

### 5. Wine shiny app

You can call the `myapp()` function directly to access the shiny app for the `wine` dataset.

```{r}
myapp()
```


