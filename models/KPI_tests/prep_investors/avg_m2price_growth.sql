/*
avg m2 price growth between 2018 and 2021
*/

WITH sales_m2 AS(
SELECT
    EXTRACT(YEAR from sales_date) AS year
,   department
,   AVG(sales_price_m2) as avg_m2_price
FROM {{ref("stg_notary_real_estate_sales")}}
WHERE sales_date > '2017-12-31'   --remove year 2017
GROUP BY year, department
)
SELECT
    *
,   ROUND(((avg_m2_price - (LAG(avg_m2_price) OVER (PARTITION BY department ORDER BY year ASC)))/LAG(avg_m2_price) OVER (PARTITION BY department ORDER BY year ASC)) * 100, 2) AS avg_m2_price_growth
,   CONCAT(year, department) AS pk
FROM sales_m2
ORDER BY department, year ASC