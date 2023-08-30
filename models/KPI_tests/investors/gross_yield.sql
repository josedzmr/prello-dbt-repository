SELECT 
    department
    , avg_surface_2021
    , avg_sales_price_m2_2021
    , ROUND(AVG(rental_med_all), 2) as rental_med_all
    , ROUND((AVG(rental_med_all) * 12) / (avg_sales_price_m2_2021 * avg_surface_2021) * 100,4) as gross_yield
FROM `prello-lewagon.dbt_mverstraete.sale_rental_prices_2021`
GROUP BY department, avg_surface_2021, avg_sales_price_m2_2021
ORDER BY department
