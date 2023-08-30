SELECT 
    LEFT(municipality_code, 2) as department
    , AVG(surface) as avg_surface_2021
    , AVG(sales_price_m2) as avg_sales_price_m2_2021
FROM `prello-lewagon.prello.notary_real_estate_sales`
WHERE EXTRACT(YEAR FROM DATE(sales_date)) = 2021
GROUP BY department
ORDER BY department
