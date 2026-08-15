# Jio Hotstar Dashboard: Movies vs TV Shows Analysis (Excel & SQL)

## 📌 Project Overview

This project analyzes Movies and TV Shows content available on Jio Hotstar, using multiple tools
to demonstrate an end-to-end analytics workflow — starting with Excel for dashboarding, then
extending into SQL for deeper data validation and business analysis using CTEs and window functions.

The project explores content distribution, genres, release trends, age ratings, and running time
patterns — while also identifying and documenting real data-quality issues found in the dataset.

## 🎯 Objectives

1. Compare the number and characteristics of Movies vs TV Shows.
2. Analyze trends in release years and genres.
3. Identify the most common age ratings and average running time for movies.
4. Build an interactive dashboard using Excel (COUNTIF, COUNTBLANK, Pivot Tables, Slicers, Charts).
5. Validate and analyze the same dataset using SQL — including data quality checks, business
   analysis, and advanced querying with CTEs and window functions (RANK, LAG, ROW_NUMBER, running totals).

## 🛠️ Tools & Techniques Used

- **Microsoft Excel** — Data cleaning, Pivot Tables, Slicers, KPI Cards, Charts (Bar, Line, Pie)
- **MySQL Workbench** — Data validation, aggregation, subqueries, CTEs, window functions
- **SQL concepts demonstrated:** GROUP BY/HAVING, subqueries, RANK(), LAG(), ROW_NUMBER(),
  PARTITION BY, running totals, percentage-share calculations

## 📁 Files Included

**Excel:**
- `JioHotstar project Dashboard.xlsx` — Dataset sheet, Charts (Pie, Bar, Line), and the final interactive dashboard
- `JioHotstar Dashboard.png` — Screenshot preview of the dashboard

**SQL:**
- `SQL/jiohotstar_sql_project.sql` — All 29 SQL queries, organized into 4 sections
- `SQL/JioHotstar_SQL_Analysis_Report.pdf` — Full report with results and insights for every query

**Dataset:**
- `JioHotstar Dataset.csv` — Source dataset (~6,874 records)

## 📊 Phase 1: Excel Dashboard

An interactive Excel dashboard comparing Movies and TV Shows, using Pivot Tables, Slicers, and
KPI cards to surface genre and content-distribution trends at a glance — reducing manual reporting
effort for repeat analysis.

**How to view:**
1. Download the Excel file from this repository.
2. Open the Dashboard sheet.
3. Use the slicers to explore and compare content interactively.

## 🗃️ Phase 2: SQL Analysis

Extended the same dataset into SQL to demonstrate a more rigorous, query-driven analysis —
organized into 4 sections:

| Section | Focus | Questions |
|---|---|---|
| 1. Data Validation | Null checks, duplicates, data quality issues | Q1–Q7 |
| 2. Basic Business Analysis | Counts, averages, distributions | Q8–Q13 |
| 3. Intermediate SQL | Filtering, subqueries, HAVING | Q14–Q22 |
| 4. Advanced SQL | CTEs, RANK(), LAG(), ROW_NUMBER(), running totals | Q23–Q28 |

Full queries: [`SQL/jiohotstar_sql_project.sql`](./SQL/jiohotstar_sql_project.sql)
Full report with results & insights: [`SQL/JioHotstar_SQL_Analysis_Report.pdf`](./SQL/JioHotstar_SQL_Analysis_Report.pdf)

## 📈 Key Insights

- The dataset contains 6,874 records spanning 1928–2023, with no NULL values in key columns.
- **Movies (4,568) outnumber TV Shows (2,306)** in the catalog.
- **Drama** is the most represented genre — 2,043 titles (29.72% of all content).
- **U/A 13+** is the largest age-rating category, with 2,980 titles.
- **2022** was the peak release year, with 609 titles — content releases show a strong upward
  trend overall, aligning with the broader growth of OTT platforms.
- Average movie runtime is **98.75 minutes (raw)** / **118.87 minutes** after excluding 868 entries
  with unrealistically low runtimes (under 30 min) — flagged as a data-quality issue rather than a
  calculation error, after manually verifying several titles.
- **TV Shows have 6 exclusive genres** not found in Movies — Reality, Awards, Lifestyle, Formula E,
  Football, and Kabaddi — reflecting their episodic/event-based format.
- Repeated titles in the dataset are not automatically duplicates; several exist under different
  genres, so Title alone should not be treated as a unique key.

## 📚 Data Source

Dataset obtained from Kaggle (Jio Hotstar Dataset). Used only for academic and analytical purposes.

## 🚀 Future Scope

- Extend the analysis using **Python** (Pandas, Matplotlib/Seaborn) for deeper EDA and statistical testing.
- Build an interactive **Power BI** dashboard using the SQL-cleaned dataset, with DAX measures.
- Add a comparative trend analysis between OTT platforms.

---

*(Project created for learning and portfolio purposes.)*
