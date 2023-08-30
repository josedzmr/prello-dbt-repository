/*
Total population by year by departement growth (2006-2019)
*/
WITH dep_population AS (
SELECT
    year
,   department
,   SUM(population) AS population_total
FROM {{ref("stg_population_by_municipality")}}
WHERE year > 2005  --remove years before 2006
GROUP BY year, department
)
SELECT
    *
,   ROUND(((population_total - (LAG(population_total) OVER (PARTITION BY department ORDER BY year ASC)))/LAG(population_total) OVER (PARTITION BY department ORDER BY year ASC)) * 100, 2) AS population_growth
FROM dep_population
ORDER BY department, year ASC