-- ============================================================
-- Netflix Analytics Database — Load Cleaned Data
-- Run this AFTER create_tables.sql
-- ============================================================

-- Load from CSV (PostgreSQL syntax)
-- Adjust path to where your netflix_cleaned.csv lives
COPY netflix_titles (
    show_id, type, title, director, cast, country,
    date_added, release_year, rating, duration,
    listed_in, description, duration_value, year_added, month_added
)
FROM '/path/to/data/cleaned/netflix_cleaned.csv'
DELIMITER ','
CSV HEADER
NULL 'Unknown';

-- Quick row count check after load
SELECT
    COUNT(*)                                          AS total_titles,
    COUNT(*) FILTER (WHERE type = 'Movie')            AS movies,
    COUNT(*) FILTER (WHERE type = 'TV Show')          AS tv_shows,
    MIN(year_added)                                   AS earliest_year,
    MAX(year_added)                                   AS latest_year
FROM netflix_titles;
