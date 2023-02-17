install.packages("neonUtilities", dependencies=TRUE)
library(neonUtilities)
library(tidyverse)

write_readme_to_txt <- function(data, 
                                path_from_wd = "/resources/NEON/", 
                                file_name = "read_me.txt") {
  
  read_me <- str_detect(ls(data), "read")
  
  for (i in 1:length(read_me)) {
    if (read_me[i] == TRUE) {
      write.table(data[i], paste0(getwd(), path_from_wd, file_name), row.names = FALSE)
    }
  }
  
}

source("course_development/NEON_API_token.R")

# Mountain Lake Biological Station - VA

## Beetles
MLBS <- loadByProduct(dpID = "DP1.10022.001",
                      site = c("MLBS"),
                      token = token)

saveRDS(MLBS, "resources/NEON/MLBS_beetles.RDS")

list2env(MLBS, envir = .GlobalEnv) 
write_readme_to_txt(MLBS, file_name = "readme_beetles_MLBS.txt")

