
test_that("proj version works", {
  expect_identical(proj_version(), package_version("7.0.0"))
})
