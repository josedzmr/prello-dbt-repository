/*
Sales numbers growth between 2018 and 2021
*/

WITH sales_year AS (
SELECT
  EXTRACT(YEAR from sales_date) AS year
, department
, COUNT(*) AS sales_numbers
FROM {{ref("stg_notary_real_estate_sales")}}
WHERE sales_date > '2017-12-31'   --remove year 2017
GROUP BY year, department
)
SELECT
  *
, ROUND(((sales_numbers - (LAG(sales_numbers) OVER (PARTITION BY department ORDER BY year ASC)))/LAG(sales_numbers) OVER (PARTITION BY department ORDER BY year ASC)) * 100, 2) AS sales_numbers_growth
FROM sales_year
ORDER BY department, year ASC