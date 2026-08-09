-- ============================================================
-- Netflix Analytics — Analysis Queries
-- ============================================================

-- ── 1. Content type split ───────────────────────────────────
SELECT
    type,
    COUNT(*)                              AS total,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct
FROM netflix_titles
GROUP BY type
ORDER BY total DESC;

-- ── 2. Titles added per year ────────────────────────────────
SELECT
    year_added,
    COUNT(*)  AS titles_added,
    COUNT(*) FILTER (WHERE type = 'Movie')    AS movies,
    COUNT(*) FILTER (WHERE type = 'TV Show')  AS tv_shows
FROM netflix_titles
WHERE year_added IS NOT NULL
GROUP BY year_added
ORDER BY year_added;

-- ── 3. Top 10 content-producing countries ───────────────────
-- Note: country field can contain multiple values (comma-separated)
-- For exact multi-value splitting use application-side logic or unnest()
SELECT
    TRIM(SPLIT_PART(country, ',', 1))  AS primary_country,
    COUNT(*)                           AS titles
FROM netflix_titles
WHERE country != 'Unknown'
GROUP BY primary_country
ORDER BY titles DESC
LIMIT 10;

-- ── 4. Top 10 genres ────────────────────────────────────────
-- listed_in is comma-separated; this counts the first genre tag only
SELECT
    TRIM(SPLIT_PART(listed_in, ',', 1)) AS genre,
    COUNT(*)                            AS titles
FROM netflix_titles
GROUP BY genre
ORDER BY titles DESC
LIMIT 10;

-- ── 5. Content rating breakdown ─────────────────────────────
SELECT
    rating,
    COUNT(*)  AS titles,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY titles DESC;

-- ── 6. Movie duration stats ─────────────────────────────────
SELECT
    MIN(duration_value)                        AS min_minutes,
    MAX(duration_value)                        AS max_minutes,
    ROUND(AVG(duration_value), 1)              AS avg_minutes,
    PERCENTILE_CONT(0.5) WITHIN GROUP
        (ORDER BY duration_value)              AS median_minutes
FROM netflix_titles
WHERE type = 'Movie' AND duration_value > 0;

-- ── 7. TV shows by number of seasons ───────────────────────
SELECT
    duration_value  AS seasons,
    COUNT(*)        AS shows
FROM netflix_titles
WHERE type = 'TV Show' AND duration_value IS NOT NULL
GROUP BY seasons
ORDER BY seasons;

-- ── 8. Titles added per month (seasonality) ─────────────────
SELECT
    month_added,
    TO_CHAR(TO_DATE(month_added::TEXT, 'MM'), 'Month') AS month_name,
    COUNT(*) AS titles_added
FROM netflix_titles
WHERE month_added IS NOT NULL
GROUP BY month_added
ORDER BY month_added;

-- ── 9. Directors with most titles ───────────────────────────
SELECT
    director,
    COUNT(*)  AS titles,
    STRING_AGG(DISTINCT type, ', ') AS content_types
FROM netflix_titles
WHERE director != 'Unknown'
GROUP BY director
ORDER BY titles DESC
LIMIT 15;

-- ── 10. Year-over-year growth ───────────────────────────────
WITH yearly AS (
    SELECT year_added, COUNT(*) AS titles
    FROM netflix_titles
    WHERE year_added IS NOT NULL
    GROUP BY year_added
)
SELECT
    year_added,
    titles,
    LAG(titles) OVER (ORDER BY year_added)  AS prev_year,
    titles - LAG(titles) OVER (ORDER BY year_added) AS yoy_change,
    ROUND(
        (titles - LAG(titles) OVER (ORDER BY year_added)) * 100.0 /
        NULLIF(LAG(titles) OVER (ORDER BY year_added), 0), 1
    ) AS yoy_pct_change
FROM yearly
ORDER BY year_added;
