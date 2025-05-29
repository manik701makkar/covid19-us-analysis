-- Phase 3: SQL Queries with Window Functions, CTEs, and Aggregations

-- 1. Rank states by total COVID cases
SELECT 
  state,
  SUM(cases) AS total_cases,
  RANK() OVER (ORDER BY SUM(cases) DESC) AS rank_by_cases
FROM us_states.states
GROUP BY state
ORDER BY rank_by_cases;

-- 2. Use a CTE to sum cases and deaths by state and filter states with > 10,000 cases
WITH StateTotals AS (
  SELECT 
    state, 
    SUM(cases::BIGINT) AS total_cases, 
    SUM(deaths::BIGINT) AS total_deaths
  FROM us_states.states
  GROUP BY state
)
SELECT *
FROM StateTotals
WHERE total_cases > 10000
ORDER BY total_cases DESC;

-- 3. List states whose total cases exceed the average total cases across all states
SELECT 
  state, 
  SUM(cases) AS total_cases
FROM us_states.states
GROUP BY state
HAVING SUM(cases) > (
  SELECT AVG(total_cases) FROM (
    SELECT SUM(cases) AS total_cases
    FROM us_states.states
    GROUP BY state
  ) AS subquery
)
ORDER BY total_cases DESC;

-- 4. Create a persistent summary table for states with high cases (> 50,000)
DROP TABLE IF EXISTS us_states.high_case_states;

CREATE TABLE us_states.high_case_states AS
SELECT 
  state, 
  SUM(cases::BIGINT) AS total_cases
FROM us_states.states
GROUP BY state
HAVING SUM(cases::BIGINT) > 50000;

-- 5. Create a TEMP TABLE summarizing total cases per state
CREATE TEMP TABLE temp_state_summary AS
SELECT 
  state, 
  SUM(cases::BIGINT) AS total_cases
FROM us_states.states
GROUP BY state;

-- 6. Categorize states by case severity using CASE WHEN on the temp table
SELECT 
  state,
  total_cases,
  CASE 
    WHEN total_cases > 100000 THEN 'Very High'
    WHEN total_cases > 50000 THEN 'High'
    WHEN total_cases > 10000 THEN 'Moderate'
    ELSE 'Low'
  END AS case_severity
FROM temp_state_summary
ORDER BY total_cases DESC;
