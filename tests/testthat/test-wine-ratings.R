test_that("point price work", {
  expect_equal(point_price(w = "China")$mean_point, 89)
  expect_equal(point_price(w = "US")$total_wines, 43)
  expect_equal(point_price(w = "world"), "Sorry, there is no information about the wines of this country available here.")
})
