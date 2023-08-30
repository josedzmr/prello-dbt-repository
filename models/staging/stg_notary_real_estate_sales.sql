/*
Creating a partioned table
Removing most of outliers
Removing """"duplicates"""" 
Removing department '97' = overseas department
*/

{{config(
    materialized='table',
    partition_by={
        'field': 'sales_date',
        'data_type': 'date',
        'granularity': 'day'
    }
)}}

WITH create_department AS (
SELECT
    *
,   LEFT(municipality_code,2) AS department     -- create department column
FROM `prello-lewagon.prello.notary_real_estate_sales`
),
test AS (
SELECT  
  sales_amount
, DATE(sales_date) AS sales_date    -- Set as date
, department
, premise_type
, SUM(number_of_principal_rooms) AS number_of_principal_rooms   -- easiest solution to show these columns due to 'groupby'
, SUM(surface) AS surface   -- easiest solution to show these columns due to 'groupby'
, SUM(sales_price_m2) AS sales_price_m2     -- easiest solution to show these columns due to 'groupby'
, COUNT(*) AS nb
FROM create_department 
WHERE department < '97'  -- remove overseas department
GROUP BY sales_amount, sales_date, department, premise_type
HAVING nb = 1   -- keep rows that do not have the same 'sales_amount, sales_date, department, premise_type'
)
SELECT 
    *
FROM test 
WHERE surface >= 10 AND sales_price_m2 BETWEEN 200 AND 80000 AND sales_amount > 20000   -- remove some outliers and wrong data, to be completed