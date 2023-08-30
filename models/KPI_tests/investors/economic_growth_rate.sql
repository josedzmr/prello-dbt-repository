WITH avg_year AS(
    SELECT
    LEFT(municipality_code,2) as department --french department are the two first numbers of the municipality code
    , AVG(avg_net_salary) as avg_salary
    , year
FROM {{ref("stg_average_salary_by_municipality")}} 
WHERE year = 2015 OR year = 2019
GROUP BY department, year
ORDER BY department, year
),
growth AS(
SELECT
    department
    , year
    , avg_salary
    , (avg_salary - LAG(avg_salary) OVER (PARTITION BY department ORDER BY year)) / LAG(avg_salary) OVER (PARTITION BY department ORDER BY year) * 100 AS growth_rate_last5y
FROM avg_year
ORDER BY department, year
)
SELECT
*
FROM growth
WHERE year = 2019