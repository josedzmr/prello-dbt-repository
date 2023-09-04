With math AS (
    SELECT
    *
    , SUM(nb_second_home) OVER () AS SumTotal
FROM {{ref("second_home_Alpes")}}
)

SELECT 
    *
    , ROUND(SumTotal / 96,2) as avg_sum_scd_houses
FROM math