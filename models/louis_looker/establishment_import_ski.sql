WITH esta AS (
SELECT
    *
,   CASE
        WHEN municipality_code = '74056' OR municipality_code = '74191' OR municipality_code = '74173' OR municipality_code = '74014' OR municipality_code = '74236' OR municipality_code = '74136' OR municipality_code = '74063' OR municipality_code = '74080' OR municipality_code = '74258' OR municipality_code = '74134' OR municipality_code = '74085' OR municipality_code = '74083' OR municipality_code = '74215' OR municipality_code = '74190' OR municipality_code = '74160' OR municipality_code = '74238' OR municipality_code = '74279' OR municipality_code = '74058' OR municipality_code = '74099' THEN importance
        ELSE 0
    END AS best_savoie_esta_import
,   CASE
        WHEN department = '74' THEN importance
        ELSE 0
    END AS savoie_esta_import
--,   SUM(importance) OVER(PARTITION BY department, touristic_site) AS sum_importance_dep
FROM {{ ref('stg_POI_tourist_establishments') }}
)
SELECT
    department
,   accomodation_type
,   SUM(best_savoie_esta_import) AS best_esta_importance
,   SUM(savoie_esta_import) AS savoie_esta_importance
,   SUM(importance) AS total_esta_importance
FROM esta
GROUP BY department, accomodation_type
