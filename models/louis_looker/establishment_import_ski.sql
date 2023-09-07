WITH esta AS (
SELECT
    *
,   CASE
        WHEN municipality_code = '74056' OR municipality_code = '74191' OR municipality_code = '74173' OR municipality_code = '74014' OR municipality_code = '74236' OR municipality_code = '74136' OR municipality_code = '74063' OR municipality_code = '74080' OR municipality_code = '74258' OR municipality_code = '74134' OR municipality_code = '74085' OR municipality_code = '74083' OR municipality_code = '74215' OR municipality_code = '74190' OR municipality_code = '74160' OR municipality_code = '74238' OR municipality_code = '74279' OR municipality_code = '74058' OR municipality_code = '74099' OR municipality_code = '74010' OR municipality_code = '74281' OR municipality_code = '74119' THEN importance
        WHEN municipality_code = '73257' THEN (8.34951262415 / 35)
        ELSE 0
    END AS best_savoie_esta_import
,   CASE
        WHEN department = '74' THEN importance
        ELSE 0
    END AS savoie_esta_import
--,   SUM(importance) OVER(PARTITION BY department, touristic_site) AS sum_importance_dep
FROM {{ ref('stg_POI_tourist_establishments') }}
)
,   renam AS(
SELECT
    department
,   accomodation_type
,   ROUND(SUM(best_savoie_esta_import), 13) AS best_esta_importance
,   SUM(savoie_esta_import) AS savoie_esta_importance
,   SUM(importance) AS total_esta_importance
FROM esta
WHERE accomodation_type = LOWER('hotel') AND (department = '74' OR department = '73')
GROUP BY department, accomodation_type
)
SELECT
    *
,   CASE
        WHEN best_esta_importance = 14.2945724440902 THEN 'Top 22'
        ELSE 'Remaining 257'
    END AS Municipalities
FROM renam