library(tidyverse)
library(lubridate)

load("data/elo_score_daily.rdata")

elo_score <- elo_score %>%
  mutate(
    date = ymd(date),
    period = case_when(
      date >= ymd("2020-11-24") & date <= ymd("2020-12-03") ~ 1L,
      date >= ymd("2021-03-24") & date <= ymd("2021-04-02") ~ 2L
    )
  ) %>%
  filter(!is.na(period)) %>%
  group_by(period, cow) %>%
  summarise(
    date_range = paste(min(date), "to", max(date)),
    avg_elo = mean(Elo, na.rm = TRUE),
    sd_elo = sd(Elo, na.rm = TRUE),
    median_elo = median(Elo, na.rm = TRUE),
    .groups = "drop"
  )

# save result
write_csv(elo_score, "result/elo_score_daily_summary.csv")