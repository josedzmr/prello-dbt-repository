WITH growth09 AS (
SELECT
    year as o_year
    , department as o_department
    , SUM(population) AS o_population_total
FROM {{ref("stg_population_by_municipality")}}
WHERE year = 2009
GROUP BY year, department
ORDER BY department, year
)

, growth19 AS (
SELECT
    year as n_year
    , department as n_department
    , SUM(population) AS n_population_total
FROM {{ref("stg_population_by_municipality")}}
WHERE year = 2019
GROUP BY year, department
ORDER BY department, year
)


SELECT
    rate.population_growth_last10y
    , growth09.o_year
    , growth09.o_department
    , growth09.o_population_total AS population_total_09
    , growth19.n_year
    , growth19.n_department
    , growth19.n_population_total AS population_total_19
FROM {{ ref('growth_rate_all') }} as rate
INNER JOIN growth09 as growth09
ON growth09.o_department = rate.department
INNER JOIN growth19 as growth19
ON growth19.n_department = rate.department
ORDER BY growth09.o_department
