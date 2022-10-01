
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wine

<!-- badges: start -->
<!-- badges: end -->

The goal of wine is to provide tools for analyzing the average point, average price, number of wines and text descriptions of the wines in the *wine* dataset for different countries. 

## Installation

You can install the development version of wine from [GitHub](https://github.com/) with:

``` r
# install.packages("wine")
```

``` r
# install.packages("devtools")
devtools::install_github("etc5523-2022/rpkg-ggao0005")
```

## Usage

``` r
library(wine)
```

Here are some examples to show you how to use `wine` package.

### 1. Wine data

The `wine` package has a built-in dataset `wine` which contains four variables: country, points, price and description. All functions in this package are designed to help you better understand the dataset `wine`.

``` r
str(wine)
#> tibble [129,971 × 4] (S3: tbl_df/tbl/data.frame)
#>  $ country    : chr [1:129971] "Italy" "Portugal" "US" "US" ...
#>  $ points     : num [1:129971] 87 87 87 87 87 87 87 87 87 87 ...
#>  $ price      : num [1:129971] NA 15 14 13 65 15 16 24 12 27 ...
#>  $ description: chr [1:129971] "Aromas include tropical fruit, broom, brimstone and dried herb. The palate isn't overly expressive, offering un"| __truncated__ "This is ripe and fruity, a wine that is smooth while still structured. Firm tannins are filled out with juicy r"| __truncated__ "Tart and snappy, the flavors of lime flesh and rind dominate. Some green pineapple pokes through, with crisp ac"| __truncated__ "Pineapple rind, lemon pith and orange blossom start off the aromas. The palate is a bit more opulent, with note"| __truncated__ ...
```

### 2. Wine point and price

You can enter a country in `point_price()` to see the mean point, mean price and total number of wines in that country.

``` r
point_price("US")
#> # A tibble: 1 × 4
#>   country mean_point mean_price total_wines
#>   <chr>        <dbl>      <dbl>       <int>
#> 1 US            88.6       36.6          43
```

If there is not any data in the `wine` dataset for the country you entered, a message will appear.

``` r
point_price("au")
#> [1] "Sorry, there is no information about the wines of this country available here."
```

### 3. Wine box plot

You can use the `boxPlot` function and enter a country to display a box plot related to the wine points and prices for that country.

``` r
boxPlot("Canada")
```

If the `wine` dataset does not contain wine data for the country you entered, a box plot will be created with all data in the dataset.

``` r
boxPlot("world")
```

### 4. Wine wordcloud plot

You can select the country you want to know about and enter its name in the `wordcloud` function, which will select the keywords in the country's wine descriptions and create a wordcloud plot.

``` r
wordcloud("China")
```

If you enter a country that cannot be found in the `wine` dataset, the `wordcloud` function will create a wordcloud plot with all the wine descriptions.

``` r
wordcloud("UK")
```

### 5. Wine shiny app

You can call the `myapp()` function directly to access the shiny app for the `wine` dataset.

``` r
myapp()
```


