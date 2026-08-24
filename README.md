<div align="center">

<img src="https://upload.wikimedia.org/wikipedia/commons/7/7a/Logonetflix.png" width="200px" alt="Netflix Logo"/>

<br/>

# 🎬 Netflix Data Analytics Project

> *A complete end-to-end data analytics project exploring Netflix's global content catalog —
> from raw data to interactive dashboards.*

<br/>

[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](python/)
[![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)](python/)
[![SQL](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)](sql/)
[![Excel](https://img.shields.io/badge/Microsoft_Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)](excel/)
[![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=for-the-badge&logo=jupyter&logoColor=white)](notebooks/)
[![License](https://img.shields.io/badge/License-MIT-E50914?style=for-the-badge)](LICENSE)

<br/>

</div>

---

## 🔴 What is this project?

This project performs a **complete data analytics workflow** on the
[Netflix Movies and TV Shows dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows)
from Kaggle — covering every stage from raw data ingestion to an interactive
Netflix-themed dashboard that runs entirely in the browser.

The goal is to answer real business questions:

> *What kind of content does Netflix have? Where does it come from?
> How has the catalog grown? What ratings and genres dominate?*

---

## 📊 Dataset Overview

<div align="center">

| 🎬 Total Titles | 🎥 Movies | 📺 TV Shows | 🌍 Countries | 🎭 Genres | 📅 Years |
|:---:|:---:|:---:|:---:|:---:|:---:|
| **7,770** | **5,372** | **2,398** | **121** | **42** | **2008 – 2021** |

</div>

**Source:** [Kaggle — Netflix Movies and TV Shows](https://www.kaggle.com/datasets/shivamb/netflix-shows) by Shivam Bansal
**File:** `data/raw/netflix_titles.csv`

---

## 🗂️ Repository Structure

```
📁 netflix-data-analytics/
│
├── 📄 README.md
├── 📄 requirements.txt
├── 📄 LICENSE
│
├── 📁 data/
│   ├── 📁 raw/
│   │   └── 📄 netflix_titles.csv          ← Original source file
│   └── 📁 cleaned/
│       └── 📄 netflix_cleaned.csv         ← Cleaned, analysis-ready dataset
│
├── 📁 excel/
│   └── 📊 Netflix_Dashboard.xlsx          ← Excel pivot dashboard
│
├── 📁 sql/
│   ├── 📄 create_tables.sql               ← Schema + indexes
│   ├── 📄 netflix_database.sql            ← Data load script
│   └── 📄 analysis_queries.sql            ← 10 analysis queries
│
├── 📁 python/
│   └── 🐍 netflix_data_cleaning.py        ← Reproducible cleaning script
│
├── 📁 notebooks/
│   └── 📓 netflix_analysis.ipynb          ← Full EDA notebook (Colab-ready)
│
├── 📁 dashboard/
│   ├── 🌐 netflix_dashboard.html          ← Interactive Netflix-themed dashboard
│   └── 🌐 netflix_cleaned_data.html       ← Searchable data viewer
│
├── 📁 reports/
│   └── 📑 Netflix_Analytics_Report.pdf    ← Full analytics report
│
└── 📁 documentation/
    ├── 📄 data_dictionary.md              ← Column reference + caveats
    └── 📄 data_cleaning.md               ← Cleaning decisions + reasoning
```

---

## 💡 Key Findings

<table>
  <tr>
    <td width="50%">

### 🎥 Content Mix
- Movies make up **69%** of the catalog
- TV Shows account for **31%**
- Netflix is movie-heavy by count, but TV shows drive more watch-hours per title

    </td>
    <td width="50%">

### 📈 Growth Story
- Near-zero additions before **2015**
- Explosive growth → **peaked at 2,153 titles in 2019**
- Slight dip in 2020 (COVID production delays)
- 2021 is a **partial year** — not a real decline

    </td>
  </tr>
  <tr>
    <td>

### 🌍 Global Reach
- **United States** leads with 3,287 titles
- **India** is a clear #2 with 990 titles
- India produces more Netflix content than **UK + Canada combined**
- Content spans **121 countries**

    </td>
    <td>

### 🎭 Genre Landscape
- **International Movies** is the #1 genre (2,437 titles)
- Reflects Netflix's deliberate **global expansion strategy**
- Dramas (2,105) and Comedies (1,471) follow
- **42 unique genre categories** across the catalog

    </td>
  </tr>
  <tr>
    <td>

### ⏱️ Movie Durations
- Median movie length: **98 minutes**
- Sweet spot: **80–120 minutes**
- Right-skewed — a small number of epics exceed 200 min
- Shortest titles (< 30 min) are stand-up specials

    </td>
    <td>

### 🔞 Content Ratings
- **TV-MA** is the most common rating
- Netflix skews heavily toward **mature content**
- TV-MA + R + TV-14 = majority of the catalog
- Family content (G, PG, TV-Y) is a much smaller share

    </td>
  </tr>
</table>

---

## 🚀 Quick Start

### 👀 View dashboards instantly (no setup needed)

```bash
# Just open these files in any browser — no server needed
[dashboard/netflix_dashboard.html](https://myportfolio-manas.netlify.app/project-netflix/netflix_dashboard)       ← Interactive dashboard with 6 charts + filters
[dashboard/netflix_cleaned_data.html](https://myportfolio-manas.netlify.app/project-netflix/netflix_cleaned_data)    ← Browse, search, sort & export all 7,770 titles
```

### 🐍 Run the Python cleaning script

```bash
# Clone the repo
git clone https://github.com/byte-forger/netflix-data-analytics.git
cd netflix-data-analytics

# Install dependencies
pip install -r requirements.txt

# Run cleaning script
python python/netflix_data_cleaning.py
# Output: data/cleaned/netflix_cleaned.csv
```

### 📓 Run the notebook in Google Colab

```
1. Go to colab.research.google.com
2. File → Upload notebook → select notebooks/netflix_analysis.ipynb
3. Upload data/raw/netflix_titles.csv via the Files panel
4. Runtime → Run all
```

> ⚠️ **Important:** Always load the CSV with `encoding="latin1"` —
> default UTF-8 throws `UnicodeDecodeError` due to special characters in titles.

### 🗄️ Run SQL analysis

```sql
-- Step 1: Create schema
\i sql/create_tables.sql

-- Step 2: Load data
\i sql/netflix_database.sql

-- Step 3: Run analysis
\i sql/analysis_queries.sql
```

---

## 🧹 Data Cleaning Summary

| Step | Action | Rows Affected |
|---|---|---|
| Load | `encoding="latin1"` to handle special characters | All 7,787 |
| Missing: director | Filled with `"Unknown"` (2,389 rows) | 2,389 |
| Missing: cast | Filled with `"Unknown"` (718 rows) | 718 |
| Missing: country | Filled with `"Unknown"` (507 rows) | 507 |
| Missing: date_added | Rows dropped (10 rows) | −10 |
| Missing: rating | Rows dropped (7 rows) | −7 |
| Type fix | `date_added` text → datetime | All |
| Derived | `duration_value`, `year_added`, `month_added` | All |
| Duplicates | Checked — none found | 0 |
| **Final** | **7,770 rows × 15 columns** | ✅ |

Full cleaning documentation → [`documentation/data_cleaning.md`](documentation/data_cleaning.md)

---

## 🛠️ Tech Stack

<div align="center">

| Tool | Version | Purpose |
|:---:|:---:|:---:|
| ![Python](https://img.shields.io/badge/-Python-3776AB?style=flat&logo=python&logoColor=white) | 3.10+ | Data cleaning & EDA |
| ![Pandas](https://img.shields.io/badge/-Pandas-150458?style=flat&logo=pandas&logoColor=white) | 2.0+ | Data manipulation |
| ![Matplotlib](https://img.shields.io/badge/-Matplotlib-11557c?style=flat) | 3.7+ | Themed visualizations |
| ![PostgreSQL](https://img.shields.io/badge/-PostgreSQL-336791?style=flat&logo=postgresql&logoColor=white) | 14+ | Database & queries |
| ![Excel](https://img.shields.io/badge/-Excel-217346?style=flat&logo=microsoft-excel&logoColor=white) | — | Pivot dashboard |
| ![JavaScript](https://img.shields.io/badge/-Chart.js-FF6384?style=flat&logo=chart.js&logoColor=white) | 4.4 | Interactive charts |
| ![Jupyter](https://img.shields.io/badge/-Jupyter-F37626?style=flat&logo=jupyter&logoColor=white) | — | EDA notebook |

</div>

---

## ⚠️ Important Caveats

```
⚠  Encoding        Always use encoding="latin1" when loading the CSV
⚠  duration_value  Filter by type first — "3" means 3 min (Movie) or 3 seasons (TV Show)
⚠  2021 data       Partial year only — exclude from year-over-year comparisons
⚠  country field   Can contain multiple values — use .str.split(', ').explode() before grouping
⚠  listed_in       Always multi-valued — same explode approach needed for genre analysis
```

---

## 📁 Documentation

| File | Description |
|---|---|
| [`documentation/data_dictionary.md`](documentation/data_dictionary.md) | Every column explained, data types, missing value handling, key value references |
| [`documentation/data_cleaning.md`](documentation/data_cleaning.md) | Step-by-step cleaning process with reasoning for every decision |

---

<div align="center">

**Dataset:** [Shivam Bansal on Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows) &nbsp;·&nbsp;
**License:** [MIT](LICENSE) &nbsp;·&nbsp;
**Made with ❤️ and 🍿**

<br/>

*If you found this useful, consider giving it a ⭐*

</div>
