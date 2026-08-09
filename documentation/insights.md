# Key Insights — Netflix EDA

## Dataset overview
- **7,787 titles** across 12 columns
- Date range: added to Netflix from 2008 through mid-2021
- No duplicate rows found; no null values after cleaning

---

## 1. Content type split
- **Movies: 5,372 (69%)** vs **TV Shows: 2,398 (31%)**
- Netflix's catalog is movie-heavy by count, but TV shows likely account for more watch-hours per title given multi-season length — something this dataset alone can't measure.

---

## 2. Top genres
| Rank | Genre | Titles |
|---|---|---|
| 1 | International Movies | 2,437 |
| 2 | Dramas | 2,105 |
| 3 | Comedies | 1,471 |
| 4 | International TV Shows | 1,197 |
| 5 | Documentaries | 786 |

"International Movies" ranking #1 reflects Netflix's deliberate global content strategy — a US-only library would not produce this result.

---

## 3. Content additions over time
- Near-zero additions before 2015 (Netflix was still primarily a DVD/US streaming service)
- Explosive growth from 2016 → **peak of 2,153 titles added in 2019**
- 2020 shows a slight dip (2,009) — possibly COVID-related production delays
- 2021 shows only 117 titles — this is a **partial year artifact** (dataset extracted mid-2021), not a real decline

---

## 4. Content-producing countries
| Rank | Country | Titles |
|---|---|---|
| 1 | United States | 3,287 |
| 2 | India | 990 |
| 3 | United Kingdom | 721 |
| 4 | Canada | 412 |
| 5 | France | 349 |

India at #2 is notable — it produces more Netflix content than the UK and Canada **combined**, reflecting a major investment in the Indian market.

---

## 5. Movie duration distribution
- Median movie length: **98 minutes**
- Distribution is right-skewed — most movies cluster between 80–120 min (the "sweet spot")
- A small number of outliers exceed 200 minutes (epics/documentaries)
- Shortest titles (under 30 min) are likely stand-up specials or short films

---

## 6. Content ratings
- **TV-MA** is the most common rating for both Movies (1,845) and TV Shows (1,016)
- Netflix skews heavily toward mature content — TV-MA + R + TV-14 account for the majority of the catalog
- Family/children's content (TV-Y, TV-Y7, PG) is a much smaller share
- PG and PG-13 ratings appear almost exclusively in Movies (not TV Shows), which makes sense given how the rating systems work

---

## Recommendations / takeaways

1. **If you're building a content recommender** — genre tags are multi-valued (comma-separated), so always explode the `listed_in` column before grouping. A title tagged "Dramas, International Movies" counts in both genre buckets.
2. **Don't use 2021 data for trend analysis** — it's a partial year and will always look like a crash even if it isn't.
3. **India-produced content deserves its own segment analysis** — at 990 titles it's large enough to analyze independently, not just lump into "International."
4. **`duration_value` must be filtered by type** — the number "3" means 3 minutes for a movie and 3 seasons for a TV show. Always `df[df['type']=='Movie']` before using it.
