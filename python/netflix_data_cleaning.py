"""
Netflix Data Cleaning Script
=============================
Cleans the raw netflix_titles.csv and produces netflix_cleaned.csv.

Usage:
    pip install -r requirements.txt
    python python/netflix_data_cleaning.py
"""

import pandas as pd
from pathlib import Path

RAW_PATH     = Path(__file__).parent.parent / "data" / "raw"     / "netflix_titles.csv"
CLEANED_PATH = Path(__file__).parent.parent / "data" / "cleaned" / "netflix_cleaned.csv"


def load(path: Path) -> pd.DataFrame:
    """Load CSV with correct encoding (latin1 due to special characters)."""
    df = pd.read_csv(path, encoding="latin1")
    print(f"Loaded:  {len(df):,} rows x {len(df.columns)} columns")
    return df


def check_quality(df: pd.DataFrame) -> None:
    """Print a data quality report before cleaning."""
    print("\n-- Data Quality Report (before cleaning) --")
    nulls = df.isnull().sum()
    print("Nulls per column:\n", nulls[nulls > 0].to_string())
    print(f"\nFull duplicate rows: {df.duplicated().sum()}")
    print(f"show_id duplicates:  {df['show_id'].duplicated().sum()}")


def clean(df: pd.DataFrame) -> pd.DataFrame:
    """
    Cleaning steps performed:
    1. Strip whitespace from all text columns
    2. Fill missing optional fields (director, cast, country) with 'Unknown'
       Reason: filling rather than dropping preserves ~30% more rows
    3. Drop rows missing date_added or rating (small number, needed for analysis)
    4. Convert date_added from text -> datetime
    5. Derive: duration_value, year_added, month_added
    6. Remove exact duplicate rows
    """
    # 1 - Strip whitespace
    for col in df.select_dtypes(include="object").columns:
        df[col] = df[col].astype(str).str.strip()

    # 2 - Fill optional missing fields
    for col in ["director", "cast", "country"]:
        df[col] = df[col].replace("nan", pd.NA).fillna("Unknown")
        print(f"  Filled '{col}' missing values -> 'Unknown'")

    # 3 - Drop rows missing required fields
    before = len(df)
    df = df[df["date_added"] != "nan"].dropna(subset=["date_added", "rating"])
    print(f"  Dropped {before - len(df)} rows missing date_added/rating")

    # 4 - Fix date type
    df["date_added"] = pd.to_datetime(df["date_added"].str.strip(), errors="coerce")

    # 5 - Derive useful columns
    df["duration_value"] = df["duration"].str.extract(r"(\d+)").astype(float)
    df["year_added"]     = df["date_added"].dt.year.astype("Int64")
    df["month_added"]    = df["date_added"].dt.month.astype("Int64")

    # 6 - Remove duplicates
    before = len(df)
    df = df.drop_duplicates()
    print(f"  Duplicates removed: {before - len(df)}")

    return df


def summarise(df: pd.DataFrame) -> None:
    print("\n-- Post-Cleaning Summary --")
    print(f"Final shape : {len(df):,} rows x {len(df.columns)} columns")
    print(f"Movies      : {(df['type']=='Movie').sum():,}")
    print(f"TV Shows    : {(df['type']=='TV Show').sum():,}")
    ctries = df[df["country"]!="Unknown"]["country"].str.split(", ").explode().nunique()
    print(f"Countries   : {ctries}")
    print(f"Year range  : {df['year_added'].min()} - {df['year_added'].max()}")
    print(f"Remaining nulls: {df.isnull().sum().sum()}")


if __name__ == "__main__":
    df = load(RAW_PATH)
    check_quality(df)
    df = clean(df)
    summarise(df)
    df.to_csv(CLEANED_PATH, index=False)
    print(f"\nSaved -> {CLEANED_PATH}")
