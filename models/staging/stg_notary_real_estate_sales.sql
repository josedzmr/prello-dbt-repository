/*
Test no nulls outside of long&lat 
Removing most of outliers
Removing """"duplicates"""" 
Removing 97 department 
*/
WITH test AS (
SELECT  
  sales_amount
, sales_date
, department
, premise_type
, SUM(number_of_principal_rooms) AS number_of_principal_rooms
, SUM(surface) AS surface
, SUM(sales_price_m2) AS sales_price_m2
, COUNT(*) AS nb
FROM `prello-lewagon.louis_test.stg_notary_partitioned` 
WHERE department < '97'
GROUP BY sales_amount, sales_date, department, premise_type
HAVING nb = 1
)
SELECT 
    *
FROM test 
WHERE surface >= 10 AND sales_price_m2 BETWEEN 200 AND 80000 AND sales_amount > 20000