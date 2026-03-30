# Dominance Extraction

Summarises daily Elo-rating scores for dairy cows across observation periods and exports per-cow statistics (mean, SD, median) to CSV.

## Data

- **Input:** `data/elo_score_daily.rdata` — daily Elo ratings per cow.
- **Output:** `result/elo_score_daily_summary.csv` — per-cow summary statistics for each period.

## Observation Periods

| Period | Date Range |
|--------|------------|
| 1 | 2020-11-24 to 2020-12-03 |
| 2 | 2021-03-24 to 2021-04-02 |


### Dependencies

- tidyverse
- lubridate
