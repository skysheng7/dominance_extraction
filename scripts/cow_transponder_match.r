library(tidyverse)

elo_summary <- read_csv("result/elo_score_daily_summary.csv")
unique_cows <- unique(elo_summary$cow)

dat_files <- list.files("data", pattern = "^VR.*\\.DAT$", full.names = TRUE)

all_dat <- map_dfr(dat_files, function(f) {
  read_csv(f, col_names = FALSE, show_col_types = FALSE) %>%
    select(transponder_id = X1, cow = X2) %>%
    filter(transponder_id != 0)
})

cow_transponder <- all_dat %>%
  filter(cow %in% unique_cows) %>%
  distinct(cow, transponder_id) %>%
  arrange(cow)

cat("Found", nrow(cow_transponder), "unique cow-transponder matches\n")
cat("Cows in ELO summary:", length(unique_cows), "\n")
cat("Cows matched:", n_distinct(cow_transponder$cow), "\n")

unmatched <- setdiff(unique_cows, cow_transponder$cow)
if (length(unmatched) > 0) {
  cat("Unmatched cows:", paste(unmatched, collapse = ", "), "\n")
}

write_csv(cow_transponder, "result/cow_transponder_match.csv")
cat("Exported to result/cow_transponder_match.csv\n")
