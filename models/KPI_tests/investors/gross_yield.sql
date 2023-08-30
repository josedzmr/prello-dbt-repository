-- average gross yield is 0.0705

SELECT 
    department
    , avg_surface_2021
    , avg_sales_price_m2_2021
    , ROUND(AVG(rental_med_all), 2) as rental_med_all
    , ROUND((AVG(rental_med_all) * 12) / (avg_sales_price_m2_2021 * avg_surface_2021) * 100,4) as gross_yield -- calculate the gross yield: first, multiplying the median rental price by 12 to approximate the annual rental income, then, divide by average investment
FROM `prello-lewagon.dbt_mverstraete.sale_rental_prices_2021`
GROUP BY department, avg_surface_2021, avg_sales_price_m2_2021
ORDER BY department
