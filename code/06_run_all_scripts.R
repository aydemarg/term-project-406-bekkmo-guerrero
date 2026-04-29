# -------------------------------
# 1. Clear environment
# -------------------------------
rm(list = ls())

# -------------------------------
# 1. Install packages if needed
# -------------------------------
#install.packages("tidyverse")
#install.packages("rvest")
#install.packages("janitor")
#install.packages("httr")
#install.packages("jsonlite")
#install.packages("furrr")
#install.packages("patchwork")
#install.packages("rnaturalearth")
#install.packages("sf")
#install.packages("waffle")
#install.packages("ranger")
#install.packages("tidymodels")
#install.packages("glmnet")
#install.packages("vip")
#install.packages("gt")

# -------------------------------
# 1. Download all project R scripts
# -------------------------------
message("Starting full pipeline from RStudio project root...")

source("code/01_scrape_olympics.R", echo = TRUE)
source("code/02_download_world_bank.R", echo = TRUE)
source("code/03_clean_merge_data.R", echo = TRUE)
source("code/04_stage2_figures.R", echo = TRUE)
source("code/05_stage3_predictive_analysis.R", echo = TRUE)

message("Pipeline complete.")
