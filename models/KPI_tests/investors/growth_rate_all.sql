/*
Merging 'investors' KPI
Null values for dep. 57, 67 and 68 in:
        rental_med_all
        gross_yield
        avg_m2_price_growth_last_year
        sales_numbers_growth
*/
WITH merging AS (
SELECT
    pop.department
,   pop.population_total
,   pop.population_growth_last10y
,   eco.avg_salary
,   ROUND(eco.growth_rate_last5y,2) AS growth_rate_avg_salary_last5y
,   pri.sales_numbers AS sales_numbers_not
,   pri.sales_numbers_growth
,   yie.avg_surface_2021 AS avg_surface_2021_sales
,   pri.avg_m2_price AS avg_m2_price_sales_not
,   pri.avg_m2_price_growth_last_year AS avg_m2_price_rental_growth_last_year
,   yie.rental_med_all AS rental_med_all_not
,   yie.gross_yield AS gross_yield_not
,   ten.intensite_tension_immo
FROM {{ ref('department_population_growth') }} pop
LEFT JOIN {{ ref('economic_growth_rate') }} eco USING(department)
LEFT JOIN {{ ref('gross_yield') }} yie USING(department)
LEFT JOIN {{ ref('growth_volume_and_avg_price') }} pri USING(department)
LEFT JOIN {{ ref('intensite_immo') }} ten USING(department)
WHERE department < '97'
ORDER BY department ASC
) 
SELECT
    * EXCEPT (avg_m2_price_sales_not, rental_med_all_not, gross_yield_not, sales_numbers_not)
,   CASE 
        WHEN avg_m2_price_sales_not IS NULL AND department = '57' THEN 1873
        WHEN avg_m2_price_sales_not IS NULL AND department = '67' THEN 2753
        WHEN avg_m2_price_sales_not IS NULL AND department = '68' THEN 2815
        ELSE avg_m2_price_sales_not
    END AS avg_m2_price_sales
,   CASE
        WHEN rental_med_all_not IS NULL AND department = '57' THEN 11.03
        WHEN rental_med_all_not IS NULL AND department = '67' THEN 12.09
        WHEN rental_med_all_not IS NULL AND department = '68' THEN 12.31
        ELSE rental_med_all_not
    END AS rental_med_all
,   CASE
        WHEN gross_yield_not IS NULL AND department = '57' THEN 5.8512
        WHEN gross_yield_not IS NULL AND department = '67' THEN 5.9631
        WHEN gross_yield_not IS NULL AND department = '68' THEN 6.1232
        ELSE gross_yield_not
    END AS gross_yield
,   CASE
        WHEN sales_numbers_not IS NULL AND department = '57' THEN 5531
        WHEN sales_numbers_not IS NULL AND department = '67' THEN 9611
        WHEN sales_numbers_not IS NULL AND department = '68' THEN 10083
        ELSE sales_numbers_not
    END AS sales_numbers
FROM merging