options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("dplyr", "ggplot2", "readxl", "tidyr", "matsindf", "Recca"))

read_data <- function(.path, sheet) {
  .path |> 
    readxl::read_excel(sheet = sheet) 
}
