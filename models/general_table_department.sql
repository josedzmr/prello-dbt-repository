WITH general AS(
SELECT
    inv.*
,   tou.nb_accomodation_type
,   tou.avg_site_importance
,   tou.sum_site_importance
,   tou.nb_touristic_site
,   tou.avg_estab_importance
,   tou.sum_estab_importance
,   tou.avg_poverty_rate
,   tou.sum_poverty_rate
,   tou.overnight_stay_hotel
,   tou.foreigners_hotel_rate
,   tou.overnight_stay_camping
,   tou.foreigners_camping_rate
,   tou.secondary_home_rate
,   tou.nb_second_home
FROM {{ ref('growth_rate_all') }} inv
LEFT JOIN {{ ref('avg_importance_per_department') }} tou
USING(department)
)
,b_replace AS(
SELECT
    *
,   REGEXP_REPLACE(department, 'B', '000') AS department_codeB
FROM general
),
a_replace AS (
SELECT
    *
,   REGEXP_REPLACE(department_codeB, 'A', '999') AS department_code
FROM b_replace
)
SELECT
    CAST(department_code AS INT64) AS department_code
,   population_total
,   population_growth_last10y
,   avg_salary
,   growth_rate_avg_salary_last5y
,   sales_numbers
,   sales_numbers_growth
,   avg_surface_2021_sales
,   avg_m2_price_sales
,   avg_m2_price_rental_growth_last_year
,   rental_med_all
,   gross_yield
,   intensite_tension_immo
,   nb_accomodation_type
,   avg_site_importance
,   sum_site_importance
,   nb_touristic_site
,   avg_estab_importance
,   sum_estab_importance
,   avg_poverty_rate
,   sum_poverty_rate
,   overnight_stay_hotel
,   foreigners_hotel_rate
,   overnight_stay_camping
,   foreigners_camping_rate
,   secondary_home_rate
,   nb_second_home
,  ((overnight_stay_hotel * (foreigners_hotel_rate/100))+(overnight_stay_camping * (foreigners_camping_rate/100))) /(overnight_stay_camping+overnight_stay_hotel) AS foreigners_rate
FROM a_replace