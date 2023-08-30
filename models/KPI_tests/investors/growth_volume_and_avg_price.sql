/*
merge of sales_number and avg_m2price
*/
SELECT
  av.year
, av.department
, ROUND(av.avg_m2_price,2) AS avg_m2_price
, av.avg_m2_price_growth
, sa.sales_numbers
, sa.sales_numbers_growth
FROM {{ref('avg_m2price_growth')}} av
LEFT JOIN {{ref('sales_numbers_growth')}} sa
USING(pk)
ORDER BY av.department, av.year ASC