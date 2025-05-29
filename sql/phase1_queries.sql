-- Phase 1: SQL Queries for COVID Data Exploration

-- 1. Count how many rows mention California
SELECT COUNT(*) AS california_rows
FROM us_states.states
WHERE state = 'California';

-- 2. Select all rows except those from California and Nebraska
SELECT *
FROM us_states.states
WHERE state NOT IN ('California', 'Nebraska');

-- 3. Calculate total cases for each state
SELECT state, SUM(cases) AS total_cases
FROM us_states.states
GROUP BY state;

-- 4. List states sorted by total cases in descending order
SELECT state, SUM(cases) AS total_cases
FROM us_states.states
GROUP BY state
ORDER BY total_cases DESC;

-- 5. Show top 5 states with the highest total cases
SELECT state, SUM(cases) AS total_cases
FROM us_states.states
GROUP BY state
ORDER BY total_cases DESC
LIMIT 5;
