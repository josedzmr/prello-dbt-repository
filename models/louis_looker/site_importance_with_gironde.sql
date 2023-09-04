WITH gironde AS (
SELECT
    *
,   CASE 
        WHEN touristic_site LIKE LOWER('water') OR touristic_site LIKE LOWER('beach') THEN 'beach'
        ELSE touristic_site
    END AS touristic_site_cleaned
,   CASE
        WHEN department = '33' THEN importance
        ELSE 0
    END gir_import
--,   SUM(importance) OVER(PARTITION BY department, touristic_site) AS sum_importance_dep
FROM {{ ref('stg_POI_touristic_sites_by_municipality') }}

)
SELECT
    department
,   touristic_site_cleaned
,   SUM(gir_import) AS gir_sum_importance
,   SUM(importance) AS sum_importance
FROM gironde
GROUP BY department, touristic_site_cleaned
