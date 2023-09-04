/*
merge of sales_number and avg_m2price
*/
SELECT
  av.year
, av.department
, ROUND(av.avg_m2_price,2) AS avg_m2_price
, av.avg_m2_price_growth AS avg_m2_price_growth_last_year
, sa.sales_numbers
, sa.sales_numbers_growth
FROM {{ref('avg_m2price_growth')}} av
LEFT JOIN {{ref('sales_numbers_growth')}} sa
USING(pk)
WHERE av.year = 2021
ORDER BY av.department, av.year ASC