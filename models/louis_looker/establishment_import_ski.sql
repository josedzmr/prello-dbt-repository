WITH esta AS (
SELECT
    *
,   CASE
        WHEN municipality_code = '74056' OR municipality_code = '74191' OR municipality_code = '74173' OR municipality_code = '74014' OR municipality_code = '74236' OR municipality_code = '74136' OR municipality_code = '74063' OR municipality_code = '74080' OR municipality_code = '74258' OR municipality_code = '74134' OR municipality_code = '74085' OR municipality_code = '74083' OR municipality_code = '74215' OR municipality_code = '74190' OR municipality_code = '74160' OR municipality_code = '74238' OR municipality_code = '74279' OR municipality_code = '74058' OR municipality_code = '74099' THEN importance
        ELSE 0
    END best_ski_import
--,   CASE
--        WHEN municipality_code = '74056' OR municipality_code = '74191' OR municipality_code = '74173' OR municipality_code = '74014' OR municipality_code = '74236' OR municipality_code = '74136' OR municipality_code = '74063' OR municipality_code = '74080' OR municipality_code = '74258' OR municipality_code = '74134' OR municipality_code = '74085' OR municipality_code = '74083' OR municipality_code = '74215' OR municipality_code = '74190' OR municipality_code = '74160' OR municipality_code = '74238' OR municipality_code = '74279' OR municipality_code = '74058' OR municipality_code = '74099' OR THEN '100'
--        ELSE department
--    END best_department
--,   SUM(importance) OVER(PARTITION BY department, touristic_site) AS sum_importance_dep
FROM {{ ref('stg_POI_tourist_establishments') }}
)
,   prep_join AS(
SELECT
    department
,   accomodation_type
,   SUM(best_ski_import) AS best_ski_sum_importance
,   SUM(importance) AS sum_esta_importance
FROM esta
GROUP BY department, accomodation_type
)
SELECT
    *
,   SUM(sum_esta_importance) OVER() AS esta_importance_total
FROM prep_join