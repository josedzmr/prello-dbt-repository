/*
Total population 2009 and 2019 by departement growth 
*/
WITH dep_population AS (
SELECT
    year
,   department
,   SUM(population) AS population_total
FROM {{ref("stg_population_by_municipality")}}
WHERE year = 2009 OR year = 2019
GROUP BY year, department
),
growth AS (
SELECT
    *
,   ROUND(((population_total - (LAG(population_total) OVER (PARTITION BY department ORDER BY year ASC)))/LAG(population_total) OVER (PARTITION BY department ORDER BY year ASC)) * 100, 2) AS population_growth_last10y
FROM dep_population
ORDER BY department, year ASC
)
SELECT
*
FROM growth
WHERE year = 2019