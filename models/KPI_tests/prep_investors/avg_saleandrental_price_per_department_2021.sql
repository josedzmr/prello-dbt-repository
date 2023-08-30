-- for 2021, average sale and rental prices, and average surface

SELECT 
    sales.department
    , ROUND(sales.avg_surface_2021, 2) as avg_surface_2021 
    , ROUND(sales.avg_sales_price_m2_2021, 2) as avg_sales_price_m2_2021
    , ROUND(AVG(rental_prices.rental_med_all), 2) as rental_med_all
FROM (
    SELECT 
        department
        , AVG(surface) as avg_surface_2021
        , AVG(sales_price_m2) as avg_sales_price_m2_2021
    FROM prello-lewagon.dbt_louis2506_staging.stg_notary_with_municipality_code
    WHERE EXTRACT(YEAR FROM DATE(sales_date)) = 2021 -- extract data from 2021 only from notary table
    GROUP BY department
    ORDER BY department
) AS sales
JOIN `prello-lewagon.dbt_mverstraete.avg rental prices` AS rental_prices -- join rental and sale prices
ON sales.department = rental_prices.department
GROUP BY sales.department, sales.avg_surface_2021, sales.avg_sales_price_m2_2021
ORDER BY sales.department
