-- ============================================================
-- Netflix Analytics Database — Table Definitions
-- Compatible with: PostgreSQL, MySQL, SQLite
-- ============================================================

CREATE TABLE IF NOT EXISTS netflix_titles (
    show_id        VARCHAR(10)  PRIMARY KEY,
    type           VARCHAR(10)  NOT NULL CHECK (type IN ('Movie', 'TV Show')),
    title          VARCHAR(500) NOT NULL,
    director       VARCHAR(500) DEFAULT 'Unknown',
    cast           TEXT         DEFAULT 'Unknown',
    country        VARCHAR(300) DEFAULT 'Unknown',
    date_added     DATE,
    release_year   INTEGER,
    rating         VARCHAR(20),
    duration       VARCHAR(20),
    listed_in      TEXT,
    description    TEXT,
    duration_value NUMERIC(6,1),
    year_added     INTEGER,
    month_added    INTEGER
);

-- ── Indexes for common query patterns ──────────────────────
CREATE INDEX IF NOT EXISTS idx_type         ON netflix_titles (type);
CREATE INDEX IF NOT EXISTS idx_rating       ON netflix_titles (rating);
CREATE INDEX IF NOT EXISTS idx_year_added   ON netflix_titles (year_added);
CREATE INDEX IF NOT EXISTS idx_release_year ON netflix_titles (release_year);
CREATE INDEX IF NOT EXISTS idx_country      ON netflix_titles (country);
