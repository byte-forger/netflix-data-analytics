# Data Dictionary — Netflix Dataset

## Source
[Netflix Movies and TV Shows](https://www.kaggle.com/datasets/shivamb/netflix-shows) — Kaggle (shivamb)
**File:** `data/raw/netflix_titles.csv`
**Encoding:** `latin1` (not UTF-8 — use `pd.read_csv(..., encoding='latin1')`)

---

## Original columns (12)

| Column | Type | Description | Missing | Handling |
|---|---|---|---|---|
| show_id | string | Unique identifier for each title | 0 | — |
| type | string | Content type: `Movie` or `TV Show` | 0 | — |
| title | string | Title of the content | 0 | — |
| director | string | Director(s), comma-separated | ~30% | Filled → `"Unknown"` |
| cast | string | Main cast, comma-separated | ~9% | Filled → `"Unknown"` |
| country | string | Production country/countries | ~6% | Filled → `"Unknown"` |
| date_added | string/date | Date added to Netflix (e.g. `August 14, 2020`) | 10 rows | Rows dropped; converted to datetime |
| release_year | integer | Original release year | 0 | — |
| rating | string | Content rating (e.g. TV-MA, PG-13) | 7 rows | Rows dropped |
| duration | string | Runtime — mixed units (`90 min` / `3 Seasons`) | 0 | — |
| listed_in | string | Genre tags, comma-separated | 0 | — |
| description | string | Short synopsis | 0 | — |

---

## Derived columns (added during cleaning)

| Column | Type | Description | Notes |
|---|---|---|---|
| duration_value | float | Numeric part of duration | Minutes for Movies, Season count for TV Shows — always filter by `type` before using |
| year_added | integer | Year extracted from date_added | 2008–2021 |
| month_added | integer | Month extracted from date_added | 1–12 |

---

## Key values reference

### type
| Value | Count |
|---|---|
| Movie | 5,372 |
| TV Show | 2,398 |

### rating (top values)
| Rating | Audience |
|---|---|
| TV-MA | Mature audiences |
| TV-14 | Ages 14+ |
| TV-PG | Parental guidance |
| TV-G | All ages |
| R | Restricted (films) |
| PG-13 | Ages 13+ (films) |
| PG | Parental guidance (films) |
| G | General (films) |
| NC-17 | Adults only (films) |

---

## Important caveats

1. **`director`, `cast`, `country` missingness is legitimate** — not every title publicly credits all fields. Treat `"Unknown"` as a valid category, not an error.
2. **`duration` mixes units** — always filter by `type` before any numeric analysis on `duration_value`.
3. **`country` can contain multiple values** (comma-separated) — use `.str.split(', ').explode()` in pandas or `SPLIT_PART()` in SQL before grouping.
4. **`listed_in` (genres) is always multi-valued** — same as above.
5. **2021 is a partial year** — the dataset was extracted mid-2021. Exclude from year-over-year comparisons.
6. **`latin1` encoding** — the file contains special characters (curly quotes, accented letters) that cause `UnicodeDecodeError` with default UTF-8.
