/*
Merging 'investors' KPI
Null values for dep. 57, 67 and 68 in:
        rental_med_all
        gross_yield
        avg_m2_price_growth_last_year
        sales_numbers_growth
*/
SELECT
    pop.department
,   pop.population_total
,   pop.population_growth_last10y
,   eco.avg_salary
,   ROUND(eco.growth_rate_last5y,2) AS growth_rate_last5y
,   yie.avg_sales_price_m2_2021
,   yie.avg_surface_2021
,   yie.rental_med_all
,   yie.gross_yield
,   pri.avg_m2_price
,   pri.avg_m2_price_growth_last_year
,   pri.sales_numbers
,   pri.sales_numbers_growth
FROM {{ ref('department_population_growth') }} pop
LEFT JOIN {{ ref('economic_growth_rate') }} eco USING(department)
LEFT JOIN {{ ref('gross_yield') }} yie USING(department)
LEFT JOIN {{ ref('growth_volume_and_avg_price') }} pri USING(department)
WHERE department < '97'
ORDER BY department ASC