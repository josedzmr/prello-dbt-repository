WITH gironde AS (
SELECT
    *
,   CASE 
        WHEN touristic_site LIKE LOWER('water') OR touristic_site LIKE LOWER('beach') THEN 'beach'
        ELSE touristic_site
    END AS touristic_site_cleaned
,   CASE
        WHEN department = '06' THEN importance
        ELSE 0
    END nice_import
,   CASE
        WHEN department = '34' THEN importance
        ELSE 0
    END montp_import
,   CASE
        WHEN department = '74' THEN importance
        ELSE 0
    END ski_import
,   CASE
        WHEN department = '75' THEN importance
        ELSE 0
    END paris_import
--,   SUM(importance) OVER(PARTITION BY department, touristic_site) AS sum_importance_dep
FROM {{ ref('stg_POI_touristic_sites_by_municipality') }}

)
SELECT
    department
,   touristic_site_cleaned
,   SUM(nice_import) AS nice_sum_importance
,   SUM(montp_import) AS montp_sum_importance
,   SUM(ski_import) AS ski_sum_importance
,   SUM(paris_import) AS paris_sum_importance
,   SUM(importance) AS sum_importance
FROM gironde
GROUP BY department, touristic_site_cleaned
