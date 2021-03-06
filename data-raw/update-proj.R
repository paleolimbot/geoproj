
library(tidyverse)

# download PROJ 7
source_url <- "https://download.osgeo.org/proj/proj-7.0.0.tar.gz"
curl::curl_download(source_url, "data-raw/proj-source.tar.gz")
untar("data-raw/proj-source.tar.gz", exdir = "data-raw")

# make sure the dir exists
proj_dir <- list.files("data-raw", "^proj-[0-9.]+", include.dirs = TRUE, full.names = TRUE)
stopifnot(dir.exists(proj_dir), length(proj_dir) == 1)

# headers can be in subdirectories no problem
# it might make more sense to have these in inst/include,
# but I can't get that to work...so they are in src/, with
# the CXXFLAGS=-I../src
headers <- tibble(
  path = list.files(file.path(proj_dir, "include"), "\\.(h|hpp|cpp)$", full.names = TRUE, recursive = TRUE),
  final_path = str_replace(path, ".*?include/", "src/")
)

# R doesn't do recursive folders easily
# so instead we replace "/" with "__"
# there aren't any headers in subdirs, so we don't need to
# search + replace in any source files
source_files <- tibble(
  path = list.files(file.path(proj_dir, "src"), "\\.(h|hpp|c|cpp)$", full.names = TRUE, recursive = TRUE),
  final_path = str_replace(path, ".*?src/", "src/") %>%
    str_replace_all("/", "__") %>%
    str_replace("src__", "src/")
) %>%
  filter(!str_detect(path, "/(apps|tests?)/"))

# clean source dir
current_source_files <- tibble(path = list.files("src", "\\.(h|hpp|cpp|o)$", full.names = TRUE, recursive = TRUE)) %>%
  filter(!str_detect(path, "^src/(geoproj-|Rcpp|Makevars|proj_config)"))

unlink(current_source_files$path)
unlink("src/proj/", recursive = TRUE)
stopifnot(file.remove(list.dirs("src")[!str_detect(list.dirs("src"), "^src$")]))


# create destination dirs
dest_dirs <- c(
  headers %>% pull(final_path),
  source_files %>% pull(final_path)
) %>%
  dirname() %>%
  unique()
dest_dirs[!dir.exists(dest_dirs)] %>% walk(dir.create)

# copy source files
stopifnot(
  file.copy(headers$path, headers$final_path),
  file.copy(source_files$path, source_files$final_path)
)

# modify source files (not automated yet)
# - pragmas (check with  tools:::.check_pragmas())
# - calls to exit(), abort()
# - stderr, stdout, putchar
# - fprintf\(stderr,\s* -> REprintf(

stop("stop!")

unlink("data-raw/proj-source.tar.gz")
unlink(proj_dir, recursive = TRUE)
