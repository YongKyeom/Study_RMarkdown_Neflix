
#################################################################################
## EDA of Netflix Data
## https://www.kaggle.com/shivamb/netflix-shows/data
#################################################################################


#### 0. Setting ####
rm(list = ls())
gc()

options(scipen = 100, stringsAsFactors = FALSE)

## Set time zone
Sys.setenv(TZ = "Asia/Seoul")
Sys.timezone(location = TRUE)

TODAY   <- Sys.Date()
ST_TIME <- Sys.time()

DEFAULT_FOLD <- "D:/개인/R/Netflix"

## Run Rmd script's directory
SETWD_FOLD <- sprintf("%s/02.script", DEFAULT_FOLD)
setwd(SETWD_FOLD)

## Output files's save directory
SAVE_FOLD <- sprintf("%s/03.result", DEFAULT_FOLD)
if( !dir.exists(SAVE_FOLD) ) { dir.create(SAVE_FOLD, recursive = TRUE) }



#### 1. library load ####
package <- c("data.table", "tidyverse", "lubridate", "scales", "ggrepel", "gridExtra",
             "DescTools", "DataExplorer",
             "foreach", "parallel", "doParallel", "doSNOW",
             "rmarkdown", "knitr", "kableExtra")
sapply(package, require, character.only = TRUE)

filter     <- dplyr::filter
lag        <- dplyr::lag
wday       <- lubridate::wday
month      <- lubridate::month
week       <- data.table::week
between    <- dplyr::between
row_number <- dplyr::row_number



#### 2. Run R Markdown ####
rmarkdown::render(input       = "Netflix_RMarkDown_RMD.Rmd",
                  output_file = sprintf("%s/Netflix_EDA_%s.html", SAVE_FOLD, gsub("-", "", TODAY)),
                  params      = list(anal_date    = TODAY,
                                     default_fold = DEFAULT_FOLD),
                  encoding    = "UTF-8"
                  )



END_TIME <- Sys.time()

cat("\n",
    sprintf("===== Total Process is END! ====="),
    '\n Start : ', paste0(ST_TIME),
    '\n End   : ', paste0(END_TIME),
    '\n',
    capture.output(difftime(END_TIME, ST_TIME, units = "mins")),
    "\n",
    "\n")


# q(save = "no")
