WITH growth AS (
SELECT
    year
    , department
    , SUM(population) AS population_total
FROM {{ref("stg_population_by_municipality")}}
WHERE year = 2009 OR year = 2019
GROUP BY year, department
ORDER BY department, year
)

SELECT
    rate.population_growth_last10y
    , growth.*
FROM {{ ref('growth_rate_all') }} as rate
INNER JOIN growth as growth
ON growth.department = rate.department
ORDER BY growth.department