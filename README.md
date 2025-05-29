
# COVID-19 U.S. States Data Analysis

## Project Overview

This project analyzes COVID-19 case data from U.S. states to understand how the pandemic affected different regions. Using SQL queries, it summarizes case counts, ranks states, and categorizes states by severity levels based on their total cases.

The project demonstrates how SQL can be used to organize and explore data, preparing it for further visualization and storytelling.

## Purpose

The goal is to provide a clear picture of COVID-19 case distribution across states, which can help inform public health decisions and increase awareness of pandemic impacts.

## Tools Used

- SQL (PostgreSQL) for data querying and analysis
- Tableau or Power BI (planned for visualization)
- Git & GitHub for project management

## Project Structure

```
/data/           # Raw data files (CSV format)
/sql/            # SQL query files
/visuals/        # Visualization files (planned)
/docs/           # Reports and notes (planned)
README.md        # Project description and instructions
```

## What the Queries Do

- Count and filter data by state  
- Calculate total cases per state  
- Rank states by total case counts  
- Create summaries and categorize states by severity  
- Work with temporary tables to organize data  

## Example Queries

```sql
-- Count rows for California
SELECT COUNT(*) AS california_rows
FROM us_states.states
WHERE state = 'California';

-- Total cases and ranking by state
SELECT 
  state,
  SUM(cases::BIGINT) AS total_cases,
  RANK() OVER (ORDER BY SUM(cases::BIGINT) DESC) AS rank
FROM us_states.states
GROUP BY state
ORDER BY rank;

-- Categorize states by case severity
WITH StateTotals AS (
  SELECT 
    state, 
    SUM(cases::BIGINT) AS total_cases
  FROM us_states.states
  GROUP BY state
)
SELECT 
  state,
  total_cases,
  CASE 
    WHEN total_cases > 100000 THEN 'Very High'
    WHEN total_cases > 50000 THEN 'High'
    WHEN total_cases > 10000 THEN 'Moderate'
    ELSE 'Low'
  END AS case_severity
FROM StateTotals
ORDER BY total_cases DESC;
```

---

*Last updated: May 2025*
