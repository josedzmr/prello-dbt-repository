

WITH cast_invest AS (
SELECT
  *
, CAST(department AS string) AS department_cleaned
FROM `prello-lewagon.dbt_louis2506_general.scaled_invest`
)
SELECT  
  CASE
    WHEN department_cleaned = '2000' THEN '2B'
    WHEN department_cleaned = '2999' THEN '2A'
    ELSE department_cleaned
  END AS deparmtent 
, (population_growth_last10y * 0.2) AS population_growth
, (sales_numbers * 0.225) AS sales_nb
, (avg_salary * 0.085) AS avg_salary
, (gross_yield * 0.105) AS gross_yield
, (avg_m2_price_sales * 0.105) AS avg_m2_price
, (rental_med_all * 0.105) AS rental_med
, (intensite_tension_immo * 0.175) AS intensite_imo
, (population_growth_last10y * 0.2) + (sales_numbers * 0.225) + (avg_salary * 0.085) + (gross_yield * 0.105) + (avg_m2_price_sales * 0.105)+ (rental_med_all * 0.105) + (intensite_tension_immo * 0.175) AS invest_score
FROM cast_invest 
ORDER BY invest_score DESC