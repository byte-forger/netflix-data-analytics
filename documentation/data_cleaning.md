# Data Cleaning Process — Netflix Dataset

## Overview

| Item | Before | After |
|---|---|---|
| Rows | 7,787 | 7,770 |
| Columns | 12 | 15 (+ 3 derived) |
| Duplicates | 0 | 0 |
| Null values | 3,700+ | 0 |
| Encoding issue | Yes (latin1) | Handled |

---

## Step-by-step process

### Step 1 — Load with correct encoding
```python
df = pd.read_csv("netflix_titles.csv", encoding="latin1")
```
The file uses `latin1` encoding due to special characters in titles and descriptions
(e.g. curly apostrophes, accented letters). Loading with default UTF-8 throws a
`UnicodeDecodeError` at byte `0x92`.

---

### Step 2 — Check missing values
```python
df.isnull().sum().sort_values(ascending=False)
```
Results before cleaning:
| Column | Missing |
|---|---|
| director | 2,389 |
| cast | 718 |
| country | 507 |
| date_added | 10 |
| rating | 7 |

---

### Step 3 — Handle missing values

**Decision: fill vs. drop**

`director`, `cast`, and `country` are filled with `"Unknown"` rather than dropping rows.

**Why?** Dropping every row with a missing director would remove ~30% of the dataset.
These fields are legitimately absent for many titles (e.g. stand-up specials often
don't credit a "director"; co-productions may not list all countries). Filling with
`"Unknown"` keeps the data usable while making the absence explicit.

`date_added` and `rating` rows are dropped (17 rows total) because:
- `date_added` is required for any time-based trend analysis
- `rating` is required for the ratings breakdown chart
- The number is small enough (0.2% of rows) that dropping is safe

```python
for col in ["director", "cast", "country"]:
    df[col] = df[col].fillna("Unknown")

df = df.dropna(subset=["date_added", "rating"])
```

---

### Step 4 — Fix data types

`date_added` is stored as text (`"August 14, 2020"`). Converted to datetime:
```python
df["date_added"] = pd.to_datetime(df["date_added"].str.strip())
```
The `.str.strip()` is necessary because some values have leading/trailing spaces.

---

### Step 5 — Derive new columns

`duration` is stored as mixed text (`"90 min"` for movies, `"3 Seasons"` for TV shows).
Extracted the numeric part into a separate column:
```python
df["duration_value"] = df["duration"].str.extract(r"(\d+)").astype(float)
df["year_added"]     = df["date_added"].dt.year
df["month_added"]    = df["date_added"].dt.month
```

**Important:** `duration_value` must always be filtered by `type` before use —
the number `3` means 3 minutes for a Movie and 3 seasons for a TV Show.

---

### Step 6 — Remove duplicates
```python
before = len(df)
df = df.drop_duplicates()
print(f"Removed: {before - len(df)}")  # Output: Removed: 0
```
No duplicate rows were found. The source dataset is already unique at the row level,
with each row uniquely identified by `show_id`.

---

## What was NOT changed

- **No values were imputed or estimated** — all cleaning is transparent and reversible
- **No outliers were removed** — unusual durations (very short or very long films) are
  kept as-is; they are legitimate data points
- **No rows were removed for business logic** — only removed for missing required fields
- **Original column names preserved** — derived columns added with clear naming

---

## Output
Cleaned file saved to: `data/cleaned/netflix_cleaned.csv`
Reproducible script: `python/netflix_data_cleaning.py`
