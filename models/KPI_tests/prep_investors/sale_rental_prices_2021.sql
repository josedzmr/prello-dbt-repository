WITH sales AS(
SELECT 
    department
    , AVG(surface) as avg_surface_2021
    , AVG(sales_price_m2) as avg_sales_price_m2_2021
FROM {{ ref('stg_notary_with_municipality_code') }}
WHERE EXTRACT(YEAR FROM DATE(sales_date)) = 2021
GROUP BY department
ORDER BY department
)
SELECT 
    sales.department
    , ROUND(sales.avg_surface_2021, 2) as avg_surface_2021
    , ROUND(sales.avg_sales_price_m2_2021, 2) as avg_sales_price_m2_2021
    , ROUND(AVG(rental_prices.rental_med_all), 2) as rental_med_all
FROM sales
JOIN {{ ref("avg_rental_prices") }} AS rental_prices
ON sales.department = rental_prices.department
GROUP BY sales.department, sales.avg_surface_2021, sales.avg_sales_price_m2_2021
ORDER BY sales.department
