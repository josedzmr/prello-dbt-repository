
WITH normalisation AS (
SELECT  
  CAST(department_code AS string) AS department
, (sales_numbers - MIN(sales_numbers) OVER ()) * 1.0 / (MAX(sales_numbers) OVER () - MIN(sales_numbers) OVER ()) AS sales_numbers
, (avg_salary - MIN(avg_salary) OVER ()) * 1.0 / (MAX(avg_salary) OVER () - MIN(avg_salary) OVER ()) AS avg_salary
, (population_growth_last10y - MIN(population_growth_last10y) OVER ()) * 1.0 / (MAX(population_growth_last10y) OVER () - MIN(population_growth_last10y) OVER ()) AS population_growth_last10y
, (avg_m2_price_sales - MIN(avg_m2_price_sales) OVER ()) * 1.0 / (MAX(avg_m2_price_sales) OVER () - MIN(avg_m2_price_sales) OVER ()) AS avg_m2_price_sales
, (rental_med_all - MIN(rental_med_all) OVER ()) * 1.0 / (MAX(rental_med_all) OVER () - MIN(rental_med_all) OVER ()) AS rental_med_all
, (gross_yield - MIN(gross_yield) OVER ()) * 1.0 / (MAX(gross_yield) OVER () - MIN(gross_yield) OVER ()) AS gross_yield
, (intensite_tension_immo - MIN(intensite_tension_immo) OVER ()) * 1.0 / (MAX(intensite_tension_immo) OVER () - MIN(intensite_tension_immo) OVER ()) AS intensite_tension_immo
, (sum_estab_importance - MIN(sum_estab_importance) OVER ()) * 1.0 / (MAX(sum_estab_importance) OVER () - MIN(sum_estab_importance) OVER ()) AS sum_estab_importance
, (sum_site_importance - MIN(sum_site_importance) OVER ()) * 1.0 / (MAX(sum_site_importance) OVER () - MIN(sum_site_importance) OVER ()) AS sum_site_importance
, (foreigners_stay_total - MIN(foreigners_stay_total) OVER ()) * 1.0 / (MAX(foreigners_stay_total) OVER () - MIN(foreigners_stay_total) OVER ()) AS foreigners_stay_total
, (nb_second_home - MIN(nb_second_home) OVER ()) * 1.0 / (MAX(nb_second_home) OVER () - MIN(nb_second_home) OVER ()) AS nb_second_home


FROM {{ ref('general_table_department') }}
ORDER BY department_code ASC
),
scores AS (
SELECT 
    *
, CASE
    WHEN department = '2000' THEN '2B'
    WHEN department = '2999' THEN '2A'
    WHEN department = '1' THEN '01'
    WHEN department = '2' THEN '02'
    WHEN department = '3' THEN '03'
    WHEN department = '4' THEN '04'
    WHEN department = '5' THEN '05'
    WHEN department = '6' THEN '06'
    WHEN department = '7' THEN '07'
    WHEN department = '8' THEN '08'
    WHEN department = '9' THEN '09'
    ELSE department
  END AS department_cleaned 
, (population_growth_last10y * 0.2) AS w_population_growth
, (sales_numbers * 0.225) AS w_sales_nb
, (avg_salary * 0.085) AS w_avg_salary
, (gross_yield * 0.105) AS w_gross_yield
, (avg_m2_price_sales * 0.105) AS w_avg_m2_price
, (rental_med_all * 0.105) AS w_rental_med
, (intensite_tension_immo * 0.175) AS w_intensite_immo
, (nb_second_home*0.295) AS w_second_home
, (foreigners_stay_total*0.11) AS w_foreigners
, (sum_site_importance*0.30) AS w_site_importance
, (sum_estab_importance*0.295) AS w_estab_importance
, (nb_second_home*0.295) + (foreigners_stay_total*0.11)+(sum_site_importance*0.30)+(sum_estab_importance*0.295) AS w_tourism_score
, (population_growth_last10y * 0.2) + (sales_numbers * 0.225) + (avg_salary * 0.085) + (gross_yield * 0.105) + (avg_m2_price_sales * 0.105)+ (rental_med_all * 0.105) + (intensite_tension_immo * 0.175) AS w_invest_score    
FROM normalisation
)
SELECT
    department_cleaned
,   population_growth_last10y AS s_population_growth
,   sales_numbers AS s_sales_nb
,   avg_salary AS s_avg_salary
,   gross_yield AS s_gross_yield
,   avg_m2_price_sales AS s_avg_m2_price
,   rental_med_all AS s_rental_med
,   intensite_tension_immo AS s_intensite_immo
,   nb_second_home AS s_second_home
,   foreigners_stay_total AS s_foreigners
,   sum_site_importance AS s_site_importance
,   sum_estab_importance AS s_estab_importance
,   w_population_growth
,   w_sales_nb
,   w_avg_salary
,   w_gross_yield
,   w_avg_m2_price
,   w_rental_med
,   w_intensite_immo
,   w_second_home
,   w_foreigners
,   w_site_importance
,   w_estab_importance
,   w_tourism_score
,   w_invest_score
,   (w_invest_score - MIN(w_invest_score) OVER ()) * 1.0 / (MAX(w_invest_score) OVER () - MIN(w_invest_score) OVER ()) AS scaled_invest_score
,   (w_tourism_score  - MIN(w_tourism_score ) OVER ()) * 1.0 / (MAX(w_tourism_score) OVER () - MIN(w_tourism_score ) OVER ()) AS scaled_tourism_score
,   (((w_invest_score - MIN(w_invest_score) OVER ()) * 1.0 / (MAX(w_invest_score) OVER () - MIN(w_invest_score) OVER ())) + ((w_tourism_score  - MIN(w_tourism_score ) OVER ()) * 1.0 / (MAX(w_tourism_score) OVER () - MIN(w_tourism_score ) OVER ()))) / 2 AS general_score
FROM scores
ORDER BY general_score DESC