SELECT
    EXTRACT(YEAR from sales_date) AS year
,   department
,   AVG(sales_price_m2) AS avg_m2_price
FROM {{ ref('stg_notary_real_estate_sales') }}
GROUP BY year, department
ORDER BY department, year
